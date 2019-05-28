---
id: 664
title: WordPress automated backup
date: 2009-11-21T13:17:14+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2009/11/21/660-revision-4/
permalink: /2009/11/21/660-revision-4/
---
I finally sat down and wrote a little script to automatically backup my wordpress site and database. My site is hosted by <a href="http://www.pcextreme.nl">pcextreme.nl</a>, a nice Dutch startup providing hosting services that are perfect for a small site like mine. Part of the package they have is shell access via ssh, which makes this very straightforward. I use two scripts that do all the work:

dumpdb.sh:

<pre lang="bash">
mysqldump -u user -ppassword \
     -h host db --single-transaction \
     | gzip -9 > ~/wordpress.sql.gz
</pre>

This script is stored in my home dir on the web server. I run it remotely using a second script backupsite.sh:

<pre lang="bash">
#!/bin/bash
BACKUPDIR=/Users/jilles/backup
date >> $BACKUPDIR/sitebackup.txt
ssh user@host sh ~/dumpdb.sh
rsync -i -v -a --delete \
     user@host:~ $BACKUPDIR \
     >> $BACKUPDIR/sitebackup.txt
</pre>

This first backups the db remotely and then rsyncs everything I have on the server to a local directory. This local directory in turn is backed up by Time Machine, which provides me with nice snapshots of my site. For this to work without interaction, I have of course set up ssh authentication using my public key. 

Anyway, nice opportunity to show of the <a href="http://wordpress.org/extend/plugins/wp-syntax/">wp-syntax</a> plugin that I finally got around to installing in wordpress.