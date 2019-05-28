---
id: 1816
title: Docker, drinking the kool-aid
date: 2016-12-29T19:11:10+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1816
permalink: /?p=1816
categories:
  - Blog Posts
tags:
  - AWS
  - java
---
At this point, Docker, should need no further introduction; so I won't bother wasting your time with yet another overview of what it is. Go read the countless other websites that do that before reading on if you happen to be in need of an introduction anyway. However, I recently got the perfectly valid question what docker was good for. This is a subtly different question. Instead of getting bogged down in analogies with things that you may or may not have used in the past that are loosely related, or similar, I'll address that question by describing how we went from a more or less standard approach (as of a few years ago) using puppet, Centos, and a lot of java, ruby and node.js stuff hosted in a traditional data center to our current architecture, which involves docker, AWS, and more or less the same applications. Minus the ruby cruft, which we took out to the back and shot along with puppet. 

When we started doing this we had a few simple goals: 1) move to AWS, 2) modernize our devops so we could easily run any development branch in something resembling our actual deployment architecture 3) have something less complicated for doing simple deploys than the convoluted mess of puppet scripts. So, we decided to jump on the Docker bandwagon.

# Packaging stuff up in a docker container

We started with the obvious thing: see if we could package our stuff up as docker images. As it turns out, this is both easy, straightforward, and a great idea. A Dockerfile, which is what you need to write to do this, is a specification of the stuff that needs to be in the docker container. There are countless examples of how to create Docker files for just about everything; so I won't go into the how part. But basically for most applications this boils down to 1) on the first line, choose a suitable base container (e.g. ubuntu 16.04) to extend, 2) add a few commands to add stuff to the container that makes up your container, 3) specify start commands, ports that need to be exposed, healthchecks, etc. Done. 

Now if your immediate thought is "hey that sounds similar to what chef, puppet, ansible, salt, etc. do!?", you'd be right: those just became obsolete. If your conclusion from that line of thought is "lets just use that inside my Dockerfile so I can take some shortcuts" you'd be wrong. Just because you can doesn't mean you should. A good reason not to is that Docker build is something you do at build time and not at deploy time whereas puppet is the other way around. Also, a docker build should not be doing anything that requires a lot of moving parts. You're not provisioning a (virtual) machine, you're simply building a package that contains everything needed to run a single process: your application. Creating a docker image is more similar to building a rpm than to provisioning a new machine (excuse the analogy).

Docker containers are layered. You always start with a base image (e.g. ubuntu:16.04) and then you add stuff to it. In fact, each line in your Dockerfile creates a new layer. This means that docker creates a new container with its own hash id that layers on top of the previous layer. What this means practically is that you don't want to be creating a whole lot of layers because that would create a lot of intermediate images and make things slow. In other words: a good Dockerfile is short and minimal. You can actually create intermediary containers and use those as common parents for your application containers. That's a great way to make your small Dockerfiles even smaller and reduce copy paste across your projects. Why would you use something like puppet to convolute something that is already short and minimal? If you think you need it, you're doing it wrong probably. In our case, we grab whatever linux base image, make sure it has a JDK or node js (depending on the application), then we copy our build artifacts and that's about it.

An interesting side effect of writing Dockerfiles is that you end up documenting how to install and run your applications in a way that everyone can easily understand. Necessarily docker containers include everything needed to run your application; therefore the Dockerfile describes exactly what that stuff is. Once you build the container and upload it to a registry, you can run it anywhere. 

# Running your own registry

That brings us to the next issue: you probably want your own Docker registry. Now at this point you might be wondering about the complexity of that. Turns out it comes as a docker image that you docker run. So your main headache is reduced to: have some place where you can run docker images (and you were going to need that anyway) and run the image. Easy. In our case, we have a small ec2 host (t2.nano) and a s3 bucket where the containers go. It's one of those fire it up and forget about it kind of things. Running your own registry in your own network minimizes the amount of bandwidth (and time) you'll spend on moving docker layers around. That's a good thing and that alone is a valid reason to be running your own container. And you probably don't want to upload your application to some public server either. But if you want, you can also pay Docker to have private containers on their hosted solution.

# Modifying your builds to produce docker containers

Once you get to this stage, you are in good shape. You can package up all your apps as containers and get them in a registry. The only thing that remains is all the rest. This is where stuff gets interesting. Lest start with the build.

There are two ways of creating docker containers. The first is to first run your traditional build tools to produce artifacts and then package those up with a Dockerfile. The second is to move the build step inside your Dockerfile as well. Dockerizing your builds means you dockerize everything needed to build, package and run your application given the source code. It turns out that this is a good thing. Our old situation was that we had huge readmes inside our applications that were always out of date that described the many things you might need to build our application, a jenkins server where all of that had been installed at some point, a convoluted jenkins build with all the magic incantations to produce the artifacts, and a Dockerfile. 



If you hadn't noticed yet, most serverside stuff comes in Docker form these days. Want Elasticsearch? Docker run elasticsearch. Want mysql? Docker run mysql. Usually there's a bit more to figuring out ports and configuration; but typically you can find that in the Dockerfile or any documentation that comes with it. This stuff is great for development; and increasingly it's a great way to deploy this stuff as well. There is now a wide variety of (typically) vendor provided and supported docker images for just about anything. Docker is a great way to provide software to others. If you have a docker capable host to run things on, you can fire up just about any server software with a 1 line command that will download the image (from dockerhub) and run it.




 

  