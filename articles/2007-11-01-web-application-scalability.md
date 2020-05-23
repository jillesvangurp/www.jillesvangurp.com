---
title: Web application scalability
date: 2007-11-01T19:10:21+00:00
author: Jilles van Gurp


permalink: /2007/11/01/web-application-scalability/
categories:
  - Blog Posts
tags:
  - eclipse
  - google
  - java
  - nokia
  - Nokia Research Center
  - OO
  - python
  - webdevelopment
---
It seems [infoq ](http://www.infoq.com/news/2007/10/big-java)picked up some stuff from [a comment](http://www.theserverside.com/news/thread.tss?thread_id=47135#240685) I left on the serverside about one of my pet topics (Server side Java). 

The infoq article also mentions that I work at Nokia. I indeed work for Nokia Research Center and it's a great place to work. Only they do require me to point out that when making such comments I'm not actually representing them. 

The discussion is pretty interesting and I've recently also ventured into using other things than Java (mainly python lately with the Django framework). So far I dearly miss development tooling which ranges from non existent to immature crap for most languages that are not Java. Invariably the best IDEs  for these languages are actually built in Java. For example, I'm using the eclipse pydev extension for python development. It's better than nothing but it still sucks compared to how I develop Java in the same IDE. Specifically: no quickfixes; only a handful of refactorings, no inline documentation, barely working autocompletion, etc make life hell. I forgot what it is like to actually have to type whole lines of code. 

I understand the development situation is hardly better for other scripting languages. There's some progress on the ruby front since Sun started pushing things on that side but none of this stuff is actually production quality. Basically the state of the art in programming environments is currently focussed primarily on statically compiled OO languages like Java or C#. Using something else can be attractive from for example language feature point of view but the price you pay is crappy tooling.

Python as a language is quite OK although it is a bit out of date with things like non utf-8 strings and a few other things that my fellow country man Guido van Rossum is planning to fix in python 3000. Not having explicit typing takes some getting used to and also means my workload is higher because I constantly have to use Google to look up stuff that eclipse would just tell me (e.g. what methods and properties can I use on this HttpResp object I'm getting from Django; what's the name of the exception I'm supposed to be catching here, etc). In my view that's not progress and leads to sloppy coding practices where people don't bother dealing with fault situations unless they have to (which long term in a large scale server environment is pretty much always).