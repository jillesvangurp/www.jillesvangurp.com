---

title: 'ubuntu &#8211; the story continues'
date: 2007-09-11T22:37:22+00:00
author: Jilles van Gurp


permalink: /2007/09/11/ubuntu-the-story-continues/
tags:
  - finland
  - FUCKING
  - google
  - problemsandsolutions
  - reviews
  - ubuntu
  - WLAN
---
If you've been following my ubuntu rants [(one,](https://www.jillesvangurp.com/2007/01/27/another-ubuntu-installation-test/) [two,](https://www.jillesvangurp.com/2007/04/29/feisty-fawn/) [three](https://www.jillesvangurp.com/2007/05/17/more-ubuntu/) + latest comment), you'll know that so far the experience has been not as FUCKING advertised (excuse the explicitive). Well, here's another rant:

After tracking down the kernel driver issue (mind you all my notes on installer usability still apply) that prevented my network from working, I had a way to get a working install. Since I no longer trust gparted to resize my ntfs partition (see post three) I opted for [Wubi](http://wubi-installer.org/). Wubi is a great idea, just install everything in a disk image file on your windows C:\ and add a item to the default windows xp bootloader to boot ubuntu. Brilliant. The installer works as advertised:

- You fill in some details
- It downloads a custom ubuntu iso image for you (would be better if I wasn't forced to download it with the installer)
- it adds an item to the bootloader
- it reboots
- it boots into a loopback filesystem on the disk image on your windows drive

Here Wubi's job ends and Ubuntus text installer takes over (so bye bye usability, welcome to the wonderful world of text based installers). Unlike the normal installation you have 0 control so naturally all the same things go wrong. I.e. it got stuck at "scanning the mirrors" again. This time I unplugged the network cable and killed a few processes in one of the other terminals (ctrl+alt+f2, nice trick I remember from slackware days) hoping the installer would pick up the hint. Surprisingly it did, although it did mess up the apt sources.list in the process. Anyway, the installer completed, I rebooted and configured the WLAN, which does work, unlike on many other people's hardware. One reboot later (sounds like windows doesn't it :-). I was looking at the ubuntu desktop.

Fixing what's wrong.

As I know from previous times, ubuntu does not do a good job of installing my video card + monitor and my sound card. The video+monitor card took a few tries and obscure commands to get right. Apparently the x.org 7.3 in the next release of Ubuntu will do a better job, The sound card issue is due to the fact that I have a modern PC with multiple sound devices. Since Ubuntu likes to guess when it should ask me, I end up with all the sound going to my USB headset instead of the soundblaster and no obvious way of fixing it. The problem is that the tools to fix this are not installed. That's right, it is assumed that Ubuntu is always right and if not you are on your own. This is true for network; this is true for video; this is true for sound. 

It gets worse.

Then (after fixing sources.list which curiously had all entries twice?!) I did an update with synaptic: 260 MB. And promptly ran into this [bug](https://bugs.launchpad.net/bugs/104553). Oops broken pipe bla bla bla, upgrade failed: here's a bunch of really obscure errors, isn't synaptic great? Pasting the first line of where things went wrong into google brought me straight to this bug (lucky me). This was another of those opportunities where maybe ordinary users would give up. A rather obscure fix in the bug report helped (basically touch all the failed files and re-run apt-get upgrade). For the record, I did not install anything before running into this bug. Just install ubuntu in Finland + upgrade is enough to trigger this bug. Known since April apparently and related to timezones.

More later. The good news is that I have a bootable system and can probably resolve most remaining issues. The bad news is that so far the experience has been really, really, really bad. I've been struggling with things that should just work or fail more gracefully.

