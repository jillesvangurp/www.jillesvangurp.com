---
id: 818
title: On Java, Json, and complexity
date: 2011-04-02T13:21:26+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=818
permalink: /2011/04/02/on-java-json-and-complexity/
aktt_notify_twitter:
  - 'yes'
aktt_tweeted:
  - "1"
dsq_thread_id:
  - "338469197"
categories:
  - Blog Posts
tags:
  - API
  - java
  - KISS
  - YAGNI
---
Time for a long overdue Saturday morning blog post.

Lately, I've been involved in some interesting new development at work that is all about key value stores, [Json](http://www.json.org/), [Solr](http://lucene.apache.org/solr/) and a few other technologies I might have mentioned a few times. In other words, I'm having loads of fun at work doing stuff I really like. We've effectively tossed out XML and SQL and are now all about Json blobs that live in KVs and are indexed in Solr. Nothing revolutionary, except it is if you have been exposed to the wonderfully bloated and complicated world of Java Enterprise Edition and associated technologies. I've found that there is a bunch of knee-jerk reflexes that causes Java developers to be biased to be doing all the wrong things here. This is symptomatic of the growing gap between the enterprise Java people on one side and the cool hip kids wielding cool new languages and tools on the other hand.

<!--more-->

**The problem with Json in Java**

One of the things I've been struggling with recently is Json. Json and the java world is not a perfect marriage. The whole point of Json is that it is valid Javascript, Python, and Ruby. That doesn't mean that you should go off and execute it but it does mean that after parsing (or rather unmarshalling), you end up with dictionaries, lists, and native types that each of those languages supports. This means you can have light weight data structures that you can just serialize to and from Json at will. In Python, classes are just dictionaries of attributes and dictionaries and lists are native types. That means that Json is a very natural serialization of any Python object structure. Javascript doesn't have classes since it is a prototype based language, but of course lists and dictionaries are native types there as well and objects are of course dictionaries. I'm not a ruby-ist but I know enough of it that it is similar to Python and Javascript in this respect as well.

Sadly, this not the case in the Java world. Dictionaries and Lists are not native types and instead people use the Collections framework (or alternatives such as Google collections). The classes in those frameworks are of course generic these days and classes bear very little resemblance to dictionaries in Java. That means Json is not a very natural serialisation for a Java based object structure. Frameworks exist to address this through mappings, which can be convenient. Except, it reduces the Json approach to yet another way to serialise Java objects rather than a beautifully simple and elegant solution to modeling your data. And that's where the problem lies.

My main problem with doing things using mapping is that it's not exactly lightweight anymore. Suddenly you need to worry about instantiating classes, stuffing the right bits of data in the right setters and constructors. Then inevitably you start doing some hashCode and equals methods and of course generics creeps in somewhere along the way (or even worse, inheritance). Then you generalize and add some interfaces, annotations, etc. Congratulations: your easy to read 50 line Json file representing a simple dictionary with some very simple, uncomplicated Json magically turned into a framework with dozens of classes and thousands of lines of code that does nothing else than represent what any javascript, python, or ruby programmer would trivially accomplish with a few lines of code. That's some serious bloat. It's the reason countless of software engineers have been fleeing the java enterprise world in favor of more sane worlds such as Python Django, Ruby on Rails, or even [Node.js](http://nodejs.org/). It makes me want to flee as well.

**The solution: do what others do and use Json**

I've been fighting this bloat & complexity over the past few months and have been stubbornly reducing the number of model classes we have to 0. Instead I simply use the classes provided by the [GSon](http://code.google.com/p/google-gson/) framework (which is one of the popular options in the Java world for dealing with Json) to represent the core Json objects, I.e. JsonObject and JsonArray + the four primitive types (int, double, string, boolean). Where in the past I would have been constructing model classes and instantiating those, I instead do a "new JsonObject()" and start modifying it through its primitives for adding JsonObjects, JsonArrays, or one of the four JsonPrimitives. This is different than what most Json frameworks in Java try to achieve, which is providing convient ways to map to and from Json and your model classes. What I want is to get rid of model classes.

You can lose some serious amounts of source code this way. People seem terribly concerned with hiding Json from the Java programmer by adding layers of indirection to hide it. What they don't realize is that there is a direct correlation between lines of code and complexity on one hand and maintenance cost on the other hand. Json world: you are adding string "foo" to a dictionary. Java world, you are creating an instance of class Foo<String> and another of FooHolder<Foo<String>>. Then you add your instance of Foo to the FooHolder and then you serialize it to Json. I'm exaggerating of course but I've seen people write code that essentially boiled down to setting a few properties on a dictionary and yet somehow required 10+ classes and an afternoon of coding to accomplish. That feels very wrong to me.

**Problems with the Java language**

The problem is actually quite subtle and strongly related to a few areas where Java is lacking relative to more modern languages:

- Java distinguishes between native types and classes (which are a native type with a shallow non native wrapper Class, but you can't 'instantiate' a new class). That means for example that a class is not a dictionary and lists and dictionaries are not native types. This causes all sorts of issues with reflection and advanced typing (like generics) or the introduction of [closures](http://blogs.sun.com/jag/entry/closures) to the language. This is a problem more modern object oriented languages don't suffer from since in those languages everything is natively an object, including a class.
- Static typing is nice but often dynamic typing is good enough. As can be seen see with [Scala](http://www.scala-lang.org/), or [Mirah](http://www.mirah.org/) (a natively compilable Ruby dialect), it doesn't have to be so black and white. Fact: the Java type system represents the state of the art in the early eighties and does not incorporate many of the advances since then. Modern languages can be far more expressive and less verbose without much sacrifice.
- Java has no good way of representing multi typed dictionaries because of its rigid type system. You cannot easily express a dictionary where key "foo" maps to an integer and key "bar" maps to another dictionary. In other words, Java lacks the language capability to express the contents of a Json dictionary elegantly. The 'workaround' is to use Object as the type, which then leads to a lot of casting elsewhere. Generics don't quite address this. This is a fundamental and critical flaw that has given rise to an enormous amount of complexity in the Java enterprise world. Any time you hear Java developers talk about mappings and frameworks, they are working around this problem. Massive amounts of code are involved with working around this problem.
- The lack of proper typing and closures leads Java coders to believe they need to model the world in terms of classes and objects. This is a very serious problem because it naturally leads to complex frameworks for even the simplest of domains. If you've been exposed to a decent amount of functional programming, you will feel dirty after a day of work with any of the big Java frameworks. They're big, clumsy, and tedious. And they generally don't play nice together and fuse data and functionality together in a way that actually prevents reuse.
- Java has no first class properties and instead relies on the [JavaBeans](http://en.wikipedia.org/wiki/JavaBean) convention of having lots of setters and getters. So where in a decent language you would go object.attribute.attribute2.attribute3 = foo, you get in Java several lines of code with setter and getter calls as well as null checks just to stuff foo in the right place in the object graph.

**Principles I stick to**

So, does that mean I'd love to switch languages to something more modern? Absolutely, I'm bored out my mind with Java! But sadly, that's not likely to be happening on any of the projects I'm currently involved with and I have to work with what I have. So, instead I've started to resist the traditional Java way since I believe a lot of these practices to be outdated and counter productive. I have started to incorporate and borrow patterns and idioms from elsewhere. 

- **Json is the primary way to represent data.** Any data that goes in or out of the system via the API is represented as Json. That makes Json the primary representation of the data. That also means any representation other than Json is a secondary concern and as such a waste of time and resources. That includes any kind of Java class or object hierarchy intended to represent the data that is in the Json. That is a reverse of principle for a traditional Java programmer who will consider Java his most important way of expressing things and will consider json a secondary concern.
- **Use a dedicated set of classes to represent Json in Java.** Because of several of the before mentioned language issues, the Java collections framework is not very suitable for representing Json in Java. I tend to prefer the way it is done in the before mentioned GSon framework. So I use JsonArray, JsonObject, JsonElement, JsonPrimitive (and its four subclasses).
- **Use a key value store.** A key value store is nothing but a persistent dictionary. So, Key Value stores are the natural way to deal with persistence. Listen carefully, I just wiped an entire layer from the traditional enterprise architecture. That's good. No more object relational mappings. Json is what goes into your system and it is what goes out into the storage layer.
- **Resist secondary representations and stick to the primary representation: Json.** Don't do secondary representations and associated mappings, translations, frameworks, etc. because every time the primary representation (i.e. Json structure) evolves, it triggers a ripple effect of code changes related to secondary code artifacts. Avoid this unnecessary cost by not having those.
- **Don't expose your internals.** Business logic natively manipulates Json objects because business logic is a primary concern. Any usage of non Json objects is disallowed in public facing APIs. So, never return List, Maps, etc. but instead return and accept JsonArray and  JsonObject instances (or Java native types). Don't force your API users into using your internal data representation. Every time you violate this rule, you are leaking internals through your API. Don't do that, it's bad design.
- **Everything may become external some day.** Of course what is internal and external is somewhat a blurry distinction. So, it follows that you must use Json internally as well since it may one day become external.
- **No needless abstractions.** All [abstractions are leaky](http://www.joelonsoftware.com/articles/LeakyAbstractions.html). This is particularly true of domain models. What seems like a good abstraction now may prove to be a horribly poor idea a few years down the road. The world is full of frameworks and domain models that don't play nice with each other and are poorly aligned (you likely are guilty of inventing several of them). Your Json input and output is the one and only representation of the data so don't even try to abstract from it.
- **[KISS](http://en.wikipedia.org/wiki/KISS_principle) and [YAGNI](http://en.wikipedia.org/wiki/You_ain%27t_gonna_need_it).** Keeping things small and simple removes much of the need for complexity. Each extra class is complexity, each extra method is complexity, each extra mapping is complexity, each extra layer is complexity. If your data is simple, your code should be simple as well. Don't add complexity you don't need because you aint gonna need it. For example, the [GeoJson](http://geojson.org/geojson-spec.html) representation of a coordinate is an array of two doubles. I'd hate to see the equivalent of GeoJson as a Java framework. I shudder just thinking of all those tedious little classes to represent points, polygons, etc. that are of course completely incompatible with similar classes you'd find in Java2D, OpenGl, or other graphics frameworks. Don't do it. Array of two doubles is good enough.
- **Respect the [law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter).** Json is inherently weakly typed, so don't assume to much about its structure and dig out that JsonObject from your main Json document and then work directly on that object rather than indirectly by passing around references to the main JsonObject. This is simply applying the law of Demeter, which requires you to use no needless levels of indirection when accessing members of an object. So bad: String s = root.foo.bar.foobar.bar, right: s = foobar.bar embedded in some code that is parametrised with whatever happens to contain foobar. Modularise your code around small, uncomplicated Json objects rather than big, deeply nested ones. Separate the assumptions about which objects go where from the assumptions of what is inside those objects because both are likely to change and because those objects might start to appear in different places.
- **Design your Json for more capable languages.** You are not merely serialising data, you are creating a Json document that others are going to use from e.g. javascript. It is worth spending some time considering their needs and requirements. Read: they don't like big, complicated Json that is hard to read.

It's not all good of course and there are downsides to rebelling against the Java way:

- Refactoring becomes a bit more tedious. I tend to use constants for my attribute names, which partially addresses this. But forget about manipulating the Json structure with the refactoring tooling in your IDE. This is particularly annoying for business logic depending on that structure. A work around here is to keep things simple.
- Extracting data from Json structures can be tedious and may involve a lot of null checks. We work around this with a few static helper methods. [Varargs](http://download.oracle.com/javase/1.5.0/docs/guide/language/varargs.html) is your friend here. e.g. extract(object, attr1, attr2, attr3) would return either null or the value of object.attr1.attr2.attr3. Mind you, you have exactly the same issue with many Java object graphs and this is a likely cause for any NullPointerException you've ever encountered.
- You will at points miss the convenience of model classes. This is the price you pay for the Java type system. Keep dreaming of a better world where you don't have to use it anymore. The alternative of using model classes in Java is a fallacy though. It's entirely true that you would end up using model classes in Python though. However, Python classes are dictionaries and as such need no translation work whatsoever. Java classes are not dictionaries and do require translation work.
- Like all good frameworks, the Json classes in GSon are final so you can't sneak in model classes by extending JsonObject. However, you might consider using wrapper objects that have a delegate JsonObject as the single field. I'm not strongly against this but it still feels like bloat to me and I prefer to avoid this pattern because of KISS and YAGNI.
- There is a lot of code out there that assumes you are doing things the Java way, reusing that just got a little harder. But I again refer you to the principle on KISS and YAGNI.

**Why this is important**

I've been refactoring quite a bit of code using the above principles and I can report to have shed many lines of code along the way while improving readability, reducing complexity, and gaining flexibility. My background as a software engineering researcher tells me this is a good thing (TM) because [lines of code directly correlate to software development cost, complexity, and maintenance cost](http://www.dwheeler.com/sloc/). Therefore, less lines of code and complexity is almost always the right thing to aim for unless you can convert the investment in cost into added value. More lines of code is not necessarily the same as adding value. If it is not adding value, it is in fact [technical debt](http://www.martinfowler.com/bliki/TechnicalDebt.html).

I've seen a lot of Java projects lately that are needlessly complicated and hard to maintain while trying to achieve seemingly simple goals that involve accepting some data, stuffing it in a data store, retrieving it and and returning it via some API.  CRUD in other words. CRUD is simple but not if it has to go to several layers of indirection that involve mapping xml to data transfer objects and then to model objects, and then to SQL tables and back again. The system we are replacing with a new system based on the principles outlined here does this. Its business logic amounts to take in data, validate it, store it, mash it together in an interesting way and retrieve it. Its business logic should also include a bunch of other things that we never got around to because we got bogged down in non value adding activities related to mapping data in different ways and dealing with over engineered & bloated technologies that got abused in a terrible way by some junior engineers who thought they were in a candy store. In other words, I've gone through months of head shaking,  swearing a lot, silently cursing misc. individuals no longer on the team, and mostly deleting code to replace it with small amounts of new code. In other words, I've taken a system that pretty much A** rapes the listed principles and am working hard on building a replacement that doesn't do that.