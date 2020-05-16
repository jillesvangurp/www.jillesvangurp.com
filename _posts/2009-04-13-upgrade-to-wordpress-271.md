---
id: 557
title: Upgrade to wordpress 2.7.1
date: 2009-04-13T14:08:24+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=557
permalink: /2009/04/13/upgrade-to-wordpress-271/
dsq_thread_id:
  - "369385329"
categories:
  - Blog Posts
tags:
  - BTW
  - DB
  - INSERT
  - RTFM
  - wordpress
---
The joys of moving and starting a new job sadly also means less time for things like upgrading wordpress. I've never been so far behind the main version (one major and a subsequent minor release). So, this morning I sat down to do the usually quick and efficient switch svn to wordpress 2.7.1 tag, upload files, upgrade DB and done type ritual.

Except it didn't work. Damn. I spent nearly two hours running into several problems and trying to fix things. The root cause was three fold.

1. I did not RTFM.
1. The little upgrade instructions have subtly changed. Bla bla bla, and oh BTW you should add this stuff to your wp-config.php. Naturally that was a problem.
1. The theme I have been using for quite some time Barthelme is no longer maintained and wp 2.7.1 doesn't seem to like it.

Basically, it didn't like the theme and hence could not show the site. Worse, it could not show the admin site either. All it showed was a blank page. Blank as in, 0 bytes. Blank as in, oops some weird php error and lets just return 0 bytes. Not good. Somewhere in between I did actually manage to run the upgrade db script. That too didn't have any UI but I could at least get to the upgrade link using view source in firefox. Hint, if you ever get this far, don't do that. That didn't make things better. I then tried removing plugin directories and theme directories to make it revert to defaults. Didn't work, still a blank page. Then I did my usual diagnostics and found out about the wp-config settings, which by now made no difference. Still a blank page.

So, I screwed up and for the first time had to resort to actually using the db backup I thankfully made (would have been in more trouble without that). Except that didn't work either. Yikes.  Loaded the nice little dump I had made earlier with phpadmin and uploaded. After some time it came back with a nice "Got a packet bigger than 'max_allowed_packet'" error. Yikes. This one took a while to figure out. Apparently this is some setting you can override if you have the right to do so, which I don't. Most advice out there points this out "hey just fix my.cnf, restart the server and you're good". Yeah right, not much help but thanks. So then I figured out that line length probably was the problem here. Indeed it was since phpadmin seems to default to generating one huge INSERT statement with a comma separated list of all the values. So everything I published since 2005 on this blog on one line and , separated. Sounds like a lot but it's only 1.5MB or so.

Anyway, the solution is buried in a comment from Gareth in the mysql documentation: http://mysql.telepac.pt/doc/refman/5.1/en/packet-too-large.html

So just search and replace ), by ); INSERT INTO `wp_posts`  VALUES. Be careful about doing that only on the insert you want to change BTW.

Anyway, I reverted back to wordpress 2.6.5, imported my fixed dump, fixed my configuration to be prepared to 2.7.1 and checked if my blog survived. It did.

Then I switched the theme to the default theme (i.e. what you are looking at), did the svn switch, upload, upgrade db and this time everything worked.

So, you will have to excuse the odd layout problems for now. Default wordpress theme sucks and I suspect I have some overflow issues here and there. I will be fixing those shortly of course.