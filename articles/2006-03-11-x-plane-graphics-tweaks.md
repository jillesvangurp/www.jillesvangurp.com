---
title: x-plane graphics tweaks
date: 2006-03-11T16:52:39+00:00
author: Jilles van Gurp


permalink: /2006/03/11/x-plane-graphics-tweaks/
dsq_thread_id:
  - "336966054"
tags:
  - CPU
  - Europe
  - NY
  - x-plane
---
Today I played a bit more with x-plane. I made two flights. One from Baltimore to Newark (with a King Air 350) and one from Philadelphia to Newark (Piper PA 180). Both planes were downloaded from [xplane.org](http://www.x-plane.org). More such goodies can be found there.

Additionally I played a bit with the graphics settings. What I found out was that the compress textures setting is really important. As noted in my previous post, the thing is mostly CPU bound. More objects require more CPU. However, with things like resolution and texture size, video ram is the bottle neck. Since I have a nice 7800 GT, there is 256 MB of memory. This may seem like a lot but there is quite a bit of textures in x-plane. Yesterday I found that it was impossible to set the texture size to extreme since that caused x-plane to reduce visibility to about a mile to keep up the framerate. Reason: I was running out of vram! The solution for that is compression, this is supported by the videocard and a common strategy for working with high resolution textures. Probably this should always be turned on unless the video card is really old.

With texture compression on (in the x-plane render settings), I can now have mega tons of objects, tons of roads (these are actual x-plane settings), extreme texture resolution and about ten AI planes in the air. That looks nice! Hundreds of textures have been included with the x-plane global scenery and they are quite good (compared to e.g. the shit that comes with ms flightsimulator).

With these settings, flying over New York is workable (though framerate suffers a bit). Outside of the cities, the number of objects is much less of a problem. Besides, most cities are quite a bit smaller than NY.

[![screenshot NY](https://www.jillesvangurp.com/wp-content/uploads/2006/03/x-plane1.jpg)](https://www.jillesvangurp.com/wp-content/uploads/2006/03/x-plane1.jpg)
Another thing I noticed is that the scenery in europe does not appear to include objects. So flying outside of the US is a lot less fun. The Alps though are very detailed. Here the lack of winter textures makes them look unrealistic though. This time of year they should all be snow covered and even in the summer some of them remain snow covered. Not in x-plane. I suppose that is the limitation of the approach taken by the global scenery people (no custom modelling, only take in data from sources like satellite images). However, europe is still 4.7GB of data. Most of this data concerns data coming from various satellite images (high detail). Things like rivers, coastlines, terrain types and elevation are all accurate. So even though Amsterdam does not have objects, it still has the right textures in the right place so you can see where the city ends.