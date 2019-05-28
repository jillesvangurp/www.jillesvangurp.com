---
id: 310
title: simple note encrypt/decrypt with AES in javascript
date: 2007-07-17T20:01:10+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/07/17/simple-note-encryptdecrypt-with-aes-in-javascript/
permalink: /2007/07/17/simple-note-encryptdecrypt-with-aes-in-javascript/
dsq_thread_id:
  - "336377128"
tags:
  - AES
  - BTW
  - createdbyjilles
  - iphone
  - java
  - UI
  - webdevelopment
---
Inspired by the hype surrounding the iphone and web applications, I hacked together a <a href="http://www.jillesvangurp.com/encdec/">nice little toy</a> to encrypt and decrypt text using aes.  I borrowed the aes implementation from <a href="http://www.movable-type.co.uk/scripts/aes.html">here</a> and basically wrote a somewhat nicer UI for it.  I still need to integrate sha1 hashing of passwords as the aes.js script author suggests that is a bit more secure than his current method. 

I have no idea if it will work in the iphone browser since I've only tested in firefox. It partially works in IE7 and I have no desire to spend time finding out why it fucks up. Suggestions to improve my little javascript hacking are welcome of course.

BTW. password of the default content is: "secret".