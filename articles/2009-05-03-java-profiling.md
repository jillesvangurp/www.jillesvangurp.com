---

title: Java Profiling
date: 2009-05-03T11:05:19+00:00
author: Jilles van Gurp


permalink: /2009/05/03/java-profiling/
dsq_thread_id:
  - "349343926"
categories:
  - Blog Posts
tags:
  - apple
  - eclipse
  - java
  - JDK
  - linux
  - maven
  - TPTP
  - ubuntu
  - XML
---
One of the fun aspects of being in a programmer job is the constant stream of little technical problems that require digging into. This can sometimes be frustrating but it's pretty cool if you suddenly get it and make the problem go away. Anyway, since starting in my new job in February, I've had lots of fun like this. Last week we had a bit of Java that was obviously out of line performance wise. My initial go at the problem was to focus on the part that had been annoying me to begin with: the way xml parsing was handled. There's many ways to do XML parsing in Java. We use [Jaxb](https://jaxb.dev.java.net/). Jaxb is nice if you don't have enough time to do the job properly with XPath but the trade off is that it can be slow and that there are a few gotchas like for example [creating marshallers and unmarshallers is way more expensive than actually using them](https://wsit.dev.java.net/servlets/ReadMsg?list=dev&msgNo=66). So when processing a shitload of XML files, you spent a lot of time creating and destroying marshallers. Especially if you break down the big xml files into little blobs that are parsed individually. Some simple pooling using [ThreadLocal](http://java.sun.com/javase/6/docs/api/java/lang/ThreadLocal.html) improved things quite a bit but it was still slow in a way that I could not explain with just xml parsing.  All helpful but it still felt unreasonably slow in one particular class.

So I spent two days setting up a profiler to measure what was going on. Two days? Shouldn't this be easy? Yes, except there's a few gotchas.

1. The [Eclipse TPTP](http://www.eclipse.org/tptp/) project has a nice profiler. Except it [doesn't work with macs](http://dev.eclipse.org/newslists/news.eclipse.tptp/msg07162.html), or worse, macs with jdk1.6. That's really an eclipse problem, [the UI is tied to 1.5 due to Apple stopping to support of Cocoa integration in 1.6](http://blog.kischuk.com/2008/05/08/running-eclipse-on-macbooks-with-java-6/).
1. So I fired up vmware, installed the latest [Ubuntu 9.04](http://arstechnica.com/open-source/news/2009/04/ubuntu-904-release-candidate-arrives.ars) (nice), spent several hours making that behave nicely ([file sharing is broken and needs a patch](http://laptopbisnis.blogspot.com/2009/04/ubuntu-904-beta-in-vmware-fusion.html)). Sadly no OpenGL eyecandy in vmware.
1. Then I installed Java, eclipse, TPTP, and some other stuff
1. Only to find out that TPTP and JDK 1.6 is [basically unusable](http://www.nabble.com/Utterly-fail-to-set-up-a-TPTP-URL-Test-td21357057.html). First, it comes with some native library compiled against a library that no longer is used. Solution: [install it](http://jordilin.wordpress.com/2009/01/01/eclipse-ganymede-tptp-and-ubuntu-810-intrepid-ibex/).
1. Then every turn you take there's some error about agent controllers. If you search for this you will find plenty of advice telling you to use the right controller but none whatsoever as to how you would go about doing so. Alternatively people tell you to just not use jdk 1.6 I know because I spent several hours before joining the gang of "TPTP just doesn't work, use netbeans for profiling".
1. So, still in ubuntu, I installed Netbeans 6.5, imported my eclipse projects (generated using maven eclipse:eclipse) and to my surprise this actually worked fine (no errors, tests seem to run).
1. Great so I right clicked a test. and chose "profile file". Success! After some fiddling with the UI (quite nerdy and full of usability issues) I managed to get exactly what I wanted
1. Great! So I exit vmware to install Netbeans properly on my mac. Figuring out [how to run with JDK 1.6](http://devblog.point2.com/2009/02/17/defaulting-to-jdk-16-in-netbeans-65-on-osx/) turned out to be easy.
1. Since I had used vmware file sharing, all the project files were still there so importing was easy.
1. I fired up the profiler and it had remembered the settings I last used in linux. Cool.
1. Then netbeans crashed. Poof! Window gone.
1. That took some more fiddling to fix. After checking the [release notes](http://www.netbeans.org/community/releases/65/relnotes.html#known_issues-core) it indeed mentioned two cases of profiling and crashes which you can fix with some commandline options.
1. After doing that, I managed to finally get down to analyzing what the hell was going on. It turned out that my little test was somehow triggering 4.5 million calls to String.replaceAll. WTF!
1. The nice thing with inheriting code that has been around for some time is that you tend to ignore those parts that look ugly and don't seem to be in need of your immediate attention. This was one of those parts.
1. Using replaceAll is a huge code smell. Using it in a tripple nested for loop is insane.
1. So some more pooling, this time of the regular expression objects. Pattern.compile is expensive.
1. I re-ran the profiler and ... problem gone. XML parsing now is the bottleneck as it should be in code like this.

But, shouldn't this just be easy? It took me two days of running from one problem to the next just to get a profiler running. I had to deal with crashing virtual machines, missing libraries, cryptic error messages about Agent Controllers, and several unrelated issues. I hope somebody in the TPTP project reads this: your stuff is unusable. If there's a magic combination of settings that makes this shit work as it should: I missed it, your documentation was useless, the most useful suggestion I found was to not use TPTP. No I don't want to fiddle with cryptic vm commandline parameters, manually compiling C shit, fiddle with well hidden settings pages, etc. All I wanted was right click, profile.

So am I now a Netbeans user? No way! I can't stand how tedious it is for coding. Run profiler in Netbeans, go ah, alt tab to eclipse and fix it. Works for me.

