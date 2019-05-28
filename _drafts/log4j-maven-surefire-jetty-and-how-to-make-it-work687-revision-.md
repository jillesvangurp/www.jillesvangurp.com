---
id: 688
date: 2010-02-12T14:52:26+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/02/12/687-revision/
permalink: /2010/02/12/687-revision/
---
I spend again some time on making log4j behave. This time I believe I succeeded and since I know other teams are suffering as well here's how you do it:

1) use mvn dependency:tree to find out which dependencies are transitively/directly depending on commons-logging
2) fix all of these dependencies with a 
                <exclusions>
                    <exclusion>
                        <groupId>commons-logging</groupId>
                        <artifactId>commons-logging</artifactId>
                    </exclusion>
                </exclusions>
3) now add these dependencies (your parent pom would be a good place):
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
4) maven plugins have their own dependencies, separate from your normal dependencies. Make sure surefire and jetty define the 3 slf4j dependencies as well.
5) make sure that surefire and jetty plugins have system properties defining log4j.configuration=file:<log4j config location>

That should do the trick, assuming you have log4j on the classpath.

How it works: Commons-logging is evil and is depended upon by several of your dependencies. One of the evil things it does is bypass log4j configuration and generally behave weird when it comes to complex class loading situation, like in maven or a typical app server. To fix it, make sure you don't have it on the classpath. Then use slf4j instead:

jcl-over-slf4j is a drop in replacement for commons logging, but it behaves much nicer
slf4j-api is used by dependencies already depending on slf4j
slf4j-log4j12 tells slf4j to output to log4j

I sincerely hope this is the last time I have to deal with this logging crap.