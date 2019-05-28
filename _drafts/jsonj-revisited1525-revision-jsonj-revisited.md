---
id: 1526
title: jsonj revisited
date: 2013-04-05T23:55:30+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/04/05/1525-revision/
permalink: /2013/04/05/1525-revision/
---
It's been nearly two years since I created the <a href="https://github.com/jillesvangurp/jsonj">jsonj project on github</a> and <a href="http://www.jillesvangurp.com/2011/05/31/jsonj/">blogged about it</a>. Inspired by my observation that dealing with json in Java kind of sucks, I set out to fix it. 

As part of our ongoing work to build the LocalStream platform I've been eating my own dogfood and this has resulted in a lot of improvements to this project. So, I thought it was about time to write about jsonj again. 

<b>Why did I create JsonJ?</b>

In short, I have some problems with the notion of representing just about any little json structure using a domain model of tons of silly classes with all the maintenance headaches that come with it. I like schema less: there is no such thing as a strongly typed domain model. Not having to write a ton of stupid code like that to deal with json data is something I prefer.

Java makes this hard because it lacks native lists and hashes like you would find in javascript, python, or ruby. In those languages, manipulating json is extremely straightforward and supported well with lots of syntactic sugar. This makes it easy to prototype e.g. using a json driven API or implementing one. This is indeed one of the reasons why ruby and python are very popular for this kind of work.

Java on the other hand has arrays and the Collection framework, which are sort of not very nice to deal with when manipulating data. The resulting code tends to be very verbose and this is a big reason lots of Java coders prefer not doing that and instead rely on mapping the data to domain classes.

JsonJ is my attempt to fix this as much as possible and avoid needing domain classes.

<b>How do we use JsonJ in Localstream?</b>

As you may know from my previous articles on Localstream, we are using Elastic search as a key value store and do not use e.g. mysql or some other relational database. The Localstream platform is a hybrid Jruby/java application. We use jruby for implementing our RESTful API layer using the Sinatra framework.

Our REST API accepts and returns json. Elastic search uses json as well for its API, its query language, its mappings, etc. So we are dealing with a lot of different json objects and JsonJ is used to do a lot of the heavy-lifting without any domain classes whatsoever.

Not having any domain classes means our code base is small and easy to maintain and JsonJ has been critical for this. It's very easy for us to add new APIs, modify existing objects or add new ones. Like with any decent RESTful API, it has gone through quite a few design iterations and JsonJ has helped us do this with the minimum of fuss. Not having a ton of domain classes means that most changes are extremely straightforward.

<b>JsonJ overview</b>

JsonJ represents json using the JsonElement interface, which is implemented by three classes: JsonObject, JsonArray, and JsonPrimitive. JsonObject implements the Map interface so it can behave just like any other Map&lt;JsonElement&gt;. Likewise JsonArray is a List&lt;JsonElement&gt;.

So far that is nothing special. The magic is that I added a lot of convenient methods to these classes that facilitate getting data in and out of them.

For example given some json {"a":{"b":42}} in a JsonObject o, you can get to the nested integer with a statement this way: 
<pre>
int i=o.getInt("a","b")
</pre>

This utilizes java's varargs feature for passing in a variable number of parameters. Additionally it does all the null checks (the object might not have "a" or "b" and takes care of converting from a JsonPrimitive to an int. This is the kind of code has given Java a reputation for being very verbose. 

Another example is modifying existing objects:
<pre>
o.getOrCreateArray("a","b","c","d","e").add(43)
</pre>

This ensures a list is added to the json object along with the objects "c" and "d" that are not there yet. And then it appends 43 to the list. If the list existed already, it would simply append 43 to that. The method basically gets rid of all the boiler plate code of first extracting b and checking whether it has c element, and checking if it is a list, etc. A similar method exists for adding or creating objects. 

Additionally, jsonj comes with a builder class that makes constructing complex json documents very straightforward. So you can write: nice little oneliners as

<pre>
String json= object().put("a",42).put("b",array(1,2,"three").get().prettyPrint();
</pre>

<b>Recent improvements</b>

This was pretty much the state of jsonj when I put it up on Github originally. Over the past six months or so, I've made numerous improvements as I ran into bugs, and scratched the inevitable itches that arose from using it on a daily basis. 

Following the DRY principle, I have automated everything that still felt repetitive about using the framework. There were a couple of things where my Java code just got to repetitive and verbose and I tackled these issues on a case by case basis.

This has resulted in the addition of loads more convenient methods and lots of API polish. Examples of this are fixing the toString method to actually serialize the json; adding a fromObject method to the builder that makes a best effort to convert Java objects into the most appropriate JsonElement.

This in turn is used in a quite a few other places so that you rarely have to manually convert things. For example, JsonArray has an add method that does the right thing when you call it with something else than a JsonElement. Same for the put in JsonObject.

Another change is that a lot of the specialized methods in the three classes are now part of the JsonElement API. Using them on an object of the wrong type will result in an exception. However, not having to check whether a JsonElement is actually a JsonPrimitive before you call asDouble on it is very helpful. 

Another thing that I worked on was making jsonj more memory friendly by representing strings (values and object keys) using utf-8 byte arrays and using my <a href="https://github.com/jillesvangurp/efficientstring">EfficientString</a> project for handling object keys. The reason I did this is because I use jsonj for a lot for data processing as well. Some of these jobs are pretty memory intensive because caching large amounts of data in memory helps speed things up considerably (as opposed to looking them up in a database). 

This change dramatically reduced the memory used by jsonj and allows me to cache much more data. 

<b>Jruby and JsonJ</b>

I currently use jsonj in a mixed Java and Jruby project. The problem with that is that on the jruby side, you actually want to convert things to normal ruby data structures. So, today I created a new github project called <a href="https://github.com/jillesvangurp/jsonj-integration">jsonj-integration</a>. This is a jruby project that adds functions to the Hash, List ruby classes as well as the java JsonObject, and JsonArray classes. to These functions include some obvious ones: toJsonJ does what you would expect on any ruby hash or list. Likewise, toRuby does the reverse on JsonObjects and JsonArrays. I also threw in a to_s method that calls toString, which serializes to String. Finally, it also adds implementations for [] to JsonObject and JsonArray as well as a << method to JsonArray. This means you can pretty much treat those objects as if they are hashes and lists without actually converting them.

This makes the integration seemless and allows me to parse data coming via the API in our Sinatra based API layer, hand it off to a Java service class, take the JsonJ object that comes back and return that from the API as json. All with a minimum of fuss. 