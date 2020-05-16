---
id: 144
title: WSDL Hell and other WS stuff
date: 2006-05-03T17:57:45+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/05/03/wsdl-hell-and-other-ws-stuff/
permalink: /2006/05/03/wsdl-hell-and-other-ws-stuff/
dsq_thread_id:
  - "336376332"
tags:
  - java
  - nokia
  - RPC
  - SOAP
  - Software Engineering
  - WS
  - XML
---
I've been working with web services technology extensively for the past few years. First as a regular software engineer and currently as a software architecture researcher at Nokia.

Right now the market can roughly be divided in a number of overlapping factions:

- The enterprise service bus people (IBM et al.). These people consider SOAP to be one of the (many) ways to plug software into a so-called enterprise bus: middleware that does the communication and marshalling on behalf of the plugged in components. This notion is particularly popular among businesses with skeleton filled closets (legacy software). If this sounds an awful lot like CORBA, it is probably because these are the same people.
- JBI (Sun et al.). Sun likes enterprise buses too but sees them more as a way of integrating Java tighter into the enterprise. JBI (Java Business Integration) is a container for java based services running inside an enterprise bus with convenient ways to access, and be accessed through a whole bunch of protocols (SOAP, CORBA, ...). The subtle difference with the IBM vision is that JBI is more about exposing and integrating new Java based services than it is about exposing old legacy services to Java.
- The [WS-*](http://www.w3.org/TR/ws-arch/) (i.e. the whole mess of web service related standards being pushed by W3C, [Oasis ](http://www.oasis-open.org/specs/index.php)and others) people. These people base themselves on piles and piles of [WSDL ](http://www.w3.org/TR/wsdl)(web service description language) descriptions of all sorts of standardized service interfaces. The interfaces cover all sorts of functionality ranging from resource management to security. In theory this is nice, in practice prepare for agony trying to get any of that stuff working.
- The lets use [SOAP](http://www.w3.org/TR/soap/) as the latest fashion in RPC protocols masses. Confused by the acronyms, most people produce and consume web services using a thick layer of tools that keep them far away from the nasty details. Of course the tools are quite stupid so effectively they are engaging in a really ineffective form of remote procedure calls. They like to think they are still doing distributed objects, but really all they got was a downgrade from good old CORBA.
- The asynchronous XML guys. These guys realize that RPC over SOAP is a really bad idea. With responsetimes being measured in seconds, doing anything non trivial runs into some hard scalability issues. Not to mention that dealing with all the details ends up getting messy real quick. This is a vocal minority, most web services (including the high profile public ones) continue to be RPC based.
- The [REST ](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm)(Representative State Transfer) guys. These guys got sick of all of the above and decided to just send (preferably simple) xml documents using HTTP. To them, the medium is not the message. It works surprisingly well for most usecases in the industry. For me setting up a REST based service is generally less work than the equivalent SOAP service, despite the fact that tools are supposed to make my life easy when doing the latter.

In short, it's an ugly world out there. Few people get the whole picture. As a programmer, I am less than enthousiastic about all of the above. I remember fondly of being amazed with the ease with which two Java applications could talk to each other over [RMI ](http://www.javacoffeebreak.com/articles/javarmi/javarmi.html)about ten years ago, effortlessly throwing entire running programs ([aglets](http://www.trl.ibm.com/aglets/)) over the network. Things have gotten a lot more difficult since then and a lot less flexible. Somewhere it seems, people forgot that this should be easy.

Let me summarize my concerns:

- XML is a machine readable format for exchanging structured data that is poorly suited for human consumption. The common textual representation sadly encourages people to believe that they should edit it. Sadly few good xml editors exist. The ones that do exist are standalone, commercial products.
- Many of the current web service solutions in the market are XML centric. That means they rely on the exchange, automated manipulation and manual editing of vast amounts of XML data. Manual editing is where all of these approaches become nasty.
- To make things 'easier' for developers, tools generally come with their own set of tool specific xml documents in addition to tool specific extensions of the standard ones. The better tools offer alternatives to text editors for some of the documents. Don't count on those tools to actually work as expected for non trivial usecases.
- The tools are part of a vertical stack, usually from one vendor. For the vendor, the stack is a tool to keep the customers tied to its services. Vendor interoperability does not extend beyond the standardized xml formats. Forget about migrating a service or service client from tool A to tool B.
- Standardization attempts to address this problem have resulted in more complex tools. The WS-* collection of standards is a good example.
- Despite the many standards, such simple and crucial things as how to integrate a web service in a servlet container have not been standardized. Nor are there usable standards for accessing a web service from client applications. The only thing that has been standardized is the syntax and some semantics of communication between client and server. The process of actually making communication happen is not covered by those standards.

And now let me illustrate by an example. Suppose I want to expose this nice little method:

String helloWorld();

What hoops would you have to jump through to expose this as a web service and consume it from some client using off the shelf tools like [Axis](http://ws.apache.org/axis/)? Well, quite a few:

- First you would need to generate a wsdl description. The tool for that is conveniently called java2wsdl The resulting document compared to the single line interface illustrates my earlier point beautifully. Several decisions need to be made:
- Like what namespace should the package name be mapped to
- What server address is going to be the endpoint for the service (not kidding you, this is part of the WSDL)
- What is the name of the service.

  <li>The next step is to generate a server stub using wsdl2java. That is a bit of generated code that translates incoming messages back to Java.</li>
  <li>Then you need to edit the generated code to make it do useful things. Yes that's right, that means some complications if later on you decide that you would want to change the interface.</li>
  <li>Additionally two wsdd files are generated by wsdl2java. Wsdd files tell axis what to deploy and undeploy.</li>
  <li>At this point it is time to setup tomcat with the default axis web application that will host the service. Once you have that up and running you need to modify the axis web application to have your own jar files (including the compiled stub) in the classpath so that axis can access them. That's right, you need to modify the service container to be able to run a service. If your service requires access to jndi resources, you will need to edit the default axis web.xml as well!</li>
  <li>Now you can start tomcat and deploy the web service. Deploying in this case means using one of the default web services included with the axis web application to tell it that there is a new web service installed. The file used in this process is the earlier generated deploy.wsdd. Now that the service is running, it may be accessed. For that you need a clientstub.</li>
  <li>To create a clientstub, download the wsdl description from your new web service (technically you could in this case use the earlier generated one. This is not always the case however!).</li>
  <li>Using wsdl2java with a different set of parameters a few java classes may be generated. Compile them and use them to create a service call.</li>
</ul>
Now, that IMHO is a lot of work for Helloworld. Too much work in fact. All this stupid bookkeeping should be done automatically (I mean, Java has typechecking, generics and annotations for a good reason!). Be glad if it stays this simple. Unfortunately, it usually gets hairy if:

- You 'want' (usually this means required) to use any of the WS-* stuff. This is the nightmare scenario, you need to edit basically all of the generated artifacts, hope that you don't make any mistakes in the process and then it may work. A good example is securing the service using WS-Security. This will essentially triple your workload. You will be doing stuff like downloading various jar files to satisfy dependencies, fiddle with axis handlers, wsdd files and lots of other axis specific stuff.
- You want to use some WS-* stuff not supported by axis (i.e. most of the WS standards). You will need to edit the generated WSDL file to do this.
- You want to make the service asynchronous. This should be possible by modifying the wsdd files. I've never actually tried this. Nor have I ever encountered an asynchronous web service in the wild.
- You want to change the Java interface and have these changes reflected in the WSDL and the client and server stubs. You need to start from step 1. Tip save some of the generated code you had to edit. You may be able to copy paste some stuff.

Now all of the above would still be doable if there was good documentation to assist programmers. Unfortunately there isn't. Worse, any mistake you make will be punished with obscure exceptions either serverside or clientside. Obcure exceptions have two problems, they don't tell you what the problem is and they don't tell you where the problem is. Consequently, a small typo can cause you to spend hours trying to find out what is going on. I've been there multiple times. In several cases I found the solution just looking at the code where the exception came from (a big advantage of OSS software is that you can do that).
That' in short is the reason I don't like WSDL/SOAP based web services.  Modern IDEs + application servers automate some of the tasks but rarely all. At best they hide the problem.