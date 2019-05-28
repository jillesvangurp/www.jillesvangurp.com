---
id: 930
title: Five rules of thumb for using Git effectively
date: 2011-07-16T10:29:30+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2011/07/16/927-revision-3/
permalink: /2011/07/16/927-revision-v1/
---
There is a bit of a debate raging ever since Martin Fowler blogged about git and using <a href="http://martinfowler.com/bliki/FeatureBranch.html">feature branches</a> and <a href="http://martinfowler.com/bliki/FeatureToggle.html">feature toggles</a>. Martin Fowler makes a few very good points about how feature branches can cause a lot of testing and integration headaches. A lot of people seemed to have picked up on this one and there seems to be a bit of an anti-feature branch movement emerging. 

The main problem I have with this is that these people are confusing problems and causes here and effectively blaming a solution they have for causing a problem they have. Roughly the argument goes as follows: feature branches cause people to accumulate change that then becomes very disruptive when it lands on the main branch. There will be CI breakage and lots of problems for people on other feature branches that are suddenly faced with merge issues. I think Martin Fowler actually gets it but some of his followers seem to be confused. By all means, feature toggles are a great way to get changes in early and have them exposed. It's a powerful tool that you can use to get changes out earlier. Early is good. However, it is not the case that if you use feature branches there has to be a lot of pain for everybody. In other words, feature branches are not evil and don't have to be problematic.

It’s not the practice of feature branching that is the problem but the fact that testing and continuous integration are not decentralized in a lot of organizations. In other words until your changes land on the central branch, you are not doing the due diligence of testing. Even worse, you are not making sure you have tested your changes before you add them to the main branch.

You can’t do feature branches unless you also decentralize your testing and integration. There is no good reason why you can’t do that with git. The whole point of git is divide and conquer. Break the change up: decentralize the testing and integration work and solve the vast majority of problems before you push change upstream. If you push your problems along with your changes you are doing it wrong.

Here’s a few simple practices that will address most of the issues:
<ol>
<li> no change that will break CI on the main branch is allowed on the main branch. Zero tolerance on this one. In git terms: rebase against main, run ci test on the feature branch, fix any problems, push. You can automate this even: jenkins pretty much supports this out of the box. If main breaks ever, somebody doesn’t get the basics: educate them with a big clue bat. Rationale, it is vital to keep main stable at all times. That way everybody on a feature branch will know it is safe to rebase.</li>
<li> Rebase against main frequently, especially if you do big changes. Rationale: you are doing the changes, it is you that will take the pain of doing the integration work when things go wrong, not everybody else. The earlier you know about problems, the easier it is to fix. Feature branches are not about stopping rebases. If your feature branch is way behind, you have done something very wrong. Don’t ever do that without good reason. If it is on the central branch, you will have to deal with it at some point: so get it over with ASAP.</li>
<li> Commit frequently, keep commits as small as you can. Rationale: smaller commits are easier to analyze and fix when you have conflicts. Also, Git is really good at applying commits one by one. If you isolate the merge problems to a handful of commits, rebasing is pretty much painless.</li>
<li> Push as early as you can. If the CI builds are green on your branch and you are confident things are fine, push and don’t wait. Don’t accumulate integration work for others. Feature branches are not about hiding change but about isolating change. There’s a difference. One is a communication problem and the other is a proven strategy of divide and conquer. If appropriate, feature toggles are indeed a great way to land experimental changes. I believe this was the main point Martin Fowler was trying to make.</li>
<li>Communicate clearly around big code restructurings. Rationale, everybody rebasing against your changes will experience some pain. You are causing people to have to do work, so tell them it is going to happen. I always ask people to push their changes before I push my big changes. That way, I can fix the integration issues on my side before I push.</li>
<li>Collaborate with people by pushing changes back and forth without involving the main branch. Git format-patch is your friend: you can do this by email. If somebody needs a change before you land it, you can give it to them.</li>
</ol>

When will feature branches get you in trouble? Antipatterns:
<ul>
<li>You are working on a big change. You haven't updated for days. Do I need to spell it out? That is just wrong. Update!</li>
<li>You are pushing a big change, all the CI builds go red. Oops, test before you push you dumb idiot. You deserve all the angry looks you are going to get. If this happens a lot, consider setting up you CI environment for having a stable and unstable branch. Jenkins supports this and it will keep unstable change out of stable.</li>
<li>You are doing a big change, somebody else is also doing a big change. You find out about that when you rebase and spend hours dealing with merge conflicts. Seriously: communicate before you do anything drastic and give people an opportunity to get their changes in before you ruin their day. Pushing massive changes that you know are going to cause others problems is a very egocentric thing to do. Be a team player.</li>
<li>You are working on a big change. You haven't updated or committed anything for several days on your local branch. You are effectively using your local branch as a feature branch: everybody who is not pushing change is effectively on a feature branch. Not committing is not a strategy to avoid using feature branches. Also, you are not committing? Why???? What's your excuse for not committing to your own branch? Seriously, consider using version management and stop treating git as a file server.</li>
</ul>

Now at this point I have to admit something: I don't use feature branches a lot. We haven't set up stable and unstable branches in jenkins yet. We have the occasional breakage of our CI builds. I'm actually guilty of breaking some of the builds myself. The reason/weak excuse is: I'm having a hard time changing people's way of working. You turn your back and people stop committing and continue treating git like they are using cvs. But I'm at least aware what the real problem is here.