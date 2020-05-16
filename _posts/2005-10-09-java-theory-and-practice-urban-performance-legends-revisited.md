---
id: 65
title: 'Java theory and practice: Urban performance legends, revisited'
date: 2005-10-09T19:28:46+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/?p=65
permalink: /2005/10/09/java-theory-and-practice-urban-performance-legends-revisited/
dsq_thread_id:
  - "387588391"
tags:
  - GUI
  - IO
  - java
---
I don't comment very often on java performance myth busting articles anymore (I used to do this a lot at slashdot and the javalobby). However, this: [Java theory and practice: Urban performance legends, revisited](http://www-128.ibm.com/developerworks/java/library/j-jtp09275.html?ca=dgr-lnxw07JavaUrbanLegends) is an exceptionally good and informative article that focuses on memory management. The article explains how both memoray allocation and deallocation and stack usage vs heap usage are smarter in Java  then with the default C/C++ mechanisms for memory allocation. 

Of course the issue is that whereas there are a lot of performance myths, it is also undeniably true that many Java desktop applications are perceived as slow. On the server the debate is  pretty much over. Not in the least because C/C++ is not very suitable for building secure network applications for reasons which have a lot to do with how memory is managed (or rather not managed) in C/C++. All the competing server languages are either interpreted or dynamically compiled.

There are a lot of myths about dynamic compilation too. A lot of people state that "because java is interpreted it will always be slower than a compiled language". Such statements are usually based on a poor understanding of compiler technology. 

In short, a compiler is a program that translates a program to running code. A dynamic compiler does this at the latest possible/convenient time (after starting the program, before executing the code).  A static compiler on the other hand does this before the program is started.

So why is the above statement wrong: a dynamic compiler has the same bag of tricks to make code run fast that a static compiler has. Wait that's not true either: it has a larger bag of tricks because it can observe the code while it is running and optimize for the runtime conditions. All this requires some overhead of course: a minor static effort to do simple compilation + whatever optimizations are worthwhile to do (this to can be determined dynamically). 

On modern computer systems, there is plenty of time for this. Proportional to the total cpu time used, the overhead for compilation and optimization is neglegible. Only in constrained environments such as low end mobile phones this is not (yet) true. High end phones on the other hand are already much faster than the PCs I used to do swing development on in 1998!

So memory management and dynamic compilations are the source of many performance myths and yet are also arguably making Java a faster environment than plain old C/C++. So where does the slowness come from. It has a lot to do with program design and library design. 

Java makes it easy to do things that used to be really difficult (IO, threading, databases). But you need to know what you are doing to make it perform well. 

Especially when trying to make a GUI application, a lot of these things tend to come together. If the application freezes a lot (a common complaint), that is not because java is garbage collecting but because the developer did not understand threading. If the application uses a lot of memory, the reason is probably that it is allocating a lot of it (duh). If that's a problem, good developers have a large bag of tricks at their disposal to detect and fix memory issues.