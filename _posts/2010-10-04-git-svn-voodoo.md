---
id: 769
title: Git svn voodoo
date: 2010-10-04T23:53:40+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=769
permalink: /2010/10/04/git-svn-voodoo/
dsq_thread_id:
  - "347376774"
wp-syntax-cache-content:
  - |
    a:9:{i:1;s:1648:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/
    svnadmin create svnrepo
    svn co file:///Users/jilles/test/svnrepo svnwc
    cd svnwc
    echo &quot;hello&quot; &gt; hi.txt
    svn add hi.txt
    svn commit -m'hi.txt added'
    svn up
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/
    svnadmin create svnrepo
    svn co file:///Users/jilles/test/svnrepo svnwc
    cd svnwc
    echo &quot;hello&quot; &gt; hi.txt
    svn add hi.txt
    svn commit -m'hi.txt added'
    svn up</p></div>
    ;i:2;s:2575:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/
    # clone the svn repository to a git repository using git-svn ...
    git svn clone file:///Users/jilles/test/svnrepo git1
    cd git1
    # observe there is a hi.txt and a .git directory. here
    echo &quot; World&quot; &gt;&gt; hi.txt
    # stage a change. 
    git add hi.txt
    # now commit the change to your local git repository (i.e. your .git directory contains it)
    git commit -m&quot;say hi to the world&quot;
    # and finally push the local change back to svn
    git svn dcommit
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/
    # clone the svn repository to a git repository using git-svn ...
    git svn clone file:///Users/jilles/test/svnrepo git1
    cd git1
    # observe there is a hi.txt and a .git directory. here
    echo &quot; World&quot; &gt;&gt; hi.txt
    # stage a change.
    git add hi.txt
    # now commit the change to your local git repository (i.e. your .git directory contains it)
    git commit -m&quot;say hi to the world&quot;
    # and finally push the local change back to svn
    git svn dcommit</p></div>
    ;i:3;s:609:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/svnwc
    svn up
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/svnwc
    svn up</p></div>
    ;i:4;s:1864:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test
    # lets not use git svn and instead do a regular git clone, either way would be fine btw.
    git clone file:///Users/jilles/test/git1 git2
    cd git2
    echo '!' &gt;&gt; hi.txt
    git add hi.txt
    # commit the change to the local git2 repository
    git commit -m&quot;finishing touch&quot;
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test
    # lets not use git svn and instead do a regular git clone, either way would be fine btw.
    git clone file:///Users/jilles/test/git1 git2
    cd git2
    echo '!' &gt;&gt; hi.txt
    git add hi.txt
    # commit the change to the local git2 repository
    git commit -m&quot;finishing touch&quot;</p></div>
    ;i:5;s:1537:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/git1
    # add git2 as a remote. 
    git remote add git2 file:///Users/jilles/test/git2
    # fetch tags and branches known on git2
    git fetch git2
    # pull the change made on git2 into the master branch (on git1)
    git pull git2 master
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/git1
    # add git2 as a remote.
    git remote add git2 file:///Users/jilles/test/git2
    # fetch tags and branches known on git2
    git fetch git2
    # pull the change made on git2 into the master branch (on git1)
    git pull git2 master</p></div>
    ;i:6;s:983:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
&#91;svn-remote &quot;svn&quot;&#93;
    url = file:///Users/jilles/test/svnrepo
    fetch = :refs/remotes/git-svn
```
</td></tr></table><p class="theCode" style="display:none;">[svn-remote &quot;svn&quot;]
    url = file:///Users/jilles/test/svnrepo
    fetch = :refs/remotes/git-svn</p></div>
    ;i:7;s:1511:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/git2
    # fetch the svn branch and tag information
    git svn fetch
    # make sure we have all the latest changes on svn by &quot;rebasing&quot;
    git svn rebase
    # now we are ready to dcommit the change we made in git2 back to svn
    git svn dcommit
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/git2
    # fetch the svn branch and tag information
    git svn fetch
    # make sure we have all the latest changes on svn by &quot;rebasing&quot;
    git svn rebase
    # now we are ready to dcommit the change we made in git2 back to svn
    git svn dcommit</p></div>
    ;i:8;s:1386:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/svnwc
    # get the latest changes from the svn repo
    svn up
    # fix the file once more ...
    echo 'hello world!' &gt; hi.txt
    # and commit it
    svn commit -m&quot;stupid newlines&quot;
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/svnwc
    # get the latest changes from the svn repo
    svn up
    # fix the file once more ...
    echo 'hello world!' &gt; hi.txt
    # and commit it
    svn commit -m&quot;stupid newlines&quot;</p></div>
    ;i:9;s:1157:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code">
```
cd /Users/jilles/test/git1
    git svn rebase
    cd /Users/jilles/test/git2
    git svn rebase
```
</td></tr></table><p class="theCode" style="display:none;">cd /Users/jilles/test/git1
    git svn rebase
    cd /Users/jilles/test/git2
    git svn rebase</p></div>
    ";}
categories:
  - Blog Posts
tags:
  - Git
  - google
  - Open Users
  - ubuntu
---
As discussed earlier on this site, I recently started using git in our svn centric organization. Since I'm trying to convince some co-workers to do the same, I would like to share a bit of git voodoo for working with multiple git repositories and a central svn repository. Most git tutorials don't really show how to do this, even though it is quite easy. The approach below gives you all the flexibility with git that you need while allowing you to inter-operate seamlessly with your svn using colleagues.

<!--more-->

Before getting started, make sure you have both git-core and git-svn installed (ubuntu) or that you have done a "sudo port install git-core +svn +bash_completion" if you have a mac. Also, you probably want to [configure git properly](http://www.arthurkoziel.com/2008/05/02/git-configuration/). Google is your friend, there are plenty of tutorials on the basics of git and svn that you might want to run through first.

Both git and svn use urls to identify repositories. For the sake of simplicity, I will use a very basic example involving three local repositories on my file system with file:// based urls but of course you can use http:// ssh+svn:// or git:// type urls just the same:

- file:///Users/jilles/test/svnrepo - A little svn repository. Generally this will be your central svn repo with years of work inside it.
- file:///Users/jilles/test/git1 - A git repository that we'll create using git svn.
- file:///Users/jilles/test/git2 - Another git repository that we will create using git clone.

Lets start by creating a simple svn repo, checking out a svn work copy, and committing some stuff using svn:

```bash

cd /Users/jilles/test/
svnadmin create svnrepo
svn co file:///Users/jilles/test/svnrepo svnwc
cd svnwc
echo "hello" > hi.txt
svn add hi.txt
svn commit -m'hi.txt added'
svn up

```

Ok, we now have a svn repo with some stuff in it. In the git world, you always work on a local repository. You don't check out from a remote repository, instead you clone it. So, lets git svn clone it to a local git repository and make some changes there and then commit it back to the svn repo:

```bash

cd /Users/jilles/test/
# clone the svn repository to a git repository using git-svn ...
git svn clone file:///Users/jilles/test/svnrepo git1
cd git1
# observe there is a hi.txt and a .git directory. here
echo " World" >> hi.txt
# stage a change.
git add hi.txt
# now commit the change to your local git repository (i.e. your .git directory contains it)
git commit -m"say hi to the world"
# and finally push the local change back to svn
git svn dcommit

```

Now lets check on the svn side if it worked ...

```bash

cd /Users/jilles/test/svnwc
svn up

```

Yup, our change is there.

Now imagine a co-worker comes along, who wants to work on his own git repository: git2. To get started, he clones the existing git1 repository and right away makes some changes.

```bash

cd /Users/jilles/test
# lets not use git svn and instead do a regular git clone, either way would be fine btw.
git clone file:///Users/jilles/test/git1 git2
cd git2
echo '!' >> hi.txt
git add hi.txt
# commit the change to the local git2 repository
git commit -m"finishing touch"

```

Back to git1, who is of course interested in the change made in git2:

```bash

cd /Users/jilles/test/git1
# add git2 as a remote.
git remote add git2 file:///Users/jilles/test/git2
# fetch tags and branches known on git2
git fetch git2
# pull the change made on git2 into the master branch (on git1)
git pull git2 master

```

Git1 and Git2 now have the same change but it is not in svn yet. Git2 can't commit to svn yet. So, lets fix that. Open /Users/jilles/test/git2/.git/config in an editor and append the following section:

```bash

[svn-remote "svn"]
        url = file:///Users/jilles/test/svnrepo
        fetch = :refs/remotes/git-svn

```

Save the file and:

```bash

cd /Users/jilles/test/git2
# fetch the svn branch and tag information
git svn fetch
# make sure we have all the latest changes on svn by "rebasing"
git svn rebase
# now we are ready to dcommit the change we made in git2 back to svn
git svn dcommit

```

Good, the change is now back in svn. Lets verify and modify some more in the svn world:

```bash

cd /Users/jilles/test/svnwc
# get the latest changes from the svn repo
svn up
# fix the file once more ...
echo 'hello world!' > hi.txt
# and commit it
svn commit -m"stupid newlines"

```

And lets rebase git1 and git2 against svn:

```bash

cd /Users/jilles/test/git1
git svn rebase
cd /Users/jilles/test/git2
git svn rebase

```

Now git1, git2, and svn are in sync and have the same history. If you examine the history with git log on git1 and git2, you will notice that all the commits have the same hashes. This is no coincidence, commits have globally unique sha1 hashes that are based on their content. The same changes will yield the same hashes no matter where you make them. This is the reason git works so well. It doesn't matter where the change came from, as long as the hashes line up, everything will be fine. 

I've demonstrated that git1 and git2 can pull changes from each other and that you can rebase and dcommit against the central svn repository. You needn't be afraid of double commits or lost commits. Git all sorts it out. From git's point of view, a central svn is just another repository. Git is decentralized and throwing svn in the mix doesn't make much of a difference. It just integrates more or less seamlessly. So, you and your git using co-workers can go off and do all the cool stuff git users do, while all staying in sync with the central svn repository.

Random things you probably want to play with next:

- git svn clone your svn repository; or git clone it from one of your git using colleagues and manually add the svn remote
- use git daemon to set up a network daemon that your colleagues can pull changes from remotely
- create a local branch and integrate changes from your colleagues there before merging back to your git master and dcommitting the change to svn
- allow others to pull your experimental branch

