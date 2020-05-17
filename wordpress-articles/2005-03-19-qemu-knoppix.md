---
id: 37
title: 'qemu & knoppix'
date: 2005-03-19T11:06:00+00:00
author: Jilles van Gurp
layout: post
guid: 16@http://blog.jillesvangurp.com/
permalink: /2005/03/19/qemu-knoppix/
tags:
  - KDE
  - linux
  - reviews
---
 Recently knoppix 3.8 was released. Knoppix is a nice linux distribution that you can boot straight from cd. It has two primary uses: showing off some linux desktop software without actually installing linux and doing maintenance on pcs (by bypassing the installed os). Fairly nice but useless to people like me since I am not a system administrator and know how to setup linux. No, the reason I dowloaded it was qemu. Qemu is a computer emulator that can emulate a variety of processors and is apparently advanced enough that it can run stuff like windows, linux, macos X and a whole bunch of other operating systems. Now that is interesting. And some guy put a nice qemu/knoppix bundle up for download.

Of course the problem with emulating is that it is slow. And it shows. Booting into KDE from the iso took a whopping 30 minutes. Then loading www.slashdot.org in konqueror took another two minutes. But the point is that it seems to work. With a ten fold performance improvement it would become quite useful. Of course stuff like vmware is much more suitable for doing this kind of thing. But the nice thing about qemu is that it is not limited to just emulating x86 but can also emulate a mac, a sparc and probably any processor architects that the qemu developers choose to support. It's a tool with lots of potential and I expect to hear a lot more from it when it matures over the next few years. 