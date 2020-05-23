---
title: Google Android
date: 2007-11-12T22:10:04+00:00
author: Jilles van Gurp


permalink: /2007/11/12/google-android/
dsq_thread_id:
  - "336377363"
categories:
  - Blog Posts
tags:
  - eclipse
  - Given Googles
  - google
  - iphone
  - java
  - linux
  - Matthew Schmidt
  - nokia
  - osgi
  - VM
---
**Update: a slightly updated version of this article has been published on the [Javalobby weekly news letter](http://www.javalobby.org/nl/archive/jlnews_20071113o.html) and on the [javalobby site](http://www.javalobby.org/java/forums/t103264.html) itself after Matthew Schmidt invited me to do so.**

**Update 2: The [serverside has linked](http://www.theserverside.com/news/thread.tss?thread_id=47614) here as well. Readers coming from there, the version on Javalobby linked above is the latest and also has some discussion attached.**

About an hour ago, Google released some additional information on the [SDK for Android](http://code.google.com/android/), its new mobile platform. Since I work for Nokia (whom I of course not represent when writing things on my *personal* blog, usual disclaimers apply), I'm naturally interested in new software platforms for mobile phones. Additionally, since I'm a Java developer, I'm particularly interested in this one.

I spent the past half hour glancing through the API documentation, just to see what is there. This does not provide me with enough information for a really detailed review but it does allow me to extract some highlights that in my view will matter enormously for platform adoption:

- The SDK is Java based. No surprise since they announced it but it is nice to see that this doesn't mean they are doing J2ME but instead use Java as the core implementation platform for all applications on the platform.
- The Linux kernel and native libraries are just there to run applications on top of Google's custom JVM Dalvik which is optimized for running on embedded hardware.
- There is no mention of any native applications or the ability to write and install native applications
- ~~Particularly, there's no mention of a browser application. Given Googles involvement in Firefox and their recent announcement of a mobile Firefox, this is somewhat surprising. Browsers are increasingly important for high end phones. Without a good, modern browser, Android is doomed to competing with low end feature phones.~~ Browser seems to be webkit, the same engine that powers the iphone browser and the S60 browser.
- Google has chosen to not implement full Java or any of the ME variants. This in my view very bad and unnecessary.
- Instead a small subset of the Java API is implemented. Probably the closest is the J2ME CDC profile (so why not go all the way and save us developers a few headaches)
- Additionally Google has bundled a few external libraries (httpclient, junit and a few others). That's nice since they are quite good libraries. I'm especially fond of httpclient, which I miss very much when doing J2ME CLDC development.
- The bulk of the library concerns android.* packages that control everything from power management, SMS to user interface.
- I did not spot any OSGi implementation in the package; Google seems to intent to reinvent components and package management. This is disappointing since it is very popular across the Java spectrum, including J2ME where it is already shipping in some products (e.g. Nokia E90).

In my opinion this is all a bit disappointing. Not aligning with an existing profile of Java is a design choice that is regrettable. It makes Android incompatible with everything else out there which is unnecessary in my view. Additionally, Android seems to duplicate a lot of existing functionality from full Java, J2ME and various open source projects. I'm sure that in each case there is some reason for it but the net result seems reinvention of a lot of wheels. Overall, I doubt that Android APIs are significantly faster, more flexible, usable, etc. than what is already out there. 

On the other hand the platform seems to be open so not all is lost. This openness comes however with a few Strings attached. Basically, it relies on Java's security system. You know, the same that is used by operators and phone vendors to completely lock down J2ME to restrict access to interesting features (e.g. making phone calls, installing applications). I'm not saying that Google will do this but they certainly enable operators and phone vendors to do this for them. This is not surprising since in the current market, operators insist on this, especially in the US. The likely result will be that Android application developers will have to deal with locked down phones just like J2ME developers have to deal with that today.

The choice for the Apache 2.0 license is a very wise choice since it is a very liberal license that will make it easy for telecom companies to integrate it with their existing products. Provided that the Android APIs are reasonably well designed, it may be possible to port some or all of it to other platforms. The Apache license ensures that doing so minimizes risk for underlying proprietary platforms. 

Additionally, the apache license also allows for some interesting other things to happen. For example, there's the Apache Harmony project that is still working on a full implementation of Java. Reusing this work might of course also make much of android.* redundant. Additionally, there is a lot of interesting mobile Java code under eclipse's EPL, which is similar to the Apache license. This includes eSWT, a mobile version of the eclipse user interface framework SWT. Eclipse also provides a popular OSGi implementation called equinox. Again, lack of OSGi is a missed opportunity and I don't care what they put in its place.

Frankly, I don't understand why Google intends to ignore the vast amount of existing implementation out there. It seems like a bad case of not invented here to me. Ultimately this will slow adoption. There's already too many Java platforms for the mobile world and this is yet another one. The opportunity was to align with mainstream Java, as Sun is planning to do over the next few years. Instead Google has chosen to reinvent the wheel. We'll just have to see how good a job they did. Luckily, the Apache license will allow people to rip this thing apart and do something more productive with it. OpenMoko + some apache licensed Java code might be nice. Also our Nokia Maemo platform can probably benefit from some components. Especially the lower level stuff they've done with the VM and kernel might be interesting.

