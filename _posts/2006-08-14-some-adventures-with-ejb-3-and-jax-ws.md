---
id: 171
title: Some adventures with ejb 3 and jax ws
date: 2006-08-14T20:50:47+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/08/14/some-adventures-with-ejb-3-and-jax-ws/
permalink: /2006/08/14/some-adventures-with-ejb-3-and-jax-ws/
dsq_thread_id:
  - "338139687"
tags:
  - IMHO
  - java
  - JEE
  - WSDL
---
You may recall some of my recent frustrated posts regarding the poor state of web services in java. While I still stand 100% behind these comments, I've found a somewhat more convenient way of implementing web services using [JAX WS 2.0](https://jax-ws.dev.java.net/) now. I spent a few hours with jboss 4.0.4 AG to explore its implementation of some of the new [JEE 5](http://java.sun.com/javaee/technologies/javaee5.jsp) (formerly known as J2EE) stuff. Up to now I've never bothered with J2EE 1.x since I consider it an overarchitected, complicated technology aimed at addressing what are (or should be) simple issues such as persisting an object to a database.

The nice thing with the latest incarnation of the specification is that it supposedly removes much of the burden of telling the [application server](http://en.wikipedia.org/wiki/Application_server) to just do its thing. Using annotations you specify what it should do and then it actually goes about and does it without me editing hundreds of little xml files and googling an afternoon for the corresponding documentation; googling some more for stuff the documentation does not tell you and finally yet more googling to explain the obscure exceptions in the log. Well it turns out that some googling skills remain essential but it sort of works as advertised. Basically the process is to write some Pojos, add some annotations and hand the whole thing to the app server to have a magic layer of web services, persistence and transactional semantics generated automatically.
Lets be fair, jboss does not address all issues in J2EE 1.4 and the JEE 5 implementation is definately not complete. But overall it is a huge improvement over the way things used to be, provided you do it exactly as they want you to. The only other open source implementation of the latest specs is Sun's glassfish so there is not exactly that much choice. Luckily, [JBoss ](http://jboss.org)is pretty nice technology.
I had some issues which were related to various things not being deployed because of errors in (jboss specific) files, which actually cost me most of this morning. My original aim was to re-implement a hibernate+tomcat based web application I already had and which I am going to do some feature development on soon. This should be easy because jboss uses hibernate to implement ejb 3 persistence and tomcat to run web applications. Indeed I had some benefit since I could copy paste a bit of the more obscure things in the hibernate configuration, thus bypassing several hours of agonizing googling for issues with mysql (did that a few months ago).

The object relational mappings were of course reusable but the whole point of ejb3 is that these are now replaced with much less verbose annotations. Adding the annotations was pretty straight forward. Next step was convincing jboss to do something with them. This is as easy as embedding a persistence.xml file in the jar file with the classes. The main purpose of this file seems to be to tell the appcontainer to hook up a database resource to the entitybeans inside the jar. Additionally some database specific configuration is embedded as well. IMHO mixing configuration with deployment artifacts is not a good idea but I guess we're stuck with this for a while since it is part of the standard now.
The next step was less easy: dependency injection. It turns out that jboss, or rather tomcat, is not quite ready for the new servlet specification that comes with JEE 5. In other words, any annotations in a servlet are ignored. If you want to use your persistent objects you need to create a so called entitymanager manually. Some googling delivered various code fragments of which one seemed to do the trick. The omnipresent fragments depending on an annotation only work inside an ejb.
Next on the agenda was creating a stateless session bean to encapsulate the business logic. Again some simple annotations do the trick and supposedly dependency injection does work here so getting the entitymanager injected actually works (with the added advantage that the app container is a lot smarter about figuring out transactional semantics). The only problem: it wasn't getting deployed :-(. Entity beans in a war (web application archive) file are no problem but session beans are.

So I figured I should create a nice ear file (enterprise application archive). This step btw is missing in action from the [nice JBoss tutorial](http://docs.jboss.org/ejb3/app-server/tutorial/) I had been glancing through. OK it's just a zip file with some stuff in it and a pretty straightforward. Essential is the application.xml which you shouldn't need but which JBoss needs anyway and crucial is the little jboss-app.xml which only needs to contain a few lines to trick it into deploying the session beans with the ejb3 deployer. Similarly the war file with my servlet needs a jboss-web.xml. Anyway, the whole point of an ear is tricking jboss into deploying jar files with the right deployer. None of the info in application.xml and jboss-app.xml actually tell jboss something it couldn't figure out itself.
The above took quite a few hours of trial and error. I wrote all java code in under 5 minutes however. The rest of this time was spent googling for the right bits and pieces. Any mistake leads to obscure errors such as a null pointer error when using the entity manager which should have been injected but wasn't. Anyway it now works and I managed to JAX WS 2.0 enable my code with a mere two annotations. Two simple annotations to expose a session bean as a webservice is way more cool than generating wsdl + crappy stub code using axis and hooking up your code to it. I'm definately going to use this some more.
The good:

- It actually all works as advertised.
- Writing the java code is considerably easier when you don't have to worry about boilerplate stuff for setting up database connections, transactions, etc.
- I will be able to do all of the above in ten minutes in future projects.
- JAX WS is getting quite close to how I want to work with web services: i.e. keep the stinking WSDL out of my sight.

The bad

- Plenty of container specific gotchas left but much less than there used to be.
- Still some pointless configuration files that I want to get rid off. Application.xml; jboss-*.xml; persistence.xml; web.xml all could be simplified or removed entirely. IMHO the jboss-* files are there because the specs omit important features related to deployment. If the spec were improved there would be no need for these files.
- There's likely to be a few issues I just have not ran into yet.
- Documentation is sketchy, misleading and incomplete. The tutorial not explaining how to hook an ejb up to a servlet (kind of essential) without annotation support has cost me quite a bit of time. Since I first had to figure out why the ejb wasn't being deployed and then how to fix that.

Overall, I'm positive and will continue to use this stuff.