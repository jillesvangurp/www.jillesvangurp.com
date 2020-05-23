---
title: Optimistic locking for updates in Elasticsearch
date: 2014-12-03T15:04:34+00:00
author: Jilles van Gurp


permalink: /2014/12/03/optimistic-locking-for-updates-in-elasticsearch/
categories:
  - Blog Posts
tags:
  - API
  - CRUD
  - DAO
  - python
---
In a post in 2012, I expanded a bit on the virtues of [using elasticsearch as a document store](http://www.jillesvangurp.com/2013/01/15/using-elastic-search-as-a-key-value-store/), as opposed to using a separate database. To my surprise, I still get hits on that article on a daily basis. This indicates that there is some interest in using elasticsearch as described there. So, I'm planning to start blogging a bit more again after more or less being too busy with building [Inbot](http://inbot.io) to do so since last February. 



First lets get the question of whether it is actually a good idea to use Elasticsearch as a datastore out of the way. The answer is: it depends. There were many reasons why this was an idea to be approached with some caution when I wrote the article last year. Some of those reasons have since been addressed in elasticsearch. As of 1.4.x, a lot of concerns noted in the now infamous [call me maybe article](http://aphyr.com/posts/317-call-me-maybe-elasticsearch) about elasticsearch resilience under different network and cluster failure scenarios have been addressed and fixes for many remaining concerns are in the works as well. This doesn't mean you can now just go ahead and just use it as a drop in database replacement but it does mean that if you understand the failure scenarios, it might actually be good enough for you. If you are interested in this topic, I recommend you keep an eye on the [ongoing work in Elasticsearch](http://www.elasticsearch.org/guide/en/elasticsearch/resiliency/current/index.html) to address these concerns. The bottom line is that elasticsearch was a decent document store last year and it is a better, more resilient one this year. However, there are still known ways in which it can fail as a reliable datastore, although it is quite rare for it to do so. 

At [Inbot](http://inbot.io) we in fact use elasticsearch as a document store without a separate database. To mitigate against disaster, we have of course some sensible policies for e.g. backups, monitoring, etc. Part of our reasoning was that 1) we are interested in, and heavily dependent on elasticsearch querying ability to the point where anything else is merely inconvenient. 2) having multiple data storage solutions and keeping them in sync has its own complexities and failure scenarios. 3) several of the alternatives we looked at have their own issues. 4) we needed elasticsearch anyway and if it goes down, we are down. We can't actually afford to be down for a few hours while we rebuild our elasticsearch cluster; even if we had a secondary store. 5) we like to have as little latency as possible between storing and searching: that means the less moving parts the better. All of this lead us to implementing an elasticsearch only architecture that, so far, has not let us down in a major way and has been a major, game changing, enabler for our business. If you are doing any kind of complex querying or reporting, you'll probably want to take a deep and hard look at elasticsearch. 

In the remainder of this article, I would like to go a bit in depth on how we do document updates in elasticsearch. As I described in my earlier article, Elasticsearch uses a version attribute to mark different versions of documents and uses this attribute to do consistency checks when modifications are made to the document. This is one of the features that makes it interesting to use as a document store. When doing updates to documents, you pass in the version of the document that you have and if it doesn't match what elasticsearch has, the update fails with a conflict. This is great for preventing accidentally overwriting updates that may have happened since you last got a recent version or that may be happening concurrently.

One thing we found is that the chance of these conflicts actually increased quite rapidly as we wrote more to elasticsearch to the point where we had to do something. We have batch systems that update and create documents all the time. Additionally our users create and modify documents as well by simply using our app. Even if a conflict occurs just once in a few thousand writes, it is actually unacceptable to just fail updates so often.

All our updates are triggered from some REST API call that typically has the object id in the url. So, given an objectId, fetch the object, perform some logic that modifies the object, and store the result. Most of our updates pretty much follow this pattern. If an update fails because of a version conflict, we try again. And if it fails permanently, we throw some error. This works but is kind of tedious to implement.

A few months ago, we switched to java 8, which now has something that other languages have had for ages: lambda functions, aka. closures. Closures are perfect for expressing the logic above in a nicer way that has some nice properties.

We use the DAO pattern to abstract CRUD operations to elasticsearch. That means we have a class that allows us to create, read, update, and delete documents in a given elasticsearch index and type. The index and type are set in the constructor of the DAO. What we did was add a new update method to this class. The old one has a signature like:

```java 
public void update(String objectId, JsonObject object)
```

This method basically overwrites the object in elasticsearch if the _version attribute inside the object matches the stored one. Otherwise it fails with a VersionConflictException. This leaves the handling of the VersionConflictException as well as getting the object to the caller. This proved to be a problem because typically there could be a bit of time consuming business logic in between getting the object and saving the object and this leaves a rather large window of opportunity for concurrent writes to the same object and increases the risk for a version conflict to actually happen.

The new method has a different signature.

```java
public void update(String objectId, Function<JsonObject,JsonObject> transformFunction)
```

For a given objectId, fetch the object, transform it with the function, and put it back again. The nice thing of this approach is that if it fails, the implementation can simply try again by re-fetching the object using the id and by re-applying the function.

The implementation is pretty straightforward and uses the old update method:

```java
    public JsonObject update(String id, Function<JsonObject, JsonObject> f) {
        JsonObject object = get(id);
        if(object == null) {
            throw new NotFoundException(type, id);
        }
        JsonObject changedObject = f.apply(object.deepClone());
        if(!object.equals(changedObject)) {
            // only update if something actually changed
            changedObject.removeEmpty();
            try {
                JsonObject update = update(object.getString(F_ID), changedObject);
                return update;
            } catch (VersionConflictEngineException e) {
                try {
                    // wait a bit to let the concurrent write op do its thing
                    Thread.sleep(50 + RandomUtils.nextInt(50));
                } catch (InterruptedException ex) {
                    throw new IllegalStateException(ex);
                }
                object = get(id);
                changedObject = f.apply(object);
                changedObject.removeEmpty();

                JsonObject update = update(object.getString(F_ID), changedObject);
                return update;
            }
        } else {
            return object;
        }
    }
```

This encapsulates a lot of nice logic. We chose not to recursively retry because the chance on a second VersionConflict drastically reduces. But retrying multiple times would be quite easy to implement here of course. The added sleep after a version conflinct ensures that a second concurrent write is much less likely because whatever concurrent action that caused the conflic will likely have completed after the sleep. We don't have a lot of updates on our objects so it would be pretty unusual to fail repeatedly and that would probably be indicitive of a a bigger issue.

So, now updates are quite straightforward:

```
myDao.update(objectId, object -> {
  object.put("foo","bar");
  return object;
});
```

This updates an object in elasticsearch by applying a closure with the modifications to the stored version. We use my [jsonj](https://github.com/jillesvangurp/jsonj) library but you could easily adapt this pattern to whatever you use to represent your documents in your code.

What this design pattern amounts to is client side [optimistic locking](http://en.wikipedia.org/wiki/Optimistic_concurrency_control). Instead of explicitly locking, like many databases would do, this function simply tries to write and if that fails fetches the latest version and tries again. Most of the time it succeeds the first time so there is no performance impact. Sometimes it has to retry and in that case there is a bit of delay but nothing really bad.

The nice thing about this approach is that it works with any system that has closures and some kind of version check. You could use it from ruby, python, javascript, go, etc. and also with other systems like couchdb that have similar version checks on update. Lock free updates are a good thing to have.