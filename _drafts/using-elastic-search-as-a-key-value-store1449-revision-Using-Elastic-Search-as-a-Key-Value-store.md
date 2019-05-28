---
id: 1450
title: Using Elastic Search as a Key Value store
date: 2013-01-03T17:43:11+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/01/03/1449-revision/
permalink: /2013/01/03/1449-revision/
---
I have in the past used solr and lucene as a key value store. Doing that provided me with some useful information:
<ol>
	<li>This actually works reasonably well and it scales pretty good. I have in the past used indexes on a solr two node master/slave node setups with up to 90M documents (json), of roughly 1-2KB each with a total index size (unoptimized) of well over 200GB handling queries that returned tens to hundreds of documents at a four queries / second basis. With writes &amp; replication going on at the same time. In a different project we had 70M compressed (gzip) xml values of roughly 5KB each stuffed in a solr index that managed to sustain dozens of reads per second in a prolonged load test with sub 10ms response times. Total index size was a bit over 100GB. This was competitive (slightly better actually) with a mysql based solution that we load tested under identical conditions. So, when I say lucene/solr is usable as a key value store, I mean I have used and would use it again in a production setting for data intensive applications.</li>
	<li>You need to be aware of some limitations with respect to eventual consistency, lack of transactionality, and reading your own writes, and a few other things. In shorts, you need to make sure your writes don't conflict, beware of a latency between the moment you write something and the moment this write becomes visible through queries, and try not to read your own writes immediately after writing them.</li>
	<li>Bearing this in mind, Solr makes a nice key value store.</li>
</ol>
Recently, I started using elastic search and this makes the above even more interesting. Elastic search is often depicted as simply a search engine. However, it is quite a bit more than that.

It is better described as a schema less, multi tenant, replicating &amp; sharding key value store that implements extensible &amp; advanced search features (geo spatial, faceting, filtering, etc.) as well.

In more simple terms: you launch it,  throw data at it, and add more nodes to scale. It's that simple. Few other products do this. And even less do it with as little ceremony as elastic search. This includes most common relational and nosql solutions on the market today. I've  looked at quite a few. None come close to the out of the box utility and usability of Elastic Search.

That's a big claim. So, lets go through some of the basics to substantiate this a little:
<ul>
	<li>Elastic search stores/retrieves objects via a REST api. Convenient put,post,get, and delete APIs are provided that implement version checks (on put), generate ids (optionally on post), and allow you to read your own writes (on get).</li>
	<li>That makes it a proper key value store for json formatted objects with an API that is similar to e.g. couchdb and other key value stores.</li>
	<li>Objects have a type and go in an index. So, from a REST point of view, the relative uri to any object is /{index}/{type}/{id}</li>
	<li>You create indices and types at runtime via a REST API. You can create, update, and delete indices. You can configure the sharding and replication on a per index basis. That means elastic search is multi tenant.</li>
	<li>Elastic search indexes documents you store using either a dynamic mapping, or a mapping you provide (recommended). That means you can find back your documents via the search API as well. This is where lucene comes in. Unlike the get, search does not allow you to read your own writes immediately. It takes time for indices to update, and replicate.</li>
	<li>The search API is exposed as a _search resource that is available in at the server level (/_search), index level (/{index}/_search, or type level (/{index}/{type}/_search). So you can search across multiple indiceses. And because elastic search is replicating and sharding, across multiple machines as well.</li>
	<li>The search API supports the GET and POST methods. Post exists as a backup for clients that don't allow a json body as part of a GET request. The reason you need one is that Elastic Search provides a domain specific language (json based, of course) to specify complex queries. You can also use the lucene query language with a q=query parameter in the GET request but it's a lot less powerful and only useful for simple stuff.</li>
	<li>Elastic Search is clustered by default. That means if you start two nodes in the same network, they will hookup and become a cluster. Without configuration. So, out of the box, elastic search shards and replicates. You actually have to configure it to not do that (if you would actually want that). Typically, you configure it in different ways for  running in different environments. It's very flexible.</li>
	<li>Elastic search is built for big server deployments in e.g. Amazaon AWS, Heroku, or your own data center. That means it comes with built in monitoring features, a plugable architecture for adapting to different environments (e.g. discovery using AWS &amp; on the fly backups &amp; restores to/from S3), and a lot of other stuff you need to run in such environments. This is a nice contrast to solr, which doesn't do any of these things out of the box (or well for that matter) without a lot of fiddling with poorly documented stuff. I speak from experience here.</li>
	<li>Elastic Search is also designed to be developer friendly. Include it as a dependency in your pom file and start it programmatically, or simply take the tar ball and use the script to launch it. Spinning up a elastic search as part of a unit test is fairly straightforward and it works the same as a full blown cluster in e.g. AWS.</li>
	<li>Configuration is mostly runtime. There are only a few settings you have to decide before launching. The out the box experience is sensible enough that you don't have to worry about it during development.</li>
</ul>
In summary: Elastic Search is a pretty damn good key value store with a lot of properties that make it highly desirable if you are looking for a scalable solution to store and query your json data without spending a lot of time and effort on such things as configuration, monitoring, figuring out how to cluster, getting it to do sensible things, etc.

That's why we're going to use it at LocalStre.am.

&nbsp;