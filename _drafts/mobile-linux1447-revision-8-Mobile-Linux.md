---
id: 1476
title: Mobile Linux
date: 2013-01-20T17:37:31+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/01/20/1447-revision-8/
permalink: /2013/01/20/1447-revision-8/
---
I recently left Nokia to start my own company. Nokia pioneered mobile telephony together with the likes of Ericsson and Motorola and had a huge influence in the market through the last two decades. Nokia was doing great when I joined in late 2005. Market share was soaring to new highs, cool gadgets were launched every few months. In recent years it has been more about iphone and android and Nokia hasn't fared so well. Others have done a great job of writing up what went wrong at Nokia. For example the ever amusing Andrew Orlowski of the The Register has written a <a href="http://www.theregister.co.uk/2010/11/23/symbian_history_part_one_dark_star/">thing</a> or <a href="http://www.theregister.co.uk/2010/11/29/symbian_history_part_two_ui_wars/">two</a> on <a href="http://www.theregister.co.uk/2012/10/11/nokia_meego_inside_story/">this</a> topic.

The recent past of mobile is of course very interesting but this article is about the future and the future is Linux. In the year ahead, at least four new Linux mobile platforms are going to launch:
<ul>
	<li>Tizen (formerly known as Meego/Maemo, and a few other names) backed by Intel, Samsung and others.</li>
	<li>Jolla, which is another Meego spinoff by some of the former development team in Nokia.</li>
	<li>Ubuntu just announced they have a phone OS as well.</li>
	<li>Mozilla is pushing a Firefox based mobile UI</li>
</ul>

This is in addition to Bada (Samsung), Android (Google), Web OS (Palm/HP) and a few smaller/deprecated platforms that are already on the market. There are probably quite a few more. Android particularly is of course very successful with a market share that is well above 50% now in the smart phone market.

The point that most people miss when discussing mobile software platforms is that these platforms overlap to an extremely large extent. These are not isolated software stacks. Instead we are talking about a family of software platforms that are largely based on the exact same open source components (kernel, tools, drivers, libraries, application frameworks. The communities around these projects overlap to a very large extent and the vendor specific added value is increasingly limited to UI spit shine, tooling, and packaging. 

Most people don't realize the size of software stacks and the economic cost related to producing it. Debian linux (kernel, thousands of packages) weighs in at about <a href="http://en.wikipedia.org/wiki/Source_lines_of_code">330 MLOC</a> (millions lines of code). The linux kernel makes up about 16MLOC. So, relative to the code the above platforms share, the code that actually differentiates them makes up only a small percentage. And that code is mostly open source as well. 

This is interesting for the following reasons:
<ul>
	<li>This stack represents an ongoing annual investment that ranges in the billions that has been sustained for well over a decade now and involves most of the software producing industry.</li>
	<li>In terms of quality, scope, depth etc. it is increasingly hard to match or beat. Any proprietary software stack hoping to keep up would need to match that investment. Whether it's IOS, Windows Phone/RT, QNX (RIM), or something else, justifying the investment related to keeping a platform alive is increasingly hard to defend in light of the freely available alternative.</li>
	<li>So, Despite the fact that Apple and Microsoft are huge, I don't believe either can afford to continue to poor money in their non Linux code base in the same manner that they have been doing for much longer. Don't be surprised to see either company make a move towards Linux in the decade ahead.</li>
</ul>
Nokia, my former employer, of course invested hugely in Linux before giving up on it and going against the trend by betting on Microsoft's proprietary software stack just as Linux (in the form of Android) was getting huge traction in the market. Mobile Linux improved enormously partially thanks to Nokia spending huge amounts of money on it. Those improvements directly benefited anybody doing linux based platforms. Including direct competitors such as Android. Essential driver work, kernel optimizations, and work on QT, QML and other technologies were all financed by Nokia and are now part of the open technology stack that it is trying to compete against. Interestingly, QT/QML is emerging as something that a lot of platform vendors embrace. Nokia was on the right track there apparently. 

Why they have given up or whether that was wise is a matter for historians. The reality is that they did and that ultimately it didn't matter for mobile Linux. Mobile linux has survived Palm/HP giving up. Several mobile linux platforms have emerged and disappeared. Particularly Intel seems to be having trouble succeeding. From that point of view, mobile Linux seems to be problematic. However, the software moves forward even if individual contributors to it didn't fare so well. Collectively, these manufacturers have done work that makes Linux more power efficient, easier to port to different ARM architectures, compatible with more different hardware, easier to distribute, develop, and work with, etc.

There has been a tipping point recently when Android started dominating the industry changed permanently. The Google specifics to the Android stack definitely helped sell the package. It's a good enough end to end solution that it won people over. The permanency of this change lies more in the underlying Linux-iness of the platform. Most of the industry at this point has adopted and has thrown in the towel when it comes to OS and platform development. Linux is the starting point of any sensible effort here. There no longer exist compelling economic arguments to even try competing against it. Rim, Apple, and Microsoft are bucking the trend, with varying degrees of success. They might even do well short term. However, I don't see any of them still pushing proprietary non Linux based platforms in five to ten years. It just doesn't make any sense whatsoever.

So far, all I've done is talk about what is the situation today. This article promised to be about the future. So here are some predictions:
<ul>
	<li>Hardware &amp; device manufacturing cost for something capable of running Linux well  will decrease from about 100-200$ today to be in the range of 20-50$ in the next few years. This is an easy prediction since the<a href="http://www.raspberrypi.org/"> Raspberry Pi</a> already sells at that price. However you might argue it's not complete product. Cheap chips, memory, screens, batteries, radios etc. will enable this. The way the chip market works on mobile is that new hardware platforms are targeted at high end devices for a premium price. As the platform ages, production becomes cheaper and more scalable and finds its way into ever cheaper products. The current quad core ARM chips should reach the low end of the market over the course of just a few short years. Today's feature phones run at speeds that were considered high end just three to four years ago.</li>
	<li>The feature phone market (50-150$  devices) that is currently still dominated by proprietary, rather unfashionable software stacks will be flooded with smart phone technology powered by Linux. Given the above, this is now a near certainty. It's just a matter of when.</li>
	<li>Mobile Linux will grow from having hundreds of millions of users to having billions of users, probably in the next few years already. There are billions of phone users today. It is inevitable that they will replace their devices with better ones. They will run Linux mostly.</li>
	<li>These devices will be connected devices: they will get their updates over the air. This is the real disruption.</li>
</ul>
But that's just the next few years. If devices are cheap, plentiful, get their software updates over the network, and can access the user's profile data in the cloud, why would you have only one device? The notion of having a device and putting stuff on it is going to be replaced with the notion of connecting to your stuff with whatever device you have in reach.

What we currently call the smart phone market will transform into a market of connected devices that will sell tens of billions of units (several times the population of this planet). T

Products in the current market have some strange limitations that I think will very soon start disappearing. Sim cards for example lock a device to a network. It's a weird authentication solution from the days that networks were about telephony and not about connecting to the internet.

This relates to another limitation: operators. An operator provides services that you mostly don't need and one service you actually do need: internet connectivity. To ensure you actually continue to use those other services there are all sorts of weird constructions that involve numbers of minutes and messages, monopolistic deals with manufacturers to keep certain applications off phones in exchange for contract deals, complex rates for calling to different parts of the world and even more complex schemes for separating people from their cash simply by being mobile. Operators are currently in the business of making it very hard for people to connect their devices to the internet. I've hoped this would change for about a decade and there are signs that things are starting to move here.

On the UI side things are about to get interesting as well. The current market is highly fragmented with a complex, multi dimensional ecosystem of frameworks, manufacturers, screen sizes, tool kits and versions. Only one platform actually works more or less reliably across all of them: html 5. Html 5 is currently somewhat limited and people seem to prefer so'called native apps. Native is a relative term of course. What people really refer to is consistency with overall device look and feel, responsiveness of the application, and fluidity of animations. I think that the current generation of windows phone, qml, and android already show that a combination of javascript, xml, and a well performing engine can pass for native here. There are few technical issues remaining that prevent the browser from being this engine. So, my view on this is that this is a temporary problem that may actually go away as browser technology continues to mature and expand.

Another weird issue is the notion of application packaging and delivery. The logistics around this involve dealing with silo specific application stores, delivering binaries to this store, and orchestrating the distribution to devices in a timely fashion. It's a mess. Web applications on the other hand just run when you need them to without any of that.

The way I see the future is that of a period of it being blocked on chip manufacturers figuring out how to deliver the goods, encumbent vendors figuring out how to adapt (or rolling over to die), operators giving up on hardware sims (and otherwise stepping out of the way), software to mature.

When this eventually happens, it will open up a market of billions of highly compatible Linux running devices that server next gen web based applications to basically the whole world. My guess is we're about three to five years from that moment.

It so happens that building a successful company, which is what I am currently spending my time on, takes a similar amount of time. Hence the above analysis and writeup. I'll leave you to ponder how the above translates into what I should and should not be doing in the next few years.

&nbsp;