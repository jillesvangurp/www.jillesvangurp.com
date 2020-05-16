---
id: 489
title: Local Interaction demo on Youtube
date: 2008-10-09T18:11:36+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=489
permalink: /2008/10/09/local-interaction-demo-on-youtube/
dsq_thread_id:
  - "557280365"
categories:
  - Blog Posts
tags:
  - Academic
  - Apache Lucene
  - Local Interaction
  - nokia
  - python
  - Python Django
  - smart space
  - Ubiquitous Pervasive Computing
---
<object width="425" height="344"><param name="movie" value="http://www.youtube.com/v/cGNYn8YLlpA&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><embed src="http://www.youtube.com/v/cGNYn8YLlpA&hl=en&fs=1" type="application/x-shockwave-flash" allowfullscreen="true" width="425" height="344"></embed></object>

I gave a demo of our system at a press event for Nokia a few weeks ago. Our PR people were busy filming and have put several short demo movies on Youtube. Including my demo and several other cool demos from colleagues in Nokia Research.

So enjoy.

Since I expect there will be people interested in learning more about this. I'll try to give some explanation right here.

In the Youtube movie above, I am showing off our Local Interaction demo, which is a mobile website that shows off our indoor location based service platform. For the positioning we have collaborated with a different team that has been working on a indoor positioning system, which was demoed separately at the same event. Our demo leverages their technology and provides services on top.

Indoor location based services are similar to outdoor location based services in the sense that things like search, navigation, social networking, and media sharing are all things that can benefit from knowing where you are. In a nutshell, we have indoor location enhanced variants of these features integrated into our platform. However indoor location based services are different in the sense that they are much more relevant to people. People spend most of their lives indoors! 

Having a platform is nice of course, but working code with real users is nicer. So we have spent most of this year preparing a trial in a real shopping mall here in Helsinki. The website you see has a nice polished UI, rich indoor content for the shopping mall and a set of useful services around the mall concept aimed at both consumers as well as proprietors of the mall, such as shop owners. The advantage of working with a real place is that it forces you to be very pragmatic about a lot of issues. 

Doing a demo like ours is easy if you can assume everybody goes to the same building, uses the same phone, and just the right firmware version + your handcrafted application. A substantial part of the Ubiquitous & Pervasive Computing research community is perfectly happy with that sort of demo setups and proofs of concepts. This is why despite decades worth of demos, there's no significant technology available for consumers beyond the boring old home automation kits and that sort of thing. It takes a bit more to make a real life impact.

A key motivation for our demo is that we don't want to make such assumptions. Our requirements are: a capable mobile web browser (most modern Nokia phones and many phones from other vendors), and optionally, the indoor positioning client software installed. Like Location based services, our services are actually perfectly usable without positioning so we don't actually require positioning. Being web based means that we can reach much more users than with a native application.   

With everything we do we have the vision that eventually we don't want to do this in just one shopping mall but world wide in a lot of public places. The primary goal of our trial is to gain experience rolling out this kind of technology and learning more about all the practical and technical obstacles there are for making this work on a more interesting scale in the future. We want to show that our platform is scalable in both a technical sense as well as a business sense. We want to kickoff a whole new market for indoor location based services. It doesn't exist today, so we have to build the whole ecosystem from scratch.

**For the more technical people**. Our web platform is based on Python Django and integrates the positioning and other services using REST based services over HTTP. The friends feature we demo is realized using the Facebook API. We rely on Atom pub and Atom feeds internally. We intend to be mashup friendly so as to not have to reinvent every feature ourselves and instead integrate with many existing services. We have an Apache Lucene based search server that powers our indoor location based search feature. We use this feature quite heavily to look for indoor location tagged content such as photos, ads, vouchers, comments, etc. Finally, we use an off the shelf open source map server that serves up the indoor maps. In general, our philosophy is that there are already enough poorly reinvented wheels. We build what we need only if we can't reuse what is out there. The web is out there and we use it.

**For the researchers**. A few articles that should be published in the next few months will outline the research we have on this. Meanwhile, you can refer to my publications page for a few workshop papers on a a predecessor of this demo that we did in 2007. Also we did a demo at the Internet of Things conference last April of our 2007 demo. And of course, there will be more details on the trial once we launch it. 

**About the project**. This demo was developed as part of a Nokia project on an "Application Environment for Smart Spaces" which is currently running in Smart Space Lab, which is a part of Nokia Research Center. Headcount has varied quite a bit but currently we are around 8 people working full time on this. My role in this project is pushing architecture solutions and coordinating the development together with a small group of researchers and several excellent software engineers. 