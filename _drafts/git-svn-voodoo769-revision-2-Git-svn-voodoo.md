---
id: 771
title: Git svn voodoo
date: 2010-10-04T23:04:22+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/10/04/769-revision-2/
permalink: /2010/10/04/769-revision-2/
---
As discussed earlier on this site, I recently switched to using git in our svn centric organization. Since I'm trying to convince some co-workers to do the same here is a bit of git voodoo for working with multiple git repositories and a central svn repository.

Both git and svn use repositories to identify repositories. For the sake of simplicity, I will use a minimal example involving three local repositories with file:// based urls but you can use http:// ssh:// or git:// just the same.
<ul>
	<li>file:///Users/jilles/test/svnrepo - A little svn repository. Generally this will be your central svn repo with years of work inside it.</li>
	<li>file:///Users/jilles/test/git1 - A git repository that we'll create using git svn.</li>
	<li>file:///Users/jilles/test/git2 - Another git repository that we will create using git clone.</li>
</ul>

Lets start by creating a simple svn repo, checking out a svn work copy and committing some stuff using svn:
<pre lang="bash">
cd /Users/jilles/test/
svnadmin create svnrepo
svn co file:///Users/jilles/test/svnrepo svnwc
cd svnwc
echo "hello" > hi.txt
svn add hi.txt
svn commit -m'hi.txt added'
svn up
</pre>

Ok, we now have a svn repo with some stuff in it. Now lets git svn clone it to a git repository and make some change and then commit it back to the svn repo:

<pre lang="bash">
cd /Users/jilles/test/
# clone the svn repository to a git repository ...
git svn clone file:///Users/jilles/test/svnrepo git1
cd git1
echo " World" >> hi.txt
# stage a change
git add hi.txt
# commit the change to your git repository
git commit -m"say hi to the world"
# and finally push the change back to svn
git svn dcommit
</pre>

Now lets check on the svn side ...
<pre lang="bash">
cd /Users/jilles/test/svnwc
svn up
</pre>

Yup, our git change is there.

Now imagine a co-worker comes along, who wants to work on his own git repository: git2. To get started, he clones the existing git repository and right away makes some changes.

<pre lang="bash">
cd /Users/jilles/test
# lets not use git svn and instead do a regular git clone
git clone file:///Users/jilles/test/git1 git2
cd git2
echo '!' >> hi.txt
git add hi.txt
# commit the change
git commit -m"finishing touch"
</pre>

Back to git1, who is of course interested in the change made in git2:

<pre lang="bash">
cd /Users/jilles/test/git1
# add git2 as a remote. 
git remote add git2 file:///Users/jilles/test/git2
# fetch tags and branches known on git2
git fetch git2
# pull the change made on git2 into the master branch (on git1)
git pull git2 master
</pre>

Git1 and Git2 now have the change but Git2 can't commit to svn yet. Lets fix that. Open /Users/jilles/test/git2/.git/config in an editor and append the following section:
<pre lang="bash">
[svn-remote "svn"]
        url = file:///Users/jilles/test/svnrepo
        fetch = :refs/remotes/git-svn
</pre>

Save the file and:
<pre lang="bash">
cd /Users/jilles/test/git2
# fetch the svn branch and tag information
git svn fetch
# make sure we have all the latest changes on svn
git svn rebase
# now commit the change we made back to svn
git svn dcommit
</pre>

Good, the change is now back in svn. Lets verify and modify some more:
<pre lang="bash">
cd /Users/jilles/test/svnwc
svn up
echo 'hello world!' > hi.txt
svn commit -m"stupid newlines"
</pre>

And lets rebase git1 and git2 against svn:
<pre lang="bash">
cd /Users/jilles/test/git1
git svn rebase
cd /Users/jilles/test/git2
git svn rebase
</pre>

Now git1, git2, and svn are in sync and have the same history. I've demonstrated that git1 and git2 can pull changes from each other and rebase and dcommit against the central svn repository. Of course, this is git and there is more than way you can achieve the above goals. For example, I could have used push instead of pull between the two git repositories. I could add a third repository to the mix. I could throw branches into the mix, etc. 