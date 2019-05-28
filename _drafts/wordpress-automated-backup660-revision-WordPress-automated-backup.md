---
id: 661
title: WordPress automated backup
date: 2009-11-21T13:11:23+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2009/11/21/660-revision/
permalink: /2009/11/21/660-revision/
---
I finally sat down and wrote a little script to automatically backup my wordpress site and database. My site is hosted by <a href="http://www.pcextreme.nl">pcextreme.nl</a>, a nice Dutch startup providing hosting services that are perfect for a small site like mine. Part of the package they have is shell access via ssh, which makes this very straightforward. I use two scripts that do all the work:

dumpdb.sh:

<pre lang="bash">
mysqldump -u user -ppassword -h host db --single-transaction | gzip -9 > ~/wordpress.sql.gz
</pre>

This script is stored in my home dir on the web server. I run it remotely using a second script backupsite.sh:

<pre lang="bash">
#!/bin/bash
BACKUPDIR=/Users/jilles/backup
echo ------------------- >> $BACKUPDIR/sitebackup.txt
date >> $BACKUPDIR/sitebackup.txt
ssh jillesvangurp-com@ssh.nl01.pcextreme.nl sh /home/vhosting/m/vhost0002738/dumpdb.sh
rsync -i -v -a --delete jillesvangurp-com@ssh.nl01.pcextreme.nl:~ $BACKUPDIR >> $BACKUPDIR/sitebackup.txt
</pre>

For this to work without interaction, I have of course set up ssh authentication using my public key. Anyway, nice opportunity to show of the wp-sy