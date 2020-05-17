---
id: 47
title: more on subclipse
date: 2005-02-24T20:27:00+00:00
author: Jilles van Gurp
layout: post
guid: 6@http://blog.jillesvangurp.com/
permalink: /2005/02/24/more-on-subclipse/
tags:
  - eclipse
  - java
  - versionmanagement
---
 I had some more fun with subclipse today. The integration with eclipse is much better than I anticipated. Eclipse already has extensive cvs functionality. Subclipse acts as a backend for this functionality and that means you get a lot of nice features. I was also pleasantly surprised with how well subclipse performs. Overall I am not so happy with eclipse in this respect (rebuilds suck and they happen a lot). But at subclipse seems to do well (compared to tortoise svn and commandline svn). Of course the bottleneck is network and disk io and doing this in Java doesn't seem to have much performance impact. Things like getting svn logs for directories actually seems to work faster. Also I absolutely love the diff tools in eclipse. 