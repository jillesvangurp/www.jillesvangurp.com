---
id: 410
title: Friend Connect
date: 2008-05-13T21:51:11+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=410
permalink: /2008/05/13/friend-connect/
dsq_thread_id:
  - "336377518"
categories:
  - Blog Posts
tags:
  - google
  - Google App Engine
  - java
  - openid
  - social networks
---
Google announced their [friend connect](http://www.google.com/friendconnect/home/moreinfo) yesterday. It's part of what is a pretty broad, and in my view really smart, strategy that they have been rolling out over the past few months bit by bit. It all started with open social which is their social network API that allows gadget creators to target any social network able to act as a open social container. By now this includes most relevant social networks except Facebook.

An issue is that open social is still a bit immature and also that compatibility between sites is not that great due to sites introducing all sorts of extensions and cherry picking features to implement, which of course leads to a great variety of circumstances to test for. However, it's a huge improvement over having just the Facebook API (which is not that old either, or that good).

Then came google app engine, which is a ultra scalable, hassle free environment for creating and hosting simple web applications. Like for example open social gadgets. App engine is a very interesting achievement at least from an architecture and scalability point of view. Whether it will work as advertised remains to be seen of course, too early to tell. Also, it comes with lots of technical restrictions that are going to be not popular with people that have investments in existing, non compatible code.

On the other hand, there's no way around the fact that most these limitations are more or less required for the type of scalability that Google wants to provide. So, Google App Engine lowers the barrier of entry for small parties to launch their own open social gadgets or full websites. That's good for Google because inevitably Google ends up being a really attractive advertising partner for people choosing to sell their soul like that choosing to host their products on Google App Engine. And of course, Google gets to monitor site activity and track users which is all very valuable data from advertising point of view. And of course all those nice Google APIs are really easy to access from inside Google's own platform.

Now yesterday they added friend connect to the mix. Friend connect does several things. First of all, it turns simple web sites into open social containers. Secondly, it comes with a few widgets that add some value to this. The most important of this is what appears to be a social network interconnect that allows for authentication of users against several popular social networks and openid thus relieving the simple website of that task. Basically visitors of a site can sign in with one or more social network credentials. Google handles all the interaction with the backend social networks which includes things such as publishing site activity to your event feed; access to your friend lists on all associated sites and that type of features.

Soon loads of blogs and other websites will start featuring nifty open social gadgets. Think wordpress sidebar widgets on steroids (checkout my frontpage to see a few in action). This will lead to a mass migration of activity from inside social networks to external websites.

I mentioned this was a very smart strategy by Google. What's going on here? Well Google, unlike most companies relying on advertisement revenue, doesn't care which websites you visit as long as they feature Google ads or as long as they can somehow track what you are doing. Friends connect vastly increases their ability to do so. It's effectively as good as users visiting a Google owned site: you sign in; all sorts of complex javascript executes; AJAX calls to Google take place, etc. They might even start pushing ads this way, although I suspect that they are not that stupid (would basically alienate a lot of website maintainers). More logic is that they continue to push ads separately and instead make it more attractive for existing adsense users to also deploy friend connect.

So, Google ads + friends connect is worth billions. It basically turns all connected websites into one huge social network with Google right at the center. Facebook can't really deliver this value because inevitably users browse to other domains than facebook.com and also because their third party website advertising marketshare is pretty much non existent: all their revenue is inside their walled garden. Same for myspace.com, or linked in.com and most other social networks. Google doesn't really have this problem. Most of their ads are served up by third party websites anyway and more eyeballs for those means more money for them. Any way you get to see a Google ad is a good one as far as they are concerned.

Google also managed to do some interesting things here. Note that Facebook is featured on friends connect. Apparently Google is just using the public facebook APIs just like any other site. But it should be interesting to learn what's in it for Facebook (revenue sharing?). Facebook and MySpace are also launching their connnect APIs this week BTW. However, as noted above, they currently lack the advertising solutions to make it work so it is debatable what the added value of that is going to be. It could be that they have to do do some website owner alienation by pushing ads. This is something Google can afford not to do.

Additionally, Google is actually bridging several social networks. Your myspace buddies showing up right next to your facebook buddies is somewhat of a novelty for the web (and the involved social networks). Google doesn't care where you park your friends, as long as you expose them via Google Connect and interact with them on sites showing nice Google ads.

Very clever.

I have a few worries though. To me friends connect sounds like a rather exclusive club and huge control point. It achieves some of the goals of [dataportability.org](http://dataportability.org/) by basically introducing one big fat central control point. So it's as open as Google wants/needs it to be. For now they seem to be doing the right way and friends connect being an openid relying party is a great example. But long term I wonder what will happen to the non Google connected web.

**Update**. It seems Facebook is [blocking their, apparently, involuntary inclusion on Google's friend connect ](https://www.jillesvangurp.com/)citing terms of use designed to lock in users into their platform. If you are not part of the solution, you are a part of the problem. Or, as Despair.com paraphrases, [If you're not a part of the solution,there's good money to be made in prolonging the problem](http://despair.com/consulting.html). I guess, they are afraid of the walls of their garden being torn down and that their estimated value might deflate before they can capitalize on it. Rumor has it Steve Balmer is sitting on a sack of unused money due to a certain deal blowing up in his face recently. And we all know he likes to throw with what he sits on.