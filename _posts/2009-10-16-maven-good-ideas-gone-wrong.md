---
id: 643
title: 'maven: good ideas gone wrong'
date: 2009-10-16T22:22:47+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=643
permalink: /2009/10/16/maven-good-ideas-gone-wrong/
dsq_thread_id:
  - "336378004"
categories:
  - Blog Posts
tags:
  - eclipse
  - Git
  - google
  - IDE
  - java
  - maven
  - osgi
  - XML
---
I've had plenty of time to reflect on the state of server side Java, technology, and life in general this week. The reason for all this extra 'quality' time was because I was stuck in an endless loop waiting for maven to do its thing, me observing it failed in subtly different ways, tweaking some more, and hitting arrow up+enter (repeat last command) and fiddling my thumbs for two more minutes. This is about as tedious as it sounds. Never mind the actual problem, I fixed it eventually. But the key thing to remember here is that I lost a week of my life on stupid book keeping.

On to my observations:
<ul>
	<li>I have more xml in my maven pom files than I ever had with my ant build.xml files four years ago, including running unit tests, static code checkers, packaging jars & installers, etc. While maven does a lot of things when I don't need them to happen, it seems to have an uncanny ability to not do what I want when I need it to or to first do things that are arguably redundant and time consuming.</li>
	<li>Maven documentation is fragmented over wikis, javadoc of diverse plugins, forum posts, etc. Google can barely make sense of it. Neither can I. Seriously, I don't care about your particular ideology regarding elegance: just tell me how the fuck I set parameter foo on plugin bar and what its god damn default is and what other parameters I might be interested in exist.</li>
	<li>For something that is supposed to save me time, I sure as hell am wasting a shit load of time on making it do what I want and watching it do what it does (or not), and fixing the way it works. I had no idea compiling & packaging less than 30 .java files could be so slow.</li>
	<li>Few people around me dare to touch pom files. It's like magic and I hate magicians myself. When it doesn't work they look at me to fix it. I've been there before and it was called ant. Maven just moved the problem and didn't solve a single problem I had five years ago while doing the exact same shit with ant. Nor did it make it any easier.</li>
	<li>Maven compiling, testing, packaging and deploying defeats the purpose of having incremental compilation and dynamic class (re)loading. It's just insane how all this application server deployment shit throws you back right to the nineteen seventies. Edit, compile, test, integration-test, package, deploy, restart server, debug. Technically it is possible to do just edit, debug. Maven is part of the problem here, not of the solution. It actually insists on this order of things (euphemistically referred to as a life cycle) and makes you jump through hoops to get your work done in something resembling real time.</li>
	<li>9 out of 10 times when maven enters the unit + integration-test phase, I did not actually modify any code. Technically, that's just a waste of time (which my employer gets to pay for). Maven is not capable of remembering the history of what you did and what has changed since the last time you ran it so like any bureaucrat it basically does maximum damage to compensate for its ignorance.</li>
	<li>Life used to be simple with a source dir, an editor, a directory of jars and an incremental compiler. Back in 1997, java recompiles took me under 2 seconds on a 486, windows NT 3.51 machine with 'only' 32 MB, ultra edit, an IBM incremental java compiler, and a handful of 5 line batch files. Things have gotten slower, more tedious, and definitely not faster since then. It's not like I have much more lines of  code around these days. Sure, I have plenty of dependencies. But those are run-time resolved, just like in 1997, and are a non issue at compile time. However, I can't just run my code but I have to first download the world, wrap things up in a jar or war, copy it to some other location, launch some application server, etc. before I am in a position to even see if I need to switch back to my editor to fix some minor detail.</li>
	<li>Your deployment environment requires you to understand the ins and outs of how where stuff needs to be deployed, what directory structures need to be there, etc. Basically if you don't understand this, writing pom files is going to be hard. If you do understand all this, pom files won't save you much time and will be tedious instead. You'd be able to write your own bash scripts, .bat files or ant files to achieve the same goals. Really, there's only so many ways you can zip a directory into a .jar or .war file and copy them over from A to B.</li>
	<li>Maven is brittle as hell. Few people on your project will understand how to modify a pom file. So they do what they always do, which is copy paste bits and pieces that are known to more or less do what is needed elsewhere. The result is maven hell. You'll be stuck with no longer needed dependencies, plugins that nobody has a clue about, redundant profiles for phases that are never executed, half broken profiles for stuff that is actually needed, random test failures. It's ugly. It took me a week to sort out the stinking mess in the project I joined a month ago. I still don't like how it works. Pom.xml is the new build.xml, nobody gives a shit about what is inside these files and people will happily copy paste fragments until things work well enough for them to move on with their lives. Change one tiny fragment and all hell will break loose because it kicks the shit out of all those wrong assumptions embedded in the pom file.</li>
</ul>

Enough whining, now on to the solutions.
<ul>
	<li>Dependency management is a good idea. However, your build file is the wrong place to express those. OSGI gets this somewhat right, except it still externalizes dependency configuration from the language. Obviously, the solution is to integrate the component model into the language: using something must somehow imply depending on something. Possibly, the specific version of what you depend on is something that you might centrally configure but beyond that: automate the shit out of it, please. Any given component or class should be self describing. Build tools should be able to figure out the dependencies without us writing them down. How hard can it be? That means some none existing language to supersede the existing ones needs to come in existence. No language I know of gets this right.</li>
	<li>Compilation and packaging are outdated ideas. Basically, the application server is the run-time of your code. Why doesn't it just take your source code, derive its dependencies and runs it? Every step in between editing and running your code is a potential to introduce mistakes & bugs. Shortening the distance between editor and run-time is good. Compilation is just an optimization. Sure, it's probably a good idea for the server to cache the results somewhere. But don't bother us with having to spoon feed it stupid binaries in some weird zip file format. One of the reasons scripting languages are so popular is because it reduces the above mentioned cycle to edit, F5, debug. There's no technical reason whatsoever why this would not be possible with statically compiled languages like java. Ideally, I would just tell the application server the url of the source repository, give it the necessary credentials and I would just be alt tabbing between my browser and my editor. Everything in between that is stupid work that needs to be automated away.</li>
	<li>The file system hasn't evolved since the nineteen seventies. At the intellectual level, you modify a class or lambda function or whatever and that changes some behavior in your program, which you then verify. That's the conceptual level. In practice you have to worry about how code gets translated into binary (or asciii) blobs on the file system, how to transfer those blobs to some repository (svn, git, whatever), then how  to transfer them from wherever they are to wherever they need to be, and how they get picked up by your run-time environment. Eh, that's just stupid book keeping, can I please have some more modern content management here (version management, rollback, auditing, etc.)?  Visual age actually got this (partially) right before it mutated into eclipse: software projects are just databases. There's no need for software to exist as text files other than nineteen seventies based tool chains.</li>
	<li>Automated unit, integration and system testing are good ideas. However, squeezing them in between your run-time and your editor is just counter productive. Deploy first, test afterwards, automate & optimize everything in between to take the absolute minimum of time. Inserting automated tests between editing and manual testing is a particularly bad idea. Essentially, it just adds time to your edit debug cycle.</li>
	<li>XML files are just a fucking tree structures serialized in a particularly tedious way. Pom files are basically arbitrary, schema less xml tree-structures. It's fine for machine readable data but editing it manually is just a bad idea. The less xml in my projects, the happier I get. The less I need to worry about transforming tree structures into object trees, the happier I get. In short, lets get rid of this shit. Basically the contents of my pom files is everything my programming language could not express. So we need more expressive programming languages, not entirely new ones to complement the existing ones. XML dialects are just programming languages without all of the conveniences of a proper IDE (debuggers, code completion, validation, testing, etc.).</li>
</ul>

Ultimately, maven is just a stop gap. And not even particularly good at what it does.

**update 27 October 2009**

Somebody produced a [great study on how much time is spent on incremental builds](http://www.zeroturnaround.com/blog/the-build-tool-report-turnaround-times-using-ant-maven-eclipse-intellij-and-netbeans/) with various build tools. This stuff backs my key argument up really well. The most startling out come:

> Java developers spend 1.5 to 6.5 work weeks a year (with an average of 3.8 work weeks,  or 152 hours, annually) waiting for builds, unless they are using Eclipse with compile-on-save.

I suspect that where I work, we're close to 6.5 weeks. Oh yeah, they single out maven as the slowest option here:

> It is clear from this chart that Ant and Maven take significantly more time than IDE builds. Both take about 8 minutes an hour, which corresponds to 13% of total development time. There seems to be little difference between the two, perhaps because the projects where you have to use Ant or Maven for incremental builds are large and complex.

So anyone who still doesn't get what I'm talking about here, build tools like maven are serious time wasters. There exist tools out there that reduce this time to close to 0. I repeat, Pyhton Django = edit, F5, edit F5. No build/restart time whatsoever.