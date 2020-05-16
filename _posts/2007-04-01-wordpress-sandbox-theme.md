---
id: 266
title: WordPress sandbox theme
date: 2007-04-01T12:24:59+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/04/01/wordpress-sandbox-theme/
permalink: /2007/04/01/wordpress-sandbox-theme/
dsq_thread_id:
  - "336376924"
categories:
  - Blog Posts
tags:
  - CSS
  - HTML
  - IE
  - microformats
  - reviews
  - wordpress
---
If you are one of the handful of people not visiting this site for the first time (i.e. less than 10% of visitors), you'll notice that for the first time since I installed wordpress, I'm not running the default theme anymore. Basically one of my reasons for installing wordpress was that despite enjoying the fiddling with html and css I got a bit tired of working around IE and mozilla incompatibilities, the many limitations of CSS and all the weird issues you run into when trying to achieve perfectly simple things like three column layouts. If you are interested in this stuff, there are several nice sites where you can read a lot of stuff about these issues. 

Now, instead of getting my hands dirty, I decided to install the sandbox theme for wordpress available at [plaintxt.org](http://www.plaintxt.org/themes/sandbox/). This is somewhat of an experiment for me, basically my requirement is that the thing shouldn't break down if I roll out upgrades for wordpress in the future. I simply want to keep that process as simple as possible: upload new wordpress php files and run the upgrade php script.

Basically, developing a wordpress theme means that these things become non trivial since with every update the theme needs to be tested again.

The sandbox theme has a few nice characteristics:
<ul>
	<li>It is skinnable using ordinary CSS (i.e. like the good people at W3C have intended all web sites to be skinnable).</li>
	<li>It generates particularly nice HTML. This always annoyed me in default wordpress and sort of took away my motivation to do something about making it look nicer in the browser.</li>
	<li>Including nice little <a href="http://www.microformats.org">microformat </a>class names for html elements where that makes a lot of sense.</li>
	<li>It's quite popular which means lots of people use it (so it is well tested) and which also means that it is likely to be updated as wordpress evolves.</li>

</ul>

Rather than develop my own CSS file for wordpress, I've decided to just pick one of the defaults that come with sandbox. I like the spartan skin since it is minimalistic and also tries to improve readability of the actual text. Overall it is quite nice to work with. Adding alternative sandbox css skins is particularly easy and I might actually do that since the spartan look is not quite minimalistic enough for my taste and also has a handful of issues with too small margins and paddings. On the other hand, I said the same about the wordpress theme when I migrated my blog to wordpress over a year ago (i.e. never happened). We'll see what happens.

