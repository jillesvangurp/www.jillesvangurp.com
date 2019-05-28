---
id: 429
title: Paper on Sensor Actuator Kit evaluation
date: 2008-07-31T19:17:00+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2008/07/31/426-revision-3/
permalink: /2008/07/31/426-revision-3/
---
One of our interns, Filip Suba, presented a <a href="http://www.jillesvangurp.com/static/filipsuba-sensors.pdf">paper</a> earlier this week in Turku at the Symposium on Applications &amp; the Internet. He's one of my former (since today) master thesis students that has been working in our team at NRC for the past few months. The paper he presented is actually based on his work a few months before that when he was working for us as a summer trainee (previous summer that is). His master thesis work (on a nice new security protocol) is likely to result in another paper, when we find the time to write it.

Anyway, we hired him last year to learn a bit more about the state of the art in Sensor Actuator development kit with a particular focus on building applications and services that are kit independent and exposing their internals via a web API. This proved quite hard and we wrote a nice paper on our experiences.

In short, wireless sensor actuator kits are a mess. Above the radio level very little is standardized and the little there is is rarely interoperable. Innovation here is very rapid though. The future looks bright though. I watched this nice video about Sun Spot earlier this week for example:

<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="425" height="344" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"><param name="allowFullScreen" value="true" /><param name="src" value="http://www.youtube.com/v/fGSObzubTfY&amp;hl=en&amp;fs=1" /><embed type="application/x-shockwave-flash" width="425" height="344" src="http://www.youtube.com/v/fGSObzubTfY&amp;hl=en&amp;fs=1" allowfullscreen="true"></embed></object>

The notion of making writing on Sensor node software as simple as creating a J2ME Midlet is in my view quite an improvement over hacking C using some bugg