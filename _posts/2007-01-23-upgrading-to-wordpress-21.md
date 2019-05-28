---
id: 230
title: Upgrading to wordpress 2.1
date: 2007-01-23T17:49:30+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/01/23/upgrading-to-wordpress-21/
permalink: /2007/01/23/upgrading-to-wordpress-21/
dsq_thread_id:
  - "438128388"
categories:
  - Blog Posts
tags:
  - firefox
  - google
  - java
  - OK
  - openid
  - wordpress
---
Whoohoo, <a href="http://wordpress.org/development/2007/01/ella-21/">wordpress 2.1</a> was released this morning. I'm upgrading tonight so expect a few hours of downtime/reduced functionality.

<strong>Update</strong>.

Well that went relatively ok. It seems a few of my plugins needed upgrading. Sadly, no compatible upgrade was available for widgets which I used to beautify my sidebar. But the important stuff is still there. I removed a few other plugins that I was hardly using.

Oddly, the database backup plugin is no longer included. I'll look for a replacement.

In terms of functionality, there doesn't seem to be that many features that are vastly different.

<strike>The editor is not working as advertised. It isn't autosaving and the wysiwyg is missing in action. I actually like the current non wysiwyg version better, but still. I'm wondering if I did anything wrong.</strike>

<strong>Update 2</strong>.

I've deleted all files except my plugins (google analyticator and openid delegation), configuration and uploads.  Then I re-uploaded the wordpress 2.1 stuff this time ensuring that there is no cruft from previous installations. This should have fixed the editor stuff but didn't. I don't see tabs for switching to wysiqyg. Also there does not seem to be any spellchecking except for the default firefox stuff. <span style="text-decoration: line-through">Solution: allow sites to abuse javascript by messing with stuff they shouldn't be touching. At least that is what is claimed here </span><a href="http://wordpress.org/support/topic/101716?replies=9" style="text-decoration: line-through">http://wordpress.org/support/topic/101716?replies=9</a><span style="text-decoration: line-through">. Only thing is that it doesn't work.</span>

<strong>Update 3</strong>.

OK, found the problem. You need to toggle "use visual editor" in the user profile. Weird place for such an option and an obvious usability problem.