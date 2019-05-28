---
id: 1572
title: Localstream demo at Wherecamp
date: 2013-06-15T14:04:15+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/06/15/1571-revision/
permalink: /2013/06/15/1571-revision/
---
I was at the first Berlin version of wherecamp two years ago and it was great fun. So, when I learned it was in Berlin again this summer, the choice of going there was easy. Last time, I was a passive consumer of information. This time, me and my co-founder <a href="https://twitter.com/markmacmahon">Mark MacMahon</a> will be there to <strong>launch and promote the private beta for <a href="http://localstre.am">Localstream</a></strong>.

<!--more-->

<strong>What is Localstream?</strong>

A lot of our twitter followers, facebook friends, linkedin connections, google plus circle members, and indeed real people might be wondering what we are up to with <a href="http://localstre.am">Localstream</a>. In this post I want to outline some of the key concepts we have implemented and will be demoing next week.

Localstream can be a lot of things to different people.
<ul>
	<li>For end users it is a <strong>location based content sharing and discovery</strong> platform that allows them to share information about locations. You can share youtube videos, souncloud clips, blog articles, news, or simply type some text.</li>
	<li>For content publishers it is that but also a platform with which they can <strong>push and promote their own content about a location</strong>. Doing so makes it easier for people to find their content.</li>
	<li>For developers it is an <strong>API</strong> that they can use to easily <strong>add location relevant content</strong> to their applications or <strong>publish their own content to Localstream</strong>. The Localstream platform is ideally suited for quickly building pretty much any type of location based application.</li>
</ul>
<strong>What does that mean?</strong>

The more technical explanation is that we take web content (anything with a url) and associate it with a location (another url), provide a search API that allows you to find location relevant content, a platform API that allows you to add content, tooling that crawls the web to add content from existing pages, and a web based application that uses the Localstream APIs that allows you to share and explore content in the Localstream platform.

<strong>The location graph</strong>

The core concept in Localstream is the location graph. Graphs have nodes and relations between those nodes. In Localstream, the nodes are locations: things that have a name, a URL, geospatial information (optional), and other meta data.

Locations are connected by their relations to each other. A simple example of a relation between two location nodes is the containment relation. The world consists of continents, countries, cities, neighborhoods, venues, streets, parks,  etc. If you go inside buildings, you might find rooms, shops, floors, cupboards, shelves, etc. All these things are locations. While Localstream currently is not focused supporting indoor yet, doing so would be a logical extension of the platform and is indeed something we may do at some point in time.

Other relations are possible as well. For example, metro stations are connected by rail. Some cities have sister cities. Locations neighbor each other or be part of a group of locations. Currently, containment and neighbor relations are the primary focus in Localstream and we are focused on providing world coverage for this. Once we have tackled this, we plan to enrich the graph with more relations.

Locations in the location graph are linked by relations they have with other locations. For some locations, we have detailed geospatial information. For other locations, all we know are their relations to other locations. In fact there are many more locations in the real world than have been documented in any database. <strong>Localstream can support anything that might legitimately be refereed to as a location</strong> regardless of whether the GPS coordinates are known, specified, or even correct.

Since Localstream is a web platform, locations are HTTP resources with a unique URL and relations are represented using links. Others have already built great place databases and many of those offer APIs that allow you to refer to these places using a link. Localstream  supports these links. So, any Foursquare, Facebook, Yelp, or Google place can be part of the Localstream Location graph. Additionally there exist open data sets such as Open Street Maps, Yahoo Geoplanet, Geonames, and other dataset that provide place information. Localstream maintains an internal location graph based on such open data and links to selected venues from external services. When needed, Localstream uses external APIs to fetch metadata for external location references.

<strong>Publishing content to the location graph</strong>

Publishing content in Localstream is very straightforward:
<ul>
	<li><span style="line-height: 15px;">Select a location</span></li>
	<li>Share something</li>
</ul>
Selecting a location is different from simply telling us the GPS coordinates. Instead we want to know the url of the location node in our graph that best matches the content you are sharing. Selecting locations is easy with the Localstream UI, which allows you to explore the location graph. By default, we use your GPS coordinates to find the nearest node in our graph. From there you can either navigate through the graph by clicking nearby locations or use the search box to find something else.

Once you have selected the right location, you can simply paste a link to something you want to share or enter some text. We automatically reach out to get meta data for the links you share. And, of course you can share what you publish on Localstream with other sharing platforms.

<strong>Exploring the Localstream Content</strong>

Exploring content is just as easy. You simply select a location and we show you the content most relevant to what you have selected. That content has links for the location nodes, hash tags, and the source of the content that you can click to explore.

We automatically rank content based on the location graph and based on what you click. Things directly attached to your selected location are the most relevant but we also show content that is connected to nearby nodes in the graph. So, you can start from your current location and end up exploring your neighborhood, your city, or jump to somewhere you've been, want to go, or used to live.

<strong>The Localstream API</strong>

Anything you can do with the UI, our API supports as well:
<ul>
	<li><span style="line-height: 15px;">You can explore the location graph</span></li>
	<li>Find the most appropriate location node for a gps coordinate</li>
	<li>Get a feed of content for a particular combination of locations and tags</li>
	<li>Publish content to a location</li>
</ul>
The API will not be part of the private beta. We are currently eating our own dog food by building the Localstream Application using our own API. If you are interested in using our API or partnering with us, get in touch with us directly. We plan to have the API ready for action by Q3 this year and are in fact looking for cool projects to pilot our API with.

<strong>What's next?</strong>

We are currently very busy rolling out the private beta to production. Very soon we will start sending invitations and we will allow people to play with the UI and share some content. Over the summer we plan to improve the platform by gathering more content, tweaking the UI, improving our Location graph, perfecting the API, ironing out bugs,  etc. We expect the private beta will last at least several months. If you are interested, follow <a href="https://twitter.com/LocalstreamHQ">@LocalstreamHQ</a> on twitter, my blog,  visit our website <a href="http://localstre.am">http://localstre.am</a>, or talk to us at Wherecamp. We'll be posting instructions on how to get in soon.

&nbsp;