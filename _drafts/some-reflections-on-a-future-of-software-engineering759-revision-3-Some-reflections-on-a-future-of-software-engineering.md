---
id: 764
title: Some reflections on a future of software engineering
date: 2010-09-09T09:02:47+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/09/09/759-revision-3/
permalink: /2010/09/09/759-revision-3/
---
I've over the past year been a bit less active blogging and posting in forums. I make an exception on things related to build processes, distributed version management and Java. You may find a couple of fine rants on my website and across various blogs on this topic.

This post is intended to pull all of it together in a bit more grand vision and reflect a bit on what a post revolution software engineering world might look like. I don't like or believe much in revolutions but I do recognize that getting from where we are to where I think we need to be amounts to one. The more likely outcome is an evolutionary development where the bits and pieces where I was not completely and utterly wrong might actually happen. At some point. Maybe.

Problem statement

Software engineering practice is stuck in abstractions and concepts dating back decades. Because it is stuck it is not really moving forward as fast as it could be towards being more capable of dealing with scale in numbers of people, amount of software, and amount of evolutionary change per time unit. 

The core abstraction I strongly believe is very wrong is the file. A file is a binary or text blob that lives on a file system that has some name. It has some content of some type that is generally associated with a  suffix in the name (e.g. *.java). Software engineers mistakenly believe their output consists of files. It doesn't. Their output consists of software that happens to be stored in files. If you were born in the fifties, you'd be serializing your software from your head onto paper and manually flip switches to de-serialize. This was tedious but it worked. People like Ada Lovelace were writing software long before there were machines capable of executing the software (other than the human brain, which is not very good at running our own software). The sixties made IO quite a bit easier with consoles, punch cards and tapes. People would transfer programs to and from RAM buffers by streaming them from tape or by feeding piles of cards to a computer. Somewhere in this era the notion of transforming these software data blobs using other software blobs also became popular: I'm talking about editors, compilers and interpreters.

Finally somewhere in the seventies floppies and hard disks started to be used and everybody started putting their data blobs in files. Sadly this is where evolution stops. At least when it comes to storing computer programs. For other types of data we have gotten a lot smarter. We have graph databases, object databases, tuple stores, relational databases, document stores, etc. None of these are commonly used to store computer programs.

This is weird and in my view it is holding software engineering practice back. A big reason is that we have build a huge sand castle of technology around the notion of files as the primary means of storing computer programs. For example we have version control systems that store different versions of files. We have build tools that consume and produce files. We have source code analyzers that expect to be working on files. We have IDEs that offer us convenient ways to edit files. Once we stop putting software in files, that technology needs to start changing as well. 

From Smalltalk to Eclipse

Actually it is not strictly true that evolution stopped with the file. Smalltalk and its descendants have a very interesting approach where the entire software system is stored in one big image file. Effectively smalltalk is using a database concept. This allowed for some interesting innovations, like meta programming and software transformations (aka refactoring) that require some readily available in memory representation of the software that is generally very rich and graph like (i.e. an abstract syntax tree). Smalltalk developers realized that it didn't make much sense to fragment bits and pieces of the software over multiple files. You might as well just use a single file. 

This inspired IBM to create a nice IDE for Java at some point: Visual Age. Visual Age was very much a reborn small talk style IDE and crucially stored its Java code not in files but in the form of a database that effectively was a serialization of the abstract syntax tree of the entire software system. It needed that tree in order to be able to power important features like refactoring, code browsers, etc. Later it became Eclipse and they dropped the notion of storing the serialized AST opting instead for a combination of on the fly construction of an in memory AST, on the fly compilation and analysis, and reading to and from files the good old fashioned way. 

Failed experiment: intentional programming?

Some late nineties papers by Charles Simonyi on Intentional Programming and persistent rumors about him actually being very close to launching related products was about taking the whole smalltalk/visual age thing to the next level. It's too early to call this a failed experiment because Simonyi never really delivered the goods. His company is still hyping intentional programming but has yet to ship a product. Seriously, this has been in the making longer than Duke Nukem Forever. In a nutshell Simonyi's very brilliant idea is that creating software is about coming up with abstractions that are represented in the form of abstract syntax trees that can be translated into other, more general abstractions in multiple iterations until you end up with a syntax tree that can simply be serialized to executable code. His core idea was to treat the transformations and not the abstractions as the first class entities. In a intentional programming world you start with really simple abstractions that you can translate into executable code and you build increasingly more complex and specialized abstractions that can be used for specialist or domain specific things. The traditional notion of compiling is very similar except it is a bit limited in the number of transformations and the abstractness of the abstractions involved. Basically most languages go to roughly 2 or 3 transformations: source code to abstract syntax tree to assembly to executable bits and bytes. There are lots of variations here but it is essentially a pipe line. Intentional software's product works differently. The user manipulates the AST of whatever abstractions he's working with in some rich editing environment that presents appropriate views on the AST and tools to edit the AST. Applicable transformations kick in on the fly to keep the executable code up to date. It probably does a bit of serialization here and there but probably not in a format that is very notepad friendly.

Another failed experiment: MDA

Readers of the previous may be tempted to sweep this in the same bucket as Model Driven Architecture (MDA). MDA was something that emerged out of the lovely world of UML. In MDA one defines systems using a standardized meta language, generally inside a dedicated tool (e.g. Rational Rose). The idea is on the surface very similar to intentional programming except it is more artifact centric. The weak spot of MDA has always been that the transformations from models to software is kind of a hacky process that is generally locked up in some proprietary tool. Basically there is the meta language and the UML language (of course defined in the meta language) and UML models. Where the whole thing becomes messy is the transformation to actual software. This bit is more or less completely proprietary and your mileage may vary though apparently some tools are quite good at this. Early MDA environments were monstrous tools with loads of J2EE, application server madness and a rich sauce of UML and XML spread on top. It's sort of a lot of not so great things stuck together and people have wasted enormous amounts of cash on making sense of the whole thing, which continues to feed hordes of very expensive consultants. MDA never really dragged itself outside the domain of finance and banking applications.

What's missing

real-time sharing, collaborative editing, and integrated versioning


There is no need for explicit, manual, pull and push operations in a connected world. Sharing and collaborating should be real time. If you want to work in isolation: branch and when you are done rebase and merge back to a shared branch. 

So what's next?

I believe that Simonyi was on the right track. However, it is not just about the transformations and the ASTs and it is all about how we developers interact with these things. The whole file fethish comes from the need to exchange software in the form of data blobs. However, in a world where data is moving into the cloud that is no longer evident. 
