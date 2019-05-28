---
id: 770
title: Git svn voodoo
date: 2010-10-04T22:41:45+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/10/04/769-revision/
permalink: /2010/10/04/769-revision/
---
As discussed earlier on this site, I recently switched to using git in our svn centric organization. Since I'm trying to convince some co-workers to do the same here is a bit of git voodoo for some common tasks.

Both git and svn use repositories to identify repositories. For the sake of simplicity, I will use a minimal example involving three local repositories:
<ul>
	<li>file:///Users/jilles/test/svnrepo</li>
	<li>file:///Users/jilles/test/git1</li>
	<li>file:///Users/jilles/test/git2</li>

Lets start by creating the svn repo, checking out a svn work copy and committing some stuff.
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

Ok, we now have svn repo with some stuff in it. Now lets git svn clone it. Make some change and commit it back to the svn repo.

<pre lang="bash">
cd /Users/jilles/test/
git svn clone file:///Users/jilles/test/svnrepo git1
cd git1
echo " World" >> hi.txt
git add hi.txt
git commit -m"say hi to the world"
git svn dcommit
</pre>

Lets check on the svn side ...
<pre lang="bash">
cd /Users/jilles/test/svnwc
svn up
</pre>

Yup, it's there.

Enter a random co-worker, who will work on his own git repository: git2. To get him started quick, he clones the existing git repository.

<pre lang="bash">
cd /Users/jilles/test
git clone file:///Users/jilles/test/git1 git2
cd git2
echo '!' >> hi.txt
git add hi.txt
git commit -m"finishing touch"
</pre>

Back to git1, who is of course interested in the change:

<pre lang="bash">
cd /Users/jilles/test/git1
git remote add git2 file:///Users/jilles/test/git2
git fetch git2
git pull git2 master
</pre>

Git1 and Git2 now have the change but Git2 can't commit to svn yet. Lets fix that. Open /Users/jilles/test/git2/.git/config in an editor and append the following section:
<pre lang="bash">
[svn-remote "svn"]
        url = file:///Users/jilles/test/svnrepo
        fetch = :refs/remotes/git-svn
</pre>


