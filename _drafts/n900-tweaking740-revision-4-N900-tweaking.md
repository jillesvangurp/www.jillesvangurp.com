---
id: 744
title: N900 tweaking
date: 2010-06-12T14:35:06+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2010/06/12/740-revision-4/
permalink: /2010/06/12/740-revision-4/
---
I've been tweaking my N900 quite a bit (just because I can).

<strong>Power management.</strong> Sadly there are some issues with some wifi routers related to power management. If you find yourself with connections timing out, the solution is going to settings, internet connections. Then edit the problematic connection and go to the last page which features an advanced button. Then under other set power management to intermediate or off.

With that sorted out, you'll want to be offline most of the day. So don't turn on sip/im/facebook unless you need it and switch it off right after you're done. Push email is nice but with 15/30 minute polling your battery will last longer.

To gain insight, of course install battery-eye. This plots a graph of your batteries power reserves. Finally, you may want to install a few applets to dim the screen, turn on/off wifi, and switch between 2G and 3G. You can find these in the extras repository that is enabled by default in the application manager. 

<strong>Apt-get</strong>. The application manager is nice but a bit sluggish and it insists on refreshing catalogs after just about each tap. Use it to install openssh and make sure to pick a good password (or set up key authentication). Then ssh into your n900 and use apt-get update and apt-get install just like you would on any decent Debian box. This is why you got this device.

<strong>Finding stuff to install</strong>. Instead of listing all the crap I installed, I'll provide something more useful: ways of finding crap to install.
<ul>
	<li>Ovi store. Small selection of goodies. Check it out but don't count on finding too much there. Included for completeness</li>
	<li>Misc sites with the latest cool stuff: 
<ul>
	<li><a href="http://www.nokian900applications.com">nokian900applications.com</a>. Loads of cool things to try here.</li>
	<li><a href="https://garage.maemo.org/">garage.maemo.com</a>. Source forge for maemo, this is where many of the cool apps live.</li>
	<li><a href="http://maemo.org/">maemo.org</a>. Maemo community page. Loads of stuff to find there.</li>
	<li><a href="http://wiki.maemo.org/N900_Web_Applications">web applications</a></li>
	<li><a href="http://nokiamobileblog.com/category/maemo-5/">Nokia blog, Maemo 5 category</a>.</li>
</ul>
</li>        
	<li>Advanced (i.e. don't come crying when you mess up and have to reflash) Enable the extras, extras-testing, extras-devel repositories from <a href="http://www.nokian900applications.com/repositories-extras-extras-devel-and-extras-testing-for-nokia-n900/">here</a>. Many useful things are provided here. Some of them have the potential to seriously mess up your device. Extras-devel is where all the good stuff comes from.</li>
</ul>

<strong>Browser extensions</strong>. Your browser supports extensions. Install adblock and maemo geolocation through the application manager.

<strong>Use the browser</strong>. Instead of applications, you can use the browser and rely on web applications instead:
<ul>
	<li><a href="http://cotchin.com/m/">Cotchin</a>. A web based foursquare client. Relies on the geolocation API for positioning.</li>
	<li><a href="https://www.google.com/reader/i">Google Reader</a> for touch screen phones.</li>
	<li><a href="http://www.google.com/maps/m">Google maps mobile</a>. Includes latitude, routing and other cool features. Relies on the geolocation API for positioning.</li>
	<li><a href="hahlo.com">Hahlo</a>. A nice twitter client in the browser.</li>
</ul>

