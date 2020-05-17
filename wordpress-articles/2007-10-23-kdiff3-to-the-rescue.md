---
id: 348
title: Kdiff3 to the rescue
date: 2007-10-23T23:47:05+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/10/23/kdiff3-to-the-rescue/
permalink: /2007/10/23/kdiff3-to-the-rescue/
dsq_thread_id:
  - "336377322"
categories:
  - Blog Posts
tags:
  - linux
  - OMFG
  - python
  - reviews
  - versionmanagement
---
I was struggling this evening with the default merge tool that ships with tortoise svn. It's not bad and quite user friendly. However, I ran into trouble with it when trying to review changes in a latex file (don't ask, I still hate the concept of debugging and compiling stuff I would normally type in word). The problem was that it doesn't support word wrapping and that the latex file in question used one line per paragraph (works great in combination with an editor that does soft word wrapping like e.g. Jedit).

A little googling revealed that the problem had been [discussed](http://svn.haxx.se/tsvnusers/archive-2007-05/0256.shtml) on the tortoise svn mailing list and dismissed by one of the developers (for reasons of complexity). Figuring that surely somebody must have scratched this itch I looked on and struck gold in the form of this blogpost:[KDiff3 - a new favorite](http://www.pluralsight.com/blogs/craig/archive/2004/10/14/2787.aspx) about [KDiff3](http://kdiff3.sourceforge.net/). 

The name suggests that this is a linux tool. Luckily it seems there is a windows port as well so no problem here. I installed it and noticed that by default it replaces the diff editor in tortoisesvn (good in this case but I would have liked the opportunity to say no here). Anyway, problem solved :-). A new favorite indeed.

Update:

Nice little kdiff3 moment. I did an update from svn and it reported a python file was in conflicted state. So I dutifully right clicked and selected edit conflicts. This launched kdiff which reported: 4 conflicts found; 4 conflicts automatically resolved. It than opens into a four pane view (mine, base, theirs and merged) allowing you to easily see what the merged result looks like and what the conflicts were. OMFG! where were you all this time kdiff3!! Damn that is useful. The resolutions look good too. I remember using tortoise svn doing merges on very large source base in my previous job and this is exactly what made them suck so much.