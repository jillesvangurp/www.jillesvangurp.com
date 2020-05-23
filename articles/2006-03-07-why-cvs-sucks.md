---
title: why cvs sucks
date: 2006-03-07T14:02:00+00:00
author: Jilles van Gurp


permalink: /2006/03/07/why-cvs-sucks/
dsq_thread_id:
  - "337720654"
tags:
  - CVS
  - eclipse
  - java
  - subversion
  - versionmanagement
---
Having worked with subversion quite extensively, I know what to expect from a proper versioning system. However, I'm currently working in a project with a cvs server. Here's a few of my observations:

- I can't seem to get tortoisecvs and eclipse to work together on the same checked out repository. Reason: tortoisecvs does not support eclipse's custom extssh stuff. Duh, ssh is only the most common way to access a cvs repository these days.
- I'm unable to put things like directories under version management, only the contents.
- I don't seem to have an easy way of getting the version history for a directory of files with the commit messages ordered by date.Ã‚Â  I'm sure there are scripts to do thisÃ‚Â  but it is definately not supported natively (and likely to bog down the cvs server).
- Each file has its own version number
- Commit messages do not specify what files were committed (unless you paste this information in the message of course)!
- I managed on several occasions to do a partial commit. That is some files were committed and some weren't
- Each time I refactor, I lose version history because cvs considers the result of a copy, move or rename to be a new file.
- My attic is full of files that now have a different name
- Branching and tagging create full serverside copies of whatever is being branched or tagged

Subversion doesn't have any of these problems. CVS seems to actively discourage refactoring, is dangerously unreliable for large commits and does an extremely poor job of keeping version history. The fact that I encounter all of these problems on a toy project says a lot about CVS.
This is why CVS should not be used for serious projects:

- Refactoring now is a key part of development. Especially (good) java developers refactor all the time.
- The versioning system should never ever end up in an inconsistent state due to partial commits. There is no excuse for this. A version management system without built in protection against should be considered seriously broken.
- Being able to keep track of version history is crucial to monitoring project progress. I've been a release manager. Only now I'm starting to realize how much my job would have sucked if we'd be CVS users. I feel sorry for all these open source people who still continue to use CVS on a voluntary basis.

