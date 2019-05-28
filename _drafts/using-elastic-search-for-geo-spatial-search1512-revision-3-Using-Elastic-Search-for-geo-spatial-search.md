---
id: 1515
title: Using Elastic Search for geo-spatial search
date: 2013-03-20T19:18:33+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/03/20/1512-revision-3/
permalink: /2013/03/20/1512-revision-3/
---
Over the past few months we have been quietly working on the <a href="http://localstre.am">localstre.am</a> platform. As I have mentioned in a previous post, we are <a href="http://www.jillesvangurp.com/2013/01/15/using-elastic-search-as-a-key-value-store/">using elastic search as a key value store</a> and that's working pretty nicely for us. In addition to that we are also using it as a geospatial search engine.

Localstrea.am is going to be all about local and that means geospatial data and lots of it. That's not just POIs (points of interest) but also streets, cities, and areas of interest. In geospatial terms that means shapes: points, paths, and polygons. Doing geospatial search means searching through documents that have geospatial data associated with it using a query that also contains geospatial data. So given a shape, find every document with a shape that overlaps or intersects with it.

Since elastic search is still very new and rapidly evolving (especially the geospatial functionality), I had some worries about whether it would work as advertised. So, after months of coding it was about time to see if it could actually take a decent data set and work as advertised instead of falling over and dying in a horrible way. 

<!--more-->

I actually have a dataset of about 30M pois that is very suitable for this kind of test. So, I launched elastic search on my laptop. Then I pointed my bulk indexing script at the 3GB of compressed json and hit enter. The script calls the bulk index API in elastic search with 500 json documents in one request and uses six threads to keep on sending it data. This enables elastic search to use multiple threads to index the data and with the recent Lucene 4.x release this the recommended way to index large amounts of data. This took about one hour. That translates into a bit under 10K documents per second. That is pretty good. I might be able to tune the throughput a bit more by fiddling with the bulk size, number of threads and other parameters. 

The end result was an index with a size of about 11GB. This too is pretty nice: the uncompressed size of the json is probably about the same size. To understand the size, I need to explain how spatial search works. 

Spatial search in Lucene (and thus Elastic Search) is implemented using so-called prefix trees. There are two varieties of this data structure in Lucene. One is geohash based and the other is quad tree based. The main difference is the number of nodes per level in the tree. A quad tree has, as the name implies, nodes with four nodes below it. A geohash is a base32 encoded quad tree path of the interleaved bits of the latitude and longitude. 

So, given a coordinate with a latitude and longitude you can calculate the path to a node in the prefix tree. In the case of the geohash implementation that is a Geohash and in the case of the quad tree that is a bit set. In both cases, the path actually describes a rectangular area. All points in that area have the same prefix. If you increase the length of the prefix by 1 level, you descend a level in the tree and the rectangle breaks down into 32 smaller rectangles in the case of a geohash or 4 rectangles in the case of a quad tree.

Lucene is a text indexing library and doesn't support any of the above natively. So, instead given a polygon, a prefix tree is used to calculate which tree nodes the polygon covers. The node paths become simple Sting terms and this is something that Lucene does know how to handle. At query time, whatever shape you are querying for is treated the same and you end up with a terms based query internally. From there on it is business as usual for Lucene. Documents have terms, queries have terms and Lucene is really good at figuring out which documents match which terms.

The problem with this is accuracy and index size. It took a bit of fiddling and asking around on the elastic search to figure out that spatial search has been a bit of a work in progress. The length of this path is controlled using the tree-levels setting. The more levels, the longer the path. Coordinates that are near to each other have the same prefix. So the more levels, the longer the path is, and the more of the coordinate's bits are encoded and the more accurate things get. More accurate also means more terms and this is why the tree-leves is very important.

In my test, I've experimented with a few different settings. In the end I used the quad tree implementation with a tree_levels setting of 20. This results in pretty decent accuracy without bloating the index and queries too much. Decent accuracy translates into about 50-100 meter, which for my use case is good enough. Increasing the tree_levels beyond this is possible but would really bloat the index size. 

Finally, I ran some queries. I used a polygon representing a circular area of 50m radius and created a few queries in different places and ran them. They all came backin 20-30 ms. That is pretty good. I actually ran a few queries while it was still indexing and those were similarly fast. Not bad for a cold index that is still ingesting data at a rate well beyond what the likes of e.g. mysql would be able to handle. While at Nokia, we spend a few months abusing mysql as a key value store and this is a big reason we are not going anywhere near it in LocalStre.am. It just doesn't scale.

This little experiment made me pretty happy today. It validates our choice of using Elastic Search as a spatial search engine and key value store. Having one solution for this means I won't lose any sleep trying to keep two systems in sync. I can simply add data and a second later it will be available for search. It seems to handle large amounts of data without breaking a sweat. Add to this the sharding and replication capabilities and you have a combination that is pretty damn good for what we do.
