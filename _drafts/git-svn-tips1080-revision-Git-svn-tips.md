---
id: 1081
title: Git-svn tips
date: 2012-06-10T14:50:35+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2012/06/10/1080-revision/
permalink: /2012/06/10/1080-revision/
---
I know that dozens of perfectly good git-svn tutorials are a mere Google search away. So I won't bother repeating those (or indeed myself). Instead, this post is about listing a few ways of working with git-svn that help you avoid some pitfalls.

<strong>Don't git merge or rebase stuff you intend to dcommit</strong>

Given the nature of the git and svn integration, both git merges and rebases (other than those against svn) are not recommended. A git merge results in a non linear history that is not compatible with svn's linear history. A git rebase rewrites history. While this works well, you should be very careful to avoid reordering any svn commits. I've seen this go wrong a couple of times.

<strong>Git format-patch is your friend</strong>

Instead of rebase and merge, use git format patch to apply commits to whatever repository/branch you want. This is also great for collaborating. You can simply email the patches around and people can apply them (or review them as is).

A git patch is a plain text version of a commit that can be applied to any repository with a compatible commit history (i.e. the ancestor commit hash referred in the commit must exist in the history on the other side). Despite the name, a git formatted patch is quite different from a normal patch. In the git world, which is decentralized, all commits have globally unique hashes that identify them as well as ancestors. Therefore a git formatted patch is a full blown commit that has all the necessary meta information. It is compatible with any repository that already has the ancestor specified in the commit.

This is how you generate patches (one for each commit)
<pre>git format-patch -n -[numberofcommits] -b</pre>
Then on the other side, you can apply the patches using the git am command.
<pre>git am /tmp/foo/* --ignore-whitespace -3</pre>
That's all there is to it. Of course both commands have tons of options as well. The git am command works very similar to the git rebase command. It applies patches one by one and allows you to fix conflicts in a way similar to git rebase does it. For that the -3 option is useful since it results in a three way merge that you can easily edit in any diff viewer like e.g. opendiff. When you are done you simply git add the modified files and do a git am --continue. If you want to roll back, you simply do a git am --abort.

<strong>Don't track svn branches</strong>

There are various blog posts out there that both warn against tracking multiple svn branches in git and then explain how to do it. Despite these explanations: don't do it. It's not worth it and it will end in tears. I did a disastrous dcommit a few months ago that looked perfectly harmless on my side but ended up doing some major damage in the svn tree.

Instead git svn clone branches into their own repositories. This way you isolate their interaction with svn and minimize the potential for disaster.

You can use the format-patch method above for moving commits between two svn branches that you track with separate git repositories. This is superior to doing svn merges a great way to reintegrate changes on a svn branch into svn trunk.

<strong>Fix commit author information</strong>

If you are collaborating with multiple git users and a central svn repository, you'll want to make sure that you use either an authors file or a script to fix commit authors. That way, you'll be able to exchange commits with others and git svn dcommit them on their behalf with the author information intact.

Author information in svn commits and git commits work a little differently. Svn stores the userid and git only stores the user name + email address. This is important when you dcommit, review the log, and clone a repository. When you see a lot of funny looking email addresses in your git log that look like userid@somehash, the information is not lined up.
<pre>git config svn.authorsprog /home/jivangur/svn_authors.sh
git config svn.addAuthorFrom true
git config svn.useLogAuthor true</pre>
For some reason I had to specify --svn.authors-prog on the command line as well for git svn fetch and git svn clone.

The script below, courtesy of @sthuebner is what we use in Nokia. You may be able to adapt it for use in your enterprise network:
<pre>uid=$1
mailaddr=$(ldapsearch -x -LLL -h nedi -b o=nokia uid=$uid mail | grep "mail:" | awk '{print $2}')
name=$(ldapsearch -x -LLL -h nedi -b o=nokia uid=$uid cn | grep "cn:" | awk '{print $3 " " $2}')

echo "$name "</pre>
<strong>Clone your git svn clone</strong>

Cloning large svn repositories is slow. Luckily you have to do it only once. So don't do it twice and use git clone the second time.

Here's how you git clone a git svn clone and hook it up to svn again.
<pre>git clone [urltoexistinggit-svnrepo]
git svn init [svnuri]
git config --global svn.authorsprog=/Users/jivangur/scripts/svn_authors.sh
git svn rebase</pre>
The last command will quickly reconstruct the svn history from the cloned repo. After that you are all set. You may want to remove the origin after you are done.
<pre>git remote rm origin</pre>
<strong>Exchanging patches with svn users</strong>

Sometimes you have to share patches with non git users, which is annoying but not impossible. The script below does what you need: it converts all local commits into a big diff file that any git challenged user can apply the old fashioned way using the patch command.
<pre>TRACKING_BRANCH=`git config --get svn-remote.svn.fetch | sed -e 's/.*:refs\/remotes\///'`
REV=`git svn find-rev $(git rev-list --date-order --max-count=1 $TRACKING_BRANCH)`
git diff --no-prefix $(git rev-list --date-order --max-count=1 $TRACKING_BRANCH) $* | sed -e "s/^+++ .*/&amp;    (working copy)/" -e "s/^--- .*/&amp;    (revision $REV)/" \
    -e "s/^diff --git [^[:space:]]*/Index:/" \
    -e "s/^index.*/===================================================================/"</pre>