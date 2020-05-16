---
id: 660
title: WordPress automated backup
date: 2009-11-21T13:19:36+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=660
permalink: /2009/11/21/wordpress-automated-backup/
dsq_thread_id:
  - "336378112"
categories:
  - Blog Posts
tags:
  - BACKUPDIR
  - Time Machine
  - wordpress
---
I finally sat down and wrote a little script to automatically backup my wordpress site and database. My site is hosted by [pcextreme.nl](http://www.pcextreme.nl), a nice Dutch startup providing hosting services that are perfect for a small site like mine. Part of the package they have is shell access via ssh, which makes this very straightforward. I use two scripts that do all the work:

dumpdb.sh:

```bash

mysqldump -u user -ppassword \
     -h host db --single-transaction \
     | gzip -9 > ~/wordpress.sql.gz

```

This script is stored in my home dir on the web server. The --single-transaction is needed to get rid of an [error I ran into](http://forums.mysql.com/read.php?10,108835,112951#msg-112951). I run it remotely using a second script backupsite.sh:

```bash

#!/bin/bash
BACKUPDIR=/Users/jilles/backup
date >> $BACKUPDIR/sitebackup.log
ssh user@host sh ~/dumpdb.sh
rsync -i -v -a --delete \
     user@host:~ $BACKUPDIR \
     >> $BACKUPDIR/sitebackup.log

```

This first backups the db remotely and then rsyncs everything I have on the server to a local directory. This local directory in turn is backed up by Time Machine, which provides me with nice snapshots of my site. For this to work without interaction, I have of course set up ssh authentication using my public key.  I keep a little log in sitebackup.log to keep an eye on whether this all continues to work.

Anyway, nice opportunity to show of the [wp-syntax](http://wordpress.org/extend/plugins/wp-syntax/) plugin that I finally got around to installing in wordpress and which was actually the whole point of this blog post.