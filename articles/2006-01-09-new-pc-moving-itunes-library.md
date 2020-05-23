---

title: 'New PC &#038; moving itunes library'
date: 2006-01-09T20:39:18+00:00
author: Jilles van Gurp


permalink: /2006/01/09/new-pc-moving-itunes-library/
dsq_thread_id:
  - "336375914"
categories:
  - Blog Posts
tags:
  - AOL
  - apple
  - google
  - HD
  - itunes
  - PC
  - problemsandsolutions
  - Software in General
---
**Update 30/07/2009**I just bought an imac and moved the same, but now consolidated, library over to it. Check out the instructions [here](https://www.jillesvangurp.com/2009/07/30/migrating-itunes-windows-to-mac/).

Whoohoo! My new hardware has arrived, last week. I've been busy playing with it so that explains the small delay in posting.

Right now I am still going through the tedious procedure of getting everything the way I want it. I have a local network so I can access my old PC. However, dragging my external HD between the two machines is much faster.
Tediousness includes copying my itunes library. Tricking itunes into accepting the old library is somewhat of a challenge. But that's what's google is for. Since I found google's answers a bit disappointing (lots of drag this folder there type of stuff from Apple users), I'll post some detailed instructions for real users who do not "consolidate" to the itunes folder but choose to keep their music organized manually. To add some difficulty, my new machine has no second harddrive so the paths are different after copying.

If all goes well everything is moved (music, playlists, play statistics, ratings) AND I can sync my ipod with the new pc without that requiring it to be wiped and refilled with the moved library. I'm moving the library, not recreating it.

The Itunes library consists of only two files, its own itunes music folder and whatever external directories you imported (two in my case). One of the two files is a binary file, the other one is an xml file with data on all your songs, including path names, statistics, ratings, etc. Essentially, the xml file contains everything we want to migrate except for the mp3s. Unfortunately, moving the itunes library is not as simple as copying the files to the new machine. Sadly, Apple deliberately made it hard to do what you are about to do. So here's a step by step guide (windows specific though Apple probably is about the same):

1. At all times, keep at least one intact backup of all files mentioned in this post. Never work on the originals. Preferably, leave the original library untouched, you can always go back to that.
1. Start by copying your mp3 folders to your new machine. That may take a while. Make sure they are where you want them to be. It took 20 minutes for my folders using an external HD, not counting the time it took to create the backup from scratch on the external hd (basically I used my incremental backup). Also copy both Itunes files (xml and itl) and the itunes mp3 folder (if not empty) onto the external hd.
1. Now dowload, install, run & close itunes. It will create an itunes directory for you the first time it starts, that's where it will look for its files. Replace the stuff inside this directory (My Documents\My Music\iTunes) with the backups on your external hd (including the itunes music folder). Now here comes the tricky part. Thanks for [this](http://www.brooks-bilson.com/blogs/rob/index.cfm?mode=entry&entry=6AE0A0A7-BD95-8DAB-DE16B46EB48026A9) post for putting me on the right track! DO NOT start itunes again until after the steps below.
1. First fix the pathnames in the xml file. They still point to the old location. Open the file in a [capable ](http://jedit.org)editor, the thing to look for is search and replace functionality. Search and replace the parts of the path names that are now different: your itunes music folder and any other folders you imported in your old library. Save the file.
1. Now this is important: iTunes will ignore whatever path info is in the xml file! Unless the itl file becomes corrupted. We can fix that! Open the itl file in an editor, delete the gibberish inside, save. Your itl file is now corrupted, normally this is a bad thing. You still have the xml file though (and a backup of the itl).
1. Start itunes, it will 'import' your music and afterwards complain that the itl file is corrupted, let it fix it.
1. Check if everything is there. In my case I messed up with the search and replace and some files were missing. Just go back a few steps, copy your backups and retry.
1. Done. Everything now is on the new PC. What about the ipod? Just plug it in!. You already installed iTunes on the new machine so you have the drivers for your ipod. The key or whatever itunes uses to recognize you ipod is in the xml file. And now also in the recreated itl. Apparently the xml file is sort of a backup of the itl. I suspect the itl is a bit more efficient to manipulate programmatically. I have no idea if this preserves any itunes store stuff you purchased. Presumably, this involves deauthorizing your old machine and authorizing the new one. I never used the itunes store so it's not an issue for me.

The only thing I lost in the transition is some iTunes preferences that are easy to restore. For example I had some of my playlists set to shuffle. The imported playlists no longer had the shuffle enabled. Big deal. The preferences probably aren't part of the library. I noticed that the shuffle settings do not sync to the ipod either. This is annoying actually because the shuffle settings is deep down in some menu on the ipod and I only want to shuffle playlists. I like my album songs served up in the order that they were put on the album.

I've used winamp for most of the past decade (I think from 1996?). Only when I got my ipod a few months ago, I started using iTunes, by choice. There is an excellent winamp plugin which will allow you to sync winamp with your ipod. Presumably, moving a winamp library is a lot more easy since winamp uses a file based library rather than a database. However, the main developer has left AOL, so winamp development seems a lot less interesting these days. AOL seems to just pile on commercial crap with every release. So I've given up on it for now.