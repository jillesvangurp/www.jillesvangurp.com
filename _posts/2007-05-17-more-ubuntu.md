---
id: 284
title: More ubuntu
date: 2007-05-17T12:29:22+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/05/17/more-ubuntu/
permalink: /2007/05/17/more-ubuntu/
dsq_thread_id:
  - "336377094"
tags:
  - google
  - linux
  - problemsandsolutions
  - reviews
  - ubuntu
---
I've given up on feisty. I've blogged several times now about my failure to install it properly. Today I gave it another try and partially succeeded before failing again.

I read somewhere that you can bypass the scanning the mirrors problem by disconnecting the network cable. You see, running ifdown eth0 is not good enough because ubuntu tries to outsmart you with its network manager. It's becoming more and more like windows. The assumption that the user is a complete idiot now dominates the whole installer. Anyway, unplugging the network forces ubuntu to acknowledge some hard reality.

So I ended up with a bootable ubuntu system this time (misconfigured and all). Great, only the network still didn't work properly. For some reason some stuff loads in the browser (e.g. google) but most stuff does not. So I was in the weird situation that I could google for my problem, get a lot of hits but unable to access any of them. So I spent the whole morning booting windows and ubuntu repeatedly. Each time in windows I tried to get some answers (no network trouble there) and in linux tried to mess with the ubuntu networking subsystems.

I failed. After the fifth time I just decided not to bother anymore. Obviously ubuntu has some weird bugs in their network layer that I do not encounter with older versions or with windows. From what I googled I learned that there are many unrelated problems related to networking in ubuntu. I now strongly suspect the dns related behaviour of my cable modem is the cause. Replacing the modem might solve my problems. But then again it might not. It's a motorola cable modem and there is no question about the quality of the firmware being particularly sucky. I have to reboot this sucker quite often and already have decided to never ever buy anything with motorola firmware embedded again. Without a working network, ubuntu is basically not very interesting. Can't run updates or install software. If anyone has a proper solution, I'd be interested to hear it.

Part two of my misery started when I started messing around with gparted. Basically I removed the linux partitions and then decided to give back the space to the ntfs partition. At this point it started to throw very scary messages at me about my ntfs partition halfway through resizing it. For about 15 minutes I was assuming it had foobarred the partition table (very depressing even though I have back ups). Finally after a reboot the ntfs partition showed up fine in gparted (unmodified) and it even mounted it without being asked (really annoying feature but welcome in this case). Next problem was booting it. I relearned a few lessons about mbr there (fdiks /mbr helped me out a few times when I was playing with slackware ten years ago). Basically the fix in windows xp is running fixmbr from the windows rescue console. Until you do that, you are stuck with a broken grub that points to a deleted partition. For legal reasons (I assume) gparted and grub lack the feature of undoing the damage to the mbr.
It took me about half an hour to figure that out and I'm now running my old windows desktop again.

So I have three conclusions to add to my review a few weeks ago:

- The networking subsystem has huge compatibility issues that likely affect many users. From what I encountered while googling, I learned that there are many different issues. The fixes I tried didn't work which suggest that these many issues are different from my specific issue. Not good. The same modem and pc have booted older ubuntu releases (dapper) so it is a regression! My modem is quite common so likely thousands of users are affected.
- Gparted has some nasty issues and should not be used to resize ntfs partitions. You will risk losing all your data. I guess any partition resizer is better than none but this crap should not be put in front of end users.
- In this form, ubuntu is guaranteed to cause lots of users to have a very negative introduction to linux.

I will try a future version again. For now, I've had enough.