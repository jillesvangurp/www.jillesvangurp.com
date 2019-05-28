---
id: 406
title: GX WebManager
date: 2008-05-01T09:32:40+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=406
permalink: /2008/05/01/gx-webmanager/
dsq_thread_id:
  - "338239679"
categories:
  - Blog Posts
tags:
  - Apache Jackrabbit
  - CMS
  - GX
  - Netherlands
  - nokia
  - osgi
  - Software in General
---
Before joining Nokia, I worked for a small web startup in the Netherlands called <a href="http://www.gx.nl">&lt;GX&gt; Creative Online Development </a>duringÃ‚Â  2004 and 2005. When I started there, I was employee number forty something (I like to think it was 42, but not sure anymore). When I left, they had grown to close to a hundred employees and judging from what I heard since, they've continued to grow roughly following Moore's law in terms of number of employees. Also they seem to have executed the strategy that took shape while I was still their release manager.

When I joined GX, GX WebManager was a pretty advanced in house developed CMS that had gone through several years of field use and evolution already and enjoyed a rapidly growing number of deployments, including many big name Dutch institutions such as KPN, Ajax, ABN-AMRO, etc. At that time it was very much a in house developed thing that nobody from outside the company ever touched. Except through the provided UI of course which was fully AJAX based before the term became fashionable. By the time I left, we had upgraded release processes to push out regular technology releases first internally and later also outside to a growing number of partners that implemented GX WebManager for their customers.

I regularly check the GX website to see what thay have been up to and recently noticed that they pushed out a community edition of <a href="http://www.gxwebmanager.com/">GX WebManager</a>. They've spent the last few years rearchitecting what was already a pretty cool CMS to begin with to refit it with a standardized content repository (JSR 170) based on Apache Jackrabbit and a OSGI container based on Apache Felix. This architecture has been designed to allow easy creation of extensions by third parties. Martijn van Berkum and Arthur Meyer (product manager and lead architect) were already musing how to do this while I was still there and had gotten pretty far doing initial designs and prototyping . Last year they pushed out GX WebManager 9.0 based on the new architecture to their partners and now 9.4 to the internet community. They seem to have pretty big ambitions to grow internationally, and in my experience the technology and know-how to do it.

So congratulations to them on completing this. If you are in the market for a CMS, go check out their products and portfolio.