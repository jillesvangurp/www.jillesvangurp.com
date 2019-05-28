---
id: 1492
title: Puppet
date: 2013-02-12T13:03:07+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/02/12/1491-revision/
permalink: /2013/02/12/1491-revision/
---
I recently started preparing for deploying localstre.am to an actual server. So, that means I'm currently having a lot of fun picking up some new skills and playing system administrator.

World plus dog seems to be recommending using either chef or puppet. Since I know few people that are into puppet in a big way and since I've seen it used in Nokia, I chose the latter. 

After getting to a usable state, I have a few observations that come from my background of having engineered systems for some time and having a general gut feeling about stuff being acceptable or not that I wanted to share.

First: it's tedious and hard to debug. Declarative in puppet means that you basically have to hand hold every little step with stupid little "this requires that" clauses all over the place. There is no implicit order of things resulting from the fact things are in a certain order in a file. This in turn leads to a lot of verbosity. 

Second: it assumes your stuff is nicely packaged up as .deb or .rpm packages (depending on your OS preference). In my experience, most stuff that I care about is hopelessly out of date. For example, I don't want last year's python, a Java that is several patch releases behin Oracle, and a jruby that is a major version behind. So


