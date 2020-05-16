---
id: 1449
title: Using Elastic Search as a Key Value store
date: 2013-01-15T21:39:52+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1449
permalink: /2013/01/15/using-elastic-search-as-a-key-value-store/
categories:
  - Blog Posts
tags:
  - API
  - AWS
  - Elastic Search
  - REST
  - Using Elastic Search
---
I have in the past used [Solr](https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;ved=0CD4QFjAA&amp;url=http%3A%2F%2Flucene.apache.org%2Fsolr%2F&amp;ei=F7n1UKH_I4_FtAb7poG4DA&amp;usg=AFQjCNF-BJAXvcPzHg4ZHXpM_Kq38AfQgA&amp;sig2=yfjyC9OdYirDF5GtTzph_A&amp;bvm=bv.41018144,d.Yms) as a key value store. Doing that provided me with some useful information:

1. Using Solr as a key value store actually works reasonably well. I have in the past used indexes on a Solr two node master/slave setup with up to 90M documents (json), of roughly 1-2KB each with a total index size (unoptimized) of well over 100GB handling queries that returned tens to hundreds of documents at a 4 queries / second throughput. With writes &amp; replication going on at the same time. In a different project we had 70M compressed (gzip) xml values of roughly 5KB each stuffed in a Solr index that managed to sustain dozens of reads per second in a prolonged load test with sub 10ms response times. Total index size was a bit over 100GB. This was competitive (slightly better actually) with a MySql based solution that we load tested under identical conditions (same machine, data, and test). So, when I say Solr is usable as a key value store, I mean I have used it and would use it again in a production setting for data intensive applications.
1. You need to be aware of some limitations with respect to eventual consistency, lack of transactionality, and reading your own writes, and a few other things. In short, you need to make sure your writes don't conflict, beware of a latency between the moment you write something and the moment this write becomes visible through queries, and thus not try not to read your own writes immediately after writing them.
1. You need to be aware of the cost of certain operations in [Lucene](http://lucene.apache.org/) (the framework that is used by Solr). Getting stuff by id is cheap. Running queries that require Lucene to look at thousands of documents is not, especially if those things are big. Running queries that produce large result sets is not cheap either. Mixing lots of reads and writes is going to kill performance due to repeated internal cache validation.
1. Newer versions of Lucene offer vastly improved performance due to more clever use of memory, massive optimizations related to concurrency, and a less disruptive commit phase. Particularly Lucene 4 is a huge improvement, apparently.
1. My experience under #1 is based on Lucene 2.9.x and 3.x prior to most of the before mentioned improvements. That means I should get better results doing the same things with newer versions.

Recently, I started using [Elastic Search](http://www.elasticsearch.org/), which is an alternative Lucene base search product, and this makes the above even more interesting. Elastic search is often depicted as simply a search engine similar to Solr. However, this is a bit of an understatement and it is quite a bit more than that.

It is better described as a schema less, multi tenant, replicating &amp; sharding** key value store** that implements extensible &amp; advanced search features (geo spatial, faceting, filtering, etc.) as well.

In more simple terms: you launch it, throw data at it, find it back querying it, and add more nodes to scale. It's that simple. Few other products do this. And even less do it with as little ceremony as Elastic Search. This includes most common relational and nosql solutions on the market today. I've  looked at quite a few. None come close to the out of the box utility and usability of Elastic Search.

That's a big claim. So, lets go through some of the basics to substantiate this a little:

- Elastic search stores/retrieves objects via a REST API. Convenient PUT, POST, GET, and DELETE APIs are provided that implement version checks (optionally on PUT), generate ids (optionally on POST), and allow you to read your own writes (on GET). This is what makes it a key value store.
- Objects have a type and go in an index. So, from a REST point of view, the relative uri to any object is /{index}/{type}/{id}.
- You create indices and types at runtime via a REST API. You can create, update, retrieve and delete indices. You can configure the sharding and replication on a per index basis. That means elastic search is multi tenant and quite flexible.
- Elastic Search indexes documents you store using either a dynamic mapping, or a mapping you provide (recommended). That means you can find back your documents via the search API as well.
- This is where Lucene comes in. Unlike the GET, search does not allow you to read your own writes immediately because it takes time for indices to update, and replicate and doing this in bulk is more efficient.
- The search API is exposed as a _search resource that is available in at the server level (/_search), index level (/{index}/_search, or type level (/{index}/{type}/_search). So you can search across multiple indices. And because Elastic Search is replicating and sharding, across multiple machines as well.
- When returning search results, Elastic Search includes a _source field in the result set that by default contains the object associated with the results. This means that querying is like doing a multi-get, i.e. expensive if your documents are big, your queries expensive, and your result sets large. What this means is that you have to carefully manage how you query your dataset.
- The search API supports the GET and POST methods. Post exists as a backup for clients that don't allow a json body as part of a GET request. The reason you need one is that Elastic Search provides a domain specific language (json based, of course) to specify complex queries. You can also use the Lucene query language with a q=query parameter in the GET request but it's a lot less powerful and only useful for simple stuff.
- Elastic Search is clustered by default. That means if you start two nodes in the same network, they will hook up and become a cluster. Without configuration. So, out of the box, elastic search shards and replicates across whatever nodes are available in the network. You actually have to configure it to not do that (if you would actually want that). Typically, you configure it in different ways for  running in different environments. It's very flexible.
- Elastic Search is built for big deployments in e.g. Amazaon AWS, Heroku, or your own data center. That means it comes with built in monitoring features, a plugable architecture for adapting to different environments (e.g. discovery using AWS &amp; on the fly backups &amp; restores to/from S3), and a lot of other stuff you need to run in such environments. This is a nice contrast to solr, which doesn't do any of these things out of the box (or well for that matter) without a lot of fiddling with poorly documented stuff. I speak from experience here.
- Elastic Search is also designed to be developer friendly. Include it as a dependency in your pom file and start it programmatically, or simply take the tar ball and use the script to launch it. Spinning up an Elastic Search as part of a unit test is fairly straightforward and it works the same as a full blown cluster in e.g. AWS.
- Configuration is mostly runtime. There are only a few settings you have to decide before launching. The out the box experience is sensible enough that you don't have to worry about it during development.

In summary: Elastic Search is a pretty damn good key value store with a lot of properties that make it highly desirable if you are looking for a scalable solution to store and query your json data without spending a lot of time and effort on such things as configuration, monitoring, figuring out how to cluster, shard, and replicate, and getting it to do sensible things, etc.

There are a few caveats of course:

- It helps to understand the underlying data structures used by Lucene. Some things come cheap, some other things don't. In the end it is computer science and not magic. That means certain laws of physics still apply.
- Lucene is memory and IO intensive. That means things generally are a lot faster if everything fits into memory and if you have memory to spare for file caching. This is true for most storage solutions btw. For example with MySql you hit a brick wall once your indexes no longer fit in memory. Insert speeds go through the roof basically and mixed inserts/selects become a nightmare scenario.
- Mixed key value reads/writes combined with lots of expensive queries is going to require some tuning. You might want to specialize some of the nodes in your cluster for reads, for writes, and for querying load. You might want to think a bit about how many shards you need and how many replicas. You might want to think a bit about how you allocate memory to your nodes, and you might want to think a lot about which parts of your documents actually need to be indexed.
- Elastic Search is not a transactional data store. If you need a transactional database, you might want to consider using one.
- Elastic Search is a distributed, non transactional system. That means getting comfortable with the notion of eventual consistency.
- Using Elastic Search like you would use a relational databases is a very bad idea. Particularly, you don't want to do joins or update multiple objects in big transactions. Joins translate to doing multiple expensive queries and then doing some in memory stuff to throw away most of the results that just invalidated your internal caching. Doing many small interdependent writes is not a great idea either since that tends to be a bit unpredictable in terms of which writes go in first and when they get reflected in your query results. Besides, you want to write in bulk with Lucene and avoid the overhead of doing many small writes.
- Key value stores are all about de-normalizing and getting clever about how you query. It's better to have big documents in one index than to have many small documents spread over several indices. Because having many different indices probably means you have some logic somewhere that fires of a shit load of queries to combine things from those indices. Exactly the kind of thing you shouldn't be doing.  If you start thinking about indices and types in database terms (i.e. tables), that is a good indicator that you are on the wrong track here.

So, we're going to use Elastic Search at LocalStre.am. We're a small setup with modest needs for the foreseeable future. Those needs are easily met with a generic elastic search setup (bearing in mind the caveats listed above). Most of our data is going to be fairly static and we like the idea of being able to scale our cluster without too much fuss from day 1.

It's also a great match for our front end web application, which is based around the backbone javascript framework. Backbone integrates well with REST APIs and elastic search is a natural fit in terms of API semantics. This means we can keep our middleware very simple. Mostly it just passes through to Elastic Search after doing a bit of authentication, authorization, and validation. All we have is CRUD and a few hand crafted queries for Elastic Search.

&nbsp;

&nbsp;