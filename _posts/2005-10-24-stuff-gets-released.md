---
id: 72
title: stuff gets released
date: 2005-10-24T19:06:20+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/?p=72
permalink: /2005/10/24/stuff-gets-released/
tags:
  - firefox
  - IMHO
  - java
  - maven
  - MB
  - Open Office
  - reviews
---
Lots of stuff has been released or is about to be released. Enough to warrant a little blog post about this stuff.

**[Open Office 2.0](http://www.openoffice.org/)**

The 2.0 version is a nice improvement over 1.1. OOo 1.1 sucked IMHO but 2.0 might convince me to actually use it. If only they fixed the bugs I reported four years ago on crossreferences (not implemented properly). Without fixes for that, I can't write large, structured content in it (i.e. scientific articles). But still, quite an improvement. Importing of office stuff now actually works. I managed to import and save an important spreadsheet at work and removed about 9 MB of redundant data in the process (no idea where this came from), which makes working with the file over the network a lot less frustrating. ~~Also it seems to actually be able to work with word documents without seriously messing up layout~~ and internal structure (and its a lot faster on large documents). ~~In short, compatibility now works more or less as advertised~~ for the past four years (1.1 didn't, even for trivial stuff). It's still quite ugly though and lots of usability challenges remain unaddressed. Looking cool is not a product feature, nor is blending in with your OS. It remains the poorman's alternative to MS Office.

Update. It looks like I was wrong about not messing up word documents. I did some roundtrip editing on a document written in word and OOo thoroughly messed it up. It turns out it doesn't handle documents with adjusted page settings. It applied the page settings for the title  page to the whole document. As a consequence it looks like shit, all the headers and footers are in the wrong place. It's a lot of work to fix it too. 

**[Maven 2.0](http://maven.apache.org/)**

I spent some time with a release candidate and decided not to use it. The reasons were a mix of poor documentation and a dislike of the structure it tries to enforce on everything you do. I'm pretty sure the ideas behind it are ok but it just doesn't feel right yet. In short it didn't pass the fifteen minute test they put on their website: the documentation keeps telling you how beautiful and useful maven is without actually telling you anything about how it works. Some crucial things are lacking like explaining how these dependencies actually work, where the repository where it magically pulls all these jar files from is, how to set up your own repository, etc.

In the end I prefer the more verbose nature of ant. I have a lot of experience writing ant build files now. I've even written a few ant tasks at work. I happen to both like and need its flexibility a lot. I don't see how maven solves any of the more non trivial stuff I do it (other than allowing me to use ant). 

The assumptions maven is based on are IMHO incorrect. First of all it is tool centric, if you don't structure your projects the way it likes you'll have lots of trouble trying to get it to do anything useful (that means it won't be used where I work now or any other place that has an existing, complex project). Secondly it solves a lot of easy stuff that is not really a problem with ant and not much else. Compiling, generating javadoc, etc. is not that hard with ant. In fact, most of the time I reuse the same tasks for that (by importing it). And, finally, maven just adds complexity. I find maven projects hideously complicated in their structure. I've seen quite a few maven projects and they all spread their source code over numerous modules in nested directories. I don't want to structure my projects like that. But the most important thing is that maven doesn't actually solve any problem I have.

**[Mysql 5.0](http://www.mysql.com)**

Nice to finally see this arrive. I expect this to have some consequences for the use of commercial databases in the next few years. At work our customers still prefer commercial stuff like oracle or mssql. Increasingly this has more to do with irrationality than actual features that are actually used. Performance certainly has little to do with it. Nor does scalability. Our webapp is a few dozen simple tables with some optional stored procedures. The latter are what have kept us from fully supporting mysql though arguably they are not required in our app. 

**[Firefox 1.5 RC1](http://mozilla.org)**
The release candidate should be ready right about now or very soon anyway. Beta2 has worked flawlessly here, as did Beta1. See my earlier review of the beta for more details.

