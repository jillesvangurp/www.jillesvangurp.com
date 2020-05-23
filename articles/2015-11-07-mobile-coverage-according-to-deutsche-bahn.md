---
title: Mobile Coverage according to Deutsche Bahn
date: 2015-11-07T11:54:11+00:00
author: Jilles van Gurp


permalink: /2015/11/07/mobile-coverage-according-to-deutsche-bahn/
categories:
  - Blog Posts
tags:
  - Bad Bentheim
  - berlin
  - traveling
  - Wtf Germany
---
Yesterday I was traveling by train and it struck me how poor connectivity is in Germany. Pretty much when traveling from Berlin to Hengelo (first stop across the border in NL), I typically plan to have no coverage whatsoever for what I guestimate is at least 80% plus of the trip. Apperently in places like Bad Bentheim, Rheine, and Osnabruck it is normal to have little or no coverage, even when the train stops on the damn railway station.
I found this nice tweet in my twitter feed this morning mentioning that Deutsche Bahn is providing some nice open data files. [One of these files](http://data.deutschebahn.com/datasets/netzradar/) maps coverage for the different mobile providers in Germany along the rail tracks. I downloaded the file and did some very low tech analysis on the file basically taking their stability metric and finding the number of non zero values for each provider using a bit of old school command line voodoo.

```
# metrics with non 0 value data points (higher is better)

ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep o2_stability | grep  -E -v '0,$' | wc -l
    2851
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep t-mobile_stability | grep  -E -v '0,$' | wc -l
    6089
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep e-plus_stability | grep  -E -v '0,$' | wc -l
    2743
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep vodafone_stability | grep  -E -v '0,$' | wc -l
    4511

# metrics with 0 value data points (lower is better)
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep o2_stability | grep  -E  '0,$' | wc -l
   20876
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep t-mobile_stability | grep  -E  '0,$' | wc -l
   17638
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep e-plus_stability | grep  -E  '0,$' | wc -l
   20984
ip-10-0-1-28:~ $ cat connectivity_2015_09.geojson | grep vodafone_stability | grep  -E  '0,$' | wc -l
   19216
```

As I suspected, O2 is the worst and T-mobile has more than twice the coverage. However, that still amounts to pretty shit coverage since the vast majority of all metrics for all providers is 0. In fact my guestimate was quite accurate and even for t-mobile they have no connection stability for a whopping 70% of the metric points, which I assume are normally distributed along the tracks (if not, it could be worse). For O2, it is more like 85%. The total number of metrics for all providers appears to be roughly the same, which suggest that the numbers should be comparable.

Wtf Germany? Please fix your infrastructure and stop being a digital backwater.