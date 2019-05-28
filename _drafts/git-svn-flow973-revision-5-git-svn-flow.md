---
id: 979
title: git-svn flow
date: 2012-05-27T11:49:33+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2012/05/27/973-revision-5/
permalink: /2012/05/27/973-revision-5/
---
In recent years, git has rapidly been adopted by software developers. Initially it was a toy used mainly in open source projects but it is now finding its way into the rest of the software development world. At this point in time, git is emerging as a tool of choice for doing version control and a lot of people have either already adopted it or are considering to do so.

A reason for the popularity of git is that it enables a lot of  new and different work flows that allow development teams to change the way they deliver software and deliver better software faster. For example:
<ul>
	<li>The people at <a href="http://scottchacon.com/2011/08/31/github-flow.html">GitHub</a> work with feature branches and merges to a stable master that is kept in a releasable state and is continuously deployed to their production servers. They use pull requests to get changes from the feature branches into the master branch. Of course they use their own products for this.</li>
	<li><a href="http://nvie.com/posts/a-successful-git-branching-model/">Git-flow</a> uses different branches for stable releasable code, development, features, and hot fixes. Additionally it has a few rules about how to merge changes between these branches and scripts to support this. Git-flow was developed by a group of developers that were experimenting with different work flows before they settled on what is now known as git-flow.</li>
	<li>Linux kernel development (which is where git originated) uses an email based pull model where git formatted patches are pulled from mailing lists and integrated into the main line trunk after extensive reviews by the kernel maintainer (i.e. Linus Torvalds himself). This works because the review and patch aggregation work is delegated to lieutenants who in turn delegate work to yet more people. Dozens of people are regular contributors and they in turn source commits from an even larger group of people. Effectively, linux kernel development is a tree of repositories with changes being pulled up all the way to the top where Linus Torvalds sits.</li>
</ul>
These work flows are optimized for very different goals and circumstances. The GitHub model is optimized for continuous deployment and is very appropriate for any server-side software where time to market is crucial. Git-flow uses a more traditional release model where released code has to be supported (with features and hot fixes) for extended periods of time. Finally, the Linux kernel team has optimized their work flow to scale the development to a massive team size with members distributed world-wide across hundreds of companies. It is one of the largest software projects in the world and the kernel team has sustained a very rapid evolution for years now. Interestingly enough, Linus Torvalds created git to support this.

<strong>Git-svn &amp; limitations for work flows.
</strong>

At work, we still use a central subversion repository. For various reasons, migrating from subversion to git is not a priority and technically challenging in our case for various other reasons that are beyond the scope of this post. Several teams commit on this central repository and we have a Jenkins doing CI builds, automated deployments to test machines, etc.

Several people (me included) across the teams are using git-svn. This allows us to work locally in git and treat the central svn as a git remote. Using git-svn is quite straight forward: you git svn rebase to get upstream changes from svn and you git svn dcommit to push out your local git commits back to svn. However, we have not really adapted our work flow and our workflow is very similar to traditional svn centric work flows.

Recently, I have started looking into adopting a more sophisticated work flow for our team and move us away from the highly centralized work flow around the central svn. Because our subversion is a pretty busy place and because our Jenkins machines take hours to churn through our quite extensive system and deployment test suite (which means there is a significant delay between committing and builds breaking), there tends to be a lot of fallout if svn trunk breaks. Unfortunately, this is a growing concern and the team is being blocked frequently by instability on trunk. To address this, my team wants to adopt a work flow that allows us to accumulate commits, verify that they don't break anything, etc. and then only when everything looks great, we push out a whole batch of git commits to the central svn repository. All this should be accomplished without disrupting the other teams that may opt to continue to use svn the old way.

Unfortunately, git-svn is a bit of a headache when it comes to using the git based work flows I listed above. The main issue is the difference in semantics between a git merge and a svn merge and the resulting lack of a git svn merge operation: you can only rebase with git-svn. A svn merge applies diffs to files. A git merge combines graphs of commits into a graph that has the commits from both graphs. Git users synchronize by exchanging their changes to this graph. Svn history is linear: each commit has only one ancestor. Git history is a directed acyclic graph (if you use merge) and commits can have several ancestors. Git svn dcommitting a non linear history of commits to svn is impossible/very hard and also very easy to get wrong. Of the three work flows I listed at the beginning of this post, two heavily depend on using git merges. So, you can't use them with git-svn. The linux kernel model relies on exchanging patches via email. This works fine in a git-svn world but is kind of tedious in a team that is neither distributed geographically nor particularly large. Exchanging patches via email with a guy sitting next to you is kind of weird and tedious.

Also git-svn in combination with git or svn branches and a git remote is a bit fragile. It is easy to get wrong and push commits that do a lot of unintended things. Whenever you update from svn using git svn rebase, you rewrite your local git history. The commits in your git repository are re-ordered so that your local git commits appear after the svn commits. This allows you to dcommit them back to svn. Rewriting history like this is fine as long as your local git repository is the only one affected.

However, a git based work flow with multiple people by definition involves multiple git repositories: at least one for each person, remote git repositories, and even Jenkins has its own repository. To synchronize between those repositories commits have to be pushed or pulled between them. This works fine as long as you use the central svn server as the only way to share changes. But it gets kind of hard if people are rewriting history all the time using git-svn rebase and combine that with pulling and pushing between git repositories. In the git world this only works because git has a graph of commits. In git, you can opt to merge two histories and push out the result. Rebasing is typically only done locally before you push/pull changes.

<strong>Coming up with a decentralized git-svn work flow that doesn't suck.</strong>

The work flow I'm about to outline is something that I want our team to start using. It has not been battle tested yet but I've done a lot of research on the topic so far and I feel this is something that might actually work.

<a href="http://www.jillesvangurp.com/?attachment_id=978" rel="attachment wp-att-978"><img class="aligncenter size-full wp-image-978" title="gitsvnflow" src="http://www.jillesvangurp.com/wp-content/uploads/2012/05/gitsvnflow.png" alt="" width="678" height="460" /></a>
<ol>
	<li>A central git server is used to store all changes in separate git branches.</li>
	<li>One of these branches is automatically populated with changes from svn by a jenkins job that regularly git svn rebases a local repository and then pushes the new svn commits from upstream to this branch on the central repository. This branch id called svnro. The main point of this is to isolate the interaction with svn (and the associated fragility) and allow all git users to simply rebase against a git branch rather than having to use git-svn directly.</li>
	<li>Each branch has a "owner" and the owner is the only one that is allowed to push commits to that branch.</li>
	<li>To collaborate, team members each fork the svnro branch to create a private branch and then rebase commits from each others branches. This emulates the git-hub pull request model except we use rebase rather than merge.</li>
	<li>Branch owners regularly rebase their branch against svnro. Because all branches on the central git repository are read only (except for their owner), it is alright for the branch owner to rewrite history like this and push the rewritten history to the central git repository. Git will disallow this by default and this only works if you use a git push --force.</li>
	<li>Branching from branches other than svnro is not allowed because the history of the other branches may be rewritten.</li>
	<li>Pushing to other people's branches is not allowed because the history of that branch may be rewritten while you still have unpushed local commits.</li>
	<li>Ownership of a branch may be transferred. Team members should communicate on this clearly to avoid problems.</li>
	<li>Branch owners must rebase against svnro before they rebase against other branches. This ensures that they don't actually reorder svn commits and mix them with git commits.</li>
	<li>Accidents with reordered commits can still happen and may be corrected by creating a new branch from svnro and then cherry picking changes from the old branch.</li>
	<li>A Jenkins integration tests every branch in the central repository. This is quite easy to set up using the git support in Jenkins. This ensures each feature branch has continuous integration before we git svn dcommit.</li>
	<li>When ready, changes on a branch can be git svn dcommitted by using the central repository as a remote on a git-svn clone of svn trunk and rebase the changes on the master.</li>
	<li>The person doing a svn dcommit must ensure the history is free of merges and has been properly rebased against svn trunk (i.e. all svn commits must appear before the new git commits).</li>
	<li>Before dcommitting, all change sets must pass all available tests. Because we can group large change sets and test them in one go, we can afford to invest time in this.</li>
	<li>A dcommit is a great opportunity for code reviews and eyeballing commits and should be handed off to a different person than the feature branch owner with the changes.</li>
</ol>
The model I outlined here combines the Linux kernel and Git-Hub model. Changes are pulled between branches like in Git Hub. A feature owner pulls in changes from other team members to integrate them, thus taking a similar role as a lieutenant in the Linux Kernel world. Finally, whomever does the git svn dcommit gets to play Linus Torvalds.

Example
<pre>branch1          x--x--x
                /
               |
svnro       *--*

git-svn     *--*

trunk       *--*</pre>
Two commits from svn are pushed onto svnro in central. Somebody creates a branch and does some work.
<pre>branch2                      x--x--x--y--y
                            /
                           |
branch1          x--x--x   |
                /          |
               |           |
svnro       *--*--*--*--*--*--*--*--*

git-svn

svn trunk   *--*--*--*--*--*--*--*--*</pre>
Another user creates a branch and rebases the changes from branch1 and commits some additional changes. Meanwhile several commits have happened in svn and both branches are slightly behind now.
<pre>branch2                      x--x--x--y--y
                            /
                           |
branch1                    |          x--x--x--y--y--z
                           |         /
                           |        |
svnro       *--*--*--*--*--*--*--*--*

git-svn     *--*--*--*--*--*--*--*--*

svn trunk   *--*--*--*--*--*--*--*--*</pre>
The owner of branch1 rebases against svnro and then against branch2 and does an additional commit.
<pre>branch1                               x--x--x--y--y--z
                                     /
                                    |
svnro       *--*--*--*--*--*--*--*--*

git-svn     *--*--*--*--*--*--*--*--*--*--x--x--x--y--y--z

svn trunk   *--*--*--*--*--*--*--*--*--*--x--x--x--y--y--z</pre>
Branch2 is deleted and someone rebases the changes on branch1 into the git-svn master and dcommits to trunk.