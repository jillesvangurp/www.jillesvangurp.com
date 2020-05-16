---
id: 346
title: Spam users
date: 2007-10-17T19:20:08+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/10/17/spam-users/
permalink: /2007/10/17/spam-users/
dsq_thread_id:
  - "866897172"
categories:
  - Blog Posts
tags:
  - problemsandsolutions
  - wordpress
  - WTF
---
The latest in blog spam seems to be users signing up with obscure addresses like filesearch@o2.pl (feel free to send all sorts of crap that way) and not posting any comments. This was sort of a minor annoyance until now but over the past 24 hours I've had 5 new user registrations like this.

I have no idea why they do this. It might be that they are trying to gain access to my blog software for hacking/spamming purposes. Hint: my provider automatically stops attempts to abuse its servers for mass mailing attempts and I would find out pretty fast if some asshole was doing this. Whatever the reason, I delete accounts that don't follow up with an actual comment and have installed a solution to prevent automated attempts in the future: [capcc](http://fuctweb.com/2007/06/15/capcc/). This plugin allows wordpress to separate real people from bots trying to abuse my web infrastructure and it seems to work pretty nicely. I now have several plugins conspiring against malicious users and hope that is enough for some time.

For real users coming here, I'm sorry about all the obstacles in between you and actually providing comments on my blog. Unfortunately this is the only way for me to keep spam off my blog.

<strong>Update</strong>.
For victims of the same problem, here's a useful query:

<blockquote>DELETE FROM wp_users WHERE wp_users.id NOT IN (SELECT DISTINCT user_id from wp_comments)</blockquote>

This will delete any user without any comments. Of course backup your database before running this and if it blows up in your face don't come complaining here.

<strong>Update</strong>.

It just occurred to me (damn that's a full 24 hours, WTF is wrong with me) that having capcc removes the need for me to require users to register before commenting.