---
id: 444
title: Indie Social Networking
date: 2008-08-07T22:05:44+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=444
permalink: /2008/08/07/indie-social-networking/
dsq_thread_id:
  - "336377596"
categories:
  - Blog Posts
tags:
  - Christopher Blizzard
  - google
  - Google Social Graph
  - John Kemp
  - openid
  - PHP
  - socialnetwork
  - webdevelopment
---
I have this [page](https://www.jillesvangurp.com/my-other-sites/) elsewhere on this site where I try to keep track of various accounts I have with social networks and other sites.Ã‚Â  I updated it earlier today with some interesting additions.

It seems finally decentralized social networking is starting to happen. It's all very low profile now but promising. It all started somewhere last week when I noticed that one of my colleagues, John Kemp was now micro blogging via something called [identi.ca](http://identi.ca/frumioj). I noticed this because his status in skype was telling me. Since we share similar interests in things like OpenID and a few other things, I decided to check it out. I never really bought into this twitter stuff and gave up on updating my Facebook status regularly long time ago. But this identi.ca looks rather cool, so I [signed up](http://identi.ca/jillesvangurp).

It's basically twitter minus some features (not yet implemented) with a few interesting twists:

- You can sign in using OpenID
- It's open source. The software identi.ca is based on is called [laconi.ca](http://laconi.ca/trac/).
- It's completely open. It has all the hooks and obvious protocols implemented. For example, I microblog using a identi.ca contact in my jabber client (pidgin) over XMPP. There's RSS and probably some more stuff.
- Your friends info is available as FOAF, thus enabling [Google's Social Graph search](http://code.google.com/apis/socialgraph/) to work with the data there and in other places (like e.g. your wordpress linkdump).
- It's decentralized, you can have laconi.ca friends on different servers. Like email, there is no need for everybody to be on the same server.
- It's written in PHP -> you can probably install it on any decent hosting provider you can now run your own microblog just like you can run your own blog.

Of course being low profile, there's only the usual suspects active: i.e. people like me.

A second interesting site I bumped into is [whoisi.com](http://whoisi.com/p/4061). It's basically friendfeed or similar sites with a few interesting twists:

- You don't have to sign in or register. You just start using it.
- In fact you can't sign in and there's little need because whoisi creates a nice account for you on the fly that you can access using the cookie it sets automatically or a url you can bookmark.
- You can follow any person on the web and associate feeds with that person.
- There's no concept of your profile on whoisi. It's simply a tool for following people, anonymously. They don't even have to use whoisi in order for you to follow them.

It's run by Christopher Blizzard who works at Mozilla. I'm not sure if he is doing this in his spare time or if this has a bigger Mozilla labs plan behind it. Either way, he's a cool guy with good ideas obviously. Since whoisi didn't know about me yet, I ended up following [myself](http://whoisi.com/p/4061), which feels slightly hedonistic, and added most of the interesting feeds. Including of course my identi.ca feed.

It occurs to me that using identi.ca's FOAF and Google's Social Graph search, whoisi should be able to automatically find websites related to a person from a single url by just following the rel=me links that Google can produce and then any friends from the rel=friend links. Check out what Google finds out about me from providing www.jillesvangurp.com [here](http://socialgraph-resources.googlecode.com/svn/trunk/samples/findyours.html?q=www.jillesvangurp.com).

This hooking up of simple building blocks is exactly the point of the decentralized social network. It's nice to see some useful building blocks emerge that work towards making this happen. Basically, all the necessary building blocks are there already. From a single link it is possible to construct a very detailed view of what your friends are doing all over the web fully automatically. True all this is still a bit too difficult for the average user right now but I imagine that a bit of search and discovery magic would go a long way to making this just work on a lot of sites.