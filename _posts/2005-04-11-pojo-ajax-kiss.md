---
id: 32
title: Pojo + ajax = KISS
date: 2005-04-11T18:00:00+00:00
author: Jilles van Gurp
layout: post
guid: 21@http://blog.jillesvangurp.com/
permalink: /2005/04/11/pojo-ajax-kiss/
tags:
  - AJAX
  - java
  - Keep It Simple Stupid
  - POJO
---
 Lately there has been a lot of fuss about POJOs and AJAX. POJOs (plain old java objects) are the answer to adding multiple layers of complexity just to store some simple data in a database. Some developers discovered that "hey I don't have to bend over backwards if I just do an insert query here instead of writing dozens of deployment descriptors, ejbs and what not" and called this POJO. 
Ajax on the other hand is just freeform httprequests with minimal restrictions: post something & parse the string that comes back. As such it is actually a very good drop in replacement for almost all applications of soap. Both are actually applications of the plain old KISS principle: don't add complexity where you don't need it. Complexity increases maintenance cost and it is only justified in a tradeoff where you gain something you need (e.g. flexibility). Soap and EJBs are examples of technologies that typically don't justify the added complexity. 

While soap can be used for more advanced stuff than remote procedures, it rarely is used in any other way than yet another remote procedure protocol. Soap calls have a number of disadvantages including performance, scalability, poor interoperability despite piles of specifications and complexity. Soap is actually not really suitable for RPC because of the high latency which forces you into a very coarse grained usage pattern (few calls with many parameters instead of many calls with few parameters). If each soap call takes 150ms, you can't afford more than two or three in a single transaction. So soap is really optimized towards posting a really complicated message and receiving something equally complicated back. If instead you want to do something simple like "doFoo with parameter X and Y and tell me if it worked" it is much more efficient to post a small message using http to a server that understands this message and returns "true" or "false". That's what AJAX is about. Http posts can do roundtrips in 20ms on a good network. So you can afford to do lots of them, e.g. from a javascript running inside a browser.

That's actually all AJAX is about because there's no such thing as a specification which tells you how to construct an AJAX message. Neither is there a POJO specification which tells you how to construct simple java objects to store simple data. POJOs and AJAX are something you are already supposed to have: common sense. Keep It Simple Stupid. 