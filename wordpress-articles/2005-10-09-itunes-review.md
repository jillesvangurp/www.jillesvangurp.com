---
id: 63
title: iTunes review
date: 2005-10-09T16:17:57+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/?p=63
permalink: /2005/10/09/itunes-review/
dsq_thread_id:
  - "352436716"
tags:
  - apple
  - Conclusion Apple
  - IMHO
  - itunes
  - reviews
  - UPDATE
---
After about a day of intensive use of iTunes (5.0.1.4, win32) I have decided to stick with it for a while. However, I'm not entirely happy with it yet and I'll list my detailed criticism here.

1) It looks nice but it is not very responsive. Especially not when managing the amounts of music the ipod is intended for. I am talking about the noticable lag when switching from one view to another, the lack of feedback what is doing when, apparently, it can't respond right away to any mouse clicks.

2). I am used to winamp which has a nerdy interface but gets several things right in the media library that iTunes doesn't. The most important thing, the notion of a currently playing list of songs, is missing. That means that if you are navigating your songs, you are also editing the list of songs that is currently playing (unless you are playing a playlist in a seperate window). This is extremely annoying because this means you can't play albums and browse your other music at the same time which is the way I prefer to listen to my music. 

Steps to reproduce: put the library in browse mode (so you can select artist and than album), select one of your albums, start playing the first song. Browse to some other album, click the next button. Instead of playing track 2 of the album you were listening to (IMHO the one and only desired behavior) you were playing the music stops because by now a different set of files is selected.

A solution (or rather workaround) to this would be to create playlists for each album and play those. This cannot be done automatically. I have 300+ albums. You can drag m3u files (a common playlist format that simply lists the files in the order they should be played) to itunes (good) but if you drag more than one it merges them into one big playlist (bad). 

3) So if you have m3u files for your albums or other playlists, you still need to import them one by one. That sucks. 

An alternative solution would be to treat albums as playlists when clicked upon.

The best solution is of course to do it like winamp. Until you start to play something new the player plays whatever is in its current playlist. If you click an album, that becomes the current playlist. So simple, intuitive and yet missing. Of course it contradicts with the misguided notion of putting checkboxes in a list of 5000 files. The browse mode sort of covers up for this design error by automatically unchecking everything hidden by the browser. That's why your album is unchecked when you select another album.

I can guess why apple chooses to not fix this issue. It requires changing the user interface to add a list of currently selected songs. This product is for novice users and adding user interface elements makes it more complex.  Incidently the ipod is much smarter! It doesn't change the current selection until you select something new and browsing is not the same as selecting!

4) Double clicking a playlist opens a new window! The idea of a playlist is to play one song after another (like I want to do with my albums). Effectively the playlist becomes the active list once you start playing it. However, as discussed above, iTunes does not have a concept of a current playlist so they 'fixed' it by opening a new window. IMHO this is needlessly confusing (for windows users, I understand multiple application windows is something mac users are more used to). 

5) Of course this conflicts with the minimize to traybar option which only works for the main window. You can also play playlists like albums but then you encounter issue number 2 again. Conclusion Apple's fix for issue number 2 is a direct cause for number 4 (serious usability issue) and this issue.

6) A separate issue is album art. Many users have file based mp3 players like winamp which store album art as a separate folder.jpg file in the directory the album mp3s are in. iTunes has an album art feature but will ignore those files. Worse the only way to add album art is to add the image to each individual music file (so if your album is fifteen tracks, the same image must be added to fifteen files). Aside from the waste of diskspace (or worse flash drive space), this is just to cumbersome to manage. I found a [neat tool](http://www.yvg.com/itunesartimporter.shtml) that can automate fetching and adding album art for albums.

7) Finally some issues with the help system. I normally do not refer to help files unless I need them. A day of using iTunes has forced me to do this several times because the user interface has a lot of obscure buttons and options that are not always self explaining. For example the menu option "consolidate library" sounds rather scary and, as I found out by reading the help file, you probably don't want to click it. Another beautiful option is "group compilations when browsing". This is a bit harder to figure out because the help search feature returns one result for 'compilation' which is a huge list of tips.

The problem: the help information is not organized around the userinterface like it should be. Task based documentation is nice to have but not if you are looking for information on button X in dialog Y.

So why do I still continue to use it: it is integrated in a clever way with my ipod :-) and I hope to find some solutions to the problems above using 3rd party tools. Ipod integration seems to work rather nicely, just plug it in and it synchronizes. I have the big version with plenty of space so I just want everything I have to be sycnhronized to it and this seems to work well. Except for one thing:

8) Apparently I have songs that the ipod can't play that itunes can play. The synchronization process warns of this by telling me it can't play some songs but fails to inform me which ones (so I can't fix it)! The obvious solution would be to translate these songs to something it can play when copying them to the ipod (and keep the original in itunes). All the tools to do this are available so it should just do this, no questions asked.

UPDATE

I've found some more serious issues with drag and drop:
9) You can drag albums to the sidebar to create a playlist and you can drag playlists to a folder but you cannot drag albums to folders to create a playlist there.

10) Dragging multiple albums sadly creates only one playlist so this is no solution for problem 2 and probably shares the same cause as problem 3.