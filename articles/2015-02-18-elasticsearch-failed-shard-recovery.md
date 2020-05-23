---
title: Elasticsearch failed shard recovery
date: 2015-02-18T19:00:31+00:00
author: Jilles van Gurp


permalink: /2015/02/18/elasticsearch-failed-shard-recovery/
categories:
  - Blog Posts
tags:
  - Diagnosis Elasticsearch
  - OK
---
We have a single node test server with some useful data in there. After a unplanned reboot of the server, elasticsearch failed to recover one shard in our cluster and as a consequence the cluster went red, which means it doesn't work until you fix it. Kind of not nice. If this was production, I'd be planning an extensive post mortem (how did it happen) and doing some kind of restore from a backup probably. However, this was a test environment. Which meant an opportunity to figure out if the problem can actually be fixed somehow.

I spent nearly two hours to figure out how to recover from this in a way that does not inolve going "ahhh whatever" and deleting the index in question. Been there done that. I suspect, I'm not the only one to get stuck in the maze of half truths, well intentioned but incorrect advice, etc. So, I decided to document the fix I pieced together since I have a hunch this won't be the last time I have to do this.

This is one topic where the elasticsearch documentation is of little help. It vaguely suggests that this shouldn't happen that red is a bad color to see in your cluster status. It also provides you plenty of ways to figure out that, yes, your cluster isn't working and why in excruciating levels of detail. However, very few ways of actually recovering beyond a simple delete and restore backup are documented.

However, you can actually fix things sometimes and I was able to piece together something that works with a few hours of googling.

# Step 0 - diagnose the problem

This mainly involves figuring out which shard(s) are the problem. So:

```
# check cluster status
curl localhost:9200/_cluster/health
# figure out which indices are in trouble
curl 'localhost:9200/_cluster/health?level=indices&pretty'
# figure out what shard is the problem
curl localhost:9200/_cat/shards
```

I can never remember these curl incantations so nice to have them in one place. Also, poke around in the log. Look for any errors when elasticsearch restarts. 

In my case it was pretty clear about the fact that due to some obscure exception involving a "type not found [0]" it couldn't start shard 2 in my inbot_activities_v29 index. I vaguely recall from a previous episode where I unceremoniously deleted the index and moved on with my life that the problem is probably related to some index format change in between elasticsearch updates some time ago. Doesn't really matter: we know that somehow that shard is not happy.

Diagnosis: Elasticsearch is not starting because there is some kind of corruption with shard 2 in index inbot_activities_v29. Because of that the whole cluster is marked as red and nothing works. This is annoying and I want this problem to go away fast.

Btw. I also tried the _recovery API but it seems to lack an option to actuall recover anything. ALso, it seems to not list any information for those shards that failed to recover. In my case it listed the four other shards in the index that were indeed fine.

# Step 1 - org.apache.lucene.index.CheckIndex to the rescue

We diagnosed the problem. Red index. Corrupted shard. No backups. Now what? 

Ok, technically you are looking at data loss at this point. The question is how much data you are going to lose. Your last resort is deleting the affected index. Not great, but it at least gets the rest of the cluster green. 

Say you don't actually care about the 1 or 2 documents in the index that are blocking the shard from loading? Is there a way to recover the shard and nurse the broken cluster back to a working state minus those apparently corrupted documents? That might be a preferable approach to simply deleting the whole index.

The answer is yes. Lucene comes with a tool to fix corrupted indices. It's not well integrated into elasticsearch. There's an [open ticket](https://github.com/elasticsearch/elasticsearch/issues/8708) in elasticsearch that may involve addressing this. In any case, you can run this tool manually.

Assuming a centos based rpm install:

```
# OK last warning: you will probably lose data. Don't do this if you can't risk that.

# this is where the rpm dumped all the lucene jars
cd /usr/share/elasticsearch/lib

# run the tool. You may want to adapt the shard path 
java -cp lucene-core*.jar -ea:org.apache.lucene... org.apache.lucene.index.CheckIndex /opt/elasticsearch-data/linko_elasticsearch/nodes/0/indices/inbot_activities_v29/2/index/ -fix
```

The tool displays some warnings about what it is about to do, and if you are lucky reports that it fixed some issues and wrote some segment. Run the tool again and it mentions everything is fine. Excellent.

# Step 2 - Convincing elasticsearch everything is fine

Except, elasticsearch is still red. Restarting it doesn't help. It stays red. This one took me a bit longer to figure out. It turns out that all those well intentioned blogposts that mention the lucene CheckIndex tool sort of leave the rest of the process as an excercise to the reader. There's a bit more to it:

```
# go to wherever the translog of your problem shard is
cd /opt/elasticsearch-data/linko_elasticsearch/nodes/0/indices/inbot_activities_v29/2/translog
ls
# note the recovery file; now would be a good time to make a backup of this file because we will remove it
sudo service elasticsearch stop
rm *recovery
sudo service elasticsearch start
```

After this, elasticsearch came back green for me (see step 0 for checking that). I lost a single document in the process. Very acceptable given the alternative of having to delete the entire index.
