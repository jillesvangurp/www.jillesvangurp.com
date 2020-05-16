---
id: 57
title: WordPress review
date: 2005-10-02T18:22:28+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/?p=57
permalink: /2005/10/02/wordpress-review/
dsq_thread_id:
  - "337909441"
tags:
  - Done Categories
  - java
  - reviews
  - RSS
  - wordpress
---
After a few days of use, I think a wordpress review would be appropriate on this newly created wordpress blog.

Installation

Wow that was easy (with help from the excellent install howto):
1) create mysql database, remember user, password + servername
2) download wordpress
3) unzip, edit the config file and insert data noted under 1
4) upload everything to the server and visit the install wizard to complete the 1 step installation (creates tables in the database and sets the permissions right on some directories)

TADA! Done.

Migrating pivot.

I had been using <a href="http://www.pivotlog.net/">pivot</a> for about half a year and had collected about 30 or so posts that I wanted to migrate to wordpress.

Sadly import of pivot posts is not supported directly (well there is an unsupported migration script some guy wrote once) but the good news is that pivot has excellent RSS support and that wordpress can import RSS.

So
1) set up pivot to spit out everything in its RSS feed (instead of the latest 10 posts)
2) download the rss feed 
3) edit the import_rss.php file to point to the rss file
4) open the php script on the server, it will import the rss

Done! Categories, authors, posts, titles, dates etc all migrated.
5) well, it's probably best to restore the import script to its default state of not being configured with any rss feed so it can't be executed accidentally.

TADA! All my posts of the past year are now in wordpress.

Using wordpress

Using and configuring wordpress is quite easy. It takes a few moments to understand how user rights, options and features relate. These concepts are quite well worked out in wordpress. By default there is one user (admin) who can do anything. Other users may register through the website and get a level of trust from the admin (or a qualified user). 0 means no rights at all. By promoting users, they get the right to add their comments, moderate/edit/create posts, manage users, etc. Nice. But I'm unlikely to register much other users.

Visitors can leave comments on the site. The behaviour can be configured such that comment spamming is unlikely to happen. An important feature for me because I had to disable commenting on pivot because of spam. I'm still experimenting with the settings to find out the best mix of freedom of speech and spam protection. 

The user interface is quite clean and functional. Oddly, the wordpress developers prefer the use of serif fonts. This gives wordpress a rather pleasing, unconventional & conservative (contradiction, I know :-)), newspaper like look and feel. The letters are big (1 em) and readability is excellent. When you think about it, this is kind of important for a tool intended to process text. The font communicates an important design philosophy: this tool is about getting content out for people to read and nothing else. It is not about feature creep, complexity or in your face flash & javascript enabled GUIs.

Aside from the look and feel, this tool has all the features you'd expect from a blog tool. The functionality is organized in a number of self explanatory tabs like 'write' and 'users'.  The default settings are probably ok for a novice user and a more advanced user can easily change the behaviour of posting, comments, templates, etc.

