---
id: 708
title: Git and agile
date: 2010-03-07T21:21:56+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=708
permalink: /2010/03/07/git-and-agile/
dsq_thread_id:
  - "336378317"
categories:
  - Blog Posts
tags:
  - Git
  - IMHO
  - java
  - subversion
---
I've been working with Subversion since 2004 (we used a pre 1.0 version at GX). I started hearing about git around the 2006-2007 time frame when Linus Torvalds' replacement for [Bitkeeper](http://en.wikipedia.org/wiki/BitKeeper) started maturing enough for other people to use it. I met people working on Maemo (the Debian based OS for the N770, N800, N810, and recently the N900) in Nokia who were really enthusiastic about it in 2008. They had to use it to work with all the upstream projects Maemo depends on and they loved it. When I moved to Berlin everybody there was using subversion so I just conformed and ignored git/mercurial and all those other cool versioning systems out there for an entire year. It turns out that was lost time, I should have switched around 2007/2008. I'm especially annoyed by this because I've been aware of decentralized versioning being superior to centralized versioning since 2006. If you don't believe me, I had a workshop paper at SPLC 2006 on version management and variability management that pointed out the emerging of DVCSes in that context. I've wasted at least three years. Ages for the early adopter type guy I still consider myself to be.

Anyway, after weighing the pros and cons for way too long, I switched from subversion to git last week. What triggered me to do this was, oddly, an excellent [tutorial on Mercurial by Joel Spolsky](http://hginit.com/00.html). Nothing against Mercurial, but Git has the momentum in my view and it definitely appears to be the band wagon to be jumping right now. I don't see any big technical argument for using Mercurial instead of Git. There's [github](http://github.com/) and no mercurial hub as far as I know. So, I took Joel's good advice on Mercurial as a hint that it was time to get off my ass and get more serious about switching to anything else than Subversion. I had already decided in favor of git based on stuff I've been reading on both versioning systems.

My colleagues of course haven't switched (yet, mostly) but that is not an issue with git-svn, which allows me to interface with svn repositories. I'd like to say making the switch was an easy ride, except it wasn't. The reason is not git but me.  Git is a powerful tool that has quite a bit more features than Subversion. Martin Fowler has a [nice diagram on "recommendability" and "required skill"](http://martinfowler.com/bliki/VersionControlTools.html). Git is in the top right corner (highly recommended but you'll need to learn some new skills) and Subversion is lower right (recommended, not much skill needed). The good news is that you will need only a small subset of commands to cover the feature set provided by svn and you can gradually expand what you use from there. Even with this small subset git is worth the trouble IMHO, if only because world + dog are switching. The bad news is that you will just have to sit down and spend a few hours learning the basics. I spent a bit more than I planned to on this but in the end I got there.

**I should have switched around 2007/2008**

The mistake I made that caused me to delay the switch for years was not realizing that git adds loads of value even when your colleagues are not using it: you will be able to collaborate more effectively if you are the only one using git! There are two parts to my mistake. 

The first part is that the whole point of git is branching. You don't have a working copy, you have a branch. It's exactly the same with git-svn: you don't have a svn working copy but a branch forked of svn trunk. So what, you might think. Git excels at merging between branches. With svn branching and merging is painful, so instead of having branches and merging between them, you avoid conflicts by updating often and committing often. With git-svn, you don't update from svn trunk, you merge its changes in your local branch. You are working on a branch by default and creating more than 1 is really not something to be scared of. It's is painless, even if you have a large amount of uncommitted work (which would get you in trouble with svn). Even if that work includes renaming the top level directories in your project (I did this). Even if other people are doing big changes in svn trunk.  That's a really valuable feature to have around. It means I can work on big changes to the code without having to worry about upstream svn commits. The type of changes nobody dares to take on because it would be too disruptive to deal with branching and merging and because there are "more important things" to do and we don't want to "destabilize" trunk. Well, not any more. I can work on changes locally on a git branch for weeks if needed and push it back to trunk when it is ready while at the same time me and my colleagues keep committing big changes on trunk. The reason I'm so annoyed right now is the time I spent on resolving svn conflicts in the past four years was essentially unnecessary. Not switching four years ago was a big mistake.

The second part of my mistake was assuming I needed IDE support for git to be able to deal with refactoring and particularly class renames (which I do all the time in Eclipse). While there is [egit](http://www.eclipse.org/egit/) now, it is still pretty immature. It turns out that assuming I needed Eclipse support was a false assumption. If you rename a file in a git repository and commit the file, Git will automatically figure out that the file was renamed, you don't need to tell git that the file was renamed. A simple "mv foo.java bar.java" will work. On directories too. This is a really cool feature. So I can develop in eclipse without it even being aware of any git specifics, refactor and rename as much as I like, and git will keep tracking the changes for me. Even better, certain types of refactorings that are quite tricky with subclipse and subversive just work in git. I've corrupted svn work directories on several occasions when trying to rename packages and moving stuff around. Git will handle this effortlessly. Merges work so well because git can handle the situation where a locally renamed file needs changes from upstream merged into it. It's a core feature, not an argument against using it. My mistake. I probably spent even more time on corrupted svn directories than conflict resolution in the last three years.

**Git is an Agile enabler**

We have plenty of pending big changes and refactorings that we have been delaying because they are disruptive. Git allows me to work on these changes whenever I feel like it without having to finish them before somebody else starts introducing conflicting changes. 

This is not just a technical advantage. It is a process advantage as well. Subversion forces you to serialize change so that you minimize the interactions between the changes. That's another way of saying that subversion is all about waterfall. Git allows you to decouple change instead and parallelize the work more effectively. Think multiple teams working on the same code base on unrelated changes. Don't believe me? The linux kernel community has thousands of developers from hundreds of companies working on the same code base touching large portions of the entire source tree.  Git is why that works at all and why they push out stable releases every 6 weeks. Linux kernel development speed is measured in thousands of lines of code modified or added per day. Evaluating the incoming changes every day is a full time job for several people.

Subversion is causing us to delay necessary changes, i.e. changes that we would prefer to do if only it wouldn't be so disruptive. Delayed changes pile up to become[ technical debt](http://martinfowler.com/bliki/TechnicalDebt.html). Think of git as a tool to manage your technical debt. You can work on business value adding changes (and keep the managers happy) and disruptive changes at the same time without the two interfering. In other words you can be more agile. Agile has always been about technical enablers (refactoring tooling, unit testing frameworks, continuous integration infrastructure, version control, etc) as much as it was about process. Having the infrastructure to do rapid iterations and release frequently is critical to the ability to release every sprint. You can't do one without the other. Of course, tools don't fix process problems. But then, process tends to be about workarounds for lacking tools as well. Decentralized version management is another essential tool in this context. You can compensate not using it with process. IMHO life is to short to play bureaucrat.

**Not an easy ride**

But as I said, switching from svn to git wasn't a smooth ride. Getting familiar with the various git commands and how they are different from what I am used to in svn has been taking some time despite the fact that I understand how it works and how I am supposed to use it. I'm a git newby and I've been making lots of beginners mistakes (mainly using the wrong git commands for the things I was trying to do). The good news is that I managed to get some pretty big changes committed back to the central svn repository without losing any work (which is the point of version management). The bad news is that I got stuck several times trying to figure out how to rebase properly, how to undo certain changes, how to recover a messed up checkout on top of my local work directory from the local git repository. In short, I learned a lot on this and I have still some more things to learn. On the other hand, I can track changes from svn trunk, have local topic branches, merge from those to the local git master, and dcommit back to trunk. That about covers all my basic needs.