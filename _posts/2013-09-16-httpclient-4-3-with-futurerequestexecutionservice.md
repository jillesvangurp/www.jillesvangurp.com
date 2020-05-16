---
id: 1599
title: Httpclient 4.3 with FutureRequestExecutionService
date: 2013-09-16T16:55:07+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=1599
permalink: /2013/09/16/httpclient-4-3-with-futurerequestexecutionservice/
categories:
  - Blog Posts
tags:
  - Apache Httpclient
---
A while ago, I contributed some of my [github code](https://github.com/jillesvangurp/httpclient-future) to Apache Httpclient, which is now out in a new 4.3 GA release with my contributed functionality. If you use Java and make http requests, you probably already use httpclient (or something similar). If not, you might want to try it. Anyway, now you can wrap your Httpclient requests with Futures. 

This is very useful for any server that needs to make multiple requests in one transaction. Using futures you can concurrently schedule the requests and use a timeout to guarantee that one rogue request doesn't end up blocking your response for too long.

Read the documentation for FutureRequestExecutionService [here](http://hc.apache.org/httpcomponents-client-4.3.x/tutorial/html/advanced.html#d5e936) or download [httpclient 4.3](http://hc.apache.org/).