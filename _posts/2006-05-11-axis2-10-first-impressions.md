---
id: 147
title: 'Axis2 &#8211; 1.0 First impressions'
date: 2006-05-11T17:57:45+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2006/05/11/axis2-10-first-impressions/
permalink: /2006/05/11/axis2-10-first-impressions/
dsq_thread_id:
  - "382352878"
tags:
  - java
  - RPC
  - SOAP
  - WSDL
---
I've had some opportunity to play around with the newly released Axis2, apaches web service framework and container. Essentially this is a complete rewrite of Axis 1.x which is why it is called Axis2 - 1.0.

This brings me to the first point of criticism: This is needlessly confusing. It is really a completely separate product and the two products sharing, for example, a mailinglist makes no sense at all (just annoys users of either browsing through the messages). It should have a different name and its own mailinglist.
Then the 1.0 status. Traditionally 1.0 is associated with a certain level of quality and feature completeness. With axis2 - 1.0 this is undeniably not a 1.0 by any standards. A few points of criticism:

- It contains obvious flaws. For example, generated client stubs throw Exception instances rather than something a bit more specific. In my book that is a bug, not a feature. Lots of things can go wrong in a SOAP clientstub, I require more detailed feedback.
- Documentation is plentyful but inacurate; incomplete and downright misleading and does not address the obvious use cases. For example, using anything else but RPC style SOAP requires you to provide manually written WSDL. The provided non RPC examples work but the server is unable to generate WSDL for them. This makes them rather useless. Second of all, it is not actually documented how to do an RPC style SOAP service.
- Error feedback is non existent. For example, a classnotfoundexception I know occured because my buildfile was not including something never made it to the tomcat console. This means that deep down in the axis code this exception occured, was caught and not logged or rethrown. If I sound annoyed, the reason is that I just spend a frustrating couple of hours getting a simple web service to work. Sure I made mistakes and in none of the cases I managed to get meaningful exceptions or log feedback. I must have triggered a few dozen common failure points and axis was just sitting there pretending everything was alright while it definately was not.
- The default dependency on log4j messes up my usual logging configuration (and might actually be the cause for the previous). I am of the opinion that log4j is a legacy component that should never be depended on directly.
- The aar concept is poorly thought out and poorly documented (none of the documentation explains that contained jar files have to be in a lib directory, failure to put them there will result in unlogged classnotfound exceptions). Any non trivial service will have library dependencies and will require external configuration. For example, I use hibernate which requires me to modify the service container and break encapsulation to add a jndi ref to the database. How many meaningful services without at least a database connection are likely to be created? The point is that aar's do not encapsulate the web service and its dependencies fully. On top of that hot deployment is broken in tomcat (release notes say this). A cold start sometimes runs into trouble with apparently cached stuff left in various directories (this might be a tomcat problem). Solution: remove work directory and subdirectory of conf.
- The generated client stub code is crap. For a start, it doesn't seem to respect code conventions; contains newlines in weird places and seems to be a container for several nested clasess. On top of that error handling is poorly implemented: this generated code will cause its users lots of misery. And then as mentioned above, there is actually this fragment "throws Exception" in several methods. Inexcusable.
- The client stub when used complains about log4j not being configured. That is correct, I never use it and have no desire to use it. As stated above, the dependency on log4j is a bug and not a feature. Apache commons.logging, which is used in many other apache projects is included as well and fully prevents the need for log4j. Removal of the log4j jar file actually breaks axis currently!

Does this mean it is a bad product? Yes and no. If you regard this as a middleware component to be integrated by e.g. geronimo, it's current state is probably acceptable since the integrator can fix things; provide documentation and provide proper tooling. If on the other hand you expect the thousands of axis 1.x users to migrate to axis 2 at this point then no way. I'm sure things will get better from here on but there is a lot of work to do before I would recommend anyone to migrate. Production usage of axis2 at this point will be causing a lot of people a lot of headaches at this point.
At this point I am willing to deal with the issues above and will continue using it (mainly because I'm interested in using some of its features). However, this is in my book an alpha release, not even a beta. I'm used to more quality from apache and am honestly wondering what the hell happened there.