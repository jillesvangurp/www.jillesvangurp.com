---
id: 235
title: porsche gets some good testdrive
date: 2007-01-31T23:50:52+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/01/31/porsche-gets-some-good-testdrive/
permalink: /2007/01/31/porsche-gets-some-good-testdrive/
categories:
  - Blog Posts
tags:
  - apple
  - Bill Gates
  - firefox
  - itunes
  - linux
  - microsoft
  - PC
  - reviews
---
It's only two days ago that I bought myself a Lacie Porsche 0.5 TB usb drive. Yesterday evening, after a reboot caused by an apple security update weird shit started to happen. Basically windows informed me that "you have 3 days to activate windows". WTF! So I dutifully click the activate now only to watch a product key being generated and the dialog closing itself, rather than letting me review the screen and opting for a internet or telephone based activation. After that it informed me that I had three more days to activate. Very weird and disturbing news! A few reboots and BSODs later (which had now also started to appear on pretty much every reboot), I took a deep breath and decided that the machine was foobarred and I needed to reinstall windows. I suspect the root cause of my problems was a reset a while back which resulted in a corrupt registry and repeated attempts by windows to repair it before booting normally. I thought the problem was fixed but apparently the damage was more extensive than I originally thought.

Considering I had a few more days to reactivat, which despite my attempts I could not do, I decided to back up everything I could think off. I.e. I have about 100 GB left on the external drive, bought it just in time :-). Copying that amount takes shitloads of time. Basically most of the backup ran overnight with the assistence of the cygwin port of rsync. After re-installing windows earlier this evening (which activated fine, to my surprise), I got to work reinstalling everything (I have a few dozen applications I just need to have) and moving back all my data. Some interesting things:

- Luckily I thought of backing up my c:\drivers dir in which I stored various system level drivers for my motherboard and other stuff that I downloaded when I installed the machine a year ago. This included the essential driver for the lan, without which I would have had no network after the install and no way to get the driver on the machine (or to activate it). Pfew.
-  I reapplied the [itunes migrate library procedure](https://www.jillesvangurp.com/2006/01/09/new-pc-moving-itunes-library/) I described last year (and which still gets me loads of hits on the blog). It still works and my library, including playlists, ratings and playcounts imported fine in my new itunes install. Would be nice if Apple was a bit more supportive of recovering your stuff in a new install.
- After installing firefox 2, I copied back my old profile folder and firefox launched as if nothing had happened. Bookmarks, cookies, passwords, extensions all there :-). Since I practically live in this thing, that pleased me a lot.
- Then I reinstalled gaim and copied back the .gaim directory to my user directory. Launched it and it just worked. Great!
- Same with jedit.
- Then I installed steam, logged in and ran the restore back up tool that was created along with the 13GB backup. Seems to work fine and I'm glad that I don't have to wait a few weeks for the download to finnish. Ok the restore was not fast either but it got the job done.

Lesson learned: backups are important. I had the opportunity to create them when it turned out I needed them. But I should have been backing up more regularly. A more catostrophic event would have caused me dataloss and much more annoyance.

So a big thank you to Bill Gates et al. for wasting my precious spare times with their rude and offensive activation crap. Fucking assholes! I'm a paying customer and very pissed. I will remember this waste of my time and genuine disregard for my rights when making any future microsoft purchasing decisions. And yes, that probably means lost revenue for you guys in Redmond.  I've adopted opensource for most of my desktop apps by now. There's only two reasons for me to boot windows on my PC: games and photoshop. I understand the latter is now supported by wine and  I'm much less active with gaming than I used to be. Everything else I use either runs on linux or has great alternatives. But for the moment, I'll keep using windows because I'm lazy.