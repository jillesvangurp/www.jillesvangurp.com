---
id: 414
title: Boosting Lucene search results using timestamps
date: 2008-05-28T18:00:41+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=414
permalink: /2008/05/28/boosting-lucene-search-results-using-timestamps/
dsq_thread_id:
  - "336377533"
categories:
  - Blog Posts
tags:
  - Boosting Lucene
  - java
  - problemsandsolutions
---
Since I spent quite a bit of time looking into how to do this properly so here's a solution to a little problem that has been nagging me today: how make [lucene](http://lucene.apache.org/java/docs/index.html) take into account timestamps when returning search results. I don't want to sort the results (that's easy) but instead when two results match a query and get the same score from lucene, I want to see the newest first.

Basically in lucene this means influencing how it 'scores' entries against a query. So far I have been relying on the lucene QueryParser that implements a nice little query language with some cool features. However, the above requirement cannot be expressed as a query in that language. At best you might work with date ranges but that is not quite what I need.

So I had to dive into lucene architecture a bit more and after lots of digging came up with the following code:

```

String query="foo"
QueryParser parser =new QueryParser("name", new StandardAnalyzer());
Query q = parser.parse(query);
Sort updatedSort = new Sort();
FieldScoreQuery dateBooster = new FieldScoreQuery("timestampscore", FieldScoreQuery.Type.FLOAT);
CustomScoreQuery customQuery = new CustomScoreQuery(q, dateBooster);
Hits results = getSearcher().search(customQuery, updatedSort);

```

The FieldScoreQuery is a recent addition to lucene. I had to upgrade from 2.1 to 2.3 to get it. Essentially what it does is interpret a field as a float and deriving a score from it. Then the CustomScoreQuery combines the score with the score from my original query.

So far it is working beautifully. I basically added a float field to my index which is basically "0." + timestamp where timestamp is formatted as a yyyyMMddhhmm string (lucene only has string fields). Consequently, later timestamps have a slightly higher score. I might have to tune the query a bit further by either using a weight or by manipulating the float a bit further.

If any Lucene gurus stumble upon this and have some useful advice, please use the comments.