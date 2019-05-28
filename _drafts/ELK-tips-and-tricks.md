---
id: 1746
title: ELK tips and tricks
date: 2015-06-26T11:11:32+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1746
permalink: /?p=1746
categories:
  - Blog Posts
tags:
  - ELK
  - ES
  - GB
  - TB
---
We started using Kibana 3 last year to get some insights in our logs. We treated this as a nice to have. We needed our logs somewhere to dig through and we were already using Elasticsearch. Logstash then takes care of grabbing logs and shoving this into Elasticsearch. Once you have that, installing Kibana is sort of a no brainer as it promises pretty analytics in real time. Together they are referred to as the ELK stack.

However, there are a few pitfalls and setting up the ELK stack has a few non trivial things associated that need taking care of. So here's what we learned along the way.

The first thing we got wrong was that we put way too much data into Elasticsearch. Setting up logstash is easy and it is tempting to hook up everything and the kitchen sink. But just because you can does not mean you should. In this case what you probably want is to be able to dig through your data. Elasticsearch scales endlessly, IF you provide it enough hardware. What's enough hardware? Well that depends. If you have a system that generates millions of messages per hour and just shove that into elasticsearch, it doesn't take that long to hit some hard limits on a modestly sized cluster. We started with a minimally tuned elasticsearch running on a biggish single node and hit that limit pretty quickly. Once your index hits a few tens of GB, problems will start to occoru. In Elasticsearc things don't always fail gracefully. Elasticsearch will become slow, crash, and do bad things when you overstress it. Solution keep your data in check: regularly clean up data using Elasticsearch curator and only log what you actually need. 

We now keep a week's worth of data and simply delete indices after that. Also because of daily index rollover, we can optimize indices after they rollover; this frees up some filehandles and other resources. It's not ideal but the price of having a larger cluster with more capacity is not justified by the limited value of having old log data around for arbitrary querying for us. Assuming things scale linearly, we'd probably need to increase our cluster for every 2-3 weeks worth of data.

The second thing we got wrong was mappings. We were storing a lot of different logs in Elasticsearch and spent no time coming up with a good mapping. This means that Elasticsearch creates a dynamic mapping, which in the case of Elasticsearch means a lot of analyzed text fields. This is nice if you are implementing a text search engine but very wrong if you are trying to do analytics. What you are interested in there is non analyzed fields that you can feed to a terms aggregation. Also, we had a problem of some fields being mistaken for number fields because they sometimes had a numeric value. This causes issues when the value is not a number and can also lead to weird failures where different shards of the same index end up with a different mapping depending on what value was indexed first. This in turn results in a cluster failure because ES cannot decide on the mapping for the whole index. Also, we were storing vastly more data on disk then needed because of all the analyzed fields. Solution: we now have a mapping that maps everything to non analyzed strings unless we say otherwise on a case by case basis. Also, we use so-called doc_values which means elasticsearch uses memory mapped files rather than heap memory to load term values into memory; this is a very big deal when you are hitting an Elasticsearch cluster with an avalanche of aggregation queries. This will be default in 2.0 apparently.

Elasticsearch ships with some out of the box configuration that is great for development but terrible for any kind of serious deployment. For example, it clusters by default with any other elasticsearch with the same cluster name in the local network. This is easily fixed. However, it also comes with circuitbreakers set to off that really should be set to on. Solution: configure the circuitbreakers. This will reduce the chance that a Kibana user kills your cluster with a misguided query. Another issue is the low disk circuitbreaker, which kicks in by default if you get below 10% disk space available. On a 3 TB raid 1 disk that is 300GB. That's actually a lot of free disk space and it is kind of strange to see your cluster stop working because of this. I've also had this problem on my laptop where I'm always low on disk space. Solution: set it to something less conservative like a 100MB.

Especially with a lot of logstash data you can and will kill your cluster with a sufficiently expensive queries. Kibana generates lots of expensive queries all the time. In our case this meant that we'd fire up elasticsearch, start gathering data and the cluster would get slower and slower over time. Then a combination of too much data, too many kibana users at once, and not enough memory would randomly kill our cluster. If Kibana appears slow, you are in the danger zone already and it is just a matter of time before something fails. Elasticsearch failures when it runs out of resources are ugly. Nodes will become unresponsive, drop out of the cluster, suck up all the CPU, etc. Worst case you are looking at index corruption as well due to garbage collection induced network partitions (see the infamous <a href="https://aphyr.com/posts/323-call-me-maybe-elasticsearch-1-5-0">call me maybe</a> article on how this works).

Another problem that we ran into is the maximum term length. With our fields set to not analyzed and some of our json log messages being very big, we actually hit this limit. This results in index failures. You can fix this by configuring a maximum term length in your mapping.

