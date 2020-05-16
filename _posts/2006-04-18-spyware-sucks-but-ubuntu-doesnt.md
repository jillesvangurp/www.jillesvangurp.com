---
id: 137
title: 'spyware sucks, but ubuntu doesn&#8217;t'
date: 2006-04-18T19:28:54+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/04/18/spyware-sucks-but-ubuntu-doesnt/
permalink: /2006/04/18/spyware-sucks-but-ubuntu-doesnt/
dsq_thread_id:
  - "336376302"
tags:
  - firefox
  - Netherlands
  - OS
  - reviews
  - Software in General
  - ubuntu
---
Last weekend (Easter holiday, long weekend) was a good opportunity to visit my parents in the Netherlands. Apart from beloved son, I'm also their system administrator. Last time I made a mistake, I left them behind with a partially secured windows machine. The thing was behind a router and they were using firefox (saw to that personally). Anyway, when I checked this weekend the machine was full of very nasty spyware. It was basically unusable and the spyware interfered with normal usage of the machine.
I tried to fix it using the usual tools ([adaware](http://www.lavasoft.de/software/adaware/), [spybot](http://www.spybot.info/)) but this did not work 100%. Both tools managed (on multiple attempts) to identify and remove a shitload of spyware. But the remaining few managed to 'fix' this as soon as they were done. Eventually I thought the machine was clean but then the rebooting started. After booting everything would look allright, and then it would reboot. Effectively I only had a few minutes to figure out what was going on before this happened. That gets old real quick.
That was roughly when I decided to bring the laptop home and start from scratch. Of course before doing so, I have to make an attempt to back up my parent's files and family photos. Accessing the laptop in its current state is pretty much impossible, hence the title of this post. [I stand corrected](https://www.jillesvangurp.com/2006/01/17/ubuntu-debian-still-sucks-nothing-to-see-here/): ubuntu does not suck after all. It's merely very unsuitable for end users :-).

A few weeks back I posted my not so positive review of ubuntu. Currently I'm using it to rescue some files. I won't bother trying to actually install it on the laptop for my parents. The main reason is that I have a hard enough job supporting my parents without them having to learn an entirely new OS. After years of practice they can sort of do things by himself now. Things like burning a cd, editing photos, doing banking, etc. I have no desire to start from scratch with them on all of that.

But the point is that it would work very well. I booted into the live dvd image. I actually mistook the dvd for my knoppix cd. I was pleasantly surprised to find a booted ubuntu desktop when I came back. All hardware, including smc pcmcia wireless card, onboard sound and display had been recognized. The wireless card needed to be configured for my network, which was easy once I had found the tool. Confusingly there is a system and administration menu that both contain network related tools.

Then I had to mount the ntfs partition. I tried to use the disk tool but it is useless (you can mount but not access the partition unless you are root which is not very convenient in ubuntu where you can't log in as root). I had to do some googling to make the correct changes to fstab manually and then proceeded to mount using the good old commandline. That worked. Then I sshed (using nautilus) into my windows box (which runs cygwin) and I'm currently uploading some crucial files. After that completes, I'll wipe the laptop and be sure to lock it down properly this time.

lessons learned:

- no auto update + no firewall + unsecured wlan = very bad idea
- firefox + router != enough protection
- adaware and spybot are not good enough for recovery, these are fine prevention tools however
- ubuntu doesn't suck, it's a nice addition to any system administrators toolbox :-)

