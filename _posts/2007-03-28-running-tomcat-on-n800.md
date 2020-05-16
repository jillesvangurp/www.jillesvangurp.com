---
id: 264
title: Running Tomcat on N800
date: 2007-03-28T10:03:29+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/03/28/running-tomcat-on-n800/
permalink: /2007/03/28/running-tomcat-on-n800/
dsq_thread_id:
  - "336376897"
categories:
  - Blog Posts
tags:
  - java
  - JIT
  - nokia
  - PATH
  - UPDATE
  - webdevelopment
---
I've been doing some N800 hacking at work recently and have been toying with getting various programming environments going. Including the one I know best: serverside Java.

To get Java on the N800, you will need jamvm. Some packages for that are provided here: http://www.internettablettalk.com/forums/showthread.php?t=2896. The packages are unsupported and not available elsewhere. Also there's some bugs (which is why it's not in official maemo repositories yet). The bugs mainly concern AWT and swing stuff which I don't really care about anyway.

To install (as root):
<blockquote>
$ dpkg -i jamvm_1.4.3-1_armel.deb
$ dpkg -i classpath_0.91-1_armel.deb
$ dpkg -i jikes_1.22-1_armel.deb
$ export PATH=/usr/local/bin:$PATH
$ export CLASSPATH=/usr/local/classpath/share/classpath/glibj.zip:.
</blockquote>

The last two commands add jamvm and jikes to the path and add the gnu classpath to the classpath.

Now you can run tomcat on the N800:
<ul>
	<li>download tomcat 5.0.30beta from tomcat.apache.org. This is the last version that does not require java 1.5.</li>
	<li>upload it to N800</li>
	<li>download this zip file with [configuration for tomcat with jamvm](https://www.jillesvangurp.com/wp-content/uploads/2007/03/jamvm.zip)</li>
	<li>copy provided server.xml to the tomcat conf directory. This configures tomcat to be a bit more lightweight than out of the box. It also disables mbeans which seem to require classes not in the gnu classpath. You can reduce footprint further by stripping stuff from the webapps dir (e.g. documentation + examples)</li>
	<li>use provided jamvmtomcat.sh script to start tomcat (you'll need to adjust the paths inside). I don't have a stop script but should be trivial to add.</li>

On my N800, startup time after first launch is 3-4 minutes and most of the servlet and jsp examples in the default tomcat both work correctly and the whole thing is quite responsive. The Jamvm process takes about 26MB with tomcat running. That's all quite impressive considering that jamvm does not include a JIT.

**UPDATE**. I've continued experimenting and got the startup time down to 2 minutes now. Basically I removed all webapps except the balancer app and my own war file. Some more experimenting with jamvm and other java stuff has learned me that the main performance problem is IO while loading classes. Once that is done, the interpreter is quite fast and usable.
