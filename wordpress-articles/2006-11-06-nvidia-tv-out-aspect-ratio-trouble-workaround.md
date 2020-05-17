---
id: 201
title: 'Nvidia tv out aspect ratio trouble &#038; workaround'
date: 2006-11-06T23:37:08+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2006/11/06/nvidia-tv-out-aspect-ratio-trouble-workaround/
permalink: /2006/11/06/nvidia-tv-out-aspect-ratio-trouble-workaround/
dsq_thread_id:
  - "336376734"
tags:
  - OK
  - problemsandsolutions
---
For a few months I've been putting off upgrading my nvidia video card drivers from 80.21 to the 9x.xx because of an issue with tv out. Anyway, there's a few other bugs in the 80.xx series that have been annoying me and several nice features in the new 9x.xx series so I upgraded anyway.

It seems nvidia introduced a bug/feature in the 9x.xx series that fucks up the aspectratio of tvout. Essentially it detects when the overlay used for the full screen signal on the tv does not have 4:3 aspect ratio (e.g. a dvd movie would be 16:9 or even wider) and then 'compensates' by scaling it to 4:3 unless the resolution of the overlay is less than 640x480. Why is this wrong: the s-video signal is always 4:3, even if you have a widescreen tv. If the movie is widescreen (e.g. 16:9 or wider as is common with dvds) black bars should be included in the signal rather than stretching the image to 4:3. This used to work correctly but is now broken in the new driver.
There seems to be a lot of people complaining in the various nvidia forums about the aspect ratio of the tv out signal. As usual most of the suggestions are useless. Essentially this is an unfixed bug in the driver that the 80.xx series did not have. So far nvidia has not fixed it. There is no magic combination of 'correct' settings in the new control panel that fixes the issue. However one of the suggested solutions provides a usable workaround that involves using ffdshow to add the black bars so that the resulting image is always 4:3. Ffdshow is a popular mpeg4 decoder available on sourceforge that comes with a bunch of useful filters that you can use to postprocess the output of the decoder. This works around the problem by ensuring the overlay aspect ratio of the overlay is always 4:3 so that the driver thinks it does not need to be scaled.
To do this:

- open  ffdshow configuration
- enable resize & aspect ratio filter
- configure it as follows
- toggle resize to on
- select 'specify size' and fill in 1024x768. In the various forum posts everybody seems to recommend 640x480. However most nvidia cards have a tv out chip that supports 1024x768 and this seems to be the default resolution used. Both resolutions are a 4:3 aspect ratio and that seems to be the main point. Also the native resolution of 1024x768 is what the image will be scaled to anyway so scaling it to 640x480 means it gets scaled twice before being sent to the tv!
- set aspect ratio to keep original aspect ratio. This ensures that ffdshow adds black bars rather than stretching the image to fill the 1024x768.


OK, this will addresses the issue sort of. A limitation is of course that it only works for content actually passing through ffdshow. This excludes for example dvds. However dvd playing software probably exists that can do similar things. This trick is also compatible with another little trick I apply to get a little extra resolution out of my widescreen (16:9) tv. This one requires media player classic (some other players probably have a similar feature).

- Open a movie, right click on the picture and select pan & scan - scale to 16:9.
- This scales the movie to anamorphic aspect ratio, it stretches the picture vertically. Due to the ffdshow config above this means the black bars are smaller. In other words there is less pixels wasted on black bars and more to actual picture.
- This looks bad on both your monitor and tv, don't worry.
- Usually a widescreen tv has an option to properly display anamorphic dvds by 'unstretching them'. Usually it is called something like wide (my tv). It does the opposite of scale to 16:9 on your tv. Use it to 'fix' the image on your tv.
- Why do this? You get a slightly better resolution due to the fact that a larger portion of the 4:3 signal sent to your tv consists of actual movie pixels rather than black bars. The slight detail loss due to stretching and unstretching is more than compensated by the extra pixels you gain.

An obvious improvement would be to actually scale to a 16:9 resolution in ffdshow and then let the driver scale it to 4:3. I tried this of course but then the driver compensates by cutting away a bit on both sides to make the image scale to 4:3. DOH!