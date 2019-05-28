---
id: 1818
title: Dockerizing your infrastructure
date: 2016-12-09T17:36:45+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2016/12/09/1816-revision-v1/
permalink: /2016/12/09/1816-revision-v1/
---
At this point, Docker, should need no further introduction; so I won't bother wasting your time with yet another overview of what it is. Go read the countless other websites that do that before reading on if you happen to be in need of that. However, I recently got the perfectly valid question what it was good for. This is a subtly different question. Instead of getting bogged down in analogies with things that you may or may not have used in the past that are loosely related, or similar, I want to attempt to address that question to simply describe how we went from a more or less standard approach using puppet, Centos, and a lot of java, ruby and node.js stuff in a traditional data center to our current architecture, which involves docker, AWS, and more or less the same applications (minus the ruby cruft, which we took out to the back and shot).

We started with the obvious things: see if we could package our stuff up as a docker image. Turns out that this is both easy, straightforward, and a good idea. Basically a Dockerfile, which is what you need to write to do this, is like a Makefile; but vastly simplified. It's not designed to replace that but simply to serve as a specification of what is inside the container that contains your application. However necessarily it also becomes a specification of everything the container needs to run. So, you get that over with probably pretty early after discovering Docker. There are countless examples of how to create Docker files for just about everything; so I won't go into the how part. But it boils down to take this existing Docker image, copy stuff to it & install whatever dependencies you need, specify ports, volumes, etc. needed. Done. 

Now if your immediate thought is "hey that sounds similar to what chef, puppet, ansible, salt, etc. do!?", you'd be right. If your conclusion from that line of thought is "lets use that instead of that crummy Docker thing" you'd be wrong. A good reason is that Docker build is something you do at build time and not at deploy time (i.e. puppet would be not something you'd use in your builds typically). Also, that crummy docker build should not be doing anything that requires a lot of moving parts. You're not provisioning a (virtual) machine, you're building a container that runs a single process: your application. It's a process wrapper, not a machine abstraction. You are packaging things up, not provisioning an new machine.

Also, Docker containers are layered. You always start with a base image (e.g. ubuntu:16.04) and then you add stuff to it. Each line in your Dockerfile creates a new layer. This means that docker creates a new container with its own hash that layers on top of the previous layer. What this means technically is that you don't want to be creating a whole lot of layers. In other words: a good Dockerfile is short and minimal. You can actually create intermediary images as well and that's a great way to make your small Dockerfiles even smaller and reduce copy paste across your projects. Why would you use puppet to replace something that is short and minimal? If you think you need it, you're doing it wrong.

If you hadn't noticed yet, most serverside stuff comes in Docker form these days. Want Elasticsearch? Docker run elasticsearch. Want mysql? Docker run mysql. Usually there's a bit more to figuring out ports and options; but typically you can find that in the Dockerfile or any documentation that comes with it. This stuff is great for development; and increasingly it's a great way to deploy this stuff as well. There is now a wide variety of (typically) vendor provided and supported docker images for just about anything. Docker is a great way to provide software to others.

So, an interesting side effect of writing Dockerfiles is that you end up documenting how to install and run your applications in a way that everyone can easily understand. Necessarily docker containers include everything needed to run your application; therefore the Dockerfile describes exactly what that stuff is. Once you build the container and upload it to a registry, you can run it anywhere. 

That brings us to the next issue: you probably want your own Docker registry. Now at this point you might be wondering about the complexity of that. Turns out it comes as a docker image that you docker run. So your main headache is reduced to: have some place where you can run docker images (and you were going to need that anyway) and run the image. Easy. In our case, we have a small ec2 host (t2.nano) and a s3 bucket where the containers go. It's one of those fire it up and forget about it kind of things. Running your own registry in your own network minimizes the amount of bandwidth (and time) you'll spend on moving docker layers around. That's a good thing and that alone is a valid reason to be running your own container. And you probably don't want to upload your application to some public server either. But if you want, you can also pay Docker to have private containers on their hosted solution.

Once you get to this stage, you are in good shape. You can package up all your apps as containers and get them in a registry. The only thing that remains is all the rest. This is where stuff gets interesting. Lest start with the build.

There are two ways of creating docker containers. The first is to first run your traditional build tools to produce artifacts and then package those up with a Dockerfile. The second is to move the build step inside your Dockerfile as well. Dockerizing your builds means you dockerize everything needed to build, package and run your application given the source code. It turns out that this is a good thing. Our old situation was that I had a huge readme that was always out of date that described the many things you might need to build our application, a jenkins server where all of that had been installed at some point, a convoluted jenkins build with all the magic incantations to produce the artifacts, and a Dockerfile. 





 

  