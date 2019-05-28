---
id: 1500
title: Mobile Linux
date: 2013-02-18T09:39:57+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/02/18/1447-revision-10/
permalink: /2013/02/18/1447-revision-10/
---
This year, at least four new Linux mobile platforms are going to launch:
<ul>
	<li>Tizen (formerly known as Meego, and a few other names) backed by Intel, Samsung and others.</li>
	<li>Jolla, which is another Meego spinoff by some of the former development team in Nokia.</li>
	<li>Ubuntu recently announced they have a phone OS as well and plan to have phones in the market.</li>
	<li>Mozilla launched their first Firefox OS based a few weeks ago.</li>
</ul>
This is in addition to Bada (Samsung), Android (Google), Web OS (Palm/HP) and a few smaller/deprecated platforms that are already on the market. There are probably quite a few more. Android is of course very successful with a market share that is well above 50% now in the smart phone market.

The point that most people miss when discussing mobile software platforms is that these platforms overlap to an extremely large extent. These are not isolated software stacks. Instead we are talking about a family of software platforms that are largely based on the exact same open source components (kernel, tools, drivers, libraries, application frameworks). The communities around these components overlap and interdepend to such an extent that they are one and the same for all practical purposes.

Platform providers such as Google, Samsung, Jolla, Ubuntu, Mozilla, basically take these components and integrate them with some software of their own making. That software too is open sourced more often than not. Their added value consists primarily of testing, integrating, and packaging all of these components as well as initiating the development of new features and building those. While this constitutes a substantial development effort, in comparison to the open source software that is integrated as is, it is only a small part of the overall software size of the shipped product.

A few things are happing in the industry that are largely predictable and well under way:
<ul>
	<li><span style="line-height: 15px;">Chips are getting faster &amp; cheaper.</span></li>
	<li>Memory is getting faster &amp; cheaper.</li>
	<li>Storage is getting faster &amp; cheaper.</li>
	<li>Networks are getting faster &amp; cheaper.</li>
</ul>
By faster and cheaper, I mean that if you are not happy with the price performance ratio today, chances are that things will be about twice as good in about 2 to 3 years. Or put in even more simple words: a raspberry pi sold for about 35$ last year, runs Linux well, and plays HD video. Similarly specced chipsets should drop well below 10$ in a year or so and will continue to drop in price for the foreseeable future.

The practical implication of the above is very simple: mass market, connected devices will be shipping in the billions to tens of billions (I'm talking volume, not dollars) and they will run whatever software is cheap, capable, and offers the best value for money. There is very little doubt that this software will be Linux. The reasons for this are that it is good enough, is available today for free, and generally the first thing that runs on any new hardware anyway.

The exciting thing is that this is not something that is vaguely predicted to happen somewhere in 2020 or beyond but something that is happening right now and very obviously too. Except you wouldn't know it if you are following what is happening around smart phones.

People are talking about 'minor' features in IOS (maps ;-) ), debating the pros and cons of the people hub in windows phone, vs. email integration in RIM's latest OS. What people are largely ignoring is why these companies are bothering to invest in what is effectively already dead technology, i.e proprietary software such as the windows Kernel, the IOS graphics subsystems, the QNX kernel, etc.

Maintaining these things is very expensive and always has been so. Open source has changed the economics though. It has allowed companies world wide to pool resources for the development of essential but non value adding software. Things like kernels for example. Developing a new operating system is spectacularly expensive and you'll spend most of your budget on replicating features and functionality that competing platforms offer. That means it is essential to do it but won't actually give you much in terms of features that differentiate the new platform.

Mobile Linux solves this problem by providing very good implementations of just about everything you'd need to tick all of the boxes. This software stack represents an ongoing annual investment that ranges in the billions that has been sustained for nearly two decades now and at this point involves most of the software producing industry. In terms of quality, scope, depth etc. it is increasingly hard to match or beat by any independent effort.

It's cheaper than ever to create your own Linux platform. That's why I don't believe Google's Android is going to be the final answer in this space. It is currently very popular but that doesn't guarantee much for the future. Most phones running Android today could easily run any of the competing Linux platforms as well. That means manufacturers have a certain level of freedom.

Right now it suits e.g. Samsung to partner with Google and ship their services and applications

Nokia, my former employer, of course invested hugely in Linux before giving up on it and going against the trend by betting on Microsoft's proprietary software stack just as Linux (in the form of Android) was getting huge traction in the market. Mobile Linux improved enormously thanks to Nokia spending huge amounts of money on it. Those improvements directly benefited anybody doing linux based platforms. Including direct competitors such as Android. Essential driver work, kernel optimizations, and work on QT, QML and other technologies were all financed by Nokia and are now part of the open technology stack that it is trying to compete against. Interestingly, particularly QT/QML is emerging as something that a lot of the new platform vendors embrace.

Why Nokia has given up or whether that was wise is a matter for historians. The reality is that they did and that ultimately it didn't matter for mobile Linux. Mobile linux has survived Palm/HP giving up. Several mobile linux platforms have emerged and disappeared. Particularly Intel seems to be having trouble succeeding with a long succession of failed mobile linux projects (meego being one of them).

From that point of view, mobile Linux seems to be problematic. However, the software moves forward even if individual contributors to it don't fare so well. Collectively, these manufacturers have done work that makes Linux more power efficient, easier to port to different processor architectures, compatible with more different hardware, easier to develop for, and work with, etc.

There has been a tipping point a few years ago: when Android started dominating the industry. The Google specifics to the Android stack definitely helped sell the package. It's a good enough end to end solution that won people and device manufacturers over. However, the permanency of this change lies more in the underlying Linux-iness of the platform. Most of the industry at this point has adopted it and has thrown in the towel when it comes to alternative OS and platform development. There no longer exist compelling economic arguments to even try competing against it.

Rim, Apple, and Microsoft are going against the trend, with varying degrees of success. They might even do well short term. However, the end result is going to be economics catching up with reality: the windows NT kernel, QNX kernel and BSD kernel used by these companies may be incredibly good pieces of software but the reality is that they are adding very little value relative to the free and open source linux at this point. Certainly not enough to justify the millions of dollars that each of these companies is investing to sustain their development. It simply does not translate into something that users care about, or even know about. Certainly Microsoft and Apple can afford to burn cash at rates that others can only dream of but doing so for prolonged periods of time is inevitably going to draw some frowns from investors and share holders.

So, Linux has arrived here to stay. That's interesting by it self but there is another trend which will basically result in the market shares of Apple, Microsoft and other non Linux device software manufacturers to reduce to somewhere in the range of a fraction of a percent of the overall smart device market. Collectively. In just a few short years.

The reason is very simple: hardware prices are dropping fast. The signs are already there. The Raspberry pi runs linux, plays back HD video, and can easily run most common linux software. It costs 35$. It's nothing more than a bunch of chips wired together and small enough to be tucked away in just about any device. In a few years time, this price could drop well below 10$. When that happens there will be tens of billions of these chips and they will run Linux and nothing else. There may continue to be a few tens of millions of high end devices running something else for a while but it won't amount to much in light of the bigger market.

Now the interesting thing to ponder is what this world will do with tens of billions of smart, connected devices. That's several times the entire population of this planet. That means most people will own multiple devices.

Products in the current market have some strange limitations that I think will very soon start disappearing because they are becoming very inconvenient. Sim cards for example lock a single device to a single network. It's a weird authentication solution from the days that networks were about telephony and not about connecting devices to the internet. So clearly, sim cards will have to go.

This relates to another limiting factor: operators. An operator provides services that you mostly don't need and one service you actually do need: internet connectivity. To ensure you actually continue to use those other services there are all sorts of weird constructions that involve numbers of minutes and messages, monopolistic deals with manufacturers to keep certain devices and applications off the market in exchange for contract deals, complex rates for calling to different parts of the world and even more complex schemes for separating people from their cash simply by being mobile and crossing borders. Operators are currently in the business of making it very hard for people to connect their devices to the internet. However, all the money is going to be in connecting these tens of billions of devices. So, clearly, operators will have to change.

On the UI side things are about to get interesting as well. The current market is highly fragmented with a complex ecosystem of frameworks, manufacturers, screen sizes, tool kits and versions. Only one platform actually works more or less reliably across all of them: HTML 5. HTML 5 is currently somewhat limited and people seem to prefer so-called native apps. Native is a relative term of course. What people really refer to is consistency with overall device look and feel, responsiveness of the application, and fluidity of animations. I think that the current generation of windows phone, qml, and android already show that a combination of javascript, xml, and a well performing engine can pass for native here. There are actually very few technical issues remaining that prevent the browser from being this engine. So, my view on this is that this is a temporary problem that may actually go away as browser technology continues to mature and expand. A influx of a few billion new Linux devices that conveniently come with a browser will no doubt speed this up.

Another weird issue is the notion of application packaging and delivery. The logistics around this involve dealing with manufacturer specific application stores, delivering binaries to this store, and orchestrating the distribution to devices in a timely fashion. It's a mess. Web applications on the other hand just run when you need them to without any of that. The whole notion of downloading and installing applications is about to become obsolete because with tens of billions of devices most information services will want to reach most of them rather than just focusing on very specific groups of devices.

The way I see the future is that of a period of it being blocked on chip manufacturers figuring out how to deliver the goods, encumbent vendors figuring out how to adapt (or rolling over to die), operators giving up on hardware sims (and otherwise stepping out of the way), and software to mature.

There's a certain inevitability to the whole thing and when this eventually happens, it will open up a market of billions of highly compatible Linux running devices that serve next gen web based applications to basically the whole world. My guess is we're about three to five years from that moment (or at least its technical feasibility).

It so happens that building a successful company, which is what I am currently spending my time on, takes a similar amount of time. Hence the above analysis and writeup. I'll leave you to ponder how the above translates into what I should and should not be doing in the next few years.