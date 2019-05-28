---
id: 595
title: Java Profiling
date: 2009-05-03T10:28:17+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2009/05/03/593-revision-2/
permalink: /2009/05/03/593-revision-2/
---
One of the fun aspects of being in a programmer job is the constant stream of little technical problems that require digging into. This can sometimes be frustrating but it's pretty cool if you suddenly get it and make the problem go away. Anyway, since starting in my new job in February, I've had lots of fun like this. Last week we had a Java class that was obviously out of line performance wise. My initial go at the problem was to focus on the part that had been annoying me to begin with: the way xml parsing was handled. There's many ways to do XML parsing in Java. We use Jaxb. Jaxb is nice if you don't have enough time to do the job properly with XPath but the tradeoff is that it can be slow and that there are a few gotchas like for example creating marshallers and unmarshallers is way more expensive than actually using them. So when processing a shitload of XML files, you spent a lot of time creating and destroying marshallers. Especially if you break down the big xml files into little blobs that are parsed individually. Some simple pooling using thread local improved things quite a bit but it was still slow in a way that I could not explain with just xml parsing.  All helpful but it still felt unreasonably slow in one particular class.

So I spent two days setting up a profiler to measure what was going on. Two days? Shouldn't this be easy? Yes, except there's a few gotchas.
<ol>
	<li>The eclipse TPTP project has a nice profiler. Except it doesn't work with macs, or worse, macs with jdk1.6. That's really an eclipse problem, the UI is tied to 1.5 due to Apple stopping to support native integration in 1.6. </li>
	<li>So I fired up vmware, installed the latest Ubuntu 9.04 (nice), spent several hours making that behave nicely (file sharing is broken and needs a patch). Sadly no OpenGL eyecandy in vmware.</li>
	<li>Then I installed Java, eclipse, tptp, and some other stuff</li>
	<li>Only to find out that TPTP and JDK 1.6 is basically unuasable.</li>
	<li>Every turn you take there's some error about agent controllers. If you search for this you will find plenty of advice telling you to use the right controller but none whatsoever as to how you would go about doing so. I know because I spent several hours before joining the gang of "TPTP just doesn't work, use netbeans for profiling".</li>
	<li>So, still in ubuntu, I installed Netbeans 6.5, imported my eclipse projects (generated using maven eclipse:eclipse) and to my surprise this actually worked fine (no errors, tests seem to run).</li>
	<li>Great so I right clicked a test. and chose "profile file". Success! After some fiddling with the UI (quite nerdy and full of usability issues) I managed to get exactly what I wanted</li>
	<li>Great! So I exit the vm to install netbeans properly on my mac. Figuring out how to run with JDK 1.6 turned out to be easy.</li>
	<li>Since I had used vmware file sharing, all the project files were still there so importing was easy.</li>
	<li>I fired up the profiler and it had remembered the settings I last used in linux. Cool.</li>
	<li>Then netbeans crashed. Poof! Window gone.</li>
	<li>That took some more fiddling to fix. After checking the release notes it indeed mentioned two cases of profiling and crashes which you can fix with some commandline options</li>
	<li>After doing that, I managed to finally get down to analyzing what the hell was going on. It turned out that my little test was somehow triggering 4.5 million calls to String.replaceAll. WTF!</li>
	<li>The nice thing with inheriting code that has been around for some time is that you tend to ignore those parts that look ugly and don't seem to be in need of your immediate attention. This was one of those parts.</li>
	<li>Using replaceAll is a huge code smell. Using it in a tripple nested for loop is insane.</li>
	<li>So some more pooling, this time of the regular expression objects. Pattern.compile is expensive.</li>
	<li>I reran the profiler and ... problem gone. XML parsing now is the bottleneck as it should be in code like this.</li>
</ol>



