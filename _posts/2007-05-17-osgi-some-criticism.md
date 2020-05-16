---
id: 283
title: 'OSGi: some criticism'
date: 2007-05-17T11:54:09+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/2007/05/17/osgi-some-criticism/
permalink: /2007/05/17/osgi-some-criticism/
dsq_thread_id:
  - "336377058"
tags:
  - API
  - eclipse
  - java
  - JCP
  - osgi
---
Over the past few weeks, I've dived into the wonderful world called OSGi. OSGi is a standardized (by a consortium and soon also JCP) set of java interfaces and specifications that effectively layer a component model on top of Java. By component I don't mean that it replaces JavaBeans with something else but that it provides a much improved way of modularizing Java software into blobs that can be deployed independently.

OSGi is currently the closest thing to having support for the stuff that is commonly modeled using architecture description languages. ADLs have been used in industry to manage large software bases. Many ADLs are homegrown systems (e.g. Philips' KOALA) or simply experimental tools created in a university context (e.g. XADL). OSGi is similar to these languages because:

- It has a notion of a component (bundles)
- Dependencies between components
- Provided and required APIs
- API versioning

Making such things explicit, first class citizens in a software system is a good thing. It improves manageability and consistency. Over the past few weeks I've certainly enjoyed exploring the OSGi framework and its concepts while working on actual code. However, it struck me that a lot of things are needlessly complicated or difficult.

Managing dependencies to other bundles is more cumbersome than handling imports in  Java. Normally when I want to use some library, I download it; put it on the classpath; type a few letters and then ctrl+space myself through whatever API it exposes. In OSGi it's more difficult. You download the bundle (presuming there is one) and then need to decide on which packages you want to use that it exposes.

I'm a big fan of the organize imports feature in eclipse which seems to not understand OSGi imports and exports at all. That means that for one library bundle you may find yourself going back and fort to the manifest file of your bundle to manually add packages you need. Eclipse PDE doesn't seemt to be so clever. For me that is a step backwards.

Also most libraries don't actually ship as bundles. Bundles are a new concept that is not backwards compatible with good old jar files (which is the form most 3rd party libraries come in). This is an unnecessary limitation. A more reasonable default would be to treat non OSGi jar files as bundles that simply export everything in it and put everything it imports on the import path. It can't be that hard to fish that information out of a jar file. At the very least, I'd like a tool to that for me. Alternatively, and this is the solution I would prefer, it should be possible to add the library to the OSGI boot classpath. This allows all bundles that load to access non OSGi libraries and does not require modifications to those libraries at all. 

Finally, I just hate having to deal with this retarded manifest file concept. I noticed the bug that requires the manifest to end with a empty line still exists (weird stuff happens if this is missing). This is equally annoying as the notion of having to use tabs instead of spaces in makefiles. I was banging my head against the wall over newline stuff in 1997. The PDE adds a nice frontend to editing the manifest (including friendly warning of the bug if you accidentally remove the newline). But the fact remains that it is a kludge to superimpose stuff on Java that is not part of Java. 

Of course with version 1.5 there is now a nicer way to do this using annotations. Understandably, OSGi needs to be backwards compatible with older versions (hence the kludge is excused) but the way forward is obviously to deprecate this mechanism on newer editions of Java. Basically, I want to be able to specify at class and method level constraints with respect to import & export. An additional problem is that packages don't really have first class representation in java. They are just referred to by name in classes (in the package declaration) but don't have their own specification. That means it is difficult to add package level annotations (you can work around this using a package-info.java file).
