---
id: 40
title: Netbeans 4.1 Beta (2)
date: 2005-03-12T08:09:00+00:00
author: Jilles
layout: post
guid: 13@http://blog.jillesvangurp.com/
permalink: /2005/03/12/netbeans-41-beta-2/
tags:
  - eclipse
  - IDE
  - java
---
 A few days ago I commented on my intention to try out netbeans. Sadly due to a bug in the project creation wizard, I didn't get very far and at this point fixing things manually (by hacking the project xml file) is not something I want to do. I did manage to get a freeform java project going. However when you want to edit jsps in such a project you need something called web modules. Probably a web module is nothing else than an extra set of tags in the project xml. However, the gui doesn't really allow you to add one by other means than using the web project wizard. And this thing crashes when you try to finish the wizard. Considering that this is a beta, I don't think this is very bad. <br />
<br />
Performance on the source only project was really good, by the way. I added a large project with multiple source folders and everything remained very responsive. Eclipse really chokes on this kind of project. Netbeans seems to take a more lazy approach to validating: if you don't open the file, netbeans won't do anything with it. Eclipse on the other hand tries to pre compile as much as possible and will tell you if there's a problem with a file you are not editing (remove a jar file from the classpath and red error icons all over the place). While this makes netbeans very fast it also makes it less useful than eclipse: I really want to know when Foo.java breaks because I changed something in Bar.java. Of course you can manually validate the whole project simply by building it.<br />
<br />
Additionally the code editor sucks compared to eclipse. If code editing is not your thing you won't care but what the hell are you using an IDE for then? The fact is that the eclipse java code editor is a more powerful tool.. The eclipse code editor is probably the best feature in eclipse. Netbeans compensates by doing everything else really well and by being fast and more scalable.<br />
<br />
There has been a lot of discussion on the www.javalobby.org forum on eclipse performance. Several myeclipse, eclipse and netbeans people bothered to respond so it is worth a read. Bottom line is that the eclipse people are now working on performance (instead of features) and the netbeans people are getting rid of the bugs in netbeans 4.1 to make it ready for release. Both IDEs should be ready in few months. Probably netbeans 4.1 will be released a few months before eclipse 3.1. However, what really matters is the eclipse web tools project which is due this summer. Only when that and eclipse 3.1 are both ready, a fair comparison can be made.<br />
<br />
Due to the problems with the web project wizard, I can't give a full review at this point. I will try the release candidates when they come in a few months. Preliminary conclusion is that netbeans is a very capable tool that scales very well with project size. A severe limitation is the code editor which is a rather weak offering when you compare it to eclipse. 