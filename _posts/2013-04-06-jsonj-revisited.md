---
id: 1525
title: jsonj revisited
date: 2013-04-06T00:51:45+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1525
permalink: /2013/04/06/jsonj-revisited/
wp-syntax-cache-content:
  - |
    a:3:{i:1;s:576:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="java" style="font-family:monospace;"><span style="color: #000066; font-weight: bold;">int</span> i<span style="color: #339933;">=</span>o.<span style="color: #006633;">getInt</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">&quot;a&quot;</span>,<span style="color: #0000ff;">&quot;b&quot;</span><span style="color: #009900;">&#41;</span></pre></td></tr></table><p class="theCode" style="display:none;">int i=o.getInt(&quot;a&quot;,&quot;b&quot;)</p></div>
    ;i:2;s:858:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="java" style="font-family:monospace;">o.<span style="color: #006633;">getOrCreateArray</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">&quot;a&quot;</span>,<span style="color: #0000ff;">&quot;b&quot;</span>,<span style="color: #0000ff;">&quot;c&quot;</span>,<span style="color: #0000ff;">&quot;d&quot;</span>,<span style="color: #0000ff;">&quot;e&quot;</span><span style="color: #009900;">&#41;</span>.<span style="color: #006633;">add</span><span style="color: #009900;">&#40;</span><span style="color: #cc66cc;">43</span><span style="color: #009900;">&#41;</span></pre></td></tr></table><p class="theCode" style="display:none;">o.getOrCreateArray(&quot;a&quot;,&quot;b&quot;,&quot;c&quot;,&quot;d&quot;,&quot;e&quot;).add(43)</p></div>
    ;i:3;s:1530:
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="java" style="font-family:monospace;"><span style="color: #003399;">String</span> json<span style="color: #339933;">=</span> object<span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span>.<span style="color: #006633;">put</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">&quot;a&quot;</span>,<span style="color: #cc66cc;">42</span><span style="color: #009900;">&#41;</span>.<span style="color: #006633;">put</span><span style="color: #009900;">&#40;</span><span style="color: #0000ff;">&quot;b&quot;</span>,array<span style="color: #009900;">&#40;</span><span style="color: #cc66cc;">1</span>,<span style="color: #cc66cc;">2</span>,<span style="color: #0000ff;">&quot;three&quot;</span><span style="color: #009900;">&#41;</span>.<span style="color: #006633;">get</span><span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span>.<span style="color: #006633;">toString</span><span style="color: #009900;">&#40;</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #666666; font-style: italic;">// {&quot;a&quot;:42,&quot;b&quot;:[1,2,&quot;three&quot;]}</span></pre></td></tr></table><p class="theCode" style="display:none;">String json= object().put(&quot;a&quot;,42).put(&quot;b&quot;,array(1,2,&quot;three&quot;).get().toString();
    // {&quot;a&quot;:42,&quot;b&quot;:[1,2,&quot;three&quot;]}</p></div>
    ";}
categories:
  - Blog Posts
tags:
  - API
  - java
  - Java Enterprise
  - python
---
It's been nearly two years since I created the [jsonj project on github](https://github.com/jillesvangurp/jsonj) and [blogged about it](https://www.jillesvangurp.com/2011/05/31/jsonj/). Inspired by my observation that dealing with json in Java kind of sucks, I set out to fix it. 

As part of our ongoing work to build the LocalStream platform I've been eating my own dogfood and this has resulted in a lot of improvements to this project. So, I thought it was about time to write about jsonj again. 

<!--more-->

<b>Why did I create JsonJ?</b>

In short, I have a problem with the notion of representing just about any little json structure using a domain model that consists of tons of small domain classes that actually don't implement any useful functionality but yet suck up a lot of development time related to implementing them, testing they are implemented correctly (e.g. hashCode and equals are often a problem), refactoring them when the data changes, etc. I've dealt with several projects that had tons of domain classes and code littered with sets, gets. In one of the more extreme cases of mapping madness I've seen, xml came in via the API, was transformed into DTOs (data transfer objects) and from there into the domain model and from there into sql tables using hibernate. This kind of madness is why engineers have been fleeing from Java Enterprise solutions.

I prefer schema-less designs instead. There is no such thing as a strongly typed domain model when you have a schema-less design. As [Marting Fowler has argued](http://martinfowler.com/articles/schemaless/), there is always an implicit schema in the form of code that assumes things about data (e.g. that it has a particular field) or validates that it is structured correctly. However, that is different from encoding that schema in a strongly typed, complex class hierarchy and defining a very finegrained mapping to and from json.

Java makes schema less json quite hard because it lacks native lists and hashes like you would find in javascript, python, or ruby. 
In those languages, manipulating json is extremely straightforward and supported well with lots of syntactic sugar. This makes it easy to prototype e.g. using a json driven API or implementing one. This is indeed one of the reasons why ruby and python are very popular for this kind of work.

Java on the other hand has arrays and the Collection framework, which are sort of not very nice to deal with when manipulating data.&nbsp;The resulting code tends to be very verbose and this is a big reason lots of Java coders prefer not doing that and instead rely on mapping the data to domain classes where a ruby user might instead opt to simply write a oneliner (e.g. response={:text=>'some message}.to_json. The beauty of json and a reason it is used so often is that data structures don't have to be complicated. Yet most Java projects completely mess this up with complex mapping solutions and the associated domain classes thus turning what would have been a small Ruby project into a 40 class project with thousands of lines of code.

Finally, Java actually lacks json support. This means you need a third party library for processing json data. Several such libraries exist and most of them are optimized for use in combination with domain classes. Some of them, e.g. jackson or gson also support mapping to Lists and Maps. However, as noted these classes are actually quite tedious to use as is.

JsonJ is my attempt to address all of these problems as best as possible within the constraints of the Java language.

<b>How do we use JsonJ in Localstream?</b>

As you may know from my previous articles on Localstream, we are using Elastic search as a key value store and do not use e.g. mysql or some other relational database. The Localstream platform is a hybrid Jruby/java application. We use jruby for implementing our RESTful API layer using the Sinatra framework. 

Our REST API accepts and returns json and Elastic search uses json as well for its API, its query language, its mappings, etc. So we are dealing with a lot of different json objects and JsonJ is used to do a lot of the heavy-lifting without any domain classes whatsoever.

Not having any domain classes means our code base is small and easy to maintain. JsonJ has been critical for this. It's very easy for us to add new APIs, modify existing objects or add new ones. Like with any decent RESTful API, Localstream has gone through quite a few design iterations and JsonJ has helped us do this with the minimum of fuss. Not having a ton of domain classes means that such changes are extremely straightforward.

<b>JsonJ overview</b>

JsonJ represents json using the JsonElement interface, which is implemented by three classes: JsonObject, JsonArray, and JsonPrimitive. JsonObject implements the Map interface so it can behave just like any other Map&lt;JsonElement&gt;. Likewise JsonArray is a List&lt;JsonElement&gt; and finally JsonPrimitive uses Integer, Double, String and Boolean to represent primitive values.

So far that is nothing special. The magic is that I added a lot of convenient methods to these classes that facilitate getting data in and out of their instances.

For example given some json&nbsp;{"a":{"b":42}} in a JsonObject o, you can get to the nested integer with a statement this way: 
<pre lang="java">
int i=o.getInt("a","b")
</pre>

This utilizes java's varargs feature for passing in a variable number of parameters. Additionally it does all the null checks (the object might not have "a" or "b" and takes care of converting from a JsonPrimitive to an int. This is the type of code has given Java a reputation for being very verbose and JsonJ makes that problem go away.

Another example is modifying existing objects:
<pre lang="java">
o.getOrCreateArray("a","b","c","d","e").add(43)
</pre>

This ensures a list is added to the json object along with the objects "c" and "d" that are not there yet. And then it appends 43 to the list. If the list existed already, it would simply append 43 to that. The method basically gets rid of all the boiler plate code of first extracting b and checking whether it has c element, and checking if it is a list, etc. A similar method exists for adding or creating objects. 

Additionally, jsonj comes with a builder class that makes constructing complex json documents very straightforward.&nbsp;So you can write nice little oneliners to quickly create an object and serialize it:

<pre lang="java">
String json= object().put("a",42).put("b",array(1,2,"three").get().toString();
// {"a":42,"b":[1,2,"three"]}
</pre>

While still somewhat more verbose than the equivalent ruby code, writing code like this is actually pretty easy in a decent IDE because most Java IDEs do autocompletion very well.

<b>Recent improvements</b>

This was pretty much the state of jsonj when I put it up on Github originally. Over the past six months or so, I've made numerous improvements as I ran into bugs and scratched the inevitable itches that arose from using it on a daily basis. The net result is that it has become vastly more usable.

Following the DRY principle, I have automated everything that still felt repetitive about using the framework. There were a couple of things where my Java code just became too repetitive and verbose when using it and I tackled these issues on a case by case basis.

This has resulted in the addition of loads more convenient methods and lots of API polish. Examples of this are fixing the toString method to actually serialize the json, a prettyPrint method that does the same but prettier; adding a fromObject(Object o) method to the builder that makes a best effort to convert Java objects into the most appropriate JsonElement.

This fromObject method is used in a quite a few other places so that you rarely have to manually convert things. For example, JsonArray has an add method that does the right thing when you call it with something else than a JsonElement. Same for the put in JsonObject.

Another change is that a lot of the specialized methods in the three classes are now part of the JsonElement API. Using them on an object of the wrong type will result in an exception. However, not having to check whether a JsonElement is actually a JsonPrimitive before you call asDouble on it is very helpful. 

Another thing that I worked on was making jsonj more memory friendly by representing strings (values and object keys) using utf-8 byte arrays and using my [EfficientString](https://github.com/jillesvangurp/efficientstring) project for handling object keys. The reason I did this is because I use jsonj for a lot for data processing as well. Some of these jobs are pretty memory intensive because caching large amounts of data in memory helps speed things up considerably (as opposed to looking them up in a database). This change dramatically reduced the memory used by jsonj and allows me to cache much more data. 

<b>Jruby and JsonJ</b>

I currently use jsonj in a mixed Java and Jruby project. The problem with that is that on the jruby side, you actually want to convert things to normal ruby data structures. So, today I created a new github project called [jsonj-integration](https://github.com/jillesvangurp/jsonj-integration). 

This is a jruby project that adds functions to the Hash, List ruby classes as well as the java JsonObject, and JsonArray classes. to These functions include some obvious ones: toJsonJ does what you would expect on any ruby hash or list. Likewise, toRuby does the reverse on JsonObjects and JsonArrays. I also threw in a to_s method that calls toString, which serializes to String. Finally, it also adds implementations for [] to JsonObject and JsonArray as well as a << method to JsonArray. This means you can pretty much treat those objects as if they are hashes and lists without actually converting them.

This makes the integration seemless and allows me to parse data coming via the API in our Sinatra based API layer, hand it off to a Java service class, take the JsonJ object that comes back and return that from the API as json. All with a minimum of fuss. 

If you are interested, JsonJ is available in my [maven repository](https://www.jillesvangurp.com/2013/02/27/maven-and-my-github-projects/) and you can get [jsonj-integration from rubygems](http://rubygems.org/gems/jsonj-integration).