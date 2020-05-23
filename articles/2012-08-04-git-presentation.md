---

title: Git presentation
date: 2012-08-04T09:48:59+00:00
author: Jilles van Gurp


permalink: /2012/08/04/git-presentation/
aktt_notify_twitter:
  - 'yes'
aktt_tweeted:
  - "1"
dsq_thread_id:
  - "792078682"
categories:
  - Blog Posts
tags:
  - Git
  - Git Pro
---
A few months ago, I posted a [rather lengthy article](https://www.jillesvangurp.com/2012/05/27/git-svn-flow/) about the use of git in combination with git-svn. I concluded that article with a vague promise to provide an update at some point when we had more experience with using git and git-svn.

We're now a few months into adopting git as a front-end for our centralized svn setup, which as I discussed in my previous article is not something we can easily replace in the near term. I wouldn't say this has been a smooth ride but we are getting there. Several of my team members had no git experience whatsoever, had no idea what it was or why it mattered and it took me a lot of patience to gently nudge them towards using git. We are well on the way now though and people are starting to see the benefits of adopting a new way of working.

Mostly what I wrote a few months ago is still valid. However, what we do in my team is actually slightly different. In Nokia, we have a really nice github like facility where people can create projects and repositories (of various types, including git). It also has forks and git hub style pull requests.

So what we ended up doing is this: I git svn cloned our svn trunk with its full history (17000 commits spanning four years) but without the branches and tags. I then pushed it to a remote git. That repository is read only except for me. Then I cloned that repository so I can work in a pure git environment. I typically work on branches and push them to remote, fetch them into my git-svn repository and only there integrate them on master just before I dcommit them. Other team members simply fork my repository, clone their fork, hook it up to svn [like I described recently](www.jillesvangurp.com/2012/06/10/git-svn-tips/), and can be ready to start working within a few minutes (downloading 600 MB of git repo just takes a bit of time).

We're using various mechanisms to move commits around, including git format-patch & am, cherry-pick and, fast forward merges. Given that several members of our team are new to git, I decided that learning to walk before we run, is a good thing. So, I'm trying to keep things simple. Format patch and am are easy to explain and use. Additionally it really has the least chance to end up in tears. People seem to have trouble wrapping their heads around rebasing and merging and the damage you can do with those commands.

Yesterday, I presented some stuff on this to several colleagues and I thought I'd share these slides. I've borrowed several pictures from various blogs and provided some links where appropriate. In general, just the process of creating this presentation forced me to read up on a lot of stuff as well and actually improved my understanding of what git is. Also, the git community is awesome. There is a wide variety of tutorials, insightful blog posts, presentation material, etc. out there. Probably git is one of the best documented version control systems at this point.

<iframe src="https://docs.google.com/presentation/embed?id=1GJX0cwz7Hx_BXuWdi_XlVZgHcgmrY0-ESd7aso9Dg9E&start=false&loop=false&delayms=5000" frameborder="0" width="480" height="389"></iframe>

In the slides I provide a brief overview of what git is and why it matters before diving into work flows. Of course the slides don't show the stuff I demoed on the command line.

The single best possible tip I can give to people is to read the [last chapter](http://git-scm.com/book/en/Git-Internals) of [Git Pro](http://git-scm.com/book), which describes the internals and plumbing of git. Understanding what git does under the hood really helps explain a lot about how certain things work on the porcelain side of git (i.e. the user facing commands you normally use). And it is actually a very elegant and straightforward design as well.