---
id: 101
title: Unchecked Exceptions
date: 2006-01-19T20:20:09+00:00
author: Jilles van Gurp
layout: post
guid: http://blog.jillesvangurp.com/2006/01/19/unchecked-exceptions/
permalink: /2006/01/19/unchecked-exceptions/
dsq_thread_id:
  - "564502950"
tags:
  - eclipse
  - IDE
  - IMHO
  - java
---
This article presents an elaborate and IMHO misguided approach to handling exceptions: [ONJava.com: An Exception Handling Framework for J2EE Applications](http://www.onjava.com/pub/a/onjava/2006/01/11/exception-handling-framework-for-j2ee.html?CMP=OTC-FP2116136014&ATT=An+Exception+Handling+Framework+for+J2EE+Applications) The author poses the problem that handling exceptions is tedious and leads to lots of boilerplate code. His proposed solution is to use unchecked, run.time exceptions. His reasoning is flawed for a number of reasons:

- Most Exceptions come from external components. When bad stuff happens, you're supposed to do stuff (other than just logging). Thinking that bad stuff won't happen is naive, it will. In most cases, the reason that you get an exception is either that your assumptions were wrong (add some if statements to check) or there is a real problem (like something is misconfigured, the db is down, network is down, ...). In some poorly designed code there may be a third reason: the software is wrapping state information in an exception. Don't do this, ever.
- You shouldn't create new exception types if you can reuse existing types. That leads to less boilerplate code and more clarity. Nothing worse than having to figure out the cause of the cause of the cause of the exception that tomcat logged.
- A good IDE makes handling exceptions really easy (eclipse ctrl+1 will give you handy quickfixes like "add throws declaration" "add catch clause for exception"). If you're typing all this stuff manually, you're doing something wrong. That leaves the problem of code readability. Poorly written code tends to be unreadable. Lots of exception handling code is a symptom, not a cause. If it's unreadable: refactor it. In general if your methods don't fit on a 1600x1200 screen you might want to start thinking about refactoring. If your classes regularly exceed 500 lines of code you're having design issues. What makes code really unreadable is excessive coupling and lack of cohesiveness. Refactoring is the solution.
- Unhandled exceptions either end up in front of the user, in the log or both and can leave your application in an unexpected state. Basically all these things are bad. Users should never see any stacktrace and should always get some kind of response from the application. Nothing worse than clicking next and ending up on the same screen because some runtime exception prevented the server from doing anything useful with the request (I see this a lot).

So in short, use a decent IDE (generate the boilerplate code) and handle the exception instead of throwing it to the caller if you can. If your code is still unreadable, don't make it worse by throwing unchecked exceptions.  