---
title: Running consul in a docker swarm with docker 1.12
date: 2016-08-26T10:00:58+00:00
author: Jilles van Gurp


permalink: /2016/08/26/running-consul-in-a-docker-swarm-with-docker-1-12/
categories:
  - Blog Posts
tags:
  - Christian Kniep
---
Recently, Docker released version 1.12 which includes swarm functionality. When I went to a meetup about this last week, [Christian Kniep](http://qnib.org/2016/08/17/consul-es-kopf-service/) demoed his solution for running consul and elasticsearch using this. Unfortunately, his solution relies on some custom docker images that he created and I spent quite a bit of time replicating what he did without relying on his docker images. 

In this article, I show how you can run consul using docker swarm mode using the official consul docker image. The advantage of this is that other services in the swarm can rely on the dns name that swarm associates with the consul service. This way you can integrate consul for service discovery and configuration and containers can simply ask for what they need without having to worry about where to find consul.

Note, this is a minimalistic example and probably not the best way to run things in a production environment but it proves that it is possible. In any case, docker 1.12 is rather new and they are still ironing out bugs and issues.

Before you continue, you may want to[ read up on how to get a docker swarm going](https://docs.docker.com/engine/swarm/swarm-tutorial/). In my test setup, I'm using a simple vagrant cluster with three vms each running docker 1.12.1 with the docker swarm already up and running. I strongly recommend to configure a logging driver so you can see what is going on. I used the syslog driver so I can simply tail the syslog on each vm.

Briefly, this approach is based on the idea of running two docker services for consul that can find each other via their round robined service names in the swarm. 

First, we create an overlay network for the consul cluster. In swarm mode, host networking is disabled. Most of the consul documentation assumes that you use that and it won't work. So, instead we use an overlay network.

```
docker network create consul-net -d overlay
```

First we need to bootstrap the consul cluster with a single node service:

```
docker service create --name consul-seed \
  -p 8301:8300 \
  --network consul-net \
  -e 'CONSUL_BIND_INTERFACE=eth0' \
  consul agent -server -bootstrap-expect=3  -retry-join=consul-seed:8301 -retry-join=consul-cluster:8300
```

Since we are going to run two services for consul, we need to run them on different ports. So the first one we simply map the exposed port to 8301. Secondly, we need to tell consul what network interface to bind on. It seems our overlay network ends up on eth0, so we'll use that. The environment variable is used to figure out the ip of the container on that interface by the consul start script in the official container.

Swarm will now launch the service and you should be able to find a running container on one of your vms after a few seconds. Wait for it to initialize before proceeding.

After the consul seed service is up, we can fire up the second service.

```
docker service create --name consul-cluster \
  -p 8300:8300 \
  --network consul-net \
  --replicas 3 \
  -e 'CONSUL_BIND_INTERFACE=eth0' \
  consul agent -server -retry-join=consul-seed:8301 -retry-join=consul-cluster:8300 
```

This will take half a minute or so to fire up. After it fires up, you can run this blurb to figure out the cluster status:

```
docker exec `docker ps | grep consul_cluster |  docker ps | grep consul-cluster  | cut -f 1 -d ' '` consul members
```

Now we can remove the consul-seed service and replace it with a 3 node service. So we have six healthy nodes in total. This will allow us to do rolling restarts without downtime.

```
docker service rm consul-seed

docker service create --name consul-seed \
  -p 8301:8300 \
  --network consul-net \
  --replicas 3 \
  -e 'CONSUL_BIND_INTERFACE=eth0' \
  consul agent -server -retry-join=consul-cluster:8300 -retry-join=consul-seed:8301
```

This will take another few seconds before the cluster becomes stable. At this point you should get something like this.  
```
root@m1:/home/ubuntu# docker exec `docker ps | grep consul_cluster |  docker ps | grep consul-cluster  | cut -f 1 -d ' '` consul members
Node          Address        Status  Type    Build  Protocol  DC
0f218b44311a  10.0.0.5:8301  alive   server  0.6.4  2         dc1
5abf4c4e7d30  10.0.0.8:8301  alive   server  0.6.4  2         dc1
682dd5bbf0e0  10.0.0.6:8301  alive   server  0.6.4  2         dc1
8a911956a8ef  10.0.0.9:8301  alive   server  0.6.4  2         dc1
e15cde65d645  10.0.0.3:8301  alive   server  0.6.4  2         dc1
e3b1ce398302  10.0.0.3:8301  failed  server  0.6.4  2         dc1
e9054b9e590b  10.0.0.7:8301  alive   server  0.6.4  2         dc1
```

Going forward, you could run docker containers that register themselves with this consul cluster. There are a few loose ends here including ensuring the containers end up on separate hosts, figuring out how to get rid of the no longer existing node that is in a perpetually failed status, figuring out if/how to persist the consul data. Another thing to figure out would be rolling restarts and upgrading the cluster. Finally, the ports in the reported members seem to be all 8301 even though three of the consul nodes should be running on 8300. That looks wrong to me. Additionally, I've hardcoded eth0 as the interace and this may prove to be something that you can't rely on. What for example if you have multiple overlay networks? I'd like a more reliable way to figure this out. It would be nice if you could specify the interface name as part of the docker service call. Finally, having 6 nodes introduces the risk of a split brain if 2 or more nodes lose their connectivity for some reason. So, it would be better to run with an odd number of nodes. Also, during a rolling restart, half the nodes disappear so you can't actually set the quorum to n/2+1 (4) which is what you would normally do.

