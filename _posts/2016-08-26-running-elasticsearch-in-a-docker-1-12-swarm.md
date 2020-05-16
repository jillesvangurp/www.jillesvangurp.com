---
id: 1799
title: Running Elasticsearch in a Docker 1.12 Swarm
date: 2016-08-26T11:09:58+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1799
permalink: /2016/08/26/running-elasticsearch-in-a-docker-1-12-swarm/
categories:
  - Blog Posts
tags:
  - DNS
  - Docker Swarm
  - HTTP
---
My last blog post was on [running consul in Docker Swarm](http://www.jillesvangurp.com/2016/08/26/running-consul-in-a-docker-swarm-with-docker-1-12/). The reason I wanted to that is because I want to run Elasticsearch in swarm so that I can use swarm service discovery to enable other containers to use Elasticsearch. However, I've been having a hard time getting that up and running because of various issues and limitations in both Elasticsearch and Docker. While consul is nice, it feels kind of wrong to have two bits of infrastructure doing service discovery. Thanks to [Christian Kniep's article](http://qnib.org/2016/08/17/consul-es-kopf-service), I know it can be done that way. 

However, I actually managed to do it without consul eventually. Since it is completely non trivial to do this, I decided to write up the process for this as well.

Assuming you have your swarm up and running, this is how you do it:

```
docker network create es -d overlay

docker service create --name esm1 --network es \
  -p 9201:9200 -p 9301:9301 \
   elasticsearch -Des.network.publish_host=_eth0_ \
  -Des.discovery.zen.ping.unicast.hosts=esm1:9301 \
  -Des.discovery.zen.minimum_master_nodes=2 \
  -Des.transport.tcp.port=9301

docker service create --name esm2 --network es \
  -p 9202:9200 -p 9302:9302 \
  elasticsearch -Des.network.publish_host=_eth0_ \
  -Des.discovery.zen.ping.unicast.hosts=esm1:9301 \
  -Des.discovery.zen.minimum_master_nodes=2 \
  -Des.transport.tcp.port=9302

docker service create --name esm3 --network es \
  -p 9203:9200 -p 9303:9303 \
  elasticsearch -Des.network.publish_host=_eth0_ \
  -Des.discovery.zen.ping.unicast.hosts=esm1:9301,esm2:9302 \
  -Des.discovery.zen.minimum_master_nodes=2 \
  -Des.transport.tcp.port=9303
```

There is a lot of stuff going on here. So, lets look at the approach in a bit more detail. First, we want to be able to talk to the cluster using the swarm registered name rather than an ip address. Secondly, there needs to be a way for each of the cluster nodes to talk to any of the other nodes. The key problem with both elasticsearch and consul is that we have no way to know up front what the ip addresses are going to be of swarm containers. Furthermore, Docker swarm does not currently support host networking so we cannot use the external ip's of the docker hosts either.

With Consul we fired up two clusters that used each other and via its gossip protocol, all nodes eventually find each other's ip addresses. Unfortunately, the same strategy does not work for Elasticsearch. There are several issues that make this hard:

- The main problem with running elasticsearch is that similar to other clustered software it needs to know the where some of the other nodes in the cluster are. This means we have need a way of addressing the individual Elasticsearch containers in the swarm. We can do this using the ip address that Docker assigns to the containers, which we can't know until the container is running. Alternatively, we can use the container DNS entry in the swarm, which we also can't know until the container is running because it includes the container id. This is the root cause of the chicken egg problem we face when bootstrapping the Elasticsearch cluster on top of Swarm: we have no way of configuring it with the right list of nodes to talk to.

- Elasticsearch really does not like having to deal with round robin'ed service DNS entries for it's internal nodes. You get a log full of errors since every time Elasticsearch pings a node, it ends up talking to a different node. This rules out what we did with consul earlier where we solved the problem by running two consul services (each with multiple nodes) that talk to each other using their swarm DNS name. Consul is smart enough to figure out the ip addresses of all the containers since it's gossip protocol ensures that the information replicates to all the nodes. This does not work with Elasticsearch.

- DNS entries of other Elasticsearch nodes that do not resolve when Elasticsearch starts start up, causes it to crash and exit. Swarm won't create the DNS entry for a service until after it has started.

The solution to these problems is simple but ugly: an Elasticsearch service can only have one node in Swarm. Since we want multiple nodes in our Elasticsearch cluster, we'll need to run multiple services: one for each Elasticsearch node. This is why in the example above, we start three services, each with only 1 replica (the default). Each of them binds on _eth0_ which is where the Docker overlay network ends up. Finally, Elasticsearch nodes rely on the ip address that nodes advertise to talk to each other. So, the port that it advertises needs to match the service port. It took me some time to figure it out but simply doing a `-p 9301:9300` is not good enough: it really needs to be `-p 9301:9301`. Therefore each of the Elasticsearch services is configured with a different port. For the HTTP port we don't need to do this so we can simply map port 9200 to a different external port. Finally, the services can only talk to other services that already exist. So, what won't work is specifying `es.discovery.zen.ping.unicast.hosts=esm1:9301,esm2:9302,esm3:9303` on each of the services. Instead, the first service only has itself to talk to. The second one can talk to the first one, and the third one can talk to the first and second one. This also means the services have to start in the right order.

To be clear, I don't think that this is a particularly good way of running Elasticsearch. Also, several of the problems I outlined are being worked on and I expect that future versions of Docker may make this a little easier.