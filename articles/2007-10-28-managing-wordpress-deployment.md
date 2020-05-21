---
id: 350
title: Managing wordpress deployment
date: 2007-10-28T17:17:04+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2007/10/28/managing-wordpress-deployment/
permalink: /2007/10/28/managing-wordpress-deployment/
dsq_thread_id:
  - "336651810"
categories:
  - Blog Posts
tags:
  - DESTDIR
  - FROMDIR
  - problemsandsolutions
  - subversion
  - versionmanagement
  - wordpress
---
This little article is a summary of how I currently manage my wordpress blog. The wordpress.org site lists [some advice](http://codex.wordpress.org/Installing/Updating_WordPress_with_Subversion) on how to manage a wordpress installation using subversion. However, I have a slightly more sophisticated setup that preserves my modifications (as long as they don't conflict) that I maintain in a private branch of wordpress.

I use rsync to push and pull changes remotely (using ssh, ftp should work as well). Since a good howto seems to be lacking online and since I spent a while figuring out how to do all this, I decided to share my little setup.

I maintain my website and lots of other stuff in my own local subversion repository. My blog with wordpress, theme plugins, files and modified files is maintained there as well.

To pull changes from remote, I use rsync like this:

```bash
#!/bin/bash
FROMDIR=jillesvangurp-com@ssh.nl01.pcextreme.nl:/home/jillesvangurp.com/blog/
DESTDIR=~/c/svn/projects/wordpress

rsync -i -v -a -f "- .svn" -f "- wp-config.php" -f "- .htaccess" $FROMDIR $DESTDIR
```

This causes rsync to get any files that are different on the live site (e.g. new uploads) and copy them to my work directory. Since that directory contains .svn directories and a custom wp-config.php (for testing locally), I added two filters to ignore those. Similarly I want to exclude .htaccess, which wordpress modifies on the server. Basically, before making changes, I always ensure that I have an up to date copy of the site in commited to my subversion repository. Additionally, I backup the database and export the site to xml regularly.

When I am done making changes locally (and have tested them). I commit them to my subversion repository and push them to the website using a similar script:

```bash
#!/bin/bash
FROMDIR=~/c/svn/projects/wordpress/
DESTDIR=jillesvangurp-com@ssh.nl01.pcextreme.nl:/home/jillesvangurp.com/blog

rsync -i -v -a -f "- .svn" -f "- wp-config.php" -f "- .htaccess" $FROMDIR $DESTDIR
```

Note that this does not delete files that you svn deleted. To achieve that, you could add --delete to the rsync command or just cleanup manually.

The wordpress documentation [recommends](http://codex.wordpress.org/Installing/Updating_WordPress_with_Subversion) simply checking out the latest wordpress tag on the server and switching and updating that whenever a new tag is set in the repository. This works but you end up with all those .svn directories on the server which in my case means I'm wasting a lot of space that I'm paying for. Additionally it conflicts with my desire to maintain my site in subversion.

So, instead what I do is use svn diff to create a diff file like this:

> `svn diff http://svn.automattic.com/wordpress/tags/2.3/ http://svn.automattic.com/wordpress/tags/2.3.1/ > wppatch.diff`

This patch I then apply to my workdirectory using tortoisesvn or (commandline patch). This preserves any changes I have made to wordpress files (I have several minor changes that I like to keep) as long as they don't conflict with the changes coming from wordpress. Subversion simply merges the patch. After it is done, I can review what has changed; test it locally (to see if e.g. my plugins still work) and commit it. Then the above script pushes the changes to the live site and I run /admin/upgrade.php on the website.

BTW. I use cygwin and have only tested my scripts in that environment. The tools mentioned are generally available for other platforms as well and things should mostly work unmodified.