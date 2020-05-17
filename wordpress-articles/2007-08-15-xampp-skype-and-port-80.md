---
id: 321
title: xampp, skype and port 80
date: 2007-08-15T23:01:34+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/08/15/xampp-skype-and-port-80/
permalink: /2007/08/15/xampp-skype-and-port-80/
dsq_thread_id:
  - "336377207"
categories:
  - Blog Posts
tags:
  - microformats
  - openid
  - problemsandsolutions
  - reviews
  - webdevelopment
  - wordpress
  - WTF
---
For some time I've been considering setting up some php development environment. Not that I like php but I want to play with some php stuff nevertheless (e.g. Drupal seems interesting). So I downloaded one of the popular all in one packages that combine apache, mysql and php: [xampp](http://www.apachefriends.org/en/xampp.html). I have actually set up apache, mysql and php manually once on windows and know that it is A) doable and B) very tedious, hence the integrated package this time.

Xampp sure makes it really easy. Download, install, run xampp configuration tool, start mysql ... green, start apache ... ???!??!!! WTF, it won't start. So I go to localhost with the browser, blank page instead of the expected error. So I check my processes list, no sign of httpd. Now this is weird, some process is definitely listening on port 80. So, I run netstat to find out who is guilty of this crime. It turns out that skype is actually listening on port 80 for some stupid reason. That just sucks. Luckily there's an option in the skype preferences to turn it off but still, don't open port 80 if you are not a web server.

Anyway, problem fixed and 2 minutes later I've created a database using phpmyadmin and installed [drupal 5.2](http://drupal.org/) and configured it. That's just what I wanted: 2 minutes of work and *poof* instant website.

In case you are wondering, yes I am considering to dump wordpress. The reason is the lack of clear progress in getting proper openid, atompub and microformats support in wordpress. You can all sort of bolt it onto a wordpress install but not without editing php and default templates (and this tends to break during upgrades, i.e. every 2-3 months). Drupal seems much more feature rich and configurable than wordpress and it sure is tempting. Concerns I have include import/export of data (including e.g. uploads); openid support; comment & referral spam blocking; etc. 

**Update.**

After playing with drupal 5.2 and a development snapshot of 6.0, I've decided not to migrate because simply the migration is too hard currently. There is only a seriously outdated module for drupal 4.7 which can only migrate wordpress version 2.0. In other words, this is unlikely to work for my blog without a lot of tinkering. Additionally, moving from drupal to something else is likely not exactly trivial either. I migrated from pivot to wordpress early 2006. That was quite painless since wordpress has excellent import feature. Drupal lacks such features and wordpress has no Drupal import as far as I know (would be hard due to the generic node datastructure in drupal).

BTW. I've spent some time researching the topic. This link here is the most informative I was able to find: http://drupal.org/node/69706. Be sure to also check the comments.

I've taken a brief look at joomla too. Interesting product but not really designed for Blogs. Overall, I'm pretty happy with wordpress. It's just that I want proper openid support.