---
id: 378
title: Crypto Crap in Python
date: 2008-01-25T19:05:22+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2008/01/25/crypto-crap-in-python/
permalink: /2008/01/25/crypto-crap-in-python/
dsq_thread_id:
  - "336377470"
categories:
  - Blog Posts
tags:
  - google
  - IO
  - java
  - python
  - RSA
  - UTF
  - webdevelopment
---
I'm looking into doing a little cryptographic stuff in python. Nothing fancy, just some standard stuff. Not for the first time I'm bumping into this brick wall of "batteries included", the notion that the python library comes with a lot of stuff that should be good enough for whatever you need to do. Only problem is that it doesn't. XML parsing stinks in Python; http IO stinks (need lots of third party stuff to make that usable); no UTF-8 by default; etc. 

Out of the box python is bloody useless unless you want to do some very simplistic stuff. So basically my problem is very simple: I need to be able to sign stuff and verify signatures in a way that is compatible with how stuff like this stuff is commonly done on the internet (tm). I.e. you'd expect some pretty mature, well tested libraries to be around for whatever programming language you'd like to use. I know exactly where to go to get this stuff for Java, for example.

So we're looking at some very basic capability to do stuff with algorithms like RSA, SHA1, MD5 etc. Batteries not included with python at all so I Google a bit to find out what people commonly use for this in python and stumble upon what seems to be the most popular library <a href="http://www.amk.ca/python/code/crypto">pycrypto</a>. It seems to have all the algorithms, great! Only one minor detail that has had me crawl all over Google for the entire afternoon:

Public keys usually come as base64 encoded thingies: how the hell do I get them in and out of the functions/classes and what not provided by pycrypto. Batteries not included. After a long search, I find this nice <a href="http://xpg.dk/index.php?mact=News,cntnt01,print,0&cntnt01articleid=23&cntnt01showtemplate=false&cntnt01returnid=54">post</a>.

Basically it's telling me that various people have bothered to provide nice libraries with relevant code for python but somehow all of them have neglected to provide this very basic functionality that you will need 100% guaranteed. That just sucks. In the hypothetical case that you'd actually want to use this stuff to do hypothetically useful things like verifying a signature attached to some http request you will basically find yourself reverse engineering this poorly documented library and figuring out how to get from a base 64 encoded RSA key to a properly configured RSA class instance and back again. I had lots of fun (not) reading about the details of RSA, x.509, etc.

Eventually I found some <a href="http://dev.w3.org/cvsweb/2000/10/swap/cwm_crypto.py?rev=1.11">sample code</a> here that seems to half do what I need. But I'd just prefer to be able to reuse something that is hassle free instead of copy pasting somebody else's code and debugging it until it works as expected and basically reinventing the wheel by making what would amount to Jilles private little python crypto library. I have better things to do.