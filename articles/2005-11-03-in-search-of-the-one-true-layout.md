---

title: In search of the One True Layout
date: 2005-11-03T20:11:37+00:00
author: Jilles van Gurp


permalink: /2005/11/03/in-search-of-the-one-true-layout/
dsq_thread_id:
  - "393177182"
tags:
  - CSS
  - IMHO
  - One True Layout
  - Software in General
  - wordpress
---
A few weeks back when I re-launched my blog in wordpress, I made a few comments about not being interested in working around the many specification and implementation bugs of CSS and make a really nice, spiffy layout for my blog. That's why you are looking at the (pretty) default template of wordpress. 

This article captures my point perfectly:
 [Introduction - In search of the One True Layout](http://positioniseverything.net/articles/onetruelayout/)

It describes a solution to a very common layout problem: how to position blocks on the page next to each other. The solution outlined works around several IE bugs. Then when it works they point out to make it do what you really want (like put the whole thing in a containing block), you will need to work around even more bugs, including a few mozilla bugs that surface when you use these workarounds. Oh and the whole thing does not work in Mozilla anyway due to a recently introduced bug that (on trunk) has just been fixed (today!).

That's why I don't want to do CSS/HTML based web design anymore. Any reasonably complicated design requires you to either compromise on what you want to achieve or to use a whole series of bug workarounds, stretching the css implementation well beyond its specified/intended behaviour and hoping that next months browser updates won't break things.

Unacceptable. 

CSS is a hopelessly complicated and IMHO deeply flawed standard.  Sadly, no alternatives are available.
