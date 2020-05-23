---
title: Ubuntu at work
date: 2008-05-05T20:56:35+00:00
author: Jilles van Gurp


permalink: /2008/05/05/ubuntu-at-work/
dsq_thread_id:
  - "341104459"
categories:
  - Blog Posts
tags:
  - eclipse
  - google
  - GUI
  - linux
  - python
  - ubuntu
  - UI
---
After my [many, not so positive, reviews](https://www.jillesvangurp.com/tag/ubuntu/) you might be surprised to learn that I'm actually using it at work now. Last week, a recent Mac convert dumped his 'old' laptop on my desk which happened to be a Lenovo T60 with a nice core duo processor, ATI graphics and 2 GB of memory. One of the reasons for the mac was that the thing kept crashing. This can either be a hardware or a software problem. I suspect the latter but I'll have to see.

It so happens that my own windows desktop is increasingly less compatible with the linux based python development going on in the team I'm in. So even before taking the laptop, I was playing around with a vmware image to run some server stuff. My idea was to do the development on my desktop (using eclipse + pydev) and deploy on a vmware server with ubuntu and the right dependencies. Slow, but it should work, mostly.

So instead, last friday I installed Ubuntu 7.10 (only CD lying around) on the T60 and then upgraded it to 8.04 over the network. The [scanning the mirror error](http://www.google.com/search?q=ubuntu+%22scanning+the+mirror%22) I discribed earlier struck again. This time because of a corporate http proxy (gee only the entire fortune 500 list probably uses one: either add proxy settings to the installer or don't attempt to use the network during installation). Solution: unplug network cable and let it time out.

Display detection actually worked this time. Anyway, I was only installing 7.10 to upgrade it to 8.10. Due to the scanning the mirror error, the installer had conveniently commented out all apt repositories. Of course there's no GUI to fix that (except gedit). After fixing that and configuring the proxy in various places, I installed some 150MB worth of upgrades and then tried to convince the update manager to show me the upgrade to 8.04 dialog that various websites assure users should show up. It refused to in my case. So back to the commandline. Having had nasty experiences upgrading debian from the commandline inside X, I opted to do this in a terminal (alt+f2). Not sure if this is still needed but it can't hurt. Anyway, this took more than an hour. In retrospect, downloading and burning a 8.04 image would have been faster.

So far so good. The thing booted and everything seemed to work. Except the wireless lan was nowhere to be seen ([known issue with the driver apparently](http://linuxtechie.wordpress.com/2008/04/24/making-intel-wireless-3945abg-work-better-on-ubuntu-hardy/), haven't managed to fix this yet). Compiz actually works and looks pretty cool. I have sound. I have network (wired).

Almost works as advertised one might say.

Until I plugged the laptop in its docking station and connected that with a dvi cable to the 1600x1200 external screen. Basically, I'm still struggling with this one. Out of the box, it seems impossible to scale beyond the native laptop screensize. What should happen is that either the dockingstation acts as a second screen or that it replaces the laptop screen with a much better resolution. Neither of this happens.

I finally edited xorg.conf to partially [fix the resolution issue by adding 1600x1200](http://ubuntuforums.org/showthread.php?t=742408) as an option. Only problem: compiz (the 3d accelerated GUI layer) doesn't like this. I can only use this resolution with compiz disabled. If I enable it, basically it adds a black bar to the right and below. I wasted quite a bit of time trying to find a solution, so far without luck although I did manage to dig up a few links to compiz/ubuntu bugs (e.g. [here](http://forum.compiz-fusion.org/archive/index.php/t-42.html)) and forum posts [suggesting I'm not alone](http://http://www.backports.ubuntuforums.org/showthread.php?t=761270). This seems to be mostly a combination of compiz immaturity and x.org autodetection having some cases where it just doesn't work. With my home setup it didn't get this far.

My final gripe concerns the amount of pixels Ubuntu/Gnome wastes. I ran into this running eclipse and noticing that compared to windows it includes a lot of white space, ugly fonts that seem to use a lot of space. Screen real estate really matters with eclipse due to the enormous amount of information the GUI is trying to present. Check here for some [tips on how to fix eclipse](http://blog.xam.dk/archives/81-Making-Eclipse-look-good-on-Linux.html). This issue was emphasized even more when I tried to access my 1400x1050 windows laptop using Ubuntu's remote desktop vnc client and the realvnc server running on windows. The retard that designed the UI for that decided in all his wisdom to show the vnc session in a vnc application window with a huge & useless toolbar with a tab bar below that (!) with in that a single tab for my windows session. Add the Ubuntu menubar + task bar and there is no way that it can show a 1400x1050 desktop in a 1600x1200 screen without scrollbars (i.e. altogether I lose around 250-300 pixels of screen real estate). Pretty damn sad piece of UI design if you ask me. Luckily it has a full screen mode.

In case you are wondering why I bother to document this, the links are a great time saver next time I need to do this. Overall, despite all the hardware issues, I think I can agree with Mark Shuttleworth now that under controlled hardware circumstances this is a pretty good OS. Window 95 wasn't ideal either and I managed to live with that for several years.