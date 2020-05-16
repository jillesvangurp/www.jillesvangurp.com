---
id: 1548
title: Windows Phone and Nokia
date: 2013-05-09T10:20:53+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1548
permalink: /2013/05/09/windows-phone-and-nokia/
categories:
  - Blog Posts
tags:
  - nokia
  - OSS
  - QT
  - Windows Phone
---
I just posted a comment to <a href="http://www.zdnet.com/nokia-investors-patience-wearing-thin-ceo-says-windows-phone-to-the-bitter-end-no-plan-b-7000015011/">this article</a> about Nokia shareholders getting impatient with the current CEO, Stephen Elop. It's a quite long comment and people might overlook it in what seems to be a long thread already. So I decided to post it here as well. Part of the text reuses some arguments I <a href="http://www.jillesvangurp.com/2013/03/29/mobile-linux/">posted earlier</a>.


So here it goes ...
<!--more-->

I'm an ex Nokia employee and I'm about to state some very harsh things about my former employer. 

At the time I recognized abandonment of the Symbian platform as a good thing. It had been a sinking ship for a long time, which was recognized inside and outside the company. Not withstanding a loyal fanbase, most Symbian products were pretty much loathed universally by reviewers and that reflected in spectacular decreases in market share that had already lead Nokia to conclude that it needed Meego, the Linux based platform that it had been developing for years. Efforts to fix Symbian had been ongoing for some years as well and it was very clear that it was not going to be anywhere near competitive any time soon. Killing it was a foregone conclusion and Nokia was paralyzed over implementing that decision with large parts of the company continuing to pretend Symbian had a future and actively frustrating Meego R&D with political games. Elop was hired to fix that and he moved quickly to push out some of the key players. 

So, abandoning Symbian was a good thing and swiftly killing the political struggles around that even better. Dismantling the insanely expensive R&D organization around Symbian was a necessary evil and tens of thousands of people were affected. Symbian was going nowhere and it stopped being competitive long before Elop showed up. Elop did a great job cutting what was an unsustainable R&D budget that was was based on an assumption of Nokia enjoying 60+% market shares in the smartphone market (as it did in 2008) . It had to be done.

The real controversy is this: Meego and Android share an extremely large part of their code base. You might even argue that Android's success was accelerated by no small amount by Nokia contributions to the Linux kernel and other OSS components that both platforms share (drivers, key power usage and performance optimizations, etc.). Nokia was one of the top corporate contributors to the Linux kernel and Meego was in an advanced stage of development at the time Elop joined with products ready to ship. Nokia had a large R&D effort with a lot of influence in key OSS components (kernel, QT, etc.). 

The decision to dismantle that organization in favor of Windows Phone was in retrospect probably the largest corporate blunder in recent history. With a single blow they wiped out the only credible opposition to Android (other than IOS) in favor of an unproven Microsoft strategy after effectively bank rolling their competitors (i.e. anybody shipping anything mobile Linux today) R&D budget for about half a decade.

Plan B was repurposing Meego as an S40 (which as others have pointed out is NOT Symbian) replacement for low end devices. Samsung and others have picked up most of the OSS pieces of Meego and are trying to do the exact same thing right now. Sailfish, Tizen, Mobile Ubuntu, Firefox OS are all based on the same strategy: make Linux run on cheap mass market devices. 

Killing that was the second blunder. Again Nokia bankrolled the competition. QT is currently the darling of several of the before mentioned platforms. Nokia owned that platform and let it go in favor of investing in the S40 strategy. Meanwhile S40 is now struggling and I don't see how it will survive long term. It is being displaced by the very software that Nokia abandoned. 

At the time of the Meego announcements, the reasoning was that scaling Meego business would take another two years. Those two years have now passed and it is now clear that Nokia overestimated how soon it could ramp up Windows Phone business, underestimated how much quicker Symbian would decline. They could have easily matched Windows Phone's current market share with Meego. 

So the question that begs answering is what would have happened if they'd adjusted their Meego strategy instead. People think of Android as a separate platform. It's not. <a href="http://www.jillesvangurp.com/2013/03/29/mobile-linux/">It's mobile Linux</a>. Just like Meego. 

Throughout Meego and Maemo's history, Nokia devices for those platforms have been able to run Android and other mobile Linux variants. Early Maemo devices were sort of the darling of developers for the simple reason that they were 100% compatible with Linux already and could trivially be repurposed to run just about anything, unlike pretty much everything else in the market. I ran Nitdroid (the Android port for Maemo phones) on an N800. This was in 2008 when Android devices were barely starting to ship. Probably the N800 was the first device on the market that you could actually run Android on even. Basically, as soon as Google published the source code people were running it on their Maemo devices. So, there is no question about Nokia being able to run Android on its existing devices at any time if it had chosen to do so. All the hard work for that had already been done.

Sailfish, which is run by some the former Meego R&D team and is effectively a Meego spinoff runs Android applications just fine: all Android is is a virtual machine that runs on just about any Desktop OS. Running on Android applications is a business decision, not a technical decision. I'm pretty sure it would take very little effort for Microsoft to make Android applications run on Windows Phone even. The reasons this is not happening are entirely non technical.

So, not only could Nokia have shipped Meego devices on very short notice (which they did BTW, the N9 shipped after they announced killing Meego): they could have also easily integrated support for running Android applications. The Meego UI was well received but what killed it was Nokia actively frustrating support for the device, killing the market budget and rebranding it as a developer phone. That was sort of the last act of the Symbian camp in Nokia and it was designed to keep the Symbian business on life support. That obviously failed miserably and most of the subsequent Symbian devices were pretty much a futile effort and Elop put a stop to that pretty quickly.

Now in light of all this, should Nokia change course now? The answer is surprisingly: no. The reason is simple: it would kill the company before they'd have any chance whatsoever to ramp up market share. All the Linux R&D staff is gone and it would take time to get that back in place. They'd be able to launch a generic Android phone and undercut Samsung in price. But that would put them in the same boat as other manufacturers: low margins, low market share, no differentiation. Typical Nokia added value such as maps and navigation, pureview, etc. would all have to be ported. A Nokia specific Android skin would take time and would have an uncertain outcome. The R&D staff needed for this is mostly gone and in any case it would take years. It took years for Windows Phone as well. The pureview project predates Elop's arrival at the company and it still hasn't shipped in its full 41 megapixel glory for Windows Phone. That's the reality of product development: these things take a lot of time. Pureview is a real game changer by the way. Samsung has nothing in the pipeline that comes close.

So, that's why Elop has no other choice than to try to push out more and better Windows Phone devices. The reason investors are disgruntled is that that Elop's sales pitch two years ago promised a lot of things that have not been delivered. Additionally, anyone can observe that others are being very successful currently with the exact same Linux assets that Elop chose to kill. He's talked a lot about accountability and he is 100% accountable for that.

Unfortunately there are no quick fixes. An affordable 41 Megapixel Windows Phone based device, mass marketed to consumers world wide might actually start impacting Samsung's success in the market. My current understanding is that that is exactly the plan. Whether Elop is the right man for that job is up for debate. Personally, I don't believe changing leadership is going to vastly change Nokia's chances.

I have a Nexus 4 currently. It's fine and I prefer it over the Samsung craptastic UI. Clearly Samsung and Nokia are in the same boat when it comes to UI and usability: they are better off leaving that to others. Microsoft actually did a decent job of Windows Phone. I believe it's current lack of success has a lot more to do with Microsoft's apparent internal struggles and less with Samsung's ability to develop good software. That's a fixable problem.  Unfortunately, Nokia is now dependent on Microsoft to fix that problem and they no longer control their own destiny. Just like people predicted. 