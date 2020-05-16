---
id: 1609
title: De-globalization or why local matters
date: 2013-10-07T18:44:43+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1609
permalink: /2013/10/07/de-globalization-or-why-local-matters/
categories:
  - Blog Posts
tags:
  - Alexander Platz
  - Axel Spring
  - Axel Springer
  - berlin
  - EU
  - Europe
  - traveling
---
Over the weekend we built a local news app at the [Mediahackday](http://www.mediahackday.com/) in Berlin. The purpose of this event was to find new ways to utilize the back catalogs of media companies such as the Guardian, Axel Springer, and others. This use-case is a perfect fit for the Localstream platform that I have been involved with over the past year. So, we went in and did our thing. My colleague Mark MacMahon wrote up a [nice article about this](http://localstream.tumblr.com/post/63311958222/localstream-at-mediahackday) on our Tumblr blog.

One of the things that struck me again while focusing on this particular use-case over the weekend is a phenomenon that has been bouncing around in my head for a while. For lack of a better word, I'd like to call it de-globalization. 

As an example of this, consider this advertisement that I spotted in the subway on my way to the Mediahackday venue:

[<img src="http://farm4.staticflickr.com/3744/10135676035_a447a80312_c.jpg" width="800" height="686" alt="Location based advertising. Very much an offline thing still.">](http://www.flickr.com/photos/jillesvangurp/10135676035/)

This is an advertisement that promotes the existence of a mobile application. [Alexa](http://www.alexacentre.com/) is a shopping mall in Berlin (near Alexander Platz) and apparently they thought it a good investment to spend money on the development of a mobile application for the people in their mall. Then to tell these people about the existence of this application, they invested in a (presumably) expensive advertising campaign as well. This is location based advertising in the wild. Big money is spent on it and it is mostly an offline business. 

In fact most of the economic activity world wide is driven by locals engaging with small and medium enterprises locally. Despite globalization and mega corporations, there is an enormous long tail of very small companies and it is growing. The EU [states](http://www.eurochambres.eu/content/Default.asp?PageID=63) that:

<blockquote>Small and medium-sized enterprises (SMEs) are the main drivers of job creation, economic growth and social cohesion in Europe. They have local roots, provide local jobs but also exploit the benefits of globalisation. SMEs indeed constitute the dominant category of business organisation in all EU countries with some 23 million enterprises (99.8%); their share in total employment creation is massive (81.6%) as well as their contribution to the EU-GDP (up to 60%).</blockquote>

Alexa is spending what must be a sizable budget for them on bespoke mobile app development and offline advertising for the resulting app. That strikes me as a particularly expensive and ineffective way of promoting themselves. Despite ongoing globalization, massive growth in online channels, and widespread adoption of internet, Alexa is forced to go offline to address their audience: Berlin locals. And just like other locals, they are finding it difficult.

The reason for this is that existing online channels for the likes of Alexa to promote themselves in or for people to discover Alexa's mobile application, and other content lack a local focus. Where do people living near the Alexa mall go to learn about what is happening around them? There's no such thing.

People in the industry have been talking about location based services and associated revenue streams for ages. But one glance at the advertisement above makes it very clear that despite this, local is still very much an offline business for most of the locals. This applies to commerce but also to other things. What is happening around my house, on my street, in my neighborhood and in my city? Who is writing about my area and what are they saying about it? What events are on and what cool historical facts can I find out about my area? The online answer today involves search engines and a lot of hard work filtering through blogs, wikipedia, event sites, social media, location based services, etc. <em>Because that is so impractical, nobody bothers</em> and consequently Alexa has to spend big money on subway advertising just to tell people that there is an app that they are very excited about.

At [Localstream](http://localstre.am) we want to change this and enable locals go online to engage with each other locally to share news, knowledge, and other information about their area. Through the Localstream platform, we can filter content by location and provide a view of the available content specific to **where</strong> it is about as opposed to <strong>what</strong> it is about (search engines) or <strong>whom** it is about (social networks).

Localstream de-globalizes the internet. The internet is full of location relevant information ranging from venue specific applications such as the Alexa app above, local news about the area, historical facts, events, etc. However, the existing channels for this content rely on people stumbling upon this content in search engines or social media. With Localstream, you can stumble upon it by location. 

At Mediahackday we specialized our concept for news and tried to turn the back catalogs of news organizations such as the Guardian and Axel Springer into a location browsable channel. While we definitely still have some challenges with respect to our ability to tag the content correctly and rank accordingly, the raw value of this was immediately obvious when we started browsing the news content about Berlin. 

Living in Berlin I of course entered my street name (Bergstrasse) as a search criteria:

[![Screen Shot 2013-10-07 at 18.34.41](https://www.jillesvangurp.com/wp-content/uploads/2013/10/Screen-Shot-2013-10-07-at-18.34.41.png)](https://www.jillesvangurp.com/wp-content/uploads/2013/10/Screen-Shot-2013-10-07-at-18.34.41.png)

As you can see here, Localstream found some news content that isn't about my street but does mention nearby streets and venues. For example, Tucholskystrasse and Ackerstrasse, which are both near my street (first hit). So, despite the fact that none of these articles were marked up with coordinates, Localstream is able to recognize the street name and deduce that articles that mention a nearby streets are relevant to my location. 

Now bearing in mind that we hadn't seen the content before and that our location graph, ranking and location tagging are very much works in progress, this is a pretty good result. We were able to ingest content we hadn't seen before that lacked any structural location information and turn it in a location browsable news application in under 24 hours. We believe we are just scratching the surface here in terms of what is possible.

