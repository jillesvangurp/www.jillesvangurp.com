---

title: semantic vs Semantic
date: 2007-10-18T21:22:24+00:00
author: Jilles van Gurp


permalink: /2007/10/18/semantic-vs-semantic/
dsq_thread_id:
  - "728372037"
categories:
  - Blog Posts
tags:
  - API
  - google
  - microformats
  - oauth
  - openid
  - OWL
  - RDF
  - webdevelopment
---
Interesting post on [how microformats relate to the Semantic web](http://www.semanticfocus.com/blog/entry/title/microformats-vs-rdf-how-microformats-relate-to-the-semantic-web/) as envisioned by the w3c. 

The capital S is semantically relevant since it distinguishes it from the [lower case semantic web](http://tantek.com/presentations/2004etech/realworldsemanticspres.html) that microformats are all about. The difference is that the Semantic web requires technology that has been defined by the w3c but is not currently available in any mainstream products such as for example web browsers that people use to browse the current web. This technologies include RDF, the OWL query language, XHTML 1.x and 2.x and a few other rather obscure "standards" that you won't find on a typical end user PC or web server. I use quotes around the word standard here because I don't believe the W3C to be very effective in transferring its recommended standards over to industry in a proper way. 

That in a nutshell is my main criticism on the capital S Semantic web vision. It's just a bunch of nice academic toys; obscure languages and mostly lisp based prototypes that no doubt keep a good many AI researchers of the streets. But, where's the end user products? What's the vision for putting all this stuff in the hands of actual users? Where's the implementation plan to incorporate any of this in mainstream browsers such as Firefox; Opera; Safari etc. Or where is the plan to replace those with a next gen Semantic Web Browser? The point is that people behind the Semantic web in W3C are sitting in a proverbial ivory tower and are not doing their jobs of actually progressing the state of the art in web technology. Web browsers have evolved independently from the W3C for close to 10 years now and the people developing them have recently taken over initiative from W3C by doing its job in the WHAT-WG. 

That's where the lowercase semantic web comes in. Tired of waiting for the W3C to decide on many things or to actually fix the broken web of 1997, a few pragmatic people started doing things outside that bloated, dysfunctional organization. The first results of that can be found in the blog community today. Here some rather informal standards such as RSS 1.0 and 2.0; the blogger ping API; the meta weblog API and a few others sort of laid the basis of what we now know as the blogosphere: a rich, dynamic mesh of information sources that refer and track each other and produce vast amounts of consumer generated content. Since this first generation lowercase semantic web, many new standards have emerged that although lacking the weight of standards organizations behind them are now becoming defacto standards. These include things like opensearch, microformats, oauth, openid, atom and atom pub and several extensions to all of these that have enjoyed various degrees of success. The two atom standards are of course IETF standards now although it should be noted that especially atom feeds were used on a massive scale long before IETF wrapped up the specification process. The vision behind all these standards is that implementing them is dead easy with a simple Lamp stack and a browser and buys you interoperability with other websites and services. Consequently, Blog software has been a main vehicle for delivering this technology to end users on a massive scale and you don't need a Ph D to do it. Just register a blog at wordpress.com or unzip some php stuff on your cheap webhosting account and you'll be typing semantically rich information in minutes.

It's true that you can't compare the semantic and the Semantic web technology. But in terms of actually achieving richer semantics on the web, only the lowercase semantic web is actually happening. Sure you cannot express everything in microformats but it turns out that a small subset of everything is already quite useful. 

Will the Semantic web ever happen? I don't know. I do know that many challenges remain and that the problem on how to agree on what the rich graphs and trees you can define in RDF actually mean is sort of a wide open issue. There are some frameworks and specifications for some data but widely accepted ontologies, as researchers prefer to call these, are missing in action. If you have two websites and two ontologies you have 0 interoperability until somebody sits down and does the hard work of mapping one to the other. Just like XML is meaningless by itself, RDF is meaningless by itself as well. XPath is useless without some form of an agreed schema and OWL is useless without some form of an agreed ontology. You can go all the way back to the 1960s when relational databases were invented. The world is now full of relational databases and people making a living out of writing code that extracts information from them and interprets their schemes to do useful stuff like putting more data in other database schemes. RDF is fundamentally not semantically richer than a good old relational database or a simple graph structure. It's just a representation format. It's the actual meaning of the structures that matter. Interpreting meaning from arbitrary structures has yet to be automated.

That's where microformats and the humble lowercase semantic web come in (to save the day). The microformat solution to ontologies is simply to refer to existing standards where people, apparently, have spent a lot of time figuring out how to represent particular data items such as addresses (vcard --- hcard); geographic locations (gps --- geo); blog structure (atom --- hatom); calendar events (vcal --- hcalender) and nested lists (xhtml --- xoxo). So can you express everything with just those formats? No of course not but you can represent people, places, events, site structure with them and mix these concepts with ordinary html to tie them to video, audio, text, web pages etc. All this provides a rich context to search engines and microformat capable web browsers that can choose to extract a Semantic web like structure (with actual semantics) from them and do cool things with them such as putting youtube movies in google earth or listing events in your city tonight next to your Yahoo local search results. That's not magic but technology that people use today.

Ultimately the lower case semantic web is required to make the uppercase Semantic web happen. Without meaning, it is just a toy. 

I just noticed I'm not being entirely original so here's a link to a [insightful post on the same topic](http://www.isolani.co.uk/blog/semanticweb/WsgMicroformatsTalkLondon2006), making some of the points I am making here. An amusing and insightful article linked from there about [meta crap](http://www.well.com/%7edoctorow/metacrap.htm) points out why relying on people properly providing meta data is not a good strategy for realizing  the Semantic web.