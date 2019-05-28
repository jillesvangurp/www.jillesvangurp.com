---
id: 656
title: Google Go
date: 2009-11-12T20:52:48+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2009/11/12/655-revision/
permalink: /2009/11/12/655-revision/
---
Like every week there were the usual announcements of new stuff from Google this week. Highlight this week must be the experimental language <a href="http://golang.org/">Go</a>. My initial response, not hindered by any knowledge about what Go is about, was: yet another language, why bother? Yesterday evening, I watched the rather interesting <a href="http://www.youtube.com/watch?v=rKnDgT73v8s">techtalk</a> about this new language and I have a bit more knowledge. My initial response is still prevailing, but I can see how Go could influence things in the right direction since it does do a few cool things.

Things I like about Go:
<ul>
	<li>Channels and "go routines" aka. jobs or threads if you insist (not necessarily the OS supported ones) supported in the language, this is the essential superglue needed for parallel computing. The only mainstream language that comes close so far here is erlang, which is not exactly very popular but is being applied successfully for e.g. xmpp implementations.</li>
	<li>Interfaces and typing. Any interface declared is automatically a type of anything that implements its contents. This is a useful formalization of duck typing (if it walks & talks like a duck, it must be a duck) that I haven't really seen elsewhere other than scripting languages.</li>
	<li>Orthogonal & KISS design of the language where things can be combined freely. Some pretty cool stuff was demoed with channels, consts and other language features being combined to do pretty complicated stuff in the above linked techtalk.</li>
	<li>Implicit typing of arbitrary precision numbers, floats, etc.</li>
</ul>

What I don't like:
<ul>
	<li>C-like syntax & weird syntax for types. C syntax was never that great (without macros, C would be unusable) and essentially most of the details were bolted on over time. Preserving the error prone & and * notations is in my view a big mistake, as are several other C constructs.</li>
	<li>Lack of generics, although they are working on a solution here apparently</li>
	<li>Yet another vm/runtime and no support for JVM, .Net, llvm, or similar run-times. In my view native is overrated (relative to dynamic compilation) and I don't buy the "runs within 10-20% of native C code" claim (what about optimizations & 40 years of compiler tweaking?). But I'm sure that is true for the trivial code that has so far been written in Go. As is the case for trivial Java code, which under controlled circumstances kicks some ass relative to any statically compiled language BTW. But show me some real software doing real stuff.</li>
	<li>Burn everything and start from scratch approach to libraries. Is that really necessary? Seriously, I spent the past few days sorting out the dependencies to external libraries I have in a 'simple' java project (i.e. updating to more recent versions, pruning unused stuff). Contrary to the popular belief, some of those ~50 direct and transitive dependencies do some really useful things. 5000 lines of Java + a few million LOC in dependencies is hard to beat with a new language plus ~100KLOC worth of libraries. Any productivity gains would be wiped out by having to reinvent a few decades worth of wheels. Not necessary in my view.</li>
	<li>The nineteen seventies architecture for compiler and runtime. As I outlined in my last post, I believe compilation is fundamentally a run-time optimization these days. With Go the compilation work is allegedly light to begin with. So why bother at all with compiling and why not just leave things to the run-time to figure out when you actually run the code.</li>
</ul>

In short, nice concepts but I don't see the need for tearing down everything we have and starting from scratch. Basically this language is scala + a couple of tweaks and minus all of the integration work and maturity.






