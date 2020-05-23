---

title: Using Git and feature branches effectively
date: 2011-07-16T12:19:49+00:00
author: Jilles van Gurp


permalink: /2011/07/16/using-git-and-feature-branches-effectively/
aktt_notify_twitter:
  - 'no'
dsq_thread_id:
  - "359879364"
categories:
  - Blog Posts
tags:
  - Git
  - linux
  - Martin Fowler
  - Using Git
---
There is a bit of a [debate](http://sarahtaraporewalla.com/design/experience-report-branch-by-feature/) raging in the last few weeks that started when somebody commented on a few things that Martin Fowler wrote about git and using [feature branches](http://martinfowler.com/bliki/FeatureBranch.html) and [feature toggles](http://martinfowler.com/bliki/FeatureToggle.html). Martin Fowler makes a few very good points about how feature branches can cause a lot of testing and integration headaches and lot of people seemed to have picked up on this one and there seems to be a bit of an anti-feature branch movement emerging. 



The main problem I have with this is that these people are confusing problems and causes here and effectively blaming a solution they have for causing a problem they have. Roughly the argument goes as follows: feature branches cause people to accumulate change that then becomes very disruptive when it lands on the main branch. There will be CI breakage and lots of problems for people on other feature branches that are suddenly faced with merge issues. I think Martin Fowler actually gets it but some of his followers seem to be confused. By all means, feature toggles are a great way to get changes in early and have them exposed. It's a powerful tool that you can use to get changes out earlier. Early is good: use it. However, it is not the case that if you use feature branches there has to be a lot of pain for everybody. In other words, feature branches are not inherently evil and don't have to be problematic.

It’s not the practice of feature branching that is the problem but the fact that testing and continuous integration are not decentralized in a lot of organizations. In other words until your changes land on the central branch, you are not doing the due diligence of testing. Even worse, you are not making sure you have tested your changes before you add them to the main branch.

You can’t do decentralized versioning unless you also decentralize your testing and integration. Git has value when used as a SVN replacement. Git has more value when used as a DVCS. There is no good reason why you can’t do decentralized testing and integration with git. Rather the opposite: it has been designed with exactly this in mind. The whole point of git is divide and conquer. Break the changes up: decentralize the testing and integration work and solve the vast majority of problems before change is pushed upstream. If you push your problems along with your changes you are doing it wrong. Decentralized integration is a very clever strategy that is based on the notion that the effort involved with testing and integration scales exponentially rather than linearly with the amount of change. By decentralizing you have many people working on smaller sets of changes that are much easier to deal with: the collaborative effort on testing decreases and when it all comes together you have a much smaller set of problems to deal with. 

This is how the linux kernel manages to remain stable, despite the fact that the amount of change there is measured in thousands of LOC/day. If you need proof that thousands of people can work collaboratively on millions of lines of code using git branches: look at the linux kernel. The amount of change, integration and testing effort, etc. in whatever you are working on probably pales in comparison with that: your problems are easy.

Here’s a few simple practices that will address most of the issues:

1. No change that will break CI on the main branch is allowed on the main branch. Zero tolerance on this one. In git terms: rebase against main, run ci test on the feature branch, fix any problems, push. You can automate this even: jenkins pretty much supports this out of the box. If main breaks ever, somebody doesn’t get the basics: educate them with a big clue bat. Rationale, it is vital to keep main stable at all times. That way everybody on a feature branch will know it is safe to rebase.
1. Rebase against main frequently, especially if you do big changes. Rationale: you are doing the changes, it is you that will take the pain of doing the integration work when things go wrong, not everybody else. The earlier you know about problems, the easier it is to fix. Feature branches are not about stopping rebases. If your feature branch is way behind, you have done something very wrong. Don’t ever do that without good reason. If it is on the central branch, you will have to deal with it at some point: so get it over with ASAP.
1. Commit frequently, keep commits as small as you can. Rationale: smaller commits are easier to analyze and fix when you have conflicts. Also, Git is really good at applying commits one by one. If you isolate the merge problems to a handful of commits, rebasing is pretty much painless.
1. Push as early as you can. If the CI builds are green on your branch and you are confident things are fine, push and don’t wait. Don’t accumulate integration work for others. Feature branches are not about hiding change but about isolating change. There’s a difference. One is a communication problem and the other is a proven strategy of divide and conquer. If appropriate, feature toggles are indeed a great way to land experimental changes. I believe this was the main point Martin Fowler was trying to make.
1. Communicate clearly around big code restructurings. Rationale, everybody rebasing against your changes will experience some pain. You are causing people to have to do work, so tell them it is going to happen. I always ask people to push their changes before I push my big changes. That way, I can fix the integration issues on my side before I push.
1. Collaborate with people by pushing changes back and forth without involving the main branch. Git format-patch is your friend: you can do this by email. If somebody needs a change before you land it, you can give it to them.
1. Be aware of the cost of things. Any time people spend on things like resolving merge conflicts, doing rebases, etc. costs you. Inevitably when you branch you accept that there is going to be some cost. Keeping a branch alive means you add cost. Don't do it needlessly. So, branch and do what you have to do and then rebase, push and delete the branch. And again, not committing is effectively the same as branching in git. It has the same cost and risk attached to it.
1. Don't push branches to origin unless they are going to be long lived and need to be worked on by multiple people. For simple work, keep the branches local to your machine. If you are going to be doing all of the commits and integration work, the only valid reason for pushing it upstream would be backups. There are alternatives to backing this way.
1. Beyond a certain team size, the stable branch needs to be protected. Pull change rather than pushing it (this is a severely underused git feature). Junior on the third floor says his patch is ready: pull it, have a look at it and give him feedback but don't allow him to push and bypass checks and balances. Push only works in small teams. Pull forces people to communicate.

When will (feature) branches get you in trouble? Antipatterns:

- You are working on a big change. You haven't updated for days. Do I need to spell it out? That is just wrong. Update!
- You are pushing a big change, all the CI builds go red. Oops, test before you push you dumb idiot. You deserve all the angry looks you are going to get. If this happens a lot, consider setting up your CI environment for having a stable branch for tested commits and an unstable branch for incoming commits that need to be tested. Jenkins supports this and it will keep unstable change out of stable.
- You are doing a big change, somebody else is also doing a big change. You find out about that when you rebase and spend hours dealing with merge conflicts. Seriously: communicate before you do anything drastic and give people an opportunity to get their changes in before you ruin their day. Pushing massive changes that you know are going to cause problems when people rebase is a very egocentric thing to do. Be a team player.
- You are working on a big change. You haven't updated or committed anything for several days on your local branch. You are effectively using your local branch as a feature branch: everybody who is not pushing change is effectively on a feature branch. Not committing is NOT a strategy to avoid using feature branches. Also, you are not committing? Why???? What's your excuse for not committing to your own local branch? Seriously, consider using version management and stop treating git as a file server for code backups.
- You are working on a branch for an extended period of time but your CI builds only run on the central branch. Congratulations, you have just tossed out CI as a good practice. Fix it. Either have the discipline to run the CI tests manually on every commit to the branch or set up a CI build for it. Either way, don't break the feedback loop you get with CI.

Now at this point I have to admit something: I don't use feature branches a lot but I do tend to accumulate a few commits locally before I push them. Also. we haven't set up stable and unstable branches in jenkins (yet, planning to). We have the occasional breakage of our CI builds. I'm actually guilty of breaking some of the builds myself. The reason/weak excuse is: I'm having a hard time changing people's way of working. You turn your back and people stop committing and continue treating git like they are using cvs. But I'm at least aware what the real problem is here: not the fact that I have branches but the fact that our testing needs to be decentralized.