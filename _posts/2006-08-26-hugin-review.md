---
id: 177
title: Hugin review
date: 2006-08-26T20:18:32+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2006/08/26/hugin-review/
permalink: /2006/08/26/hugin-review/
dsq_thread_id:
  - "338268555"
tags:
  - MB
  - photography
  - reviews
---
I just got back from Baltimore where I had a nice hotel room on the 21st floor with a view on the Baltimore skyline and harbor. In other words, I just had to shoot some nice panorama pictures. This afternoon I spent some time stitching them together. There are various tools you can use for this. There is the Canon specific stitch assist; there's a commercial tool called panorama factory which I used long time ago and there is the photo merge included with photoshop. None of these tools are really up to the job, especially when stitching photos that are not perfectly aligned. So I spent some time searching for alternatives and stumbled upon a nice open source tool by the name of <a href="http://hugin.sourceforge.net/">Hugin</a>. Hugin is a frontend for a whole bunch of, mostly, commandline tools. These tools are very powerful and to be honest, I don't understand most of them. But that's what the frontend is for.

Make no mistake, this is a tool for the professional. It delivers excellent quality but has rather poor usability and requires a specific way of working that is discussed in detail on the <a href="http://hugin.sourceforge.net/">Hugin homepage</a>. Actually, the process is rather easy. First you tell it what image to use as a reference point for exposure and stitching the other images to. Usually this is one of the images in the center of the panorama. Then you need to define a bunch of control points for each image pair in the panorama. A control point is a clearly regognizable feature in both images. You define one of them by clicking on the feature and then you click in the other image roughly on the same spot and Hugin will try to find the corresponding feature where you clicked. They recommend a minimum of four control points per image pair.
The next steps are about optimizing and tweaking the control points a bit. Essentially what happens in this stage is that Hugin tries to fit the images together using various algorithms. Once the preview looks more or less like what you want you go to the stitch panel and set it to work. I just stitched 9 images of the Baltimore skyline (zoomed in) and the result are great (click for full version):

<a title="View from my hotel in Baltimore" class="imagelink" href="http://blog.jillesvangurp.com/wp-content/uploads/2006/08/zoomed-view-from-hotel.jpg"><img alt="View from my hotel in Baltimore" id="image176" src="http://blog.jillesvangurp.com/wp-content/uploads/2006/08/zoomed-view-from-hotel.jpg" /></a>

Ok, this version has been compressed a bit. The photoshop file on my harddisk is a whopping  219 MB (15826x2435 pixels). It is composed of 9 8 megapixel photos and is extremely rich in detail. I had to downsize it a little to squeeze that down to 245KB :-). As you can see it is pretty hard to find the seams, yet there are 8 of them. This is pretty much close to a 170 degree view.

Update: a must have if you are going to use Hugin is <a href="http://user.cs.tu-berlin.de/~nowozin/autopano-sift/">autopano</a> which produces a hugin project file with automatically recognized controlpoints. It's a separate tool but not having to manually identify controlpoints is of course a real timesaver.