---
id: 1546
title: Jruby and Java
date: 2013-05-03T12:11:03+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/05/03/1544-revision-2/
permalink: /2013/05/03/1544-revision-2/
---
Our server side code in the Localstream platform is a mix of Jruby and Java code. Over the past few months, I've gained a lot of experience using the two together and making the most of idioms and patterns in both worlds. Ruby purist might wonder why you'd want to use Java at all. Likewise, Java purists might wonder why you'd waste your time doing Jruby at all instead of more hipster friendly languages such as Scala. In this article I want to steer clear of that particular topic and instead focus on more productive things.

The Java ecosystem provides a lot of very well supported technology. This includes the jvm itself but also libraries such as httpclient, Google's guava, misc. Apache frameworks such as commons-lang, commons-io, commons-compress, the Spring framework, icu4j, and many others. Equivalents exist for Ruby, but mostly those equivalents leave a lot to be desired in terms of features, performance, design, etc. It didn't take me long to conclude that a lot of the ruby stuff out there is sub-standard and not quite up to my level of expectations. That's why I use Jruby instead of Ruby: it allows me to get the best of both worlds. The value of ruby is in its simplicity and the language. The value of Java is access to a lot of good software. Jruby allows me to have both. While there are a lot of ruby gems out there, most of them lack the rich and maturity that many Java libraries have after one and a half decade of evolution. 

<strong>Server</strong>

The Localstream server platform consists of an API layer written using the <a href="http://www.sinatrarb.com/">Sinatra</a> framework and several backend Java services. The whole thing is deployed as a rack application to a rack compliant wrapper around the Jetty servlet engine called <a href="https://github.com/dekellum/fishwife">fishwife</a>. Jetty is a pretty cool project that provides support for all the latest HTTP stuff such as the SPDY protocol and asynchronous requests. Also, it is very fast and scales very well. Fishwife runs it in an embedded mode with a lightweight wrapper that hands off requests to any rack compliant ruby framework, such as Sinatra. This simple setup alone would be worth it for most Ruby shops. No more mongrels. No more wasted memory on duplicate ruby processes. Nice scalable servers.

<strong>Dependencies</strong>

To integrate Java, you can simply add jar files on the Jruby classpath and then require them. We struggled for a while to do this properly. I got sidetracked by a project called <a href="https://github.com/mkristian/jbundler">jbundler</a>, which aims to behave just like bundle does. It utilizes maven to ensure dependencies get installed and then does some jruby specific magic to ensure all the jar files you need are imported. This works well but has one big problem: you shouldn't have to have maven on a production server. Likewise, you shouldn't run bundle on a server either. Instead, you should vendorize your applications and make sure you gather all your dependencies as part of your build process. Bundle supports this, jbundle doesn't. So I did something a lot more simple: 1) have maven download dependencies into a lib folder as part of our Java build. 2) write a little ruby script that simply includes all jars in that folder. 3) as part of our deployment, simply gather all binaries (bundles and jars) and make sure the fishwife startup script can find them. So, this gives me the best of both worlds: I manage dependencies with maven on the Java side and bundle on the ruby side.

<strong>Dependency injection</strong>

Dependency injections is something that Java developers over use and that ruby developers underuse in favor of things like monkey patching. Monkey patching is one of those hammers that gets overused in Ruby. While sometimes useful, this results in a lot of needlessly complicated and unreadable code and poorly structured applications. 

Anyway, coming from a Java background, I need dependency injection on the Java side and having a need to access that code from Jruby, I need it there as well. Luckily, dependency injection is extremely easy in ruby. You don't need any framework for this. In fact, it is so easy, you really have no excuse for not using it. All it takes is a singleton context that has members for each dependency. You could use a hash but that is not the ruby way. Instead, I have a register method that creates a new function that returns the registered instance. This follows the <a href="http://misko.hevery.com/2010/05/26/do-it-yourself-dependency-injection/">DIY dependency injection design pattern</a>. All you are doing is separating your glue code from your business logic, which is a good thing regardless of the language. When the context initializes, it accesses the Spring context, lists the beans registered there, and registers them in this context class. From then on, I can access any spring bean at will simply by typing AppContext.instance.beanName. Additionally, I can register any new ruby bean using AppContext.instance.register(:beanName, instance)

We use this in Sinatra controllers to give them access to my Java services. We don't have Sinatra views because our application is a client side MVC application rather than a server side MVC application. So Json comes in, gets handed off to java, comes back to the controller, which serializes it out with some headers. Things like authorization and authentication get handled on the Ruby side. All interaction with elastic search (<a href="http://www.jillesvangurp.com/2013/01/15/using-elastic-search-as-a-key-value-store/">our storage layer</a>) is encapsulated with Java services that are exposed as Spring beans.

That leaves the question of how to start Spring. Since we don't use a traditional application service, I have a Java class that creates a Spring context for me the old fashioned way: <code>new AnnotationConfigApplicationContext(SpringConfig.class); </code>. The context that comes back is stored in a static global variable, which is initialized only once. From there it is business as usual. SpringConfig is a Spring 3 configuration class that defines the beans. The rest of my Java code is free of any spring stuff, as it should be. We don't use any of the fancy Spring frameworks for accessing databases but that would be trivial to integrate as well.



