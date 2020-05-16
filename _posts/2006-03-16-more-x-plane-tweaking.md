---
id: 125
title: more x-plane tweaking
date: 2006-03-16T21:59:03+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/03/16/more-x-plane-tweaking/
permalink: /2006/03/16/more-x-plane-tweaking/
dsq_thread_id:
  - "349371977"
tags:
  - x-plane
---
I've finally found some optimal settings for my system. The number of objects in the view determines the framerate. X-plane includes an option to display render statistics including number of objects and framerate.As a benchmark, I start x-plane, take off from jfk and make a turn towards Manhattan. As I make the turn, the worst case scenario in terms of the number of objects kicks in. Seeing the statistics change makes you understand the effect of various options.My current options: 

- textures: extreme
- anti-aliasing: 4x
- resolution 1024x768 (in a window)
- distance detail: very high
- objects & roads: both default
- compress textures: on 
- other options, set to default

The key options here are objects & roads. I've experimented with anti aliasing and objects setting whilst keeping an eye on the statistics. In the scenario above with the settings outlined above, I start out facing east (towards the atlantic) with about 2200 objects and 50 fps. As I take off, the number of objects increases to about 2500. Turning towards Manhattan the number goes up to 3600 and the framerate drops to about 25fps.By changing the objects setting from default to lots (i.e. this comes after default and before tons, mega tons, too many and totally insane). As the names of these settings suggest, most of them are not realistic. going to lots from default means that the turn to Manhattan now drives the number of objects up to 10000. At the same time the framerate drops to 20 fps which is what (by default) is the level where x-plane starts reducing the visibility to keep the framerate up. In other words, you're fogged in at 20fps. You can actually lower this number but less than 20 fps is not much fun. In fact I consider 25 to be the minimum for enjoyable flying.Interestingly enough, the numbers are independent of the anti aliasing setting. Anti aliasing happens on the video card, which can easily handle it regardless of the number of object. I've disabled it, set it to 2x and set it to 4x. No difference (except visual quality). It's purely a cpu thing. Somewhere around 8000 it becomes just to much for my poor amd x2 4400+. Too bad only one of the cores is used. The settings above are a compromise between visual quality and number of objects. I've decided that most of the time, it is more important to be able to see every terrain feature in visual range (e.g. rivers, airports and mountains 20 miles away) than it is to see 10000 little cubes of various shapes with various textures in front of me. So I've maxed out texture settings & distance settings, turned on anti aliasing, compress textures and I am now seeing good framerates almost everywhere. 