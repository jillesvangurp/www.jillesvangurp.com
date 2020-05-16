---
id: 200
title: Subversion 1.4 windows binaries
date: 2006-10-31T20:24:53+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/10/31/subversion-14-windows-binaries/
permalink: /2006/10/31/subversion-14-windows-binaries/
dsq_thread_id:
  - "337383769"
tags:
  - subversion
  - versionmanagement
---
For a few weeks I've been waiting for cygwin to update their subversion binaries. But for some reason they are not in a hurry. Subversion 1.4 was recently released and this time it includes some changes to both the repository format and the work directory format. If you use 1.4 binaries on your workdirectory, it will automatically be upgraded. Nice, except cygwin still has 1.3 binaries and no longer recognizes the work directory after you've used tortoise svn 1.4 on it. Similarly, the repository is upgraded if you use 1.4 version on it. So, upgrading is not recommended unless you can upgrade all subversion related tools to 1.4.

Naturally I found this out after upgrading tortoise svn to 1.4 :-).

Luckily, you don't need cygwin binaries. So here's what you can do instead:

- download the win32 commandline subversion tools from <a href="http://subversion.tigris.org/">tigris </a>and install it.
- modify your path to add the bin directory
- uninstall the obsolete cygwin subversion version

Of course the win32 version doesn't handle cygwin paths too well. Luckily subversion handles moving of repositories pretty well. In my case my repositories were in /svnrepo which in reality is this path on windows c:\cygwin\svnrepo. Since I use the svn+ssh protocol, the urls for all my workdirectories were svn+ssh://localhost/svnrepo/... These urls of course broke due to the fact that the win32 binaries interpret the path /svnrepo differently than the cygwin version. Solution: mv /svnrepo /cygdrive/c.

This allows me to continue to use the same subversion urls and all my tools now work. Also, in the future I won't have to wait for cygwin to upgrade their subversion binaries and can get them straight from tigris.