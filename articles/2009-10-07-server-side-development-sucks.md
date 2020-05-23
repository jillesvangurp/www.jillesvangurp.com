---
title: Server side development sucks
date: 2009-10-07T21:01:00+00:00
author: Jilles van Gurp


permalink: /2009/10/07/server-side-development-sucks/
dsq_thread_id:
  - "336377928"
categories:
  - Blog Posts
tags:
  - eclipse
  - java
  - maven
  - python
  - REST
  - spring
---
Warning: long rant :-)

The past half year+ I've been 'enjoying' myself with lots of technical things related to working with Java, the spring framework, maven, unit testing and lots of command line stuff. And while I like my job, I have to say: it can be enormously tedious from time to time.

If you are coding Java in Eclipse, life is good. Eclipse is enormously helpful and gives you more or less real time feedback on how you are doing with respect to warnings, compilation errors, etc. This is great because it saves you from manual edit compile debug fix cycles, which take time and are frustrating. Frustrating however is what I'd call the current state of server side Java, which takes place mostly outside Eclipse. I spend a shit load of time on a day to day basis waiting for my application server to catch up with what I did in Eclipse, only to find that some minor typo is blocking my progress. So shut down server, edit, compile, package, deploy, wait a minute or so, get the server in the same state you had before and see if it works. Repeat, endlessly. That's more or less my day.

There's lots of tools to make this easier. Maven is nice, but it is also a huge time waster with its insistence on checking for updates of everything you have every time you try to use it (20 dependencies is 20 GET requests to your maven repository) and on top of that running the test suite as well. Useful, except if you've done this 20 times in the last hour already and you are pretty damn sure you are not interested in whether it will pass this time since you just want to know if that one typo you fixed was actually good enough. Then there are ways of hooking up application servers to eclipse and making them be somewhat more reasonable about requiring full shutdown, deploy and restart. Still it is tedious. And it doesn't help that maven is completely oblivious about this feature, leaving you to set up things manually. Or not, since that's not exactly trivial.

The maven way is "our way or the highway". Eclipse and application servers are part of the highway and while there is the maven eclipse plugin and the eclipse maven plugin (yes, you read that right), the point of both is that there is a (huge) gap to bridge. They each have their own idea of where source code and binaries go and where dependencies come from, or indeed where stuff gets deployed to be debugged. Likewise, maven's idea of application server integration is wrapping the start up process with some plugin. It does nothing to speed up the actual process of getting the application server up and running. It just saves you from having to start it manually. Eclipse plugins exist to do the same. And of course getting the maven and eclipse plugins to play nice with each other is kind of a challenge. Essentially, there are three worlds: maven, eclipse, and the application server and you'll lose shit loads of development time watching one catch up with the other.

I have in the back of my mind still last year's project which was based on python Django. Last year, my job was like this: edit, alt+tab to browser, F5, test, alt+tab back to eclipse, fix, etc. I had 1-3 second roundtrips between my browser and editor, apache was loading the python files straight from my svn work directory. We had a staging server that updated with a cron job that did nothing but "svn up". Since then I've had the pleasure of debating the merits of using dynamic languages in a server side environment in a place where everybody is partying on the Java bandwagon like it's 1999. Well here it is: you spend a shitload less time waiting for maven or application servers to finish whatever they think needs to be done. On top of that, quite a lot of server side Java is actually scripting. Don't fool yourself into believing otherwise. We use spring web flow, which means my application logic is part Java, part xhtml with jsf (and a half dozen xml name spaces for that), part xml definitions for webflow, part definitions for spring beans and part Javascript. Guess where you can find bugs: all of them. Guess which ones Eclipse actually provides real time feedback on: Java only. So basically all the disadvantages of using a scripting environment (run-time bug discovery) without most of the advantages (like fast edit-test round trips). 

So it is not surprising to me that scripting languages are winning over a lot of people lately. You write less code, in less languages, and on top you get more time to spend editing it because you are not waiting for tools and servers to catch up with your editor. This matters a lot and the performance and scalability benefits of Java are melting away rapidly lately.

On top of that, when I look at what we do, which is really straightforward web & REST stuff with a mysql db, and what a shitload of code, magic producing tools and frameworks, complexity, etc. we end up with something feels terribly wrong. We use hibernate for our database layer. Great stuff, until it doesn't do what you want and starts basically throwing pretty random RunTimeExceptions at you because you forgot to add a column in your database schema (thus reducing Java to a scripting language because all of this happens run-time). 

We have sort of a three way impedence mismatch going here straight out of the cookbook of Enterprise Architecture. Our services speak DTOs (data transfer objects), the database layer needs model classes and the database itself speaks SQL. So a typical REST call will go like this: xml/json comes in, gets translated to dtos, which are manipulated and get translated into model objects, which are manipulated, which results in sql being sent to the database, records coming back and translated into model objects, dto's and back to xml/json. Basically stuff can go wrong in any of these transitions and a lot of development is basically babysitting your application through all these transitions instead of writing actual application logic.

To make this work, we need mappings from dto's to model classes and from there to the database. So to add 1 field: I have to edit a model class, update the dto class, edit the mapping from models to dtos, the mapping from models to databases, the database schema itself. Then I have to write tests that verify all the mappings still work correctly and adapt any depending tests. 1 field, about a dozen of files touched. Re-fucking-diculous in my view. This is made 'easier' with Dozer that maps object hierarchies to each other, hibernate that takes care of the database and which uses annotations that make magic happen around the places where you use them, resteasy that does all of the incoming and outgoing xml/json magic, maven to download the world (the number of dependencies we have 30+). All to get one really straightforward REST service + 8 table mysql database going.

In short, I kind of miss the days where server side java development meant servlets+jdbc: read parameters from request, do some select/update query, write some stuff to the response. It might lack elegance but you get the same job done with a fraction of the number of components and without having to wait for Spring to figure out how to instantiate a bazillion little objects that go into your application context. I kind of miss the simplicity of edit, f5, edit. 

Anyway, end of rant.