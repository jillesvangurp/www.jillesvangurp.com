---

title: server side osgi, a myth?
date: 2008-11-25T17:56:17+00:00
author: Jilles van Gurp


permalink: /2008/11/25/server-side-osgi-a-myth/
dsq_thread_id:
  - "336377742"
categories:
  - Blog Posts
tags:
  - eclipse
  - HTTP
  - java
  - nokia
  - osgi
  - Software Engineering
  - spring
  - Spring Application
---
Two years ago, I started using OSGI, the popular Java dependency injecting component standard, for an internal project. Fast forward to now and I have a nice set of bundles that depend on, amongst other the OSGI HTTP service.

All along, I've been reading how great OSGI is and how flexible it is and how it is the future of server side Java. I was ready to believe it. But to cut to the meat of this blog post: server side OSGI is vaporware. It doesn't exist. None of the vendors actually support it. Support it as in production quality, well documented, widely used product available right now. I've looked at Felix, Tomcat, Equinox,Ã‚Â  Jetty, Glassfish, JBoss, etc. and came up with nothing but a few obscure, unsupported, undocumented components. The default HTTP service implementation is not my idea of scalable & production quality. And the connections of existing production quality OSGI containers to existing production quality application servers is sketchy at best.

Frankly, I'm very surprised at this.I know lots of people that claim use OSGI serverside and there are are lots of announcements of vendor X endorsing OSGI bla bla bla fully modularized bla bla bla dependency injectionÃ‚Â  bla bla bla. That's great but after two years of OSGI hacking I was hoping for something a little more substantial than what I have found so far:

The best option I came up with is the [HTTP servlet bridge from equinox](http://www.eclipse.org/equinox/server/http_in_container.php). The documentation for this is either hopelessly out of date or this is a case of abandonware. Basically all the page says is download this bridge.war and good luck. Problem #1 this bridge.war is from 1997 .. eh 2007 :-). Problem #2, I'd like to use a bit newer version of Equinox. Does this work at all? Are people still working on this? Problem #3, this page hasn't changed substantially since I started using OSGI. Is anyone still working on this or is this a dead project? Are there any users?

Option #2 is to use Apache Felix which [apparently](http://www.gridshore.nl/2008/02/29/creating-a-jetty-based-osgi-httpservice-for-apache-felix/) can embed Jetty. That's great but I'm a tomcat guy and am more interested in using tomcat as the outer container than Jetty. Neither the jetty nor the tomcat option is documented properly. I'm not even sure the tomcat option is possible/advisable. Some people hint at this being possible. A particular concern for me is that I need to cluster the damn thing, potentially on a large scale. Is this possible at all? I'm pretty sure people have done this but in terms of production quality code and documentation they have not left much of a trail. The Felix people don't seem to much documentation in general. There's of course the gratuitous OSGI tutorial and some hints of how you could use it but that's it.

This situation is not something I can sell here at Nokia. I need something more substantial, preferably Tomcat or JBoss based that is 1) scalable in a cluster 2) production quality 3) well documented. I'm now pretty far convinced that what I'm looking for doesn't exist. If I don't find something soon, I'm going to just have to rip out all the OSGI stuff and switch to a proper dependency injecting container. Spring 3.0 is looking pretty neat for example but a bit heavyweight in my opinion.

Anyway, comments are open and please point out how wrong I am and what information I overlooked :-). My main gripe here is that I just have very little to base a decision on. Sketchy documentation, bits and pieces on blogs and mailinglists but nothing solid. Either OSGI is a genuine server side option or it is just an urban legend (some people have heard of other people that have done this). Everything I've seen so far hints at the latter.

I know Jboss 4, Glassfish 3, and Spring Application server are all going to be OSGI based of course. These are far from vaporware but also not exactly production ready. Additionally, being OSGI based is one thing, being able to deploy servlets from OSGI bundles is another thing. Most things I've read on this suggests that these servers are not really designed to allow application developers to interact with the OSGI container directly (i.e. deploying bundles, using http service instead of WAR files, etc.).