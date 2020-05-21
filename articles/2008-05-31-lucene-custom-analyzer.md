---
id: 416
title: Lucene Custom Analyzer
date: 2008-05-31T12:03:16+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=416
permalink: /2008/05/31/lucene-custom-analyzer/
dsq_thread_id:
  - "336377561"
categories:
  - Blog Posts
tags:
  - API
  - java
  - problemsandsolutions
---
A second neat trick I did with Lucene this week was to wrap the StandardAnalyzer with my own analyzer (see [here](https://www.jillesvangurp.com/2008/05/28/boosting-lucene-search-results-using-timestamps/) for the other post on Lucene I did a few days ago).

The problem I was trying to address is very simple. I have a nice web service API for my search engine. The incoming query is handled by Lucene using the bundled QueryParser which has a quite nice and elaborate [query language](http://lucene.apache.org/java/docs/queryparsersyntax.html) that covers most of my needs. However, a problem is that it uses the StandardAnalyzer on everything which means that all the terms in the query are being tokenized. For text this is a good thing. However, I also have fields in my index that are not text.

The Lucene solution to this is to use Untokenized fields in the index. Only problem, using untokenized fields in combination with the QueryParser is not recommended and tends to not work well since everything in the query is being tokenized. So, you should not use the QueryParser but programmatically construct your own Query. Nice but not what I want since it complicates my search API and I need to make complicated queries on the other end of it.

What I wanted is to match a url field against either the whole or part of the url (using wildcards). On top of that, I want to do that as part of a normal QueryParser query e.g. keyword: foo and link: "http\://example.com/foo". I've been doing this the wrong way for a while and let Lucene tokenize the url. So http://example.com/foo becomes [http] [example.com] [foo] for Lucene. The StandardAnalyzer is actually quite smart about hostnames as you can see since otherwise it would treat the . as a token separator as well.

This was working reasonably well for me. However, this week I ran into a nice borderline case where my url ended in ..../s.a. Tokenization happens on characters like . and /. On top of that, the StandardAnalyzer that I use with the QueryParser also filters out stopwords like a, the, etc. Normally this is good (with text at least). But in my case it meant the last a was dropped and my query was getting full matches against entries with a similar link ending in e.g. s.b. Not good.

Of course what I really wanted is to be able to use untokenized fields with the QueryParser. Instead what I did this week was create a tokenizer that for selected fields skips tokenization and treats the entire field content as a single token. I won't put the code for that here but it is quite easy:

- extend Analyzer
- override tokenStream(String field, Reader r)
- if field matches any of your special fields, return a custom TokenStream that returns the entire content of the Reader as a single Token, else just delegate to a StandardAnalyzer instance.

This is a great way to influence the tokenization and also enables a few more interesting hacks that I might explore later on.