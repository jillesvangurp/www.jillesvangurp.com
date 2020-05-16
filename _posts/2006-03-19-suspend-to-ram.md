---
id: 127
title: suspend to ram
date: 2006-03-19T11:38:28+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/03/19/suspend-to-ram/
permalink: /2006/03/19/suspend-to-ram/
dsq_thread_id:
  - "336376043"
tags:
  - ACPI
  - Doh Apparently
  - google
  - microsoft
  - PC
  - problemsandsolutions
  - Software in General
---
Over the years I've encountered, and resolved many annoying software issues with Microsoft. This one surely counts as one of the more annoying ones.

The problem is that my previous PC had a beautiful suspend to ram feature, which basically means that whenever you put the machine in stand by mode the system turns of almost completely except for a bit of power to keep the memory going. The technical term for this is ACPI S3 mode. My new PC however, suspends using ACPI S1 mode which means it goes stand by with the harddisk still spinning and the fans still blowing, not my idea of stand by. Naturally this was something I wanted fixed really badly. So I enabled the feature in the bios, set all the power options in windows as they should be and .... no success.

My mistake was to assume that this is a hardware/bios problem. So I kept checking the asrock site for bios updates and browsed through their FAQ, double checked bios settings drivers, etc.. Since this isn't a problem with their hardware, bios or drivers after all, no solution was found this way. Next stop was google, but I still had the asrock keyword as part of the query so nothing useful came out of that. Then I just gave up and for the past few months I've been shutting down the pc completely.

This morning I googled for "force s3 standby" and ended up on [this ](http://www.thegreenbutton.com/community/shwmessage.aspx?ForumID=41&MessageID=76021&TopicPage=2)site. I learned a things here:

- My system supporst S3 just fine, I checked using this <a href="http://www.passmark.com/products/sleeper.htm">sleeper </a>tool.
- Users with completely different hardware are experiencing the exact same issue (and are equally frustrated).
- There's a registry hack you can do but it doesn't do much good on its own.
- There's lots of useless advice on enabling/disabling wake up from standby options on usb devices (my mouse and keyboard are ps/2!).
- There's a tool called dumppo which supposedly does something useful.

Ok, the next google query concerned dumppo, which got me [here](http://www.shahine.com/omar/CommentView,guid,82.aspx). It appears that this is a Microsoft provided (but totally undocumented) utility that you can use to check and change the ACPI settings. Sure enough my "Min sleep state" was set to S1. The reason? I installed windows XP before I enabled suspend to ram in the bios. Doh! Apparently the ACPI settings are determined forever during setup and no functionality to fix this is included with the OS. After the installation you're screwed no matter what you toggle in any control panel, bios or other screen. Windows XP just keeps insisting that S1 is the way to do standby.

Dumppo ([download from microsoft](ftp://ftp.microsoft.com/products/Oemtest/v1.1/WOSTest/Tools/Acpi/dumppo.exe)) apparently is the only way out (short of reinstalling XP). A simple "dumppo.exe admin minsleep=s3" on the command line fixes the problem. Of course this wisdom is not officially documented anywhere on the Microsoft site. There must be millions of users out there that are unable to suspend to ram because of this. Basically all computers sold in the past few years are technically capable of suspend to ram. Many of them have the option disabled in the bios by default.

Anyway, problem solved :-). Just one of these issues ordinary users will never ever figure out. I must have solved hundreds of these issues over the years.