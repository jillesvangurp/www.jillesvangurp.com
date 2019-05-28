---
id: 875
title: Jsonj
date: 2011-05-30T23:03:17+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2011/05/30/873-revision-2/
permalink: /2011/05/30/873-revision-2/
---
I've just uploaded a weekend project to github.

If you read my previous post on <a href="http://www.jillesvangurp.com/2011/04/02/on-java-json-and-complexity/">json</a>, you may have guessed that I'm not entirely happy with the state of Json in Java relative to other languages that come with native support for json. I can't fix that entirely but I felt I could do a better job than most other frameworks I've been exposed to.

So, I set down on Sunday and started pushing this idea of just taking the Collections framework and combining that with the design of the Json classes in GSon, which I use at work currently, and throwing in some useful ideas that I've applied at work. The result is a nice, compact little framework that does most of what I need it to do. I will probably add a few more features to it and expand some of the existing ones. I use some static methods at work that I can probably do in a much nicer way in this framework. 

So, here it is, <a href=" https://github.com/jillesvangurp/jsonj">jsonj</a>. Enjoy.





