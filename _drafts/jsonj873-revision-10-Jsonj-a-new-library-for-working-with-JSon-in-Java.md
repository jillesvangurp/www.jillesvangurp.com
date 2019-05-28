---
id: 894
title: 'Jsonj: a new library for working with JSon in Java'
date: 2011-06-02T14:42:20+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2011/06/02/873-revision-10/
permalink: /2011/06/02/873-revision-10/
---
I've just uploaded a weekend project to github. So, here it is, <a href=" https://github.com/jillesvangurp/jsonj">jsonj</a>. Enjoy.

If you read my post on <a href="http://www.jillesvangurp.com/2011/04/02/on-java-json-and-complexity/">json</a> a few weeks ago, you may have guessed that I'm not entirely happy with the state of json in Java relative to other languages that come with native support for json. I can't fix that entirely but I felt I could do a better job than most other frameworks I've been exposed to.

So, I sat down on Sunday and started pushing this idea of just taking the Collections framework and combining that with the design of the Json classes in GSon, which I use at work currently, and throwing in some useful ideas that I've applied at work. The result is a nice, compact little framework that does most of what I need it to do. I will probably add a few more features to it and expand some of the existing ones. I use some static methods at work that I can probably do in a much nicer way in this framework. 

<!--more-->

Here is some example usage (note, this will likely not stay in sync with the code in github, check there for latest version):

<strong>Updated to version 0.3</strong>

<pre lang="JAVA" line="1">
/**
 * Copyright (c) 2011, Jilles van Gurp
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package org.jsonj;

import static org.jsonj.tools.JsonBuilder.array;
import static org.jsonj.tools.JsonBuilder.nullValue;
import static org.jsonj.tools.JsonBuilder.object;
import static org.jsonj.tools.JsonBuilder.primitive;
import static org.jsonj.tools.JsonSerializer.serialize;
import static org.jsonj.tools.JsonSerializer.write;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.LinkedList;

import org.jsonj.tools.JsonParser;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Not really a test but a nice place to show off some how to use this.
 */
@Test
public class ShowOffTheFramework {

	/** this could be a singleton or a spring injected object, threadsafe of course. */
	private final JsonParser jsonParser = new JsonParser();;

	public void whatCanThisBabyDo() throws IOException {
		JsonObject object = object()
			.put("its", "just a hash map")
			.put("and", array(
				primitive("adding"),
				primitive("stuff"),
				object().put("is", "easy").get(),
				array("another array")))
			.put("numbers", 42)
			.put("including_this_one", 42.0)
			.put("booleanstoo", true)
			.put("nulls_if_you_insist", nullValue())
			.put("a", object().put("b", object().put("c", true).put("d", 42).put("e", "hi!").get()).get())
			.put("array",
				array("1", "2", "etc", "varargs are nice")).get();

		Assert.assertTrue(object instanceof LinkedHashMap, 
			"JsonObject actually extends LinkedHashMap");

		// get with varargs, a natural evolution for Map
		Assert.assertTrue(object.get("a","b","c").asPrimitive().asBoolean(), 
			"extract stuff from a nested object");
		Assert.assertTrue(object.getBoolean("a","b","c"), "or like this");
		Assert.assertTrue(object.getInt("a","b","d") == 42, "or an integer");
		Assert.assertTrue(object.getString("a","b","e").equals("hi!"), "or a string");

		Assert.assertTrue(object.getArray("array").isArray(), "works for arrays as well");
		Assert.assertTrue(object.getObject("a","b").isObject(), "and objects");

		// builders are nice, but still feels kind of repetitive
		JsonObject anotherObject = object.getOrCreateObject("1","2","3","4");
		anotherObject.put("5", "xxx");
		Assert.assertTrue(object.getString("1","2","3","4","5").equals("xxx"),
			"yep, we just added a string value 5 levels deep");
		JsonArray anotherArray = object.getOrCreateArray("5","4","3","2","1");
		anotherArray.add("xxx");
		Assert.assertTrue(object.getArray("5","4","3","2","1").contains("xxx"),
			"naturally works for arrays too");

		// Lets do some other stuff
		Assert.assertTrue(object.equals(object),
			"equals is implemented as a deep equals");
		Assert.assertTrue(array("a", "b").equals(array("b", "a")),
			"mostly you shouldn't care about the order of stuff in json");
		Assert.assertTrue(
			object().put("a", 1).put("b", 2).get()
			.equals(
				object().put("b", 2).put("a", 1).get()),
			"true for objects as well");

		// Arrays are lists
		JsonArray array = array("foo", "bar");
		Assert.assertTrue(array instanceof LinkedList, "JsonArray extends LinkedList");
		Assert.assertTrue(array.get(1) == array.get("bar"), "returns the same object");
		Assert.assertTrue(array.contains("foo"), "obviously");
		Assert.assertTrue(array.contains(primitive("foo")), "but this works as well");

		// serialize like this
		String serialized = serialize(object);

		System.out.println(serialized);

		// parse it
		JsonElement json = jsonParser.parse(serialized);

		// and write it straight to some stream
		write(System.out, json, false);

		// or pretty print it like this
		System.out.println("\n" + serialize(json, true));
	}
}
</pre>





