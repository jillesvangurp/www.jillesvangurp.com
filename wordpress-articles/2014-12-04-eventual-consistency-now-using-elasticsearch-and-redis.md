---
id: 1697
title: Eventual Consistency Now! using Elasticsearch and Redis
date: 2014-12-04T00:09:27+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=1697
permalink: /2014/12/04/eventual-consistency-now-using-elasticsearch-and-redis/
categories:
  - Blog Posts
tags:
  - API
---
Elasticsearch promises real-time search and nearly delivers on this promise. The problem with 'nearly; is that in interactive systems, it is actually unacceptable to not have user changes reflect in the any query results. [Eventual consistency](http://en.wikipedia.org/wiki/Eventual_consistency) is nice but it also means occasionally being inconsistent, which is not so nice for users, or worse, product managers, who typically don't understand these things and report them as bugs. At Inbot, this aspect of using Elasticsearch has been keeping us busy. It would be awfully convenient if it never returned stale data.

Mostly things actually work fine but when a user updates something and then within a second navigates back to a list of stuff that includes what he/she just updated, chances are that it still has the old version because elasticsearch has not yet committed the change to the index. In any interactive system this is going to be a an issue and one way or another, a solution is needed. The reality is that elasticsearch is an eventually consistent cluster when it comes to search and not a proper transactional store that is immediately consistent after modifications. And while it is reasonably good at catching up in a second, that leaves plenty of room for inconsistencies to surface. While you can immediately get any changed document, it actually takes a bit of time for search results to get updated as well. Out of the box, the commit frequency is once every second, which is enough time for a user to click something and then something else and see results that are inconsistent with actions he/she just performed.

We started addressing this with a few client side hacks like simply replacing list results with what we just edited via the API, updating local caches, etc. Writing such code is error prone and tedious. So we came up with a better solution: use [Redis](http://redis.io). The same DAO I described in [my recent article on optimistic locking with elasticsearch](http://www.jillesvangurp.com/2014/12/03/optimistic-locking-for-updates-in-elasticsearch/) also stores the id of any modified documents in a shortlived data structure in Redis. Redis provides in memory data structures such as lists, sets, and hash maps and comes with a ton of options. The nice thing about Redis is that it scales quite well for small things and has a very low latency API. So, it is quite cheap to use it for things like caching.

So, our idea was very simple: use Redis to keep track of recently changed documents and change any results that include these objects on the fly with the latest version of the object. The bit of Java code that we use to talk to Redis uses something called JedisPool. However, this should pretty much work in a similar way from other languages.

```
try(Jedis jedis = jedisPool.getResource()) {
  Transaction transaction = jedis.multi();
  transaction.lpush(key, value);
  transaction.ltrim(key, 0, capacity); // right away trim to capacity so that we can pretend it is a circular list
  transaction.expire(key, expireInSeconds); // don't keep the data forever
  transaction.exec();
}
```

This creates a circular list with a fixed length that expires after a few seconds. We use it to store the ids of any document ids we modify for a particular index or belonging to a particular user. Using this, we can easily find out when returning results from our API whether we should replace some of the results with newer versions. Having the list expire after a few seconds means that it is enough for elasticsearch to catch up and the list will stay short or will not be there at all. Under continuous load, it will simply be trimmed to the latest ids that were added (capacity). So, it stays fast as well. 

Each of our DAOs exposes an additional function that tells you which document ids have been recently modified. When returning results, we loop over the results and check the id against this list and swap in the latest version. Simple, easy to implement, and it solves most of the problem and more importantly, it solves it on the server and does not burden our API users or clients with this.

However, It doesn't fix the problem completely. Your query may match the old document but not the new document and replacing the old document with the new document in the results will make it appear that the changed document actually still matches the query. But it is a lot better than showing stale data to the user. Also, we're not handling deletes currently but that is trivially supported with a similar solution.

**Update 2016-02-10** I recently released our Elasticsearch client code on [github](https://github.com/Inbot/inbot-es-http-client). It includes support for the strategy I outline above; and loads more goodies. Simply create a dao using the CrudOperationsFactory, be sure to enable redis caching there, and use the modifiedIds() on the dao to retrieve a list of recently modified ids. If you use the pagedSearch or iterableSearch methods on the dao, you can easily create a ProcessingSearchResponse that applies a lambda function that does the lookup if the id is contained in these modified ids. 