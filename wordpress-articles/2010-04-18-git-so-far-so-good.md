---
id: 723
title: 'Git: so far, so good'
date: 2010-04-18T09:30:21+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=723
permalink: /2010/04/18/git-so-far-so-good/
dsq_thread_id:
  - "336378411"
categories:
  - Blog Posts
tags:
  - Git
  - IT
---
I started using git two months ago. Basically, colleagues around me fall into three categories:

- Those that already use git or mercurial (a small minority).
- Those that are considering to start using it like me a few months ago (a few).
- Those that don't get it (the majority).

To those that don't get it: time to update your skill sets. Not getting it is never good in IT and keeping your skill set current is vital to survival long term. Git is still new enough that you can get away with not getting it but I don't think that will last long.

The truth of the matter is that git mostly works as advertised and there are a few real benefits to using it and a few real problems with not using it. To start with the problems:

- Not using git limits you to one branch: trunk. Don't fool yourself into thinking otherwise. I've seen branching in svn a couple of times and it was not pretty.
- Not using git forces you to either work in small, non invasive increments or accept pro-longed instability on trunk with lots of disruptive change coming in. Most teams tend to have a release heart beat where trunk is close to useless except when a release is coming.
- Not using git limits size of the group of people that can work effectively on the same code base. Having too many people commit on the same code will increase the number conflicting changes.
- Not using git exposes you regularly to merge problems and conflicts when you upgrade your work copy from trunk.
- Not using git forces a style of working that avoids the above problems: you don't branch; people get angry when trunk breaks (which it does, often); you avoid making disruptive changes and when you do, you work for prolonged periods of time without committing; when you finally commit, you find that some a**hole introduced conflicting changes on trunk while you weren't committing; once you have committed other people find that their uncommitted work now conflicts with trunk etc.
- Given the above problems, people avoid the type of changes that causes them to run into these problems. This is the real problem. Not refactoring because of potential conflicts is an anti-pattern. Not doing a change because it would take too long to stabilize means that necessary changes get delayed.

All of those problems are real and the worst part is that people think they are normal. Git is hardly a silver bullet but it does take away these specific problems. And that's a real benefit. Because it is a real benefit, more and more people are starting to use git, which puts all those people not using it at a disadvantage. So, not getting it is causing you real problems now (which you may not even be aware off). Just because you don't get it doesn't stop people who do get it from competing with you. 

In the past few weeks, I've been gradually expanding my use of git. I started with the basics but I now find that my work flow is changing:

I'm no longer paranoid about updating from svn regularly because the incoming changes tend to not conflict with my local work if I "git svn rebase". Rebasing is git specific process where you pull in changes from remote and "reapply" your own local commits on top of them. Basically before you push changes to remote, you rebase them on top of the latest and greatest available remote. This way your commit to remote is guaranteed to not conflict. So "git svn rebase" pulls changes from trunk and applies my local commits on top of them. Occasionally there are conflicts of course but git tends to be pretty smart about resolving most of those. E.g. file renames tend to be no problem. In a few weeks of using git, I've only had to edit conflicts a couple of times and in all of these cases, this was straightforward. The frequency with which you rebase doesn't really matter since the process works on a per commit basis and not on a merge basis like in svn. 
 
I tend to isolate big chunks of work on their own git branch so I can switch between tasks. I have a few experimental things going on that change our production business logic in a pretty big way. Those changes live in their own git branch. Once in a while, I rebase those branches against master where I rebase against svn trunk regularly to get the latest changes from svn trunk on the branch and make sure that I can still push them back to trunk when the time comes. Simply being able to work on such changes without those changes disrupting trunk or trunk changes disrupting my changes is a great benefit. You tend to not experiment on svn trunk because this pisses people off. I can experiment all I want on a local branch though. However, most of my branches are actually short lived: just because I can sit on changes forever doesn't mean I make a habit of doing that needlessly. The main thing for me is being able to isolate unrelated changes from each other and from trunk and switching between those changes effortlessly.

Branching and rebasing allows me to work on a group of related changes without committing back to trunk right away. I find that my svn commits tend to be bigger but less frequent now. I've heard people who don't get it argue that this is a bad thing. And I agree: for svn users this would be a bad thing because of the above problems. However, I don't have those problems anymore because I use git. So, why would I want to destabilize trunk with my incomplete work?

Whenever I get interrupted to fix some bug or address some issue, I just do the change on whatever branch I'm working on. I commit the changes in that branch. Then I do a git stash save to quickly store any uncommitted work in progress. I do a git checkout master followed by a git cherrypick <commitid> to get the commit with the fix on master. Then I git svn rebase and git svn dcommit to get the change into trunk. Then I checkout my branch again and do a git stash pop to pickup where I was before I was interrupted. This may sound complicated but it means that I am no more than two commands away from having a completely clean directory that matches svn trunk exactly that I can execute at any time without losing work in progress. So, no matter how disruptive the changes are that I am working on, I can always switch to a clean replica of svn trunk to do a quick change and then pick up the work on my disruptive changes. Even better, I can work on several independent sets of changes and switch between them in a few seconds.

So those are big improvements in my workflow that have been enabled by using git svn to interface with svn. I'd love to be able to collaborate with colleagues on my experimental branches. Git would enable them to do that. This why them not getting git is a problem. 

Btw. you can replace git with mercurial in the text above. They are very similar in capabilities.

