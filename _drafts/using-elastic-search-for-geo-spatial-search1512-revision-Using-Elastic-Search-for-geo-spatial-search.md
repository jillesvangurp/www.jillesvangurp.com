---
id: 1513
title: Using Elastic Search for geo spatial search
date: 2013-03-20T17:58:00+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/03/20/1512-revision/
permalink: /2013/03/20/1512-revision/
---
Over the past few months we have been quietly working on the localstre.am platform. As I have mentioned in previous posts, we are using elastic search as a key value store. In addition to that we are also using it as a geospatial search engine.

Localstrea.am is going to be all about local and that means geospatial data and lots of it. Since elastic search is very new and rapidly evolving (especially the geospatial functionality), I had some worries about whether it would work as advertised. So, after months of coding it was about time for seeing if it could take a decent data set. I have a dataset of about 30M pois that is great for this kind of test.

So, I launched elastic search on my laptop. Pointed my bulk indexing script at the 3GB of compressed json and hit enter. The script calls the _bulk index API in elastic search with about 500 documents in one request and uses six threads to keep on sending it data. This took about one hour. That tran