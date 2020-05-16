---
id: 50
title: subclipse
date: 2005-02-23T17:08:00+00:00
author: Jilles
layout: post
guid: 3@http://blog.jillesvangurp.com/
permalink: /2005/02/23/subclipse/
tags:
  - eclipse
  - java
  - subversion
  - versionmanagement
---
 For the zillionth time I decided to spend some time trying to get subclipse (http://subclipse.tigris.org/) to play nice with our svn+ssh repository at work. For those scratching their heads: eclipse is a popular java development ide; subversion is a version management system and subclipse is a subversion backend for eclipse's team synchronization functionality. Until recently subclipse did not support subversion repositories secured with ssh, which unfortunately is a very common type of subversion repsository (and also very easy to setup). So, no subclipse. The reason was that subclipse depends on a native subversion library which in turn depends on the presence of ssh. That's a lot of dependencies and it doesn't work without a lot of tinkering and even then it may not work.

But the good news is that the guys at http://tmate.org fixed things for the subclipse guys by providing a java only implementation of the svn library. I installed it today and it works beautifully. The eclipse team synchronization stuff looks really useful and with subclipse finally working I can now put it to work. 