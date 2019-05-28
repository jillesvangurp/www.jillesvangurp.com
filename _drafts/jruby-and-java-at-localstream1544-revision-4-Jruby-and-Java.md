---
id: 1550
title: Jruby and Java
date: 2013-05-09T13:20:45+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/05/09/1544-revision-4/
permalink: /2013/05/09/1544-revision-4/
---
The server side code in the <a href="http://localstre.am">Localstream</a> platform is a mix of Jruby and Java code. Over the past few months, I've gained a lot of experience using the two together and making the most of idioms and patterns in both worlds. Ruby purist might wonder why you'd want to use Java at all. Likewise, Java purists might wonder why you'd waste your time doing Jruby at all instead of more hipster friendly languages such as Scala, Clojure, or Kotlin. In this article I want to steer clear of that particular topic and instead focus on more productive things.

The Java ecosystem provides a lot of good, very well supported technology. This includes the jvm itself but also libraries such as Google's guava, misc. Apache frameworks such as httpclient, commons-lang, commons-io, commons-compress, the Spring framework, icu4j, and many others. Equivalents exist for Ruby, but mostly those equivalents leave a lot to be desired in terms of features, performance, design, etc. It didn't take me long to conclude that a lot of the ruby stuff out there is sub-standard and not quite up to my level of expectations. That's why I use Jruby instead of Ruby: it allows me to get the best of both worlds. The value of ruby is in its simplicity and the language. The value of Java is access to a lot of good software. Jruby allows me to have both.

<strong>Server</strong>

The Localstream server platform consists of an API layer written using the <a href="http://www.sinatrarb.com/">Sinatra</a> framework for Ruby and several backend Java services that implement most of the business logic. This Sinatra application is deployed as a <a href="https://github.com/rack/rack">rack</a> application to a rack compliant wrapper around the Jetty servlet engine called <a href="https://github.com/dekellum/fishwife">Fishwife</a>. Rack is the defacto way of interacting with servers in the Ruby world and Jetty is a pretty cool serlvet engine that provides support for all the latest HTTP stuff such as the SPDY protocol and asynchronous requests. Also, it is very fast and scales very well. 

Fishwife runs Jetty in an embedded mode with a lightweight wrapper that hands off requests to any rack compliant ruby framework, such as Sinatra. So, a lightweight rack wrapper for Jetty is a pretty nice alternative to wrapping up the application as a war file and deploying it in a traditional application server such as Tomcat, JBoss, or Jetty (which supports this as well). It sidesteps the whole war file business, which frankly is a pretty bad idea that hopelessly complicates many Java deployments. 

The original idea for Java application servers was to be multi tenant servers that could host multiple applications that could be managed independently without shutting down the server. In practice, a more sane deployment strategy is to simply drop war files in place and restart servers. This sidesteps a whole bunch of issues related to class loading and reloading, associated memory leaks, and is actually something that system administrators understand. Also, having a shared single point of failure for an application (i.e. the app server) is not a great idea, which is why many Java deployments have a single application server for each application. Isolation is a good thing. Given that, war files are just a really inconvenient way of packaging deploying stuff. Basically you zip a whole bunch of files and the first thing the application does is unzip the file again. Kind of a waste of time.

So with Fishwife, we have none of that madness and can indeed start it, edit a file, and hit F5 (refresh) in the browser. Much nicer during development.

This simple setup alone would be worth it for most Ruby shops. No more mongrels. No more wasted memory on duplicate ruby processes. Nice scalable servers. Minimally disruptive to whatever you were doing before with your rack application and it scales a lot better.

<strong>Java Dependencies</strong>

To integrate Java libraries in jruby, you can simply import jar files in your ruby code, and then import some java classes and pretend it is all ruby. The key trick here is getting the jar files in the right place.

We struggled for a while to do this properly and I got sidetracked by a project called <a href="https://github.com/mkristian/jbundler">jbundler</a>, which aims to behave just like ruby's bundler does. It utilizes maven to ensure dependencies get installed and then does some jruby specific magic to ensure all the jar files you need are imported. This works well but has one big problem: you shouldn't have to have maven on a production server. Likewise, you shouldn't run bundler on a server either. Instead, you should 'vendorize' your applications and make sure you gather all your dependencies as part of your build process. Bundle supports this for normal Ruby dependencies but jbundle doesn't seem to have this feature. So, I got rid of jbundle altogether and did something a lot more simple: 1) have maven download dependencies into a lib folder as part of our Java build. 2) write a little ruby script that simply requires all jars in that folder. 3) as part of our deployment, simply gather all binaries (vendorized gems and jars from the build directory) and make sure the fishwife startup script can find them. So, this gives me the best of both worlds: I manage dependencies with maven on the Java side, with bundle on the ruby side, and I deploy a simple tar.gz file with all my binaries. 

During development, the jars are in a predictable place (the maven target directory) and my Ruby script knows where to look for them. So all I need to do after changing some Java code is use maven to create a new and then simply restart fishwife.

<strong>Dependency injection</strong>

Dependency injection is something that Java developers over use and that ruby developers underuse in favor of things like monkey patching. Monkey patching is one of those hammers that gets overused in Ruby. While sometimes useful, this results in a lot of needlessly complicated and unreadable code and poorly structured applications it seems like a free pass for omitting good design because you can always hack your way around the worst design mistakes. Dependency injection can be a more straightforward alternative. On the Java side, people tend to overdo it with dependency injection. Not every use of <code>new</code> requires an injected dependency. But sometimes it is a useful pattern.

Anyway, coming from a Java background, I need dependency injection on the Java side and having a need to access that code from Jruby, I need it there as well. Luckily, dependency injection is extremely easy in ruby. You don't need any framework for this. In fact, it is so easy, you really have no excuse for not using it. All it takes is a singleton context object that has members for each dependency. You could use a hash but that is not the ruby way. Instead, I have a register method that creates a new function that returns the registered instance. This follows the <a href="http://misko.hevery.com/2010/05/26/do-it-yourself-dependency-injection/">DIY dependency injection design pattern</a>. All you are doing is separating your glue code from your business logic, which is a good thing regardless of the language: mixing the two is always a bad idea. 

When the context initializes, it also accesses the Spring context on the Java side, lists the beans registered there, and registers them in this context class. From then on, I can access any registered object (ruby or spring bean) at will simply by typing <code>AppContext.instance.objectName</code>. Additionally, I can register any new ruby object using <code>AppContext.instance.register(objectName, instance)</code>

We use this in Sinatra controllers to give them access to the various Java services, which do most of the heavy-lifting. We don't have Sinatra views because our application is a client side MVC application rather than a server side MVC application. So Json comes in, gets handed off to java, comes back to the controller, which serializes it out with some headers. Things like authorization and authentication get handled on the Ruby side as well. All interaction with elastic search (<a href="http://www.jillesvangurp.com/2013/01/15/using-elastic-search-as-a-key-value-store/">our storage layer</a>) is encapsulated with Java services that are exposed as Spring beans.

That leaves the question of how to start Spring. Since we don't use a traditional application server, I have a Java class that creates a Spring context for me the old fashioned way: <code>new AnnotationConfigApplicationContext(SpringConfig.class); </code>. The context that comes back is stored in a static global variable, which is initialized only once. From there it is business as usual. SpringConfig is a Spring 3 configuration class that defines the beans (i.e. no XML involved). The rest of my code is free of any spring stuff, as it should be. 

<strong>Configuration</strong>

Configuration is one of those things that is pretty much done in an adhoc fashion in Ruby. Some people use Yaml, some people use ruby scripts, some people use json files, and some people use property files. In the Java world things are mostly governed using properties and Spring has a nice mechanism for integrating configuration. Java also has a notion of System properties that can be overridden on the command line with -D, which you can use in Spring as well. This is kind of nice for testing. So given the lack of any defacto configuration solutions in Ruby, we stuck with properties and I made sure they are loaded in a ruby friendly way (i.e. <code>AppContext.instance.config.propertyName</code> does what you would expect).

<strong>Logging</strong>

Ruby has a logging framework that looks like a naive version of what Java developers are used to. Basically it's a glorified printf with very little options and no good conventions for configuring it at deployment time. Indeed there is little advantage to using that over using a puts. Since Fishwife comes with all the plumbing to hook up ruby, rack and sinatra logging to SLF4J, using that was an easy choice. Basically it's another argument for using Fishwife and Jruby: you get pretty much free integration with a proper logging framework. We funnel SLF4j into Logback. But you can also use Log4j or Java's built in logging framework. 

<strong>Final remarks>/strong>
So there are some big advantages to using Jruby together with Java. We get to use a decent, well performing servlet container instead of some micky mouse solution involving poorly scalable, single threaded mongrels. On top of that it supports a few useful things such as https, spdy, and asynchronous requests. Nice and more or less for free.

Then we can integrate just about any Java technology easily through our DIY ruby dependency injection, which is backed by Spring on the Java side. 

