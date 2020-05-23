---
title: Anamorphic aspect ratio calculator
date: 2004-02-10T13:27:48+00:00
author: Jilles van Gurp


permalink: /2004/02/10/anamorphic-aspect-ratio-calculator/
dsq_thread_id:
  - "336486418"
categories:
  - Blog Posts
tags:
  - createdbyjilles
  - eclipse
  - java
  - PC
  - TV
---
[Anamorphic aspect ratio calculator](https://www.jillesvangurp.com/nerdstuff/anamorphicratiocalculator/anamorphic.jar). I sometimes play movies from my PC to my widescreen TV. Unfortunately the tvout of my Geforce 4 card does not support widescreen. In other words, it sends a signal with a 4:3 aspect
ratio to my tv. Luckily my tv can stretch the image to 16x9. Normally this would result in a flattened picture on the tv, which is not the intention. So suppose you have a cinematic dvd movie (aspect ratio 11:5) and want to play it on the tv. If you just send it to the tv, you'd have a 4:3 picture with enormous black bars ontop. Using the zoom function of the tv it will display fine but you are also not using a significant amount of tv signal so you're losing precious pixels!

What you can do instead is change the aspect ratio of the movie and let the tv stretch it back to its orginal 11:5 aspect ratio. The new aspect ratio for the film is called the anamorhic aspect ratio and you can
calculate it with [this](https://www.jillesvangurp.com/nerdstuff/anamorphicratiocalculator/anamorphic.jar) neat little calculator I created. You can enter the results in [bsplayer](http://www.bsplayer.org/),
which allthough enormously feature rich does not have an anamorphic setting built in (at the moment of writing) and play your movie using the full available resolution and enjoy the extra detail :-).

*The [jar](https://www.jillesvangurp.com/nerdstuff/anamorphicratiocalculator/anamorphic.jar) file can be started by double clicking on it (windows, must have a Java 2 jvm installed of course) or running "java -jar anamorphic.jar" from the commandline. [Source code](https://www.jillesvangurp.com/nerdstuff/anamorphicratiocalculator/aspectratioconverter.zip) in the form of an eclipse project can be found here. *

If this all sounds too nerdy, just download media player classic from sourceforge.net and use the options->pan&scan->scale to 16:9 option to get the same effect.