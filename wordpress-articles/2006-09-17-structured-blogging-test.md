---
id: 185
title: Structured Blogging Test
date: 2006-09-17T15:33:30+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2006/09/17/structured-blogging-test/
permalink: /2006/09/17/structured-blogging-test/
tags:
  - microformats
  - reviews
  - UI
  - wordpress
---
Rating: 2 out of 5
I just installed a plugin for wordpress that allows me to write blog posts in a structured way and ensures that such posts comply with all sorts of microformats. The main benefit of this is that it facilitates automatic processing by sites such as technorati.com and many others, which understand these formats.

The installation procedure is basically dump files all over the place in the wordpress directory and then activate the plugin in the wordpress UI. Easy but it would have been nicer if the plugin would just have its own directory in the wordpress plugins directory.

The user interface of the plugin integrates with the wordpress administator UI. Under the write menu I now have a whole bunch of new options for creating reviews, events, lists, etc. The text editor for the review plugin which I am using to write this review appears to be just a textarea instead of the rich text editor that comes default with wordpress. This is of course annoying, especially if I want to use links or bullet lists. Writing all the tags manually sort of sucks. The rest of the user interface sort of is intuitive but too elaborate. It would have been nicer to have this more integrated with the write post UI. That is probably more difficult to implement but it is much more user friendly.

So I'm giving this 3 2 stars out of 5. It's a nice plugin to have but there's the integration issues and the issue with putting files where they don't belong on my server. Lets see what happens if I click publish.

Update: it looks like it worked. It looks quite nice and the edit link below, which you don't see since you don't have write access to this site, works as expected: it brings up the review editor rather than the default wordpress edit UI.

Tags: microformats wordpress
Update 2: I just removed it for the following reason: it doesn't seem to use the ping facilities in wordpress. Instead it forces you to create an account on a site called [outputthis.org](http://outputthis.org). The site is very brief on what it is all about and I don't feel like creating an account there when I have a perfectly fine working pingomatic already. As explained in this lengthy rant, these structured blogging guys have their own agenda. I don't feel like endorsing their services (at least until I know what they are) and without pingomatic being pinged I have no use for their plugin. So I'm removing it.

Update 3: I also removed the semantic formatting since it was screwing up my page layout.