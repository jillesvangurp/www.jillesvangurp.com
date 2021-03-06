---
title: Localstream demo at Wherecamp
date: 2013-06-15T16:07:20+00:00
author: Jilles van Gurp


permalink: /2013/06/15/localstream-demo-at-wherecamp/
categories:
  - Blog Posts
tags:
  - API
  - GPS
  - Localstream Content
  - UI
  - URL
---
I was at the first Berlin version of [Wherecamp](http://wherecamp.de/) two years ago and it was great fun. So, when I learned it was in Berlin again this summer, the choice of going there was easy. Last time, I was a passive consumer of information. This time, me and my co-founder [Mark MacMahon](https://twitter.com/markmacmahon) will be there to **launch and promote the private beta for [Localstream](http://localstre.am)**.



**What is Localstream?**

A lot of our Twitter followers, Facebook friends, LinkedIn connections, Google Plus circle members, and indeed real people might be wondering what we are up to with [Localstream](http://localstre.am). In this article I want to outline some of the key concepts we have implemented and will be demoing next week.

Localstream can be a lot of things to different people.

- For end users it is a **location-based content sharing and discovery** platform that allows them to share information about locations. You can share youtube videos, souncloud clips, blog articles, news, or simply type some text.
- For content publishers it is that but also a platform with which they can **push and promote their own content about a location**. Doing so makes it easier for people to find their content.
- For developers it is an **API** that they can use to easily **add location relevant content** to their applications or **publish their own content to Localstream**. The Localstream platform is ideally suited for quickly building pretty much any type of location-based application.

**Why are we building Localstream?**

A lot of location-based services exist already and even more are under development in numerous start-ups around the world. Location based services are great and we love using them. They allow us to share photos, tweet, read restaurant reviews, navigate our cars, find out cool stuff about the world around us, check in, find deals, etc.

However, they share one problem: they are hopelessly siloed and fragmented! To share photos you have to go here, to read reviews there, and to navigate to the restaurant yet another app, which is of course not the same app you use to check-in, and deals are locked up in yet another application.

The location-based web is broken up into silos that mostly don't connect with each other and that severely restrict usage to the very simple use cases they were designed for. The web is not meant to be different silos, it's meant to be an open, flourishing ecosystem of content, people, and services. The location-based web today is not open, has yet to flourish, and adding more silos is not going to fix it.

Knowing about all these silos and finding the content locked away in them poses a hard problem for many users. This pretty much limits them to a small group of users who have fancy phones, are clued in about technology, and frequently install new applications. But even that small group of users has issues that relate to different people using different sets of apps and certain apps only being available on certain phones (*cough* iphone *cough*), regional unavailability of certain apps. The chances of all these things needed to make a location based service successful lining up in the real world are pretty slim and that's why many location-based services are struggling.

The silo mentality is what is holding location-based services back. It prevents people from exploring the location-based web in the way they can explore the real web: by clicking on links.

We want to fix this problem. Localstream will be open. It will be web-based. It  will be something that people can take and adapt to their needs. It will enable location-based services to open up and enable people to find them, their content, and discover their value. We want to unlock the current web, which is full of location relevant content, including the before mentioned silos, and transform it into a location-based web.

**What does that mean technically?**

The more technical explanation of what we do is that we take web content (anything with a URL) and associate it with a location (another URL) in the location graph, provide a search API that allows you to find location relevant content, a platform API that allows you to add content, tooling that crawls the web to add content from existing pages, and a web-based application that uses the Localstream APIs that allows you to share and explore content in the Localstream platform.

**The location graph**

The core concept in Localstream is the location graph. Graphs have nodes and relations between those nodes. In Localstream, the nodes are locations: things that have a name, a URL, geospatial information (optional), and other meta data; and locations are connected by their relations to each other.

A simple example of a relation between two location nodes is the containment relation. The world consists of continents, countries, cities, neighborhoods, venues, streets, parks,  etc. If you go inside buildings, you might find rooms, shops, floors, cupboards, shelves, etc. All these things are locations. While Localstream is not focused on supporting indoor yet, doing so would be a logical extension of the platform and is indeed something we may do at some point in time. Also, there is nothing in the API stopping us from doing that and the few people familiar with my[ earlier work on indoor location based](https://www.jillesvangurp.com/static/pervasivemag.pdf) services may indeed notice some conceptual overlap with the way that worked.

Other relations are possible as well. For example, metro stations are connected by rail. Some cities have sister cities. Locations neighbor each other or are part of a group of locations, etc. Currently, containment and neighbor relations are the primary focus in Localstream and we are focused on providing world coverage for this. Once we have tackled this, we plan to enrich the graph with more relations.

For some locations, we have detailed geospatial information. For other locations, all we know are their relations to other locations. In fact there are many more locations in the real world than have been documented in any database. **Localstream can support anything that might legitimately be referred to as a location** regardless of whether the GPS coordinates are known, specified, or even correct.

Since Localstream is a web platform, locations are HTTP resources with a unique URL and relations are represented using links. Others have already built great place databases and many of those offer APIs that allow you to refer to these places using a link. Localstream  supports these links. So, any Foursquare, Facebook, Yelp, or Google place can be part of the Localstream Location graph. Additionally there exist open data sets such as Open Street Maps, Yahoo Geoplanet, Geonames, and other dataset that provide place information. Localstream maintains an internal location graph based on such open data and links to selected venues from external services. When needed, Localstream uses external APIs to fetch metadata for external location references.

**Publishing content to the location graph**

Publishing content in Localstream is very straightforward:

- Select a location
- Share something.

Selecting a location is different from simply telling us the GPS coordinates. Instead we want to know the URL of the location node in our location graph that best matches the content you are sharing. Selecting locations is easy with the Localstream UI, which allows you to explore the location graph. By default, we use your GPS coordinates to find the nearest node in our graph. From there you can either navigate through the graph by clicking related locations or use the search box to find something else.

Once you have selected the right location, you can simply paste a link to something you want to share or enter some text. We automatically reach out to get meta data for the links you share. And, of course you can share what you publish on Localstream with other sharing platforms or linking to it from your own blog or web site.

**Exploring the Localstream Content**

Exploring content is just as easy. You simply select a location and we show you the content most relevant to what you have selected. That content has links for the locations it is about, hash tags, and the source of the content that you can click to explore.

We automatically rank content based on the location graph and based on what you click. Things directly attached to your selected location are the most relevant but we also show content that is connected to related nodes in the graph. So, you can start from your current location and end up exploring your neighborhood, your city, or jump to somewhere you've been, want to go, or used to live.

**The Localstream API**

Anything you can do with the UI, our API supports as well:

- You can explore the location graph
- Find the most appropriate location node for a GPS coordinate
- Get a feed of content for a particular combination of locations and tags
- Publish content to a location

The API will not be part of our private beta. We are currently eating our own dog food by building the Localstream UI using our own API. However, if you are interested in using our API, learning more about it, or partnering with us, get in touch with us directly. We plan to have the API ready for action by Q3 this year and are in fact looking for cool projects to pilot our API with.

**What's next?**

We are currently very busy rolling out the private beta to production and fixing bugs. The goal of the private beta is gathering feedback. This will enable us to improve the service and plan our next moves. Very soon we will start sending invitations and we will allow people to play with the UI and share some content. Over the summer we plan to improve the platform by gathering more content, tweaking the UI, improving our Location graph, perfecting the API, ironing out bugs, working on localization, etc. We expect the private beta will last at least several months. If you are interested, follow [@LocalstreamHQ](https://twitter.com/LocalstreamHQ) on twitter, my blog,  visit our website [http://localstre.am](http://localstre.am), or talk to us at [Wherecamp](http://wherecamp.de/). We'll be posting instructions on how to get in soon.