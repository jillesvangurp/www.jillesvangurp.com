---
id: 124
title: fun with rendezvous
date: 2006-03-16T22:04:39+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/03/16/fun-with-rendezvous/
permalink: /2006/03/16/fun-with-rendezvous/
dsq_thread_id:
  - "444297961"
tags:
  - apple
  - google
  - itunes
  - java
  - Software in General
  - UI
---
One of the innovative features in Mac OS X is support for <a href="http://www.zeroconf.org/">DNS-SD</a>, a.k.a. <a href="http://www.apple.com/pr/library/2002/sep/25rendezvous.html">rendezvous</a>. I was reading about the Java API for this by apple on <a href="http://www.onjava.com/pub/a/onjava/excerpt/bonjour_ch08/index.html?CMP=OTC-FP2116136014&ATT=Zero+Configuration+Networking:+Using+the+Java+APIs+Part+1">onJava</a>. Then I wondered if there was a pure Java implementation, because I dislike using native stuff in Java (complicates deployment).

That's why I like google: "+rendezvous apple pure java" -&gt; <a href="http://jmdns.sourceforge.net/">this link</a>, right at the top. So two minutes after getting this idea, I'm doing a "jmdns-1.0&gt;java -jar lib\jmdns.jar -browse" as the readme of JmDNS suggests, to launch the swing based dns-sd browser. JmDNS is a 100% pure java implementation of dns-sd that claims to be compatible with the real thing from Apple.

Now the reason I'm posting. I was expecting zero or at most a handful of dns-ds services on my network. I was absolutely shocked by the number of people publicizing these services on the same cable network as I am. There's dozens of different services, each with multiple devices offering them. It seems the default settings of Apple cause their devices to happily announce all sorts of details about themselves on the lan. The nature of cable networks of course is that the entire neighbourhood is one big lan. So effectively, I'm getting access to all Rendezvous capable devices in my neighbourhood.

Right now, I'm listening to a some AC-DC tracks of one of these users who has kindly shared his music in iTunes, which means my iTunes magically finds this music (courtesy of dns-sd) :-).

Speaking of iTunes. I'm thinking of abandoning it. I like the UI but it crashes way too often. Just now it crashed twice. <a href="http://www.yamipod.com">Yamipod</a> aledgedly is very nice and capable of syncing with my ipod.