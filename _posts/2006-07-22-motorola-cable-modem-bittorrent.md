---
id: 166
title: 'motorola cable modem &#038; bittorrent'
date: 2006-07-22T14:23:24+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/07/22/motorola-cable-modem-bittorrent/
permalink: /2006/07/22/motorola-cable-modem-bittorrent/
dsq_thread_id:
  - "338602468"
tags:
  - google
  - nokia
  - problemsandsolutions
  - reviews
  - Software in General
  - USB
---
I've blogged several times already about my problems connecting my pc to the internet:
<ul>
	<li>Getting a <a href="http://blog.jillesvangurp.com/2005/10/07/back-online/">cable modem was easy</a>.</li>
	<li>I mistakenly bought a <a href="http://blog.jillesvangurp.com/2005/12/19/wireless-hell-2/">Siemens wireless</a> network USB stick. Solution don't buy crap and use a decent brand. Currently I'm using an smc pci card; my ibm/lenovo's laptop's built in network card and my Nokia e70 with its wlan support.</li>
	<li>The driver software going <a href="http://blog.jillesvangurp.com/2006/01/15/wlan-gone-paranoid/">paranoid</a> from time to time.</li>
</ul>
A remaining problem that has been annoying me for months is that my cable modem, a Motorola sbg900e, has some issues. Most of the time it works fine except when applications like bittorrent run. Then it just resets more or less continuously. Motorola apparently does not believe it is important to support their customers with useful advice or firmware updates so that basically meant no bittorrent for the past few months. Bittorrent is a resource intensive protocol and it probably represents a worse case scenario for the modem in terms of number of connections, bandwidth consumed etc.
Some googling ("motorola modem reset bittorrent"), once again, brought me a work around. It is not the first time that I find out the hard way that solving a technical problem is just a matter of providing google with the right keywords. Believe me I've been searching many times using the type number of my modem in the query bringing up nothing but unrelated problems and advertisement material.
Anyway, one of the people in <a href="http://www.neowin.net/forum/lofiversion/index.php/t233280.html">this forum</a> was kind enough to explain that the problem is with the number of connections that the bittorrent client tries to open simultaneously. If this exceeds a certain number, the modem firmware crashes and the modem resets (apparently earlier models just crashed and did not reset, lucky me :-). The workaround consists of telling your bittorrent client to not open too many connections at the same time. It's no problem having say 50-100 connections open at the same time but opening them all at once is a problem. True, most bittorrent clients do not have such a setting but recent versions of my favourite one (Azureus) do have such a setting. It's called "max simultaneous outbound connection attempts" and by default it is set to 16. You can find it under connection->advanced network settings. I find that, so far, limiting it to 8 prevents the modem from crashing.

Problem solved :-)