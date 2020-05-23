---
title: Paper on Sensor Actuator Kit evaluation
date: 2008-07-31T19:17:36+00:00
author: Jilles van Gurp


permalink: /2008/07/31/paper-on-sensor-actuator-kit-evaluation/
dsq_thread_id:
  - "397329451"
categories:
  - Blog Posts
tags:
  - Academic
  - Filip Suba
  - New publication
  - NRC
  - research
  - Sensor Actuator
  - Sun Spot
  - workshop
---
One of our interns, Filip Suba, presented a [paper](https://www.jillesvangurp.com/static/filipsuba-sensors.pdf) earlier this week in Turku at the Symposium on Applications & the Internet. He's one of my former (since today) master thesis students that has been working in our team at NRC for the past few months. The paper he presented is actually based on his work a few months before that when he was working for us as a summer trainee (previous summer that is). His master thesis work (on a nice new security protocol) is likely to result in another paper, when we find the time to write it.

Anyway, we hired him last year to learn a bit more about the state of the art in Sensor Actuator development kit with a particular focus on building applications and services that are kit independent and exposing their internals via a web API. This proved quite hard and we wrote a nice paper on our experiences.

In short, wireless sensor actuator kits are a mess. Above the radio level very little is standardized and the little there is is rarely interoperable. Innovation here is very rapid though. The future looks bright though. I watched this nice video about Sun Spot earlier this week for example:
[Sun Spot](http://www.youtube.com/v/fGSObzubTfY&hl=en&fs=1)

The notion of making writing on Sensor node software as simple as creating a J2ME Midlet is in my view quite an improvement over hacking C using some buggy toolkit, cross compiling to obscure hardware and hoping it works.