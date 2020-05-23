---

title: wireless hell (2)
date: 2005-12-19T21:14:25+00:00
author: Jilles van Gurp


permalink: /2005/12/19/wireless-hell-2/
tags:
  - google
  - problemsandsolutions
  - reviews
---
The story below has gotten a little long so I'll summarize for the benefit of those with similar problems:

I applied various solutions to the connectivity and stability problems I encountered:

- My PC froze up every half hour. This required a reboot and then unplug/replug the usb stick and then repair the connection.
- I noticed gaim reconnected every few minutes. Connection was marked as good and then it was suddenly dropped.
- Sometimes my router could not be found at all and then one minute later it had an 'excellent' connection

Here are the solutions I applied:

- Look for firmware upgrade. In my case there wasn't any but if there is this may be your solution
- Look for driver updates for your wireless card/usb stick. Generally the software on the cd is obsolete. This applies to any hardware you buy.
- See if you can live without the wireless monitor thing that was installed along with the driver. 
- Uninstall the software and driver
- make sure you have the (downloaded) driver somewhere on disk
- reboot
- windows may recognize your usb stick on boot, opt to select the driver yourself and then to locate the driver yourself
- If windows does not detect your hardware, go to control panel-systems-device manager. Likely there is an exclamation mark at the icon of the device. You can fix the problem by rightclicking, properties and then install the new driver. Alternatively you can use the find new hardware wizard.
- If all goes well, you can now configure your wireless connection through the default windows wizard. It is less feature rich than your monitor app, which is just fine if all you want is a network connection.
- Some of the more advanced/non-standard features may not be available to you. Most notably, non standard speeds such as 108mbps. This does not really as matter as much as you might think since those speeds are based on compression rather than actual bits. Hard to compress data like multimedia, photos and compressed binaries do not really benefit that much from this network layer compression.

- You may have disabled upnp in the past. In it self this is a good thing because you probably don't need it. Unfortunately, in my case the driver depends on this service. So, go to control panel-administrative tools-services and set the upnp service from disabled to automatic (this means it will start if it is required).
- If connectivity problems remain the reason may be interference from other devices. Most wifi cards default to channel 1 (this is a busy channel). Depending on where you live you may select from 11 or 13 channels. Some of these channels have overlapping frequencies. Channels 1, 6 and 11 do not overlap. You can configure the channel on your router and may need to configure it elsewhere to. I set the channel to 11 and the number of disconnects has dropped substantially.
- Figure out type and brand of the faulty hardware (and possibly of the chipset in that hardware) and google for your problem. Likely you will find this site if you have the same hardware as me: a motorola sbg900e cable modem and a siemens gigaset 108 usb wlan stick. You may find it useful anyway even if you don't have the same hardware.

This more or less solved my problems. I still encounter the occasional disconnect. But it now reconnects immediately, by itself. A smart download manager, gaim and most media players should survive the brief disconnect without intervention.

If the above does not solve your problem, bring back the hardware to the store and change it for a different brand. Seriously, having to go through all of the above constitutes a really bad end user experience. Things are definately not working as advertised and you are entitled to complain, loudly! Most shop people are totally incompetent so be understanding of their ignorance but insist on a replacement or refund. Don't accept the same brand unless you are sure you had a hardware failure. If you do so anyway, make a deal with the shop that if the replacement doesn't work either he'll refund.

If someone from Siemens reads this: you people suck. Your software is absolute crap and you know it.