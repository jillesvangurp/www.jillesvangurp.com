---
id: 684
title: Missing the point
date: 2010-02-10T21:44:49+00:00
author: Jilles van Gurp
layout: post
guid: http://www.jillesvangurp.com/?p=684
permalink: /2010/02/10/missing-the-point/
dsq_thread_id:
  - "336378147"
categories:
  - Blog Posts
tags:
  - google
  - Google Buzz
  - RSS
  - So Facebook
  - social networks
  - socialnetwork
  - webdevelopment
---
Like most of you (probably), I've been reading the news around [Google Buzz](http://www.google.com/buzz) with interest. At this point, the regular as clockwork announcements from Google are treated somewhat routinely by the various technology blogs. Google announced foo, competitor bar says this and expert John Doe says that. Bla bla bla, revolutionary, bla bla similar to bla, bla. Etc. You might be tempted to dismiss Buzz as yet another Google service doomed to be ignored by most users. And you'd be right. Except it's easy to forget that most of those announcements actually do have some substance. Sure, there have been a few less than exciting ones lately and not everything Google touches turns into gold but there is some genuinely cool stuff being pushed out into the world from Mountain View on a monthly, if not more frequent, basis.

So this week it's Google Buzz. Personally, I think Buzz won't last. At least not in its current gmail centric form. Focusing on Buzz is missing the point however. It will have a lasting effect similar to what happened with RSS a few years back. The reason is very simple, Google is big enough to cause everybody else to implement their APIs, even if buzz is not going to be a huge success. They showed this with open social, which world + dog now implements, despite it being very unsuccessful in user space. Google wave, same thing so far. The net effect of Buzz and the APIs that come with it will be internet wide endorsement of a new real time notification protocol, [pubsubhubbub](http://code.google.com/p/pubsubhubbub/). In effect this will take twitter (already an implementer) to the next level. Think pubsubhubbub sinks and sources all over the internet and absolutely massive traffic between those sources and sinks. Every little internet site will be able to notify the world of whatever updates it has, every person on the internet will be able to subscribe to such notifications directly, or more importantly, indirectly to whichever other websites choose to consume, funnel and filter those notifications on their behalf. It's so easy to implement that few will resist the temptation to do so. 

Buzz is merely the first large scale consumer of pubsubhub notifications. Friendfeed tried something similar with RSS, was bought by Facebook and successfully eliminated as a Facebook competitor. However, Pubsubhubbub is the one protocol that Facebook won't be able to ignore. For now they seem to stick with their closed everything model. This means there is Facebook and the rest of the world and well guarded boundaries between those. As the rest of the world becomes more interesting in terms of notifications, keeping Facebook isolated as it is today will become harder. Technically, there are no obstacles. The only reason Facebook is isolated is because it chooses to be isolated. Anybody who is not Facebook has a stake in committing to pubsubhubbub to be able to compete with Facebook. So Facebook becoming a consumer of pubsubhubbub type notifications is a matter of time, if only because it will simply be the easiest way for them to syndicate third party notifications (which is their core business). I'd be very surprised if they hadn't got something implemented already. Facebook becoming a source of notifications is a different matter though. The beauty of the whole thing is that the more notifications originate outside of Facebook, the less this will matter. Already some of their status updates are simply syndicated from elsewhere (e.g. mine go through Twitter). Facebook is merely a place people go to see an aggregated view on what their friends do. It is not a major source of information, and ironically the limitations imposed by Facebook make it less competitive as such.

So, those dismissing Buzz for whatever reason are missing the point: it's the APIs stupid! Open APIs, unrestricted syndication and aggregation of notifications, events, status updates, etc. It's been talked about for ages, it's about to happen in the next few months. First thing to catch up will be those little social network sites that almost nobody uses but collectively are used by everybody. Hook them up to buzz, twitter, etc. Result, more detailed event streams popping up outside of Facebook. Eventually people will start hooking up Facebook as well, with or without the help of Facebook. By this time endorsement will seem like a good survival strategy for Facebook. 