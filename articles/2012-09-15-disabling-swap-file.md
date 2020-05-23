---

title: Disabling swap file
date: 2012-09-15T14:59:43+00:00
author: Jilles van Gurp


permalink: /2012/09/15/disabling-swap-file/
aktt_notify_twitter:
  - 'no'
dsq_thread_id:
  - "845426395"
categories:
  - Blog Posts
tags:
  - Adobe Aperture
  - GB
  - OS
  - RAM
---
I have an imac from 2009. At the time, I maxed out the memory to a whopping 4GB. This may not seem much these days but it is still plenty for most things.

Over time, my disk has gotten a bit fragmented, applications have gotten a bit heavier (e.g. Firefox commonly uses well over a GB), and things have gotten a little slower. 

I had already half decided to buy a new mac to 'solve' this problem by simply getting the latest model and maxing out the RAM. The only problem is that Apple seems to be dragging their heels refreshing their iMac line, which is now more than a year old (ancient basically). So, I'll have to survive for a bit and figure out how to do that until they get around to fixing that.

Basically the primary reason for slowness on macs is swapping. You may think you have enough RAM, and you may in fact have plenty of available RAM. It doesn't matter, your mac will swap applications to disk even when you don't need the memory. That takes time. Especially on fragmented disks. Basically on my machine it got to a point where the disk would be churning for minutes every time I opened applications and there was considerable lag when switching applications that I had already opened. All this despite still having a full GB of memory available. So even though I am nowhere close to running out of memory, the OS decides to spend time swapping stuff to and from disk almost constantly. Reason: it was designed well over a decade ago during a time when 16MB was massive amount of memory. I have about 250x that amount.

I found [this nice post](http://wiki.summercode.com/how_to_disable_or_enable_swapping_in_mac_os_x) explaining how to turn swapping off (you have to reboot for this to work). Now there are all sorts of reasons why swapping and virtual memory are good things in theory and all sorts of advice warning that all sorts of evil things can and will happen if you mess with it. 

Consider yourself warned. 

There are also people claiming that swapping "improves performance". The latter point is of course massive bull shit: how does using a massively slower disk help make things faster compared to only using RAM, which has massively better bandwidth and latency?. There are also loads of people confusing virtual memory and swap space whining that applications won't run without virtual memory. Virtual memory is the notion that applications have access to a memory space that is much larger than the available RAM. On a 64 bit machine, this typically is way more than the capacity of your disk or indeed most storage solutions (think a couple of hundred TB). 

Swap space on the other hand is used for temporarily swapping memory to disk that has actually been allocated and is in use by some application to free it up for some other application. I.e. you don't swap virtual memory but only memory that is actually used. So, swapping is only useful when you need more RAM than you have and when you somehow prefer to not close applications and instead have their memory written to disk and read from disk when you switch between them.

Provided you have enough RAM to run all the applications that you need, this should be exactly never. On servers this is the reason you generally turn swapping off because by the time you need it, your server is dead anyway. On desktops, the same argument can be used, provided you can fit your applications into memory comfortably.

So, I turned off swapping on my mac a few days ago and was rewarded with a massive reduction in disk activity and nearly full restoration of the performance I enjoyed when this machine was still new and 4GB was four times what you actually needed. I call that a huge win.

Now, there is one caveat: modern operating systems run hundreds of processes. Those processes use memory. Nasty things happen if it cannot be allocated. The price of running out of memory is that random processes may crash and fail. If that happens to a critical process, your entire OS becomes unstable and you may have to reboot. Solution: make sure you don't run out of memory. The good news is that normally you shouldn't run out of memory except when running buggy software with memory leaks or when running a lot of software or software with extreme memory needs (e.g. Adobe Aperture or some games). A little awareness about what is running goes a long way to avoiding any trouble.

I routinely have Firefox open with a few dozen tabs, spotify, skype, a terminal, eclipse, and maybe preview and a few other small things. With all that open, I'm still below 3GB. That leaves about 1 GB for file caches, misc other OS needs, and a little bandwidth to open extra applications. If I run low on memory, or suspect that I will, I simply close a few applications.

I used to do this with windows XP as well and only recall a hand full of cases where applications crashed because they ran out of memory. Well worth the price for a vast increase in performance. Turning off swapping on old PCs is pretty much a no brainer and especially on new ones with way more memory than you need (and considering memory prices, why would you run with less ...), I cannot possibly imagine any scenario where swapping adds any value whatsoever but I guess it would be a nice fallback solution as a last resort when the only alternative would be for applications to crash. Unfortunately, neither macs nor windows pcs have a setting that would enable that. So, turning off swapping entirely is the next best thing.