---
id: 82
title: wireless hell
date: 2005-12-17T11:45:49+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/?p=82
permalink: /2005/12/17/wireless-hell/
tags:
  - BTW
  - GAIM
  - Improvement Right
  - reviews
  - UPDATE
---
This wireless shit is absolute crap. This is the second time I'm setting up a wireless network. The first time was for my father. He'd bought a wireless adsl router (smc) and a usb stick. It didn't work. So he brought back the stick and got one from another brand (my advice). It sort of worked but the connection was very poor. So far he'd been doing stuff by the book (he knows nothing about computers) and then he called in me. First action: remove the crappy software from the previous stick. That didn't work (the uninstaller is broken) but at least the connection was a bit more consistent now since the old software no longer intervened. Second action replace the driver for the new stick, no improvement but it made me feel better. Third action: replace the firmware of the router. That worked! Suddenly the connection was fine and it has been ever since. Conclusion: the router software was crap and the first usb stick was crap. More importantly, the manufacturer of the router knew it was crap and silently fixed the problem and released an update. Thousands of it's customers must still be getting a really lousy end user experience. Getting this setup to work required non trivial intervention that no normal consumer would ever figure out. BTW. the troubleshooting material, website and documentation were like the software: poorly written crap.

Now fast forward to 2005. I'm buying a wireless router and a usb stick. I know I am in for trouble. But I'm an optimist so I RTFM, sit back and watch the thing install. First sign of trouble: the widgets of the wlan monitor look like the thing has been written in ancient pascal. These old borland applications had a distinctively looking, shitty look and feel that dates back to 16 bit windows. I've seen several such applications in my life and I now associate this look and feel with poor quality software that is extremely likely to crash, hard. Had a screenshot of this software been displayed on the box, I would have left it on the shelf. But the connection sort of worked so I leave it alone. Second sign of trouble, I now have an Odyssey thingy ontop of the tcp thingy in my network properties from an obscure company by the name of funk.com. Two layers of crappy software is like asking for trouble. It claims to do stuff with security.

Then an hour later my mouse stops moving, the system is frozen. My pc has some stability issues (cpu overheats) so I do not directly suspect the usb stick, yet. I reset. Hey the wireless network icon is missing and the monitor icon is greyed out. Hmmm. What could be wrong here? Power cycle, same thing happens again. No connection. It's plug and play so I (un) plug and pray. Now the wireless icon reappears but this time with a nice red cross. Improvement! Right click, repair connection. And we're back in business. That's some nasty bugs down there. Just to be sure I downloaded the latest driver from siemens. The well hidden changelog mentions some 'installation issues' were fixed, yeah right. Confusing website too.

Half an hour later it happens again exact same scenario. And then again. Also I notice that GAIM keeps reconnecting every few minutes. Now I'm getting suspicious and zoom in on the monitor application: it looks like crap so it probably is crap. So uninstall the entire wireless software (monitor, funky odyssey + driver), plug and pray, and this time manually install only the driver when windows 'detects the new hardware'. Let the windows wireless wizard thingy do it it's thing (that's crappy too but at least it looks like it was written this century). I seem to be back in business, for now. At least long enough to write this text. I'll keep you posted. If it doesn't stay online until tonight I'm bringing back this heap of smelly crap to the store.

Lesson learned: when installing wireless lan, don't touch any of the cds that come with it. Download the latest driver, install it through the software that comes with windows and minimize the number of external software components.

UPDATE. It appears I've not solved the issue yet. Uptime has improved somewhat (up to 2.5 hours) but it still disconnects at random, has trouble finding my router and hangs very often. I've also upgraded the chipset software. The router firmware seems to be the latest version (at least, motorola doesn't offer any upgrades). I've now disabled wep encryption. In other words, I'm running out of options.  :-(. If this doesn't do the trick, nothing will.

UPDATE 2. I enabled the upnp service. Seems to be working, I've been online for 4.5 hours now. Could this be it?

UPDATE 3. No computer freezes today. I did lose the connection a couple of times. I understand that wifi cards can operate at different channels and that channel 1 (default), 6 an 11 use different frequency ranges. I'm in an apartmentblock with several wifi routers in range and who knows what other equipment. So I changed the channel to 11. I suspect interference is part of the problem.
