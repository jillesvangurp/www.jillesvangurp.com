---
id: 155
title: jedit plugin manager
date: 2006-05-21T15:46:37+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/05/21/jedit-plugin-manager/
permalink: /2006/05/21/jedit-plugin-manager/
dsq_thread_id:
  - "340870888"
tags:
  - eclipse
  - IO
  - java
  - problemsandsolutions
  - Utilities Global
---
I tried to install some plugins in <a href="http://www.jedit.org">jEdit</a>, my favourite programming editor (for things other than Java, for that I use eclipse of course). I got some IO errors trying to install some plugins in the plugin manager. Since this has happened before, I looked into it and found a solution to the problem:
<ul>
	<li>go to Utilities->Global options</li>
	<li>Select plugin manager</li>
	<li>click 'update mirror list'</li>
	<li>select one of the alternatives</li>
</ul>
Apparently the problem is that the default repository url in jEdit is no longer ok. Changing it to another one fixes that problem. Since the whole point of jEdit is using the many plugins that are available this is a pretty critical thing to fix.

Anyway, I'm glad to see that development for jEdit seems to be picking up again. I noticed that the 4.3pre4 release is fairly recent.  Also the sourceforge page shows that there is a healthy activity on the core jEdit source code.  I'm glad because it started to feel like this project was more or less dead. Jedit is pretty unique, all the other editors have (much) less features.