---
id: 690
title: log4j, maven, surefire, jetty and how to make it work
date: 2010-02-13T09:30:13+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/02/13/687-revision-3/
permalink: /2010/02/13/687-revision-3/
---
I spend some time this week on making log4j behave. Not for the first time and I was getting thoroughly frustrated with how my logs refuse to conform to my log4j configuration, or rather any type of configuration. This time, I believe I succeeded and since I know plenty of others must be facing the exact same misery and since most of the information out there is downright misleading in the sense of presenting all types of snake oil solutions that actually don't change a thing, here's a post that offers a proper analysis of the problem and a way out.

In a nutshell, the problem is common-loggings. This trusty little library is depended on by just about any dependency in the maven repository that does logging. Some others depend on log4j and yet some others depend on slf4j. Basically, you are extremely likely to have a transitive dependency on all of these. One of the nasty things with commons-logging is that it behaves weirdly when it comes to complex class loading situation, like in maven or a typical app server. As a result, it takes over orchestration of the logs for basically the whole application and wrongly assumes that you want to use jdk logging. Symptoms: you configure in log4j.xml logger foo to shut the fuck up (STFU) below error level and when running your maven tests it barfs all over the place at INFO level, which is the unconfigured default. To top it off, it does this using an appender you sure as hell did not configure. Double check, yes log4j is on the classpath, it finds your configuration, it even creates the log file you defined an appender for but nothing shows up there. You can find this out with -Dlog4j.debug=true. To add to your misery, you might have partly succeeded with your attempts to get log4j working so now you have stuff from different log libraries showing up in the console. A decent workaround in that case is to define a file appender, which will be free from non log4j stuff.

However, that's less than satisfactory. To fix it properly, make sure you don't have commons-logging on the classpath. At all. This will break stuff that depends on it being there. Fix that by using slf4j instead. Slf4j comes in several maven modules. I used the following ones:

<ul>
	<li>jcl-over-slf4j is a drop-in, API compatible replacement for commons logging. It writes messages logged through commons-logging using slf4j, which is similar to commons-logging  but behaves much nicer (i.e. it actually works).</li>
	<li>slf4j-api is used by dependencies already depending on slf4j</li>
	<li>slf4j-log4j12 If this is on the classpath slf4j will attempt to use log4j</li>
</ul>


That's it, here's what I had to do:

<ol>
	<li>use mvn dependency:tree to find out which dependencies are transitively/directly depending on commons-logging</li>
	<li>fix all of these dependencies with a 
<code>
                <exclusions>
                    <exclusion>
                        <groupId>commons-logging</groupId>
                        <artifactId>commons-logging</artifactId>
                    </exclusion>
                </exclusions>
</code>
</li>

 	<li>now add these dependencies (your parent pom would be a good place):
<code>
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
</code>
</li>
          
	<li> maven plugins have their own dependencies, separate from your normal dependencies. Make sure surefire and jetty define the 3 slf4j dependencies as well.</li>

	<li>make sure that surefire and jetty plugins have system properties defining log4j.configuration=file:[log4j config location]</li>

</ol>


That should do the trick, assuming you have log4j on the classpath.

How it works: 