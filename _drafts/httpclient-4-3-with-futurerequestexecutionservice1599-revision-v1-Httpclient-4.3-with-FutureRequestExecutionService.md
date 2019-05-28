---
id: 1600
title: Httpclient 4.3 with FutureRequestExecutionService
date: 2013-09-16T16:55:07+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/09/16/1599-revision-v1/
permalink: /2013/09/16/1599-revision-v1/
---
A while ago, I contributed some of my <a href="https://github.com/jillesvangurp/httpclient-future">github code</a> to Apache Httpclient, which is now out in a new 4.3 GA release with my contributed functionality. If you use Java and make http requests, you probably already use httpclient (or something similar). If not, you might want to try it. Anyway, now you can wrap your Httpclient requests with Futures. 

This is very useful for any server that needs to make multiple requests in one transaction. Using futures you can concurrently schedule the requests and use a timeout to guarantee that one rogue request doesn't end up blocking your response for too long.

Read the documentation for FutureRequestExecutionService <a href="http://hc.apache.org/httpcomponents-client-4.3.x/tutorial/html/advanced.html#d5e936">here</a> or download <a href="http://hc.apache.org/">httpclient 4.3</a>.