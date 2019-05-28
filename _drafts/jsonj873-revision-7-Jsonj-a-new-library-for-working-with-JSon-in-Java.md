---
id: 891
title: 'Jsonj: a new library for working with JSon in Java'
date: 2011-06-01T20:09:28+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2011/06/01/873-revision-7/
permalink: /2011/06/01/873-revision-7/
---
I've just uploaded a weekend project to github. So, here it is, <a href=" https://github.com/jillesvangurp/jsonj">jsonj</a>. Enjoy.

If you read my post on <a href="http://www.jillesvangurp.com/2011/04/02/on-java-json-and-complexity/">json</a> a few weeks ago, you may have guessed that I'm not entirely happy with the state of json in Java relative to other languages that come with native support for json. I can't fix that entirely but I felt I could do a better job than most other frameworks I've been exposed to.

So, I set down on Sunday and started pushing this idea of just taking the Collections framework and combining that with the design of the Json classes in GSon, which I use at work currently, and throwing in some useful ideas that I've applied at work. The result is a nice, compact little framework that does most of what I need it to do. I will probably add a few more features to it and expand some of the existing ones. I use some static methods at work that I can probably do in a much nicer way in this framework. 

<!--more-->

Here is some example usage (note, this will likely not stay in sync with the code in github, check there for latest version):

<pre lang="JAVA" line="1">
package org.jsonj;

import static org.jsonj.tools.JsonBuilder.array;
import static org.jsonj.tools.JsonBuilder.nullValue;
import static org.jsonj.tools.JsonBuilder.object;
import static org.jsonj.tools.JsonBuilder.primitive;
import static org.jsonj.tools.JsonSerializer.serialize;
import static org.jsonj.tools.JsonSerializer.write;

import java.io.IOException;

import org.jsonj.tools.JsonParser;
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
			.put("arrays_are_easy",
				array("1", "2", "etc", "varargs are nice")).get();

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





