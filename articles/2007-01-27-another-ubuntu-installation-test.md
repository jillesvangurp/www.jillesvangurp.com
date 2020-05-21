---
id: 232
title: another ubuntu installation test
date: 2007-01-27T14:15:18+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/01/27/another-ubuntu-installation-test/
permalink: /2007/01/27/another-ubuntu-installation-test/
dsq_thread_id:
  - "336376803"
tags:
  - CRT
  - linux
  - OK
  - reviews
  - ubuntu
---
Currently ubuntu is my favourite linux distro. I don't use it but do install it and other distros from time to time to see where linux is going. I've been doing this a couple of times per year since about 1995 when I was biking home from university with 30 or so slackware floppy disks in my bag. So, I am not a newby!

Things have been getting a lot easier since then. I bought a new PC last year and recently wiped everything from the old one so I can sell it, eventually. It's a AMD 2200+ with 1 GB of ram, 2 hds (80 and 120 GB), a nvidia 4400, a cd burner and a dvd burner and some minor heat related instability (works fine with the cover off). The stability issue is the main reason I still have this machine, I just feel bad about selling something with issues. If you are interested in taking over the hardware, let me know. I promise full disclosure of any hw issues I'm aware of and you'll inherit some fine components at bargain price (negotiable). Should make an excellent linux desktop or server still. I suspect it is either the powersupply or cpu fan that is the issue. Should be easy to fix by somebody with more hardware tinkering experience than me.

In short, it's ideal for one of my linux tests. So I downloaded the ubuntu 6.10 desktop iso, burned it and popped in the cd. Below is a chronological account of what I did and how that worked out.

- It boots into a graphical desktop from the install cd. This is nice but it also takes about five minutes for it to properly boot.
-  On the desktop sits a big install icon. I guess I'm supposed to click it even though I already selected install in a previous menu.
- The wizard launches and leads me to new and improved dialogs for setting the usual stuff (keyboard, language, user and password) and then presents me with a menu with three options to use the first hard drive, the second one or manually partition. The both option seems to be missing, so I go manual. This seems to work nicely although I now find out that I should have picked a different cd if had wanted soft raid 0. Ah too bad.
- I partition it to have root and swap on drive 1 and home on drive 2 (the 120 GB one).
- I click next and the installer goes to work. This takes about 20 minutes during which I have the opportunity to use the fully functional desktop that runs the installer. It seems to include a couple of games, a browser and some other stuff. Fun, I guess but cdroms don't repsond to nicely to multiple processes doing stuff at the same time so I leave it alone.
- Done. Reboot!
- Oops, it's 2007 and ubuntu still fucks up display configuration. I smelled a rat when I wasn't presented with an option to configure the screen and indeed ubuntu botched it completely. It sort of works but 1024x768 at 60HZ sort of sucks on a CRT that can do 1280x1024 at 85HZ. It hurts my eyes! And there's no option to fix it in the menu. There is a resolution dialog but this only allows me to select even worse resolutions. Naturally, the excellent binary driver nvidia provides is not installed so I can't use any of the high end features of my once very expensive nvidia card. Come on guys, fix this. Both monitor and videocard are plug and play. You have no good excuse to not recognize either. I guess removing the, admittedly, very crappy monitor and videocard configuration was a bad idea because now I'll have to do things manually and find out how much X configuration still sucks.
- It informs me there's 160 MB worth of updates so I do the autoupdate. Apparently there were quite a bit of issues with 6.10 when it was released causing some people to recommend the previous version. Lets see how good things are after the update.
- Wow! A linux update that requires me to reboot. That's a first. I guess it is getting better at reproducing the windows experience :-).  OK, lets do this.
- Yikes! So I click around a bit and suddenly the desktop freezes. Mouse still works but clicking anywhere doesn't seem to work as expected. I can switch to the text console using ctrl+alt+f1 keybinding. So a default install with no custom software installed produces a freeze by just clicking around in the menus a bit.
- Ctrl+alt+del has not been implemented so I use the good old reboot command from one of the consoles: "sudo reboot now". Life is great, 0 things installed/configured and I need a command line already. This had better not happen again!
- OK, rebooted. Lets fix the fucking screen first. Synaptic package manager sounds right, let search for nvidia. OK, clickety, nvidia-glx sounds right. Apply means install I guess. So much for usability :-).
- Great the video driver is installed but X was not restarted. I guess that requires another manual override. I know there's ways to do this without a restart but the option is not provided in the shutdown screen. So here goes another required reboot. This is feeling more and more like windows by the minute. Random freezing, check. Required reboots (three so far), check!
- Oops, I still can't fix the default resolution. This is bad! Effectively I am now stuck with a broken desktop that gives me headaches. I will need to get under the hood to fix it. I know how to do it but it just pisses me off that I have to do this on what is supposedly the most user friendly linux distro.
- As explained [here](http://tuxicity.wordpress.com/2006/12/04/nvidia-on-ubuntu/) you need to fix things from the commandline. The good news: whoohoo 85 HZ. The bad news, still no 1280x1024 in the screen resolution thingy.
- [This page](http://tuxicity.wordpress.com/2006/12/02/configure-your-resolution-in-ubuntu-and-debian/ ) has the instructions for launching the good old x configuration tool. This sucker hasn't changed substantially in ten years and insists on leading you through a whole bunch of screens for mouse and keyboard (which were detected just fine). It brings tears to my eyes that this tool actually wants me to enable the emulate three buttons option. Anyway, hitting enter works as advertised and I now run in the right resolution and refreshrate.
- Lets launch firefox .... seems to work and it's 2.01! Good!

OK so far for a default install. So overall, this is not good. X installation after ten years of linux distributions is still a mess. The basic job of configuring generic plug and play monitors as well as the installation of essential drivers is still a mess. Ubuntu has made this more "userfriendly" by removing the tools needed to fix this from the setup. This just makes them harder to find.

On the other hand, once installed, ubuntu is a pretty nice distribution. Of course the cd install is a bit limited but I'm fixing this right now by installing a few hundred MB worth of add on packages which are now being downloaded over the network.

Some things I noticed good and bad:

- GOOD Graphical install seems more user friendly.
- NOT SO GOOD The graphical install takes ages to launch. Effectively it adds five to ten minutes to the whole installation procedure.
- VERY GOOD The graphical install boots into a fully functional CD with network connectivity and a browser. Though I did not need it this time, I have had to abort installations in the past in order to boot into windows to be able to access online documentation. So this is great!
- EXTREMELY BAD Screen configuration is not part of the setup procedure and the automated routines fail miserably. Predictably my monitor and graphics card are misconfigured and the only fix involves entering commands on a commandline. I think it is safe to say that this part of the installation is not compatible with most end user capabilities. I don't see how a non technical user could fix their screen settings without somebody holding their hands while they execute cryptic commands on the commandline. This is a regression from last time I installed ubuntu.
- BAD I don't like that the screen resolution tool provides no obvious references for fixing the extremely likely case of a misconfigured X desktop. Both the binary nvidia driver and a properly configured CRT are things most users would want to fix.
- BAD installing nvidia-glx via synaptic does not trigger the additional configuration of x.org to actually use it that is obviously implied by this action.
-  BAD X froze on me after the updates but before I had configured anything. I had no obvious way to fix this other than go to the comandline and execute a command that no end user should be aware of. If I were an end user, I would have reset the pc.
- NOT SO GOOD the shutdown screen does not contain an option to restart X. True, you shouldn't need it but I needed it anyway during screen configuration so it should be there.
- BAD synaptic is hopelessly complicated and lacks a few simple coarse grained options like just install the bloody KDE desktop without me micromanaging all the details.

BTW. I still think the shitty brown sucks.

UPDATE. install of additional software went fine but using the hibernate pc resulted in an obscure error. If it doesn't work, don't put it in the fucking shutdown screen!