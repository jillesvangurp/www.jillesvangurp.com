---
id: 1398
title: My github projects
date: 2012-11-06T12:38:36+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2012/11/06/1396-revision-2/
permalink: /2012/11/06/1396-revision-2/
---
Since announcing that I will be leaving Nokia, I've been quite busy. I will be announcing more details on what I'll be doing in a few weeks. Meanwhile, you may have noticed some increased activity on my git hub account.

I've been updating and adding a few new projects that seen in isolation may or may not be that interesting. Basically I use these projects as libraries in some on the side projects for crunching large amounts of data, on my laptop. The phrases "large amounts" and "laptop" might make you go hmm use Hadoop and some super large cluster and bla bla. Well, I don't have a access to a super large cluster and it is actually overkill for what I do. Nothing against Hadoop but for some things it's just a huge distraction.

My laptop is a nice 15" quad core mac book pro with 8GB and an SSD. That's plenty of horse power to crunch through a few GB of data. Now, for various reasons, I like doing this in Java. I like the stability, performance, type safety, and IDE support. 

Doing such things in Java used to be tedious. You had to do a lot of boiler plate code, deal with poorly designed standard APIs and third party libraries, etc. None of that is actually inherent to the language. If you apply a few idioms and design patterns, if you make use of some recent language features, a lot of those problems melt away. 

If you are a proper hipster, you'd probably insist on something like Scala or Ruby for this kind of thing. I never really liked Scala since it looks like a reincarnation of C++ (everything and the kitchen sink bolted on) that needs to be replaced by something designed by grown ups, hopefully soonish. Meanwhile, ruby is nice for prototyping stuff but I'd like to get some performance as well as expressiveness. Most stuff in the ruby libraries is just horribly underpowered compared to what I'm used to. I do like some of the idioms and language features that are currently lacking in Java. Mainly the lack of proper closures is getting a bit painful and the Java type system could be improved.

I've done quite a bit of this stuff in python, which is a language of choice for this kind of stuff. In my experience, it's actually not a whole lot better than just doing things in Java, provided you do it properly. The key thing is being able to do stuff in just a few lines of code. 

In a nutshell, that is what my github projects are about. I've been creating a lot of mini frameworks to help me do just that. Basically, most of my data comes with a latitude and longitude. I kind of like json as it is easy to parse and light on memory and disk space. A lot of the processing I do involves iterating and processing things concurrently and then writing it back somewhere. For some things, it is nice to build some in memory data structures. There's always a bit of error handling failure scenarios to worry about. Basically, my  



