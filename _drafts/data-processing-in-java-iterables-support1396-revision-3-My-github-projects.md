---
id: 1399
title: My github projects
date: 2012-11-08T18:41:21+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2012/11/08/1396-revision-3/
permalink: /2012/11/08/1396-revision-3/
---
Since announcing that I will be leaving Nokia, I've been quite busy. I will be announcing more details on what I'll be doing in a few weeks. Meanwhile, you may have noticed some increased activity on my git hub account where I've been updating and adding several small projects. 

These are projects ara about me scratching a few itches that are mostly related to processing large amounts of geospatial data on my laptop. The phrases "large amounts" and "laptop" might raise a few eyebrows and cause people to wonder what is wrong with existing solutions such as hadoop, geospatial databases and search engines, misc frameworks, languages, and other stuff. Fair enough, none of what my github projects do is particularly unique or novel. So why bother?
<ul>
	<li>No single of the solutions I looked at do all I need them to do. So I would have to combine several solutions.</li>
	<li>Most of these solutions don't integrate particularly well with each other (misc incompatibilities, overlapping functionality, missing stuff, etc).</li>
	<li>Most of these solutions are quite sophisticated and complex (read hard/awkward to work with, optimized for other purposes than mine, poorly documented, and probably overkill). This is especially true of most geospatial products I've looked at. This is not intended as criticism; I'm merely observing the mismatch in what I need and what is available.</li>
	<li>Mostly what I need is not that hard. That's a combination of me knowing exactly what I want to do and having some experience doing it.</li>
</ul>

That last point is the crucial point. Do I invest my time getting up to speed with product X, knowing in advance that it won't cover all my needs, or do I just sit down and do things myself? I chose the last option.

The rest of this blog post is about outlining the scope of my github projects and their general design philosophy.

*Java*

Most of my projects are Java based. I realize that that is a bit unfashionable lately. But I have quite a bit of experience programming Java and I happen to like software that combines performance, type safety and reasonable levels of expressiveness. That last point might provoke scala/ruby/python/whatever hipsters. And they'd be right. Those languages come with powerful features that are definitely very nice to have. However there are downsides as well. Scala scares the shit out of me in terms of maintainability, lack of readability, complexity, and the general feeling that this is C++ all over again. Python is nice for simple stuff but ultimately clumsy when it comes to certain other things that I do without giving it a second thought in Java (*cough* concurrency), and the YAGNI attitude rubyists bring to the table means you'll be reinventing lots of wheels that you needed after all. As a result, rubyists tend to use dozens of 'gems' that are mostly in a perpetual state of being reinvented, not being documented, or being deprecated. Java has a 15 year head start here and it so happens that there is quite a bit of very mature, bug free stuff out there that just works. I think ruby 10 years down its evolutionary path will be just as mature (and unfashionable). However, I need something that works now. 

So, Java it is. Doing data processing in Java used to be tedious. You had to do a lot of boiler plate code, deal with poorly designed standard APIs and third party libraries, etc. None of that is actually inherent to the language. If you apply a few idioms and design patterns (i.e. borrow from the Ruby and Scala communities), and if you make use of some recent language features, a lot of those problems melt away. 
 
*Projects overview*

I currently have the following java projects on github.
<ul>
	<li>efficientstring</li>
	<li>geotools</li>
	<li>geokv</li>
	<li>iterables-support</li>
	<li>httpclient-future</li>
	<li>jsonj</li>
	<li>xmltools</li>
</ul>






