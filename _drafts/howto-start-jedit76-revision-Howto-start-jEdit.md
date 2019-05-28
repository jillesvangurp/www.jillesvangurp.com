---
id: 821
title: Howto start jEdit
date: 2006-11-06T23:48:10+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2006/11/06/76-revision/
permalink: /2006/11/06/76-revision/
---
At work I am (in)famous for being responsible for getting <a href="http://www.jedit.org">jEdit</a> onto everybodies desktop. Despite this everyone uses textpad :-/. These primitive souls are perfectly happy (or ignorant?) not using syntax highlighting, not having their xml validated, not being able to search and replace using regexs, not being able to indent their xml files, not having autocompletion, etc.

Anyway, one of the nastier aspects of jEdit is integrating properly with windows and configuring it. Older versions included a convenient but broken .exe frontend. Newer versions require some manual setup to get going.

First of all, the jvm matters. jEdit runs faster and prettier with jre 1.5. Second of all, select native look and feel unless you really like the shitty java look and feel.

A crucial thing is to provide enough memory AND specify a small enough minimum heapsize. Contrary to the popular belief, java programs are quite efficient. jEdit for example can run with just 10MB of memory heap. Unless of course you open up big files or multiple files in which case you may need more than that. The trick with Java is that you can specify upper and lower limits on the memory heap. The garbage collector will never shrink the heap below the minimum or grow it above the maximum. With jEdit, most of the time you don't need that much, so specify 10Mb as the minimum. You may need more sometimes though, especially when you are running lots of plugins so specify 256 as the upper limit (probably way more than jEdit will ever use).

Another crucial setting is -reuseview which will allow you to reuse already running jedit windows for opening new files.

Use the following settings for a shortcut:
<pre><code>
javaw.exe -Xms10M -Xmx256M
-jar "C:/Program Files/jEdit 4.2/jedit.jar" -reuseview
</code></pre>
I also have a nice cygwin shell script to be able to open a file straight into jEdit.
<pre><code>
#!/bin/bash
currentpath=`pwd`
javaw -Xms10M -Xmx256M
-jar "c:/Program Files/jEdit 4.2/jedit.jar" -reuseview `cygpath -w $currentpath/$1` &
</code></pre>
An 'open in jedit' context menu option can be obtained by importing this registry setting (create text file jedit.reg and paste stuff below, save, double click on the file)
<pre><code>
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT*shellOpen with jEdit]

[HKEY_CLASSES_ROOT*shellOpen with jEditcommand]
@="javaw -Xms40M -Xmx256M -jar \"C:\\Program Files\\jEdit 4.2\\jedit.jar\" -reuseview \"%l\""</code></pre>
Edited as suggested in the comments, wordpress conveniently removes slashes when you save the text :-(.