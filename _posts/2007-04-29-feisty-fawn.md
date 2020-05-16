---
id: 277
title: Feisty fawn
date: 2007-04-29T09:32:19+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/04/29/feisty-fawn/
permalink: /2007/04/29/feisty-fawn/
tags:
  - google
  - LCD
  - linux
  - OSS
  - reviews
  - ubuntu
---
I tried ([again](https://www.jillesvangurp.com/2007/01/27/another-ubuntu-installation-test/)) to install ubuntu and ran into a critical bug that would have left my system unbootable if it weren't for the fact that I know how to undo the damage the installer does. Since this will no doubt piss off the average linux fanboy, let me elaborate.
<ul>
	<li>I ran into the "scanning the mirrors" bug. Google for "scanning the mirrors" + ubuntu and you will find plenty of material. </li>
	<li>This means the installer hangs indefinitely trying to scan remote mirrors of apt repositories.</li>
	<li>Predictably the servers are under quite a bit of load currently: this is extremely likely to not work for a lot of people right now. I recall running into the same issue a month ago with edgy when there was no such excuse.</li>
	<li>The bug is that the installer should detect that things are not working and fail gracefully</li>
	<li>Gracefully in the sense that it should
<ul>
	<li>Allow the user to skip this step (I only had a close button, which was my only option to interrupt the scanning the mirrors procedure)</li>
	<li>Never ever, ever, ever, let the user exit the installer *AFTER* removing the bootflag on the ntfs partition but before installing an alternative bootloader.</li>
	<li>Recover from the fact that the network times out/servers are down. There's no excuse for not handling something as common as network failure. Retry is generally a stupid strategy after the second or third attempt.</li>
	<li>I actually ran ifdown to shut the network down (to force it into detecting there was no connection) and it still didn't detect network failure!</li>
</ul>
</li>
</ul>

The scanning the mirrors bug is a strange thing. Ubuntu actually configured my network correctly and I could for example browse to Google. However, for some reason crucial server side stuff was unreachable. Since ubuntu never gave an error, I can't tell you what went wrong there. This in itself is a bug, since murphy's law pretty damn much guarantees that potential network unreliability translates into users experiencing network problems during installation. 

Could I have fixed things? Probably. Will I do so? Probably not, my main reason for trying out 7.04 was to verify that in fact not much has changed in terms of installer friendlyness since 6.10. All my suspicions were confirmed. In short, the thing still is a usability nightmare. The underlying problem is that the installer is based on the assumption that the underlying technology works properly. In light of my 10+ years experience with installing linux, this  is extremely misguided. The installer merely pretends everything is ok. The problem is that it sometimes doesn't in which case a usable system distinguishes itself from an unusable system by offering meaningful ways out. For example, display configuration failed (again, see my [earlier post](https://www.jillesvangurp.com/2007/01/27/another-ubuntu-installation-test/) on edgy installation) which means I was looking at a nice 1024x768 blurry screen on a monitor with a different native resolution. I suspect the nvidia + samsung LCD screen combo is quite popular so that probably means lots of users end up with misconfigured ubuntu setups. The *only* way to fix it is after the installation using various commandline tools. Been there done that. The resolution change dialog is totally inadequate because it mistakenly assumes it was configured correctly and only offers resolutions that it properly detected (i.e. 640x80 -1024x768 @60Hz, no hardware has shipped this decade with that as the actual maximum specs). 

I found the two main new features in the installer misguided and confusing. The installer offered to migrate my settings and create an account. The next screen then asks me who I am. Eh ...  didn't I just provide a user/password combo. And BTW. what does it mean to migrate My Documents? Does it mean the installer will go ahead and actually copy everything (which I don't want, it's about 80GB) or will it merely mount the ntfs disk (would be useful). I need a little more info to make an informed decision here. 

The other main new feature is to actually advertise the binary drivers that most end users would probably want installed by default. That's good. The problem is that the dialog designed to offer it is very confusing (using such terms as unsupported) and also that the drivers are not actually on the cd. In other words I couldn't actually install them for the same mysterious network problem outlined above. Similarly, the dialog doesn't seem to have a good solution for network failure. The reality with the drivers is that they are the only thing that the hardware vendors support (i.e. they have better support for the hardware and from the actual vendor that provided it). The problem of course is that they are ideologically incompatible with some elements in the OSS community. Which probably lead to the probably highly debated blob of text explaining to the user that it is not recommended to install the unsupported software which happens to be the only way to get your 300$ video card working as advertised. The dialog does not do a good job of explaining this, which is it's primary job.
