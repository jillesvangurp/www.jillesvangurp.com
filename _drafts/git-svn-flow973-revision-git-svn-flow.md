---
id: 974
title: git-svn flow
date: 2012-05-26T20:28:11+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2012/05/26/973-revision/
permalink: /2012/05/26/973-revision/
---
Git enables a lot of different work flows. A few examples of this:
<ul>
	<li>The workflow used by <a href="http://scottchacon.com/2011/08/31/github-flow.html">GitHub</a>. The GitHub people work with feature branches and merge to a stable master, which is kept in a releasable state. Additionally they use pull requests to get changes from the feature branches into the master branch. Additionally they use their own product to do reviews as well.</li>
	<li>The <a href="http://nvie.com/posts/a-successful-git-branching-model/">git-flow</a> work flow was blogged about a lot a few years ago and they use a stable and a development branch and a few rules about how to merge changes between the two.</li>
	<li>Linux kernel development (which is where git originated) uses an email based pull model where git formatted patches are pulled from mailing lists and integrated into the main line trunk after extensive reviews by the kernel maintainer (i.e. Linus Torvalds himself). This works because the review and patch aggregation work is delegated to lieutenants who in turn delegate work to yet more people. Dozens of people are regular contributors and they in turn source commits from an even larger group of people.</li>
</ul>

Each of these work flows depends on git specific features that you don't find in traditional VCS tools such as CVS or Subversion that work with a central repository model rather than a decentralized model.

At work, we use a central subversion repository. For various reason, migrating from subversion to git is not a priority and also technically quite challenging in our case for various reasons I won't go into. Several teams commit on this central repository and we have a jenkins doing builds, automated deployments to test machines, etc. In short, we have a lot of moving parts in our build infrastructure.

Several people across the teams are using git-svn. Using git-svn in isolation is quite straightforward. You git svn rebase to get incoming changes from svn and you git svn dcommit to push out your local git commits back to svn. I've been doing this for a few years now and it is generally superior to using plain svn. Git-svn supports working like this very well.

Recently, I have started looking into adopting a more extensive git work flow for our team. Because our central subversion is a pretty busy place and because our Jenkins machines take hours to churn through our quite extensive system and deployment test suite (which means there is a significant delay between committing and builds going red), there tends to be a lot of fallout if trunk breaks, which unfortunately has been a growing concern. To prevent trunk breakage, we want to adopt a work flow that allows us to accumulate commits, verify that they don't break anything, etc. and then only when everything looks great, we push out a whole batch of git commits to the central svn repository. 

Unfortunately, git-svn is a bit of a headache when it comes to git based work flows. The main issue is the difference in semantics between a git merge and an svn merge. A svn merge is about applying diffs to files. A git merge is about combining graphs of commits into a graph that has the commits from both graphs. Svn history is linear. Git history is a directed acyclic graph (if you use merge). Git svn dcommitting a non linear history of commits to svn is basically not possible. Of the three work flows I listed at the beginning of this post, two heavily depend on using merges. So, they can't be used with git-svn. The third one uses exchanging of patches via email. This works fine but is kind of tedious in a team our size and too much of a cultural change to stand a chance of being popular.

An additional issue is that git-svn in combination with branches and a git remote tends to get ugly. Basically, whenever you update from svn by using git svn rebase, you rewrite your local history. The commits get re-ordered. That is fine as long as your local git repository is the only one affected. A work flow with multiple people by definition involves multiple git repositories and pushing/pulling commits between them. You can't do that if people are rewriting history all the time. In the git world this only works because git has a graph of commits rather than a linked list of commits. Crucially, we can't do this.

The work flow I'm about to outline is something I want to start using. It has not been battle tested yet but I've done a lot of research on the topic so far and I feel this is something that might work.

Basically what I want to do is going to look like a variation of the git-hub work flow. Except without merges. 

<ol>
        <li>A central git server is used to store all changes in separate git branches.</li>
	<li>One of these branches is automatically populated with changes from svn by a jenkins job that regularly git svn rebases a local repository and then pushes the new svn commits from upstream to this branch on the central repository. Lets call this branch svnro.</li>
        <li>Team members only push to their own branches. When they want changes from another team member, they rebase their branches against each other (and don't merge). So, each branch has a "owner" and the owner is the only one that adds commits. Those commits may come from another branch but they'll be pulled in by the owner and not pushed.</li>
        <li>Because all branches on the central git repository are read only (except for their owner), it is alright for the branch owner to rewrite history and push the rewritten history to the central git repository. Git will disallow this by default and this only works if you use a git push --force.</li>
	<li>To collaborate, users create their own local branch from the readonly svn branch and then pull in changes from other team members as needed. Then they do their own commits on their local branch and if desired push that branch out to the central repository where the commits will be available for pulling by other users.</li>
	<li>Branch owners rebase regularly against the readonly svn branch to ensure their branch will integrate without conflicts when the time comes.</li>
	<li>A Jenkins integration tests every branch in the central repository. This is quite easy to setup using the git support in jenkins.</li>
        <li>When ready, changes on a branch can be git svn dcommitted by using the central repository as a remote on a git-svn clone of svn trunk and pulling the changes in. This requires a few checks and balances of course. The person doing this must ensure the history is free of merges and and has been properly rebased (i.e. all svn commits must be before the new git commits).</li>
</ol>