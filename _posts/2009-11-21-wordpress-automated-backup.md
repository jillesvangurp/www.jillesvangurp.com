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
wp-syntax-cache-content:
  - |
    a:2:{i:1;s:831:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="bash" style="font-family:monospace;">mysqldump <span style="color: #660033;">-u</span> user <span style="color: #660033;">-ppassword</span> \
    <span style="color: #660033;">-h</span> host db <span style="color: #660033;">--single-transaction</span> \
    <span style="color: #000000; font-weight: bold;">|</span> <span style="color: #c20cb9; font-weight: bold;">gzip</span> <span style="color: #660033;">-9</span> <span style="color: #000000; font-weight: bold;">&gt;</span> ~<span style="color: #000000; font-weight: bold;">/</span>wordpress.sql.gz</pre></td></tr></table><p class="theCode" style="display:none;">mysqldump -u user -ppassword \
    -h host db --single-transaction \
    | gzip -9 &gt; ~/wordpress.sql.gz</p></div>
    ;i:2;s:1705:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="bash" style="font-family:monospace;"><span style="color: #666666; font-style: italic;">#!/bin/bash</span>
    <span style="color: #007800;">BACKUPDIR</span>=<span style="color: #000000; font-weight: bold;">/</span>Users<span style="color: #000000; font-weight: bold;">/</span>jilles<span style="color: #000000; font-weight: bold;">/</span>backup
    <span style="color: #c20cb9; font-weight: bold;">date</span> <span style="color: #000000; font-weight: bold;">&gt;&gt;</span> <span style="color: #007800;">$BACKUPDIR</span><span style="color: #000000; font-weight: bold;">/</span>sitebackup.log
    <span style="color: #c20cb9; font-weight: bold;">ssh</span> user<span style="color: #000000; font-weight: bold;">@</span>host <span style="color: #c20cb9; font-weight: bold;">sh</span> ~<span style="color: #000000; font-weight: bold;">/</span>dumpdb.sh
    rsync <span style="color: #660033;">-i</span> <span style="color: #660033;">-v</span> <span style="color: #660033;">-a</span> <span style="color: #660033;">--delete</span> \
    user<span style="color: #000000; font-weight: bold;">@</span>host:~ <span style="color: #007800;">$BACKUPDIR</span> \
    <span style="color: #000000; font-weight: bold;">&gt;&gt;</span> <span style="color: #007800;">$BACKUPDIR</span><span style="color: #000000; font-weight: bold;">/</span>sitebackup.log</pre></td></tr></table><p class="theCode" style="display:none;">#!/bin/bash
    BACKUPDIR=/Users/jilles/backup
    date &gt;&gt; $BACKUPDIR/sitebackup.log
    ssh user@host sh ~/dumpdb.sh
    rsync -i -v -a --delete \
    user@host:~ $BACKUPDIR \
    &gt;&gt; $BACKUPDIR/sitebackup.log</p></div>
    ";}
categories:
  - Blog Posts
tags:
  - BACKUPDIR
  - Time Machine
  - wordpress
---
I finally sat down and wrote a little script to automatically backup my wordpress site and database. My site is hosted by [pcextreme.nl](http://www.pcextreme.nl), a nice Dutch startup providing hosting services that are perfect for a small site like mine. Part of the package they have is shell access via ssh, which makes this very straightforward. I use two scripts that do all the work:

dumpdb.sh:

<pre lang="bash">
mysqldump -u user -ppassword \
     -h host db --single-transaction \
     | gzip -9 > ~/wordpress.sql.gz
</pre>

This script is stored in my home dir on the web server. The --single-transaction is needed to get rid of an [error I ran into](http://forums.mysql.com/read.php?10,108835,112951#msg-112951). I run it remotely using a second script backupsite.sh:

<pre lang="bash">
#!/bin/bash
BACKUPDIR=/Users/jilles/backup
date >> $BACKUPDIR/sitebackup.log
ssh user@host sh ~/dumpdb.sh
rsync -i -v -a --delete \
     user@host:~ $BACKUPDIR \
     >> $BACKUPDIR/sitebackup.log
</pre>

This first backups the db remotely and then rsyncs everything I have on the server to a local directory. This local directory in turn is backed up by Time Machine, which provides me with nice snapshots of my site. For this to work without interaction, I have of course set up ssh authentication using my public key.  I keep a little log in sitebackup.log to keep an eye on whether this all continues to work.

Anyway, nice opportunity to show of the [wp-syntax](http://wordpress.org/extend/plugins/wp-syntax/) plugin that I finally got around to installing in wordpress and which was actually the whole point of this blog post.