---
id: 362
title: Bad behavior
date: 2007-12-30T16:16:57+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/12/30/bad-behavior/
permalink: /2007/12/30/bad-behavior/
dsq_thread_id:
  - "336377404"
categories:
  - Blog Posts
tags:
  - IP
  - problemsandsolutions
  - UI
  - WELHO
  - wordpress
---
My previous post was a bit short because I was basically calling the taxi to the airport at the same time. The reason for this was "[Bad Behavior](http://wordpress.org/extend/plugins/bad-behavior/)", which is a wordpress plugin that got a little overzealous and locked me out of my own site stating that I had just been blacklisted. Consequently I spent most of the half hour before I left figuring out what the hell was wrong and cursing those damn bad behavior idiots.

I didn't manage to figure that out entirely but did figure out that the problem was not on my side of the connection at least (lucky me). Figuring that out was easy since I just used my phone's 3G connection only to discover that that ip address also had been blacklisted. The chances of both my phone, PC and/or WELHO (cable) and Elisa (3G) providers being hacked and blacklisted correctly were pretty small. So bad behavior was misbehaving big time and software that misbehaves doesn't really last that long with me.

Only problem: I could not actually log in to my site via the wordpress admin UI to fix it (blacklisted, doh!). Since all the advice out there on how to fix this seems to assume you do that, here's how to kill bad behavior properly:

1. Figure out your IP address
1. Edit whitelist.inc.php in the bad behavior plugin directory and add your IP address to the array.
1. Upload this file to your remote site.
1. Login to your wordpress admin UI (should work now)
1. Disable the plugin and delete it (unless you like pissing off randomly blacklisted users)
1. in phpmyadmin or whatever you use to admin your wordpress db: DROP TABLE `wp_bad_behavior`;

BTW. In analyzing the behavior of the misbehaving plugin, I also discovered that it does nasty things like putting user passwords in a database for every login attempt, plain text. Bad behavior indeed, hence the drop table. 

