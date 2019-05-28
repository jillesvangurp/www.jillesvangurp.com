---
id: 693
title: log4j, maven, surefire, jetty and how to make it work
date: 2010-02-13T10:01:36+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/02/13/687-revision-6/
permalink: /2010/02/13/687-revision-6/
---
I spend some time yesterday on making <a href="http://logging.apache.org/log4j/1.2/index.html">log4j</a> behave. Not for the first time (gave up on several occasions) and I was getting thoroughly frustrated with how my logs refuse to conform to my log4j configuration, or rather any type of configuration. This time, I believe I succeeded and since I know plenty of others must be facing the exact same misery and since most of the information out there is downright misleading in the sense of presenting all types of snake oil solutions that actually don't change a thing, here's a post that offers a proper analysis of the problem and a way out. That, and it's a nice note to self as well. I just know that I'll need to set this up again some day.

In a nutshell, the problem is that there are multiple ways of doing logging in Java and one in particular, Apache c<a href="http://commons.apache.org/logging/">ommon-logging</a>, is misbehaving. This trusty little library, which has not evolved significantly since about 2005 and is depended on by just about any dependency in the maven repository that does logging, mostly for historical reasons. Some others depend on log4j directly and yet some others depend on <a href="http://www.slf4j.org/">slf4j</a> (Simple Logging Facade for Java). Basically, you are extremely likely to have a transitive dependency on all of these and even a few dependencies on <a href="http://java.sun.com/j2se/1.4.2/docs/guide/util/logging/overview.html">JDK logging</a> (introduced in Java 1.4).  

The main goal of commons.logging is not having to choose log4j or JDK logging. It acts as a facade and picks one of them using some funky reflection. Nice but most production deployments seem to favor log4j anyway. In our case, all our projects depend on log4j directly.

One of the nasty things with commons-logging is that it behaves weirdly in complex class loading situations. Like in maven or a typical application server. As a result, it takes over orchestration of the logs for basically the whole application and wrongly assumes that you want to use jdk logging. 

Symptoms: you configure logger foo in log4j.xml to shut the fuck up (STFU) below error level and when running your maven tests (or even from eclipse) or in your application server it barfs all over the place at INFO level, which is the unconfigured default. To top it off, it does this using an appender you sure as hell did not configure. Double check, yes log4j is on the classpath, it finds your configuration, it even creates the log file you defined an appender for but nothing shows up there. You can find out what log4j is up to with -Dlog4j.debug=true.  So, log4j is there, configured and all but commons-logging is trying to be smart and is redirecting all logged stuff, including the stuff actually logged with log4j directly, to the wrong place. To add to your misery, you might have partly succeeded with your attempts to get log4j working so now you have stuff from different log libraries showing up in the console. 

A decent workaround in that case is to define a file appender, which will be free from non log4j stuff. This more or less is the advice for production deployments: don't use a console logger because dependencies are prone to hijacking that for all sorts of purposes. 

Good advice, but less than satisfactory. To fix it properly, make sure you don't have commons-logging on the classpath. At all. This will break all the stuff that depends on it being there. Fix that by using slf4j instead. Slf4j comes in several maven modules. I used the following ones:

<ul>
	<li>jcl-over-slf4j is a drop-in, API compatible replacement for commons logging. It writes messages logged through commons-logging using slf4j, which is similar to commons-logging  but behaves much nicer (i.e. it actually works).</li>
	<li>slf4j-api is used by dependencies already depending on slf4j</li>
	<li>slf4j-log4j12 If this is on the classpath slf4j will attempt to use log4j for its output</li>
</ul>

That's it, here's what I had to do:

<ol>
	<li>Use mvn dependency:tree to find out which dependencies are transitively/directly depending on commons-logging.</li>
	<li>fix all of these dependencies with a 
<pre lang="xml">
<exclusions>
    <exclusion>
        <groupId>commons-logging</groupId>
        <artifactId>commons-logging</artifactId>
    </exclusion>
</exclusions>
</pre> 
</li>
	<li>You might have to iterate fixing the dependencies and rerunning mvn dependency:tree since only the first instance of commons-logging found will used transitively.
 	<li>Now add these dependencies (your parent pom would be a good place):
<pre lang="xml">
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>1.5.10</version>
</dependency>                
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>jcl-over-slf4j</artifactId>
</dependency>
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-log4j12</artifactId>
</dependency>
</pre>
</li>          
	<li>Maven plugins have their own dependencies, separately from your normal dependencies. Make that you add the three slf4j dependencies to surefire, jetty, and other relevant plugins. At least jetty seems to already depend on slf4j.</li>
	<li>Finally mskr sure that surefire and jetty plugins have system properties defining log4j.configuration=file:[log4j config location]. Most of the googled advice on this topic covers this (and not much else).</li>
</ol>

That should do the trick, assuming you have log4j on the classpath.