---
id: 1645
title: Versioneye
date: 2014-02-01T11:59:29+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1645
permalink: /2014/02/01/versioneye/
categories:
  - Blog Posts
tags:
  - berlin
  - Lotus Notes
  - maven
  - reviews
---
During our <a href="http://www.jillesvangurp.com/2014/02/01/localstream-and-linko/">recent acquisition</a>, we had to do a bit of due diligence as well to cover various things related to the financials, legal strucuturing, etc. of Localstream. Part of this process was also doing a license review of our technical assets.

Doing license reviews is one of those chores that software architects are forced to do once in a while. If you are somewhat knowledgable about open source licensing, you'll know that there are plenty of ways that companies can get themselves in trouble by e.g. inadvertently licensing their code base under GPLv3 simply by using similarly licensed libraries, violating the terms of licenses, reusing inappropriately licensed Github projects, etc. This is a big deal in the corporate world because it exposes you to nasty legal surprises. Doing a license review basically means going through the entire list of dependencies and transitive dependencies (i.e. dependencies of the dependencies) and reviewing the way these are licensed. Basically everything that gets bundled with your software is in scope for this review. 

I've done similar reviews in Nokia where the legal risks were large enough to justify having a very large legal department that concerned themselves with doing such reviews. They had built tools on top of Lotus Notes to support that job, and there was no small amount of process involved in getting software past them. So, this wasn't exactly my favorite part of the job. A big problem with these reviews is that software changes constantly and that the review is only valid for the specific combination of versions that you reviewed. Software dependencies change all the time and keeping track of the legal stuff is a hard problem and requires a lot of bookkeeping. This is tedious and big companies get themselves into trouble all the time. E.g. Microsoft has had to <a href="http://www.zdnet.com/blog/microsoft/microsoft-admits-its-gpl-violation-will-reissue-windows-7-tool-under-open-source-license/4547">withdraw products</a> from the market on several occasions, <a href="http://www.groklaw.net/staticpages/index.php?page=OracleGoogle">Oracle and Google</a> have been bickering over Android for ages, and famously <a href="http://www.groklaw.net/staticpages/index.php?page=20061212211835541">Sco</a> ended up suing world + dog over code they thought they owned the copyright of (Linux).

Luckily there's a new Berlin based company called Versioneye that makes keeping track of dependencies very easy. Versioneye is basically a social network for software. What it does is genius: it connects to your public or private source repositories (Bitbucket and Github are fully supported currently) and then picks apart your projects to look for dependencies in maven pom files, bundler Gemfiles, npm, bower and many other files that basically list all the dependencies for your software. It then builds lists of dependencies and transitive dependencies and provides details on the licenses as well. It does all this automatically. Even better, it also alerts you of outdated dependencies, allows you to follow specific dependencies, and generally solves a lot of headaches when it comes to keeping track of dependencies.  

I've had the pleasure of drinking more than a few beers with founder <a href="https://twitter.com/RobertReiz">Robert Reiz</a> of <a href="https://www.versioneye.com/">Versioneye</a> and gave him some feedback early on. I was very impressed with how responsive he and his co-founder Timo were. Basically they delivered all the features I asked for (and more) and they are constantly adding new features. Currently they already support most dependency management tooling out there so chances are very good that whatever you are using is already supported. If not, give them some feedback and chances are that they add it if it makes sense. 

So, when the time came to do the Localstream due diligence, using their product was a no-brainer and it got the job done quickly. Versioneye gave me a very detailed overview of all Localstream dependencies across our Java, ruby, and javascript components and made it trivially easy to export a complete list of all our dependencies, versions, and licenses for the Localstream due diligence.

Versioneye is a revolutionary tool that should be very high on the wish list of any software architect responsible for keeping track of software dependencies. This is useful for legal reasons but also a very practical way to stay on top of the tons of dependencies that your software has. If you are responsible for any kind of commercial software development involving open source components, you should take a look at this tool. Signup, import all your Github projects and play with this. It's free to use for open source projects or to upload dependency files manually. They charge a very reasonable fee for connecting private repositories.