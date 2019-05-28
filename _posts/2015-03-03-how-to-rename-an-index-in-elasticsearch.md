---
id: 1727
title: How to rename an index in Elasticsearch
date: 2015-03-03T15:35:52+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1727
permalink: /2015/03/03/how-to-rename-an-index-in-elasticsearch/
categories:
  - Blog Posts
---
I've found that Elasticsearch on startup fixes index names to reflect the directory name, which is nice. 

This is useful if you want to for example change the logstash index mapping template and don't want to lose all the data indexed so far and going through a lengthy reindex process or wait until midnight for the index to roll over.

So, this actually works:

 - configure the new index template in logstash
 - shut down cluster
 - rename todays logstash index directory to logstash-2015.03.03_beforenoon
 - restart cluster and elasticsearch figures out that  logstash-2015.03.03_beforenoon probably should be opened as  logstash-2015.03.03_beforenoon; logstash will notice the missing index for today and fix it with the new template

Nice & almost what I want but I was wondering if I can do the same without shutting down my cluster and restarting it, which kind of a disruptive thing to do in most real environments. After a bit of experimenting, I found that the following works:

```
PUT /_cluster/settings
{
    "transient" : {
        "discovery.zen.minimum_master_nodes" : 1
    }
}
```

The actual settings don't matter, as long as you have something there, any PUT to the settings will basically cause elasticsearch to reload the cluster.

Update. You may want to not do this on a index that is being updated (like typically an active logstash index) since this duplicates lock files that elasticsearch uses. I ended up removing these lock files in my index copy after which it stopped barfing errors about the duplicated lock files. But probably not nice. So probably better is to 

 - mv logstash-2015.03.03 logstash-2015.03.03_moved
 - clear out any write.lock files inside the new 2015.03.03_moved dir
 - do the PUT to /_cluster/settings