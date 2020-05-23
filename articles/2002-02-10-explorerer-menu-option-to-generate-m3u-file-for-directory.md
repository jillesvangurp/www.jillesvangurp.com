---
title: Explorerer menu option to generate m3u file for directory
date: 2002-02-10T13:38:56+00:00
author: Jilles van Gurp


permalink: /2002/02/10/explorerer-menu-option-to-generate-m3u-file-for-directory/
dsq_thread_id:
- "344400089"
tags:
- Bill Gates
- createdbyjilles
- extension
- GRR
---
If you are like me, you probably 'receive' mp3s occasionally. Unfortunately,most mp3s do not have proper filenames and generally have incomplete meta information tags attached. I'm one of these guys who likes the songs on an album played in the order they were put on the album. So, I rename the songs with the track number listed first with leading zeros if appropriate (for sorting)and then use this small[windows shell extension to right click on the folder and automatically create a play.m3u file](https://www.jillesvangurp.com/nerdstuff/makem3u.reg). On win2k or winnt you can just rightclickon the reg file and choose install. On win9x you need to open the file and replacecmd with command and then right click andinstall. One limitation is that the windowscommandline does not handle some characterscorrectly (e.g. scandinavian characters,like a few of my favorite bob hund songs).

Update 26 Aug 2002, it seems Bill Gates can't even get the dir command right.

Update. GRR, on some machines the /s parameter was working correctly while on others it wasn't (used the ancient 8+3format for files, even on ntfs). I've removed it for the moment so the command does not work recursively.