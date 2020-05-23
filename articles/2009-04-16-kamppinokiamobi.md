---
title: kamppi.nokia.mobi
date: 2009-04-16T20:29:54+00:00
author: Jilles van Gurp


permalink: /2009/04/16/kamppinokiamobi/
dsq_thread_id:
  - "336377753"
categories:
  - Blog Posts
tags:
  - Academic
  - createdbyjilles
  - Daniel Wilms
  - Git
  - Jaakko Kyro
  - java
  - nokia
  - Nokia Account
  - openid
  - osgi
  - python
  - webdevelopment
---
I'm rather late with this since it has been more than a month this was news. Busy, moving to Berlin, and other lame excuses. But better late than never. 

You might recall a little [youtube video](http://www.youtube.com/watch?v=cGNYn8YLlpA) I posted back in October of me demoing a prototype at a press event from Nokia. As promised, but slightly later than planned, my colleagues back in Helsinki actually [launched](http://pressbulletinboard.nokia.com/2009/03/04/indoor-services-and-mobile-advertising-trial-started-in-kamppi-shopping-center-in-helsinki/) (press release) the thing in a place in Helsinki called Kamppi. Kamppi is a shopping mall plus bus station in the center of Helsinki. About 100000 people pass through the building every day. Mostly commuters but also shoppers. There's several floors with shops, restaurants, etc. It's an ideal setting for trialing our system and my colleagues worked hard to get the shops in Kamppi on board.

By launching I mean that we opened [kamppi.nokia.mobi](http://kamppi.nokia.mobi), which is a mobile website, for the public. You can visit this with your desktop browser of course but the website is designed to be used from a mobile phone with a mobile browser. A broad range of browsers from different phone vendors is supported but for best results you need of course the latest and greatest from Nokia. You can actually use the website from anywhere in the world though admittedly it is a bit pointless to do so unless you are planning to visit Kamppi or are actually in Kamppi (or on your way to Kamppi).

The site we launched has actually less features then the stuff we demoed in October. The reason for this was a change in focus of the trial and not the technology. The trial is now focused on indoor maps, vouchers, shop pages, and ratings. We found that the other features we demoed in October were nice but also a bit confusing to users. They may be added back later on. But since I no longer work in Helsinki, it isn't up to me. But I put a lot of work in getting this trial going. I helped build and design the software and many of the features and had lots of fun learning Python, Django, and a load of other stuff as well as re-acquainting myself with Apache Lucene, Java, and OSGI.

Some highlights of features I actually worked on/designed:
	
- Implicit profiles. Save vouchers in your account without actually signing in. This is a big benefit because most users will never bother to signup. This was implemented after we implemented both OpenID and Nokia Account. In the end the usability argument won. Nobody asks for your ID when you grab a paper voucher at the entrance. Why should digital vouchers be any different?
- Search. The search server behind the scenes is based on Apache lucene and has custom extensions for indoor location tags, which we use to search through shops, vouchers, ads, etc. Many of the dynamic views have one or more search queries integrated to pull useful info out of the system. And of course there's a search box as well. The website is in Finnish, which I don't speak, and I configured Lucene to do Finnish stemming and tokenizing.
- I didn't build it but one of my former master thesis students, Daniel Wilms, did build the voucher subsystem for us after I sketched the design on a whiteboard. The voucher subsystem was born quite late in the process (a few months before the October demo) just because we could. We had been looking at voucher systems for some time because the use case was interesting and we decided to just go ahead and build it. We had the first working prototype implemented in about two days. The rest of the development was just tweaking the usability.


Additionally me and Jaakko Kyro have lead a team of developers to build this that was always changing, and other stuff, through nearly two years. During this time there were many internal demos, including one to our CEO, and external demos, e.g. at the Internet of Things Conference in 2008.

So, it's really nice that this is finally out. Go and check it out!

