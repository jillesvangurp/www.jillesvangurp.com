---
id: 76
title: Howto start jEdit
date: 2005-11-07T21:28:38+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/?p=76
permalink: /2005/11/07/howto-start-jedit/
aktt_notify_twitter:
  - 'no'
dsq_thread_id:
  - "336375693"
categories:
  - Blog Posts
tags:
  - java
  - linux
  - problemsandsolutions
  - Program Files
  - Software in General
  - Windows Registry Editor Version
---
At work I am (in)famous for being responsible for getting [jEdit](http://www.jedit.org) onto everybodies desktop. Despite this everyone uses textpad :-/. These primitive souls are perfectly happy (or ignorant?) not using syntax highlighting, not having their xml validated, not being able to search and replace using regexs, not being able to indent their xml files, not having autocompletion, etc.

Anyway, one of the nastier aspects of jEdit is integrating properly with windows and configuring it. Older versions included a convenient but broken .exe frontend. Newer versions require some manual setup to get going.

First of all, the jvm matters. jEdit runs faster and prettier with jre 1.5. Second of all, select native look and feel unless you really like the shitty java look and feel.

A crucial thing is to provide enough memory AND specify a small enough minimum heapsize. Contrary to the popular belief, java programs are quite efficient. jEdit for example can run with just 10MB of memory heap. Unless of course you open up big files or multiple files in which case you may need more than that. The trick with Java is that you can specify upper and lower limits on the memory heap. The garbage collector will never shrink the heap below the minimum or grow it above the maximum. With jEdit, most of the time you don't need that much, so specify 10Mb as the minimum. You may need more sometimes though, especially when you are running lots of plugins so specify 256 as the upper limit (probably way more than jEdit will ever use).

Another crucial setting is -reuseview which will allow you to reuse already running jedit windows for opening new files.

Use the following settings for a shortcut:

```bash

javaw.exe -Xms10M -Xmx256M
-jar "C:/Program Files/jEdit 4.2/jedit.jar" -reuseview

```

I also have a nice cygwin shell script to be able to open a file straight into jEdit.

```bash

#!/bin/bash
currentpath=`pwd`
javaw -Xms10M -Xmx256M
-jar "c:/Program Files/jEdit 4.2/jedit.jar" -reuseview `cygpath -w $currentpath/$1` &

```

An 'open in jedit' context menu option can be obtained by importing this registry setting (create text file jedit.reg and paste stuff below, save, double click on the file)

```text

Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT*shellOpen with jEdit]

[HKEY_CLASSES_ROOT*shellOpen with jEditcommand]
@="javaw -Xms40M -Xmx256M -jar \"C:\\Program Files\\jEdit 4.2\\jedit.jar\" -reuseview \"%l\""
```

Edited as suggested in the comments, wordpress conveniently removes slashes when you save the text :-(.

**Update 02-04-2011**:

It's been a while since I wrote this and when I hit my own post accidentally with a Google query, I knew it was time to do a little update. All of the above is still valid as far as I know, except I now use a mac. For a mac, or in fact any linux/unix type installation, there's a convenient way to start jEdit from a bash function. Just include the line below in your .profile or .bashrc (adjust paths as needed of course):


```bash

function jedit() { java -Xms15M -jar /Applications/jEdit.app/Contents/Resources/Java/jedit.jar -reuseview "$@" &}

```

**Update 11-07-2011**:

The above line of .profile voodoo is now also available on [Gist](https://gist.github.com/1004521), the code snippet sharing site on Github.