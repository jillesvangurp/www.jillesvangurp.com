---
id: 1545
title: Jruby and Java
date: 2013-05-03T11:12:19+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/05/03/1544-revision/
permalink: /2013/05/03/1544-revision/
---
Our server side code in the Localstream platform is a mix of Jruby and Java code. Over the past few months, I've gained a lot of experience using the two together and making the most of idioms and patterns in both worlds. Ruby purist might wonder why you'd want to use Java at all and likewise, Java purists might wonder why you'd waste your time doing Jruby at all instead of more hipster friendly languages such as Scala. In this post I want to steer clear of that particular topic and instead focus on more productive things.

The Java ecosystem provides a lot of very well supported technology. This includes the jvm itself but also libraries such as httpclient, Google's guava, misc. Apache frameworks such as commons-lang, commons-io, commons-compress, the Spring framework, icu4j, and many others. Equivalents exist for Ruby, but mostly those equivalents leave a lot to be desired in terms of features, performance, design, etc. It didn't take me long to conclude that a lot of the ruby stuff out there is sub-standard and not quite up to my level of expectations. That's why I use Jruby instead of Ruby. 

Jruby allows me to get the best of both worlds. The value of ruby is in its simplicity. The value of Java is access to a lot of good software. Jruby allows me to have both.

The Localstream server platform consists of an API layer written using the <a href="http://www.sinatrarb.com/">Sinatra</a> framework and several backend Java services. The whole thing is deployed as a rack application to a rack compliant wrapper around the Jetty servlet engine called <a href="https://github.com/dekellum/fishwife">fishwife</a>. Jetty is a pretty cool project that provides support for all the latest HTTP stuff such as the SPDY protocol and asynchronous requests. Also, it is very fast and scales very well. Fishwife runs it in an embedded mode with a lightweight wrapper that hands off requests to any rack compliant ruby framework, such as Sinatra. This simple setup alone would be worth it for most Ruby shops. No more mongrels. No more wasted memory on duplicate ruby processes. Nice scalable servers.

To integrate Java, you can simply add jar files on the Jruby classpath and then require them. We struggled for a while to do this properly. I got sidetracked by a project called jbundle, which aims to behave just like bundle does. It utilizes maven to ensure dependencies get installed and then does some jruby specific magic to ensure all the jar files you need are imported. This works well but has one big problem: you shouldn't have to have maven on a production server. Likewise, you shouldn't run bundle on a server either. Instead, you should vendorize your applications and make sure you gather all your dependencies as part of your build process. Bundle supports this, jbundle doesn't. 

So, we got rid of jruby and did things manually. This was surprisin




