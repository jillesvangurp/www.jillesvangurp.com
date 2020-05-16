---
id: 1504
title: Maven and my GitHub projects
date: 2013-02-27T16:31:47+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=1504
permalink: /2013/02/27/maven-and-my-github-projects/
wp-syntax-cache-content:
  - |
    a:1:{i:1;s:8550:"
    <div class="wp_syntax" style="position:relative;"><table><tr><td class="code"><pre class="xml" style="font-family:monospace;"><span style="color: #808080; font-style: italic;">&lt;!-- this bit goes into the profiles section --&gt;</span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;profile<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>jillesvangurp<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;repositories<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;repository<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>release.repo<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;url<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>http://repo.jillesvangurp.com/releases/<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/url<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;releases<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>true<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/releases<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;snapshots<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>false<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/snapshots<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/repository<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;repository<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>snapshot.repo<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/id<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;url<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>http://repo.jillesvangurp.com/snapshots/<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/url<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;releases<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>false<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/releases<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;snapshots<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>true<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/enabled<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/snapshots<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/repository<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/repositories<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/profile<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    ....
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;activeProfiles<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;activeProfile<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>sonatype<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/activeProfile<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;activeProfile<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>jillesvangurp<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/activeProfile<span style="color: #000000; font-weight: bold;">&gt;</span></span></span>
    <span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/activeProfiles<span style="color: #000000; font-weight: bold;">&gt;</span></span></span></pre></td></tr></table><p class="theCode" style="display:none;">&lt;!-- this bit goes into the profiles section --&gt;
    &lt;profile&gt;
    &lt;id&gt;jillesvangurp&lt;/id&gt;
    &lt;repositories&gt;
    &lt;repository&gt;
    &lt;id&gt;release.repo&lt;/id&gt;
    &lt;url&gt;http://repo.jillesvangurp.com/releases/&lt;/url&gt;
    &lt;releases&gt;
    &lt;enabled&gt;true&lt;/enabled&gt;
    &lt;/releases&gt;
    &lt;snapshots&gt;
    &lt;enabled&gt;false&lt;/enabled&gt;
    &lt;/snapshots&gt;
    &lt;/repository&gt;
    &lt;repository&gt;
    &lt;id&gt;snapshot.repo&lt;/id&gt;
    &lt;url&gt;http://repo.jillesvangurp.com/snapshots/&lt;/url&gt;
    &lt;releases&gt;
    &lt;enabled&gt;false&lt;/enabled&gt;
    &lt;/releases&gt;
    &lt;snapshots&gt;
    &lt;enabled&gt;true&lt;/enabled&gt;
    &lt;/snapshots&gt;
    &lt;/repository&gt;
    &lt;/repositories&gt;
    &lt;/profile&gt;
    ....
    &lt;activeProfiles&gt;
    &lt;activeProfile&gt;sonatype&lt;/activeProfile&gt;
    &lt;activeProfile&gt;jillesvangurp&lt;/activeProfile&gt;
    &lt;/activeProfiles&gt;</p></div>
    ";}
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
<pre lang="xml">
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
</pre>
<strong>Disclaimer.</strong> This repository is provided as is. Particularly the snapshot part is basically there to support my own builds. I may clean it out at any time and there is no guarantee that snapshots of my github projects are there or up to date. Likewise, the releases repository is there to support my own builds. I will likely only keep recent releases there and you shouldn't use older releases of my projects in any case. Binaries in either maven repository may broken and do untold amounts of damage (which the LICENSE tells you is your problem).

If this worries you, you can always build from source of course. Simply check out the github project (and any dependencies) and maven clean install it or deploy it to your own maven repository.

If not, using my repository may be convenient for you and I generally deploy source and javadoc jars as well.

If any of my projects become popular enough to warrant me putting in some more energy, I can deploy to maven central. I've done this for the jsonj project up to 0.7 for example. If this would help you, simply drop me an email and I'll look into it.

I'll try to keep this post up to date if things should change.