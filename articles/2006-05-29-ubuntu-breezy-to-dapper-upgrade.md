---
title: ubuntu breezy to dapper upgrade
date: 2006-05-29T17:49:30+00:00
author: Jilles van Gurp


permalink: /2006/05/29/ubuntu-breezy-to-dapper-upgrade/
dsq_thread_id:
  - "548677702"
tags:
  - eclipse
  - java
  - KDE
  - OK
  - reviews
  - ubuntu
---
I still have my old pc sitting next to my new pc. A few months back I installed ubuntu on it. Since then it has just sat there doing nothing. Occasionally I boot it into windows to retrieve some file I forgot to migrate. These occasions are getting very rare now. Soon it will be time to dispose of the box.

Anyway, I've been reading that ubuntu breezy is soooo 2005 and that ubuntu dapper is all hot and new. So I've attempted an upgraded. Forget about user friendly-ness. The procedure for this requires command line usage. But I've handled Debian before so that does not scare me. It's not like the ubuntu installation is important to me anyway (and yes, I managed to mangle quite a few Debian installs attempting stuff like this. In my experience apt-get dist-upgrade is dangerous stuff).

For the record, it's a vanilla ubuntu install with the kubuntu package installed and the kdm login manager installed. It should work just fine. Other than that, I did nothing to it other than trying to get it to work properly (which I eventually managed to do as reported earlier) and install Java and eclipse.

Here's the proper procedure: use ctrl+alt+function keys to find a non graphical console. The update procedure will include all your X, Gnome and KDE stuff. Replacing it while it is running is not a good idea IMHO (it might actually work but I didn't care to find out the hard way this time).
OK, now login. Fix /etc/apt/sources.list by replacing all occurances of 'breezy' with 'dapper'. Type sudo apt-get update. This updates your package database with the dapper packages. Now (fingers crossed) type sudo apt-get dist-upgrade. Apt-get now asks you if you are sure that you want to download 750MB (in my case) and really want to install or upgrade 1000+ packages. I said yes, you should say no unless you are sure you want this. Since then it has been downloading and installing stuff by itself. Cryptic messages about packages installing and configuring themselves fly by way to fast to read. Clearly, stuff is happening!

Now, I'm writing this while it is happening. Since that takes quite some time, let me elaborate on my expectations. As said earlier. I've dist-upgraded debian installs before. Usually to testing and I even got to unstable once (bad idea, it really was unstable). Usually it works fine, provided both the starting source and target of the procedure are stable (Debian testing by definition is not so your mileage will vary). Worst case for me was ending up with a situation where nothing worked anymore. Best case, it just worked. Ubuntu claims to be enterprise ready. If it fails here it is not.

OK, it finnished. The whole process took about an hour (excluding download). I did a sudo reboot (I'm a windows user).

Problem #1: ubuntu boots nicely to the text console. Solution: it's not a bug but a feature, ubuntu remembered that I was on a text console when I rebooted. Good thinking?!

Whoo, new kubuntu login screen. No more nasty shades of shitty brown. Oh wait this is just the default KDE look (nice). Log out, login into gnome. Looks like shitty brown is back on the menu :-(.

In short, the upgrade seems to have worked just fine. The little preferences I had seem to have migrated. Including my x settings; my manual install of java and eclipse; and a terminal icon I dragged to the desktop.

Other than this. My main points in my previous review still stand. Despite some slight improvements, menu layout is a mess; the theme looks shitty and the commandline is still required for non trivial stuff like performing an upgrade or configuring X properly (though admittedly I did not try the new installer; merely assuming it doesn't do a better job than the previous version).

Some afterthought. I installed koffice. The icons only show up in the menu when I use KDE. I guess this unified menu shit is only skin deep.