---
id: 339
title: 'OpenID &#038; Microformats in WordPress'
date: 2007-10-01T23:09:24+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/10/01/openid-microformats-in-wordpress/
permalink: /2007/10/01/openid-microformats-in-wordpress/
dsq_thread_id:
  - "336377299"
categories:
  - Blog Posts
tags:
  - Guys It
  - microformats
  - openid
  - wordpress
---
The good news is that [Will Norris is making progress with his openid plugin](http://willnorris.com/2007/10/plugin-updates). Once he puts up a release, I'm probably going to give it a try. 

The bad news is that the wordpress bug database still lists as a main reason to not support [openid ](http://openid.net) that [support is provided by third party plugins](http://trac.wordpress.org/ticket/3613). I think this is rubbish. 

First of all, they've broken those plugins several times with wordpress updates. Secondly, the reason they break is that authentication is rather critical to how wordpress security works (i.e. it is kind of non trivial to do properly). This is why I'd like first class support for OpenID rather than second class we currently get. And finally most of the plugins appear to be abandon-ware (they once were excellent hobby projects but people seem to have moved on with their lives) and there are no release quality openid plugins for wordpress 2.2 and higher. Will Norris seems to have adopted one of the abandoned plugins (which is very nice of him) but as discussed, I'd prefer a bit more structural solution in terms of support, testing and integration. What I'd really like is the wordpress guys getting off their ass and provide first class support for openid like the Drupal guys are doing. I hope his plugin will get some nice exposure and will eventually be picked up by the wordpress guys as something to properly integrate into wordpress.

In general, the wordpress people seem to be a bit reluctant to pick up new blog technology lately. For example, I'm using the [barthelme](http://www.plaintxt.org/themes/barthelme/) theme which supports a number [microformats ](http://microformats.org/)and semantically structured html. Barthelme basically provides searchengines, microformat plugins and other semantic tools with a shitload of hooks to extract information from the blog. That is sort of hidden for ordinary users but kind of rapidly becoming crucial to the whole notion of web 2.0 Sorry for sounding superficial, I hate this 2.0 bullshit as much as anyone (forget about a web20 tag on this site). 

Tag support in wordpress is a nice first step and it should be noted that they [do it properly](http://microformats.org/wiki/rel-tag). Also, there seem to be patches in the bug database for [hcard](http://trac.wordpress.org/ticket/2105) and [hatom](http://trac.wordpress.org/ticket/2105) support. It would be great if these changes actually make it into 2.4 instead of just floating around (like they've been doing for some time). Also nice would be extending atom feed support to the default template. This still defaults to listing only rss feeds, despite the fact that Atom Pub has prominently featured on the last few wordpress release notes (2.2.2 and 2.3) and that backend support for Atom 1.0 feeds has been present for quite some time now. Guys: It's just one line of text to fix! Get it in already!