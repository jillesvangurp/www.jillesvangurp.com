---
id: 1506
title: Maven and my GitHub projects
date: 2013-02-27T16:09:52+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/02/27/1504-revision-2/
permalink: /2013/02/27/1504-revision-2/
---
I have several Java projects on github. Generally these require maven to build and some of them require each other.

Deploying to maven central would be the nice way to provide binaries to my users. However, the process that sonatype imposes for pushing out binaries is somewhat tedious (involves jira fiddling, pgp signing), hard to automate, and given the time it takes and the frequency with which I want to push out binaries, it's just not worth it.

Basically I want to code, check that it builds, release, deploy and move on with the minimum amount of fuss.

So, I set up my own maven repository. If you wish to use some of my github projects, you can utilize this repository by adding the following snippet to your maven settings.xml.

<pre><code>
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
</code></pre>



&nbsp;