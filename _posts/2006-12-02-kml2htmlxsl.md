---
id: 211
title: kml2html.xsl
date: 2006-12-02T21:08:35+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/12/02/kml2htmlxsl/
permalink: /2006/12/02/kml2htmlxsl/
dsq_thread_id:
  - "352841274"
tags:
  - createdbyjilles
  - firefox
  - google
  - Google Earth
  - Google Maps
  - Interesting Locations
  - microformats
  - webdevelopment
---
A nice feature in Google Earth is that you can export your placemarks as a kmz file. This is just a zipfile with a .kml file inside. This file in turn is just a xml format that Google uses to list your placemarks.

I spent some time creating [a nice xsl](https://www.jillesvangurp.com/places/kml2html.zip) file with which you can use to convert these files to html. I use it to publish some of [my own placemarks](https://www.jillesvangurp.com/places) on my website. Effectively, it turns Google Earth into a content management system for publishing information about places.

I do the transformation statically using an ant build file. But you can of course also let the browser do the transformation. However, search engines probably have difficulty handling the kml format. Also, not all browsers can do xsl, e.g. mobile browsers and screen readers. This is why I prefer to generate the html.

The stylesheet has the following nice features:

- Generates link to Google Maps for each location. It also creates a link to Google Maps pointing to the original kmz file (note you need to set the base url in the build file for that to work)
- Generates the coordinates of the location formatted using the geo microformat. This allows firefox extensions such as operator and future browsers that support microformats to detect the coordiantes.
- Produces nice semantic html (makes it easy to style using css).
- It works for nested folders of placemarks and structures the page using nested unordered lists.
- Preserves any html you type in the descriptions in Google Earth. So you can add links there and have them appear in the html.
- Of course includes a link to the original kmz file.

**Update.** Since posting this I made several updates to the xsl and the css. The link above always points to the latest version of the stylesheet. In the zip file you will also find the css and a ant build file. As part of this update, I also rewrote the text above.