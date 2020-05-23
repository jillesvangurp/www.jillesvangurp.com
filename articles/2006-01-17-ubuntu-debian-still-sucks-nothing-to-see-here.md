---
title: 'ubuntu: debian still sucks, nothing to see here'
date: 2006-01-17T23:40:31+00:00
author: Jilles van Gurp


permalink: /2006/01/17/ubuntu-debian-still-sucks-nothing-to-see-here/
dsq_thread_id:
  - "336375935"
tags:
  - apple
  - google
  - linux
  - OK
  - reviews
  - ubuntu
  - UI
---
One of the nice things of buying a new pc is that you have an old pc to mess with. Having backed up the most important stuff, my old machine now is the victim of some random linux installer abuse. Right now I'm installing ubuntu, a debian derived linux distribution. It's been a few years since I ran linux outside of vmware (basically when I bought the machine I am now using for my linux install). I used to have more time to mess with trying out this kind of stuff. I know from experience that getting linux to work is easy and getting it to work properly is very difficult. Presumably, ubuntu should make this more easy but lets see what we end up with. I actually typed most of this review during the install, plenty of time for that.

If you came here to read how beautiful ubuntu is, move on because the stuff below is probably a bit painful for you.

The download.

I opted for the bittorrent release of th 5.10 release. It's a 2.8GB download so bittorrent is mandatory. Burned it to a dvd with my new drive

Booting.

Insert the dvd in the drive, make sure bios is configured to boot from cd (on most systems the default is wrong) and reset.

The installer.

Here it gets interesting. I can select install, server and live dvd. Install seems a good plan. Up comes the text based installer. I was half expecting a graphical installer so that is disappointing. Worse, the installer seems of the intimidating, piss off end user variety. Luckily, I've seen worse (I installed slackware on 486 SX 25 mhz once). Navigating is pretty straightforward if you've dealt with ms dos or similarly clumsy uis in the past. The only severe usability issue is going back. There's a back option on some screens but you can't get to it using the arrow keys. You have to use the backspace, doh!

Progress bars or lack thereoff.

Another odd thing in the installer is that in between the screens where you are supposed to select stuff you get these nice blue screens without any content whatsoever. For example, I'm currently running the disk partition tool and the screen has been very blue for the past ten minutes (of the ms bsod variety). I mean, at least display some text telling me that everything is fine and I should be patient.

Hardware detection.

My network cards are detected and configured using dhcp. Bonus points for that, nothing worse than trying to fix linux problems offline. The usb mouse seems to work (led is on) as well but I can't use it in commandline ui.

Disk partitioning.

This tool, aside from the before mentioned HUGE usability problem, seems to behave rather nice. The default is resize my hdb1 partition which supposedly makes it possible to leave my windows partitions alone. That's nice but it takes a loooooong time. A warning might have been nice. Anyway I remember the old days of manually partitioning using all sorts of obscure tools including the commandline fdisk tools of both windows and linux. Again usability rears its ugly head. After resizing the UI reappears with some worrying information about new partitions it is about to write on the (supposedly?) freed space. What's worrying is that it doesn't say how large each partition will be and what happened to the resized partition. Some confirmation that resizing worked as expected would have been nice. After some hesitation I select yes to indicate that it can do its thing. Had there been any important stuff on the partition I would probably have ejected the ubuntu disc at this point. This is bad. This is a crucial phase in the installation and if something goes wrong, it will likely be here. Bonus points for functionality but the usability totally sucks here. Partitioning is scary, especially with a tool you've never used before. I've seen it go wrong in the past.

Installing the base systems and copying remaining packages.

Finally some scrollbars. But no package selection at this point. That's probably good as debian package selection is not something you want to put in front of users at this point.  More on this later.

Timezone and user configuration, configuring apt.

I suppose this is necessary but I'd prefer a real user interface. Also there's some odd stuff here. Like having to know if the hardware clock is gmt or not (it's not, I happen to know this). Ntp + me telling what timezone I'm in provides the same information. Finally it offers to configure a bootloader (grub) so I can choose to boot into linux or windows xp. That's a nice touch. Debian got this wrong last time I tried it and I had to fix LILO manually to get back to windows.

Time for a reboot.

The boot screen. Pretty, if you like brown. And then back to the commandline UI in stylish bsod blue. It's now doing its post installation routine which appears to involve configuring a user (no root, ubuntu has no root!), installing all the debian packages, downloading a few new ones. I know how debian works so not unexpected but definately not very user friendly. It involves lots of cryptic messages about various obscure pacakages being prepared, configured etc.

It comes up with a question about screen size halfway. I select 1280x1024. I can't select refreshrate and indeed this proves to be configured wrong after the installation (60Hz instead of 85hz) Then the install continues, no more questions.

Done!

Then suddenly it is done and the login screen appears. This is linux, no further reboots necessary the installer finished without much ceremony and X was launched. The bootscreen is nice, if you like brown. I log in with my user/password. Gnome appears to be configured apple style (menu bar at the top, taskbar at the button) a popup informs me that 48 updates are available. Install seems to work fine which proves that the network is indeed configured properly.

Configuring the screen properly.

60 hz will give me a headache so that needs to be changed. Upfront I'm not very hopeful that tools have improved to the point where this can be done without manually editing X configuration files. But lets see how things have improved in the past few years.

Not much apparently. The good news is that there is a resolution tool in the system->preferences. It even has a dropdown for the refreshrate. Only one item is in it: 60HZ. Doh!

This is linux at its worst. It's not working and the provided tools are too crappy to solve the problem at hand. A search on the ubuntu site confirms that monitor configuration is undocumented. In other words, I'm on my own. Google brings up the solution which indeed involves the commandline and hoping that the autorecognition will magically work when tried again.

Of course it doesn't. Worse, I now understand why the installer tries to hide the inevitable sudo dpkg-reconfigure xserver-xorg. This basically is the good old XF86Config wizard. I have fond memories of toying with it in 1995 (slackware). It has gotten worse since. At the time it asked a few difficult but straightforward questions. The modern version of this tool presents you with a whole array of bullshit features and autorecognition features which half work. Lets face it, if they worked you wouldn't be running the reconfigure. Forget about autoconfiguration. Everything the installer figured out is now forgotten (with no obvious way to redo that part other than placing the backup back).

Essentially this is horrible tool brings together everything that sucks about X in one convenient tool. Mere mortals are guaranteed to be totally confused by this beautiful piece of shit that after all these years still survives in linux. The inability of the linux community to fix this once and for all is illustrative of the hopelessness of the whole concept of desktop linux. The linux solution to display configuration is to hide this tool instead of implement an alternative. On the first go I did not manage to get the optimal refreshrate. On the second go I screwed up the display configuration. Copying back the backed up configuration did not fix the problem.

Ahem, reboot seems to 'magically' fix the problem. At least, I'm back where I started (1280x1024 @ 60 Hz).

Ok, so much for wizards. I knew in advance that I was going to end up manually editing the display settings. For the record, this is where normal users either go back to windows or accept the headache. I know from experience that editing X configuration is a matter of trial and error. In my case five reboots and the documentation for my plug and play m990 monitor did the trick. Ubuntu failed to setup my monitor's horizontal and vertical refreshrates, something it should have figured out from the plug and play information. OK shit happens. The next problem was that the tool to fix this problem is reconfiguring the package. Doing this undos most of the good work the ubuntu installer did (so it makes things worse). Solution: copy the backup of the ubuntu configuration and edit it manually to fix the refreshrates (30-96 and 50-160 in my case). Then reboot because misconfiguring X really screws things up to the point that a reboot is required to make X start again after you fix the configuration. Been there, done that before. At least the bloody wheel mouse works out of the box nowadays.

Conclusions for the installer

Usability sucks but the installer gets the job done anyway except for configuring the screen (important). However there are several majr pitfalls you have to know how to avoid. The installer is not particularly informative about what it is doing and needlessly verbose at the same time. However, the defaults are sane and a strategy of going with the obvious choices will work most of the time (if in doubt, hit enter).

The default theme is ugly. There's no other word for it. It looks like
shit. Damn this is ugly. Yes you can fix it. There's hundreds of shitty
themes to select from. but the default is unbelievably ugly. It leaves no other conclusion than that the the ubuntu people are (color) blind. Menu layout seems ok. I have the feeling stuff is being hidden from me.

Configuring the screen properly is back to the commandline. There is no excuse for this in 2006 and I knew this was going to happen. The provided (ubuntu forum, the official documentation is of no use here) solution corrupted my configuration to the point where X just wouldn't start anymore. Unbelievable, inexcusable.

It's 2006, ten years after my first slackware install and I'm still messing
with the X configuration the same way as ten years ago. X continues to
suck.

And of course the installer fails to install the commercial nvidia driver (or even point me in the right direction). Amusingly the documentation is full of helpful stuff you can do manually that IMHO the installer should do for me. What the fuck do I care about ideological issues with commercial stuff? I'm not a GPL communist.  Give me the choice to install the driver that I likely want. Why would I spend 400 euro on a video card and then opt not to run the software that is required to access the more interesting features of this card? Exactly, that's very rare user.

OK on to the rest of the system.

Read only ntfs has been possible for years and even some experimental rw capabilities are possible these days. Not in ubuntu. Both my ntfs partitions are nowhere to be found. The system->administration->disks tool is as useless as the resolution tool. It fails to 'enable' the partitions. Yes I know how to mount stuff from the commandline. But as for Joe average, he can't get to his ntfs files with ubuntu. Bad but I can probably fix this.

Lets see about the sound card. It's soundblaster audigy. But there's also a motherboard sound card (I actually uses both under windows). Pleasant surprise, ubuntus seems to have configured this correctly. Succeeding where, so far, every version of knoppix has failed.

Good. So far I've been sceptical but lets be positive. I have a working system, ubuntu has configured itself properly my windows install still works and I have not lost any data.

Installing kde using synaptec.

Wow, this is easy. There's a separate distribution called kubuntu which is just ubuntu with kde instead of gnome. If you install ubuntu, like I did, you get only Gnome. Installing kde is as simple as installing the kubuntu-desktop package. This involves installing more pacakages from the dvd and downloading a few new ones. Alltogether, including the downloading this takes about 20 minutes (120 KB/seconds). I don't understand why the kde packages are not on the dvd though, there's plenty of room. Anyway, I  now have the latest kde and gnome on one machine. The KDE theme looks much better even though it is not the default KDE theme.

The menus in both kde and gnome are a mess. This is a linux problem in general and it's not fair to blame this on ubuntu. But still, 90% of the crap in the menus probably shouldn't be there.

Conclusions

The installer has lots of usability issues. Aside from not being graphical, it is confusing, misguiding and asks a lot of stupid stuff. The partitioning tool has good functionality but also does a good job of scaring you with some misleading information.

Configuring X still is an issue. Probably it's slightly better if you have an LCD screen (60 hz is ok then).

Hardware support is pretty decent, it failed to detect the monitor but the rest seems to work fine. It doesn't install the commercial nvidia driver that most users will want to use.

The ubuntu gnome theme is ugly
.
Kde install went smooth and the ubuntu kde theme is not that bad.