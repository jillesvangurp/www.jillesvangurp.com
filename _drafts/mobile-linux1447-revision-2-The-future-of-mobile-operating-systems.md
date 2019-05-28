---
id: 1456
title: The future of mobile operating systems
date: 2013-01-05T16:45:03+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/01/05/1447-revision-2/
permalink: /2013/01/05/1447-revision-2/
---
I recently left Nokia. Nokia is a great company. They pioneered mobile telephony together with the likes of Ericsson and Motorola and had a huge influence in the market through the last two decades.  Nokia was doing great when I joined in late 2005. Market share was soaring to new highs, cool gadgets were launched every few months. Then something happened that has been written a lot about. First the iphone launched and roughly a year later Google unleashed Android. I'm not going to rehash that. That's the past of mobile. This article is about the future and the future is Linux.

In the year ahead, three new Linux mobile platforms are going to launch:
<ul>
	<li>Tizen (formerly known as Meego, Maemo, and a few other names) backed by Intel, Samsung and others.</li>
	<li>Jolla, which is a spinoff of Maemo by some of its former development team in Nokia.</li>
	<li>Ubuntu just announced they have a phone OS as well.</li>
</ul>
This is in addition to Bada (Samsung), Android (Google), Web OS (Palm/HP) and a few smaller platforms. Android particularly is very successful with a market share that is well above 50% now.

The point that most people miss is that these platforms overlap to a very large extent. These are not isolated software stacks. Instead we are talking about a family of platforms that are largely based on the same open source components.

This is significant. The reason that a small Finnish start up (Jolla) can launch a new mobile platform that (from the looks of it) is competitive with software stacks pushed by the likes of Samsung, Google, and Microsoft is that the cost for launching a new mobile platform is lower than ever. It's low enough that a small startup can do it within a year of being founded.

That is deeply disruptive and it means a bunch of things:
<ul>
	<li>Any proprietary software stack, regardless of current success or market share, will have to match (dollar for dollar, development hour for hour, feature for feature) the collective and cumulative investment that is happening in the Linux world. Or put differently: hundreds of companies are collaborating on Linux and a huge stack of associated software. This stack represents an ongoing annual investment that ranges in the billions that has been sustained for well over a decade now.</li>
	<li>If you are not matching that investment with similar investments in your own stack, you are effectively falling behind very rapidly. Most non Linux based platforms are either becoming niche platforms or are backed by Microsoft and Apple, the two largest companies in this business that invest billions and can apparently afford to continue to do this.</li>
	<li>IOS and Windows Phone are both very nice platforms. But they are built on a foundation that is largely not technically superior in any way when compared to the free and open source Linux stacks out there. Maintaining and continuing to develop that foundation represents an enormous commitment and investment that is unlikely to provide any substantial differentiation relative to Linux. Worse, it will largely have to be financed out of margins on products that are competing with similar products from other manufacturers that don't have this burden.</li>
	<li>Apple enjoys huge margins and a large (but declining) market share. Their software stack is partially open source. I think there is a good chance they will survive. But I wouldn't be surprised if they at some point swapped out their BSD kernel for a Linux kernel. They have a history of bold moves like that (e.g. switching from Motorola to Intel) and it would make sense from a cost perspective .</li>
	<li>Microsoft has a very small market share with Windows Phone, margins that are not that great, and a dependency on third party device manufacturers that are comparing the license cost of Windows Phone with that of Jolla, Ubuntu, and Android. Do I need to spell it out? There is no way that they are going to win this. But this being Microsoft, it might take a few billion for them to figure that out.</li>
	<li>Every Linux based device on the market today benefits from the many code contributions made by Nokia just a few years ago while it was investing (heavily) in Meego and Maemo. Nokia's contributions include driver work, kernel optimizations, adaptations to embed mobile phone stacks, and of course QT and QML. A big "Thank you Nokia!" would be appropriate for the likes of Ubuntu, Google, Samsung and those countless others that are actively benefiting from Nokia's investments. Unfortunately, the OSS nature of the whole thing makes any more substantial form of a thank you unlikely.</li>
	<li>This has of course some implications for my former employer that basically went from being a major Linux contributor (they ranked up there with the likes of IBM and Red Hat when it comes to kernel contributions) to betting the company on Microsoft's proprietary software stack right at the moment that Linux based mobile platforms were starting to dominate the market. An odd decision to say the least.</li>
	<li>Nokia's primary competition today consists almost exclusively of products running platforms with roots back to the very year it chose to back Symbian instead of Linux. Abandoning Meego, indeed marks the second occasion where Nokia made the wrong choice regarding a choice between Linux or something proprietary: the Symbian foundation was founded in the same year that IBM poured 1 billion $ in Linux: 1999. Also, several embedded device manufacturers were shipping Linux based products in that year. Now you might wonder if that is valid since those were different times. However, Both Google and Apple got serious about a mobile platform around 2004/2005. Android was purchased by Google in 2005 after being founded around 2003. Apple figured out around the same time that OS X (launched in 2000) could scale down to mobile levels. The difference between now and then is that it is a glaringly obvious reality today whereas at the time it was merely a possibility that required vision and lots of investments. Nokia had the means but lacked the vision.</li>
	<li>Android as we know it today (a Google branded, Java based UI) may or may not survive. Given that it is open source and linux based, the technical distinction with other Linux based platforms is somewhat blurry to begin with in any case. Android applications are supported on Google's platform, but also on Jolla. Apparently RIM has made them work on their platform (QNX) as well. Ubuntu already is compatible with Android to the extent that it can boot using the Android kernel. Android applications run fine in Linux, Apple, and Windows based development environments with a generic virtual machine (Java) and Google's development tooling. The point here is that Android as a mobile platform is a non entity. It's a Java based application framework that can run pretty much anywhere with very little effort. The kernel, associated drivers, libraries and tools is more appropriately referred to as Linux.</li>
</ul>
So far, all I've done is talk about what is the situation today. This article promised to be about the future. So here are some predictions:
<ul>
	<li>Hardware &amp; device manufacturing cost for something capable of running Linux  will decline from about 100-200$ today to be in the range of well below 50$ in the next few years. Cheap chips, memory, screens, batteries, radios etc. will enable this.</li>
	<li>This means that the feature phone market (50-150$  devices) that is currently dominated by proprietary software stacks (Nokia S30 &amp; S40, Blackberry, Samsung, etc.) will be flooded with smart phone technology powered by Linux.</li>
	<li>This means mobile Linux will grow from having hundreds of millions of users to having billions of users, probably in the next two years.</li>
	<li>Those billions of networked devices will be connected to the internet and update over the air.</li>
	<li>The net result is billions of devices that are running a very homogeneous software ecosystem that can be kept up to date over the air.</li>
	<li>That's a huge ecosystem compared to the walled gardens full of boring fart applications, disgruntled poultry tossing games, and other crap ware. The last time we had something remotely similar, Bill Gates became the world's richest person in a few short years. This ecosystem will be magnitudes larger.</li>
</ul>
But that's just the next few years. If devices are cheap, plentiful, get their software updates over the network and can access the user's profile data in the cloud, why would you have only one device? Imagine your phone, tablet, laptop, camera, car, tv, ipod, etc. were all connected. Would you still want to have a smart phone that tries to compete with all these?

I think not. Products in the current market have some strange limitations that I think will very soon start disappearing. Sim cards for example lock a device to a network. It's a weird authentication solution from the days that networks were about telephony and not about connecting to the internet.

This relates to another limitation: operators. An operator provides services that you mostly don't need and one service you actually do need: internet connectivity. To ensure you actually continue to use those other services there are all sorts of weird constructions that involve numbers of minutes and messages, complex rates for calling to different parts of the world and even more complex schemes for separating people from their cash simply by being mobile. Operators are currently in the business of making it very hard for people to connect their devices to the internet. That doesn't sound like a growth market to me.

I don't need a phone. I have access to Skype, Facebook, Google Plus and several other services that are both cheaper and more convenient to use, provided I have some form of usable internet.

&nbsp;

&nbsp;