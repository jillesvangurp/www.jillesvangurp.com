---
id: 1462
title: The future of mobile
date: 2013-01-12T14:37:03+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/01/12/1447-revision-6/
permalink: /2013/01/12/1447-revision-6/
---
I recently left Nokia. Nokia is a great company to start my own company. Nokia pioneered mobile telephony together with the likes of Ericsson and Motorola and had a huge influence in the market through the last two decades.  Nokia was doing great when I joined in late 2005. Market share was soaring to new highs, cool gadgets were launched every few months. Then something happened that has been written a lot about. First the iphone launched and roughly a year later Google unleashed Android. I'm not going to rehash that. That's the past of mobile. This article is about the future and the future is Linux.

In the year ahead, at least four new Linux mobile platforms are going to launch:
<ul>
	<li>Tizen (formerly known as Meego, Maemo, and a few other names) backed by Intel, Samsung and others.</li>
	<li>Jolla, which is a spinoff of Maemo by some of its former development team in Nokia.</li>
	<li>Ubuntu just announced they have a phone OS as well.</li>
	<li>Mozilla is pushing a Firefox based mobile UI</li>
</ul>
This is in addition to Bada (Samsung), Android (Google), Web OS (Palm/HP) and a few smaller/deprecated platforms. Android particularly is very successful with a market share that is well above 50% now in the smart phone market.

The point that most people miss when discussing platforms is that these platforms overlap to a extremely large extent. These are not isolated software stacks. Instead we are talking about a family of platforms that are largely based on the same open source components (kernel, tools, drivers, libraries, application frameworks.

Most people don't realize the size of software and the economic cost related to producing it. Debian linux (kernel, thousands of packages) weighs in at about <a href="http://en.wikipedia.org/wiki/Source_lines_of_code">330 MLOC</a> (millions lines of code). The linux kernel makes up about 16MLOC. So, relative to the code the above platforms share, the code that actually differentiates them makes up only a small percentage. And that code is mostly open source as well.

This is interesting for the following reasons:
<ul>
	<li>This stack represents an ongoing annual investment that ranges in the billions that has been sustained for well over a decade now.</li>
	<li>Any proprietary software stack hoping to keep up would need to match that investment.</li>
	<li>So, Despite the fact that Apple and Microsoft are huge, I don't think either can afford to continue to poor money in their non Linux code base in the same manner that they have been doing. Don't be surprised to see either company make a move towards Linux in the decade ahead.</li>
</ul>
Nokia, my former employer, of course invested hugely in Linux before giving up on it and going against the trend by betting on Microsoft's proprietary software stack just as Linux (in the form of Android) was getting huge traction in the market. Mobile Linux improved enormously partially thanks to Nokia spending huge amounts of money on it. Those improvements directly benefited anybody doing linux based platforms. Including direct competitors such as Android. Essential driver work, kernel optimizations, and work on QT, QML and other technologies were all financed by Nokia and are now part of the open technology stack that it is trying to compete against.

So far, all I've done is talk about what is the situation today. This article promised to be about the future. So here are some predictions:
<ul>
	<li>Hardware &amp; device manufacturing cost for something capable of running Linux well  will decrease from about 100-200$ today to be in the range of 50-75$ in the next few years. Cheap chips, memory, screens, batteries, radios etc. will enable this. The way the chip market works on mobile is that new hardware platforms are targeted at high end devices for a premium price. As the platform ages, production becomes cheaper and more scalable and finds its way into ever cheaper products. The current quad core ARM chips should reach the low end of the market over the course of just a few short years. Today's feature phones run at speeds that were considered high end just three to four years ago.</li>
	<li>The feature phone market (50-150$  devices) that is currently still dominated by proprietary, rather unfashionable software stacks will be flooded with smart phone technology powered by Linux.</li>
	<li>Mobile Linux will grow from having hundreds of millions of users to having billions of users, probably in the next few years already.</li>
	<li>These devices will be connected devices: they will get their updates over the air.</li>
</ul>
But that's just the next few years. If devices are cheap, plentiful, get their software updates over the network, and can access the user's profile data in the cloud, why would you have only one device? The notion of having a device and putting stuff on it is going to be replaced with the notion of connecting to your stuff with whatever device you have in reach.

I'm predicting that what we currently call the smart phone market will transform into a market of connected devices that will sell tens of billions of units (several times the population of this planet).

Products in the current market have some strange limitations that I think will very soon start disappearing. Sim cards for example lock a device to a network. It's a weird authentication solution from the days that networks were about telephony and not about connecting to the internet.

This relates to another limitation: operators. An operator provides services that you mostly don't need and one service you actually do need: internet connectivity. To ensure you actually continue to use those other services there are all sorts of weird constructions that involve numbers of minutes and messages, monopolistic deals with manufacturers to keep certain applications off phones in exchange for contract deals, complex rates for calling to different parts of the world and even more complex schemes for separating people from their cash simply by being mobile. Operators are currently in the business of making it very hard for people to connect their devices to the internet. I've hoped this would change for about a decade and there are signs that things are starting to move here.

On the UI side things are about to get interesting as well. The current market is highly fragmented with a complex, multi dimensional ecosystem of frameworks, manufacturers, screen sizes, tool kits and versions. Only one platform actually works more or less reliably across all of them: html 5. Html 5 is currently somewhat limited and people seem to prefer so'called native apps. Native is a relative term of course. What people really refer to is consistency with overall device look and feel, responsiveness of the application, and fluidity of animations. I think that the current generation of windows phone, qml, and android already show that a combination of javascript, xml, and a well performing engine can pass for native here. There are few technical issues remaining that prevent the browser from being this engine. So, my view on this is that this is a temporary problem that may actually go away as browser technology continues to mature and expand.

Another weird issue is the notion of application packaging and delivery. The logistics around this involve dealing with silo specific application stores, delivering binaries to this store, and orchestrating the distribution to devices in a timely fashion. It's a mess. Web applications on the other hand just run when you need them to without any of that.

The way I see the future is that of a period of it being blocked on chip manufacturers figuring out how to deliver the goods, encumbent vendors figuring out how to adapt (or rolling over to die), operators giving up on hardware sims (and otherwise stepping out of the way), software to mature.

When this eventually happens, it will open up a market of billions of highly compatible Linux running devices that server next gen web based applications to basically the whole world. My guess is we're about three to five years from that moment.

It so happens that building a successful company, which is what I am currently spending my time on, takes a similar amount of time. Hence the above analysis and writeup. I'll leave you to ponder how the above translates into what I should and should not be doing in the next few years.

&nbsp;