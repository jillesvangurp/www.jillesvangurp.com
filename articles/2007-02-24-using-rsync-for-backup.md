---

title: Using rsync for backup
date: 2007-02-24T14:00:19+00:00
author: Jilles van Gurp


permalink: /2007/02/24/using-rsync-for-backup/
dsq_thread_id:
  - "336376853"
tags:
  - CRC
  - createdbyjilles
  - google
  - linux
  - Particularly Fujifilm
  - problemsandsolutions
  - subversion
  - versionmanagement
---
As you may recall, I had a nice incident recently which made me really appreciate the fact that I was able to restore my data from a backup. Over the years I've sort of gobbled together my own backup solution using rsync (I use the cygwin port to windows).

First a little about hardware. Forget about using CDs or DVDs. They are just too unreliable. I'm currently recovering data from a whole bunch of CDs I had and am horrified to discover that approximately one third has CRC errors on them. Basically, the light sensitive layer has deteriorated to the point that the disc becomes unreadable. Sometimes as soon as within 2 years. I've used various brands of CDs over the years and some of them have higher failure rates than others but no brand seems to be 100% OK. In other words, I've lost data on stored on pretty much every CD brand I've ever tried. Particularly Fujifilm (1-48x) and unbranded CDs are bad (well over 50% failure rate) on the other hand, most of my Imation CDs seem fine so far. Luckily I didn't lose anything valuable/irreplacable. But it has made it clear to me to not trust this medium for backups.

So, I've started putting money in external harddrives. External drives have several advantages: they are cheap; they are big and they are much more convenient. So far I have two usb external harddrives. I have a 300GB Maxtor drive and the 500GB Lacie Porsche drive I bought a few weeks back. Also I have a 300 GB drive in my PC. Yes that's 1.1 TB altogether :-).

The goal of my backup procedures is to be 'reasonably' safe. Technically if my apartment burns down, I'll probably lose all three drives and all data on them. Moving them offsite is the obvious solution but this also makes backups a bit harder. Reasonably safe in my view means that my backed up data survives total media failure on one of the drives and gives me an opportunity to get to the reasonably safe state again. When I say my data, I'm referring to the data that really matters to me: i.e. anything I create, movies, music, photos, bookmarks, etc.

This data is stored in specific directories on my C drive and also a directory on my big Lacie drive. I use the Maxtor drive to backup that directory and use the remaining 200GB on the lacie drive for backing up stuff from my C drive.

All this is done using commands like this:

`rsync -i -v -a --delete ~/photos/ /cygdrive/e/backup/photos  >> /cygdrive/e/backup/photos-rsync.txt`*

This probably looks a bit alien to a windows user. I use cygwin, a port of much of the gnu/linux tool chain that layers a more linux like filesystem on top of the windows filesystem. So /cygdrive/c is just the equivalent of good old c:\. One of the ported tools is ln, which I've used to make symbolic links in my cygwin home directory to stuff I want to backup. So ~/photos actually points to the familiar My Pictures directory.

Basically the command tries to synchronize the first directory to the second directory. The flags ensure that content of the second directory is identical to that of the first directory after execution. The --delete flag allows it to remove stuff that isn't in the first directory. Rsync is nice because it works incrementally. I.e. it doesn't copy data that's already there.

The bit after the >> just redirects the output of rsync to a text file so that afterwards, you can verify what has actually been backed up. I use the -v flag to let rsync tell me exactly what it is doing.

Of course typing this command is both error prone and tedious. For that reason I've collected all my backup related commands in a nice script which I execute frequently. I just turn on the drives; type ./backup.sh and go get some coffee. I also use rsync to backup my remote website which is easy because rsync also works over ftp and ssh.

Part of my backup script is also creating a dump from my subversion repository. I store a lot of stuff in a subversion repository these days: my google earth placemarks; photos; documents and also some source code. The subversion work directories are spread across my harddrive but the repository itself sits in a single directory on my cdrive. Technically I could just back that up using rsync. However, using 

`svnadmin dump c:/svnrepo | gzip > /cygdrive/e/backup/svnrepo.gz`* 

to dump the repository allows me to actually recreate the repository in any version of subversion from the dump. Also the dump file tends to be nicely compressed compared to either the work directory or the repository directory. Actually, the work directory is the largest because it contains 3 copies of each file. In the repository, everything is stored incrementally and in the dump gzip squeezes it even further. The nice thing of a version repository is of course that you preserve also the version history.

