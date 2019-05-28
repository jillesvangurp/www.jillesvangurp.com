---
id: 49
title: tomcat and iis
date: 2005-02-23T17:23:00+00:00
author: Jilles
layout: post
guid: 4@http://blog.jillesvangurp.com/
permalink: /2005/02/23/tomcat-and-iis/
tags:
  - java
---
 I had to look into some configuration issues which I had been delaying for the past few weeks. How to get iis to play nice with tomcat such that you can have two virtual iis servers forward stuff to one tomcat with again two virtual servers. <br />
We have two tomcat applications that we need to shield from the outside world with a webserver like apache or iis. How this works is that the webserver forwards some urls to tomcat and acts as a proxy for those urls. <br />
<br />
This is pretty routine stuff, the only problem is that it is not documented how one should do this. And lets face it, the apache jakarta people write beautiful code but their documentation is typically not that good. You can get started easily but the advanced stuff is understandably not documented well. I say understandably because I understand that developers have other priorities (like getting things to work) but still, it's bloody unusable now.<br />
<br />
But I figured it out today thanks to this page: http://tjworld.net/help/kb/0001_iis6-Tomcat5-JK2.html#conConnector. This page contained all the necessary information to get me started. I followed the instructions to the letter and ended up with a working iis-tomcat setup. From there it was easy, just add a few hosts to the tomcat server in server.xml (I'm going to experiment with the alias tag later on) and add a bunch of iis virtual services (all with the isapi filter active) for each of the tomcat hosts. Works just fine. I knew all along that it was possible to do this and now I have the proof <img src='http://blog.jillesvangurp.com/pivot/includes/emot/e_01.gif' alt=':-)' align='middle'/>. 