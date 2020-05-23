---
title: Maven and my GitHub projects
date: 2013-02-27T16:31:47+00:00
author: Jilles van Gurp


permalink: /2013/02/27/maven-and-my-github-projects/
categories:
  - Blog Posts
tags:
  - LICENSE
  - maven
---
I have several Java projects on [github](https://github.com/jillesvangurp/). Generally these projects require maven to build and some of them require each other.

Deploying to maven central would be the nice way to provide binaries to my users. However, the process that Sonatype imposes for pushing out binaries via their free repository is somewhat tedious (involves jira fiddling, pgp signing), hard to automate, and given the time it takes and the frequency with which I want to push out binaries, it's just not worth my time.

Basically I want to code, check that it builds, commit, release, deploy and move on with the minimum amount of fuss.

So, I set up my own maven repository. This is good enough for what we do in LocalStre.am. If you wish to use some of my github projects, you may utilize this repository by adding the following snippet to your maven settings.xml.

```xml

<!-- this bit goes into the profiles section -->
<profile>
    <id>jillesvangurp</id>
    <repositories>
        <repository>
            <id>release.repo</id>
            <url>http://repo.jillesvangurp.com/releases/</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </repository>
        <repository>
            <id>snapshot.repo</id>
            <url>http://repo.jillesvangurp.com/snapshots/</url>
            <releases>
                <enabled>false</enabled>
            </releases>
            <snapshots>
                <enabled>true</enabled>
            </snapshots>
        </repository>
    </repositories>
</profile>
....
<activeProfiles>
    <activeProfile>sonatype</activeProfile>
    <activeProfile>jillesvangurp</activeProfile>
</activeProfiles>

```

**Disclaimer.** This repository is provided as is. Particularly the snapshot part is basically there to support my own builds. I may clean it out at any time and there is no guarantee that snapshots of my github projects are there or up to date. Likewise, the releases repository is there to support my own builds. I will likely only keep recent releases there and you shouldn't use older releases of my projects in any case. Binaries in either maven repository may broken and do untold amounts of damage (which the LICENSE tells you is your problem).

If this worries you, you can always build from source of course. Simply check out the github project (and any dependencies) and maven clean install it or deploy it to your own maven repository.

If not, using my repository may be convenient for you and I generally deploy source and javadoc jars as well.

If any of my projects become popular enough to warrant me putting in some more energy, I can deploy to maven central. I've done this for the jsonj project up to 0.7 for example. If this would help you, simply drop me an email and I'll look into it.

I'll try to keep this post up to date if things should change.