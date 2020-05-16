---
id: 73
title: Generic event code
date: 2005-10-26T22:30:02+00:00
author: Jilles
layout: post
guid: http://blog.jillesvangurp.com/?p=73
permalink: /2005/10/26/late-to-generics/
dsq_thread_id:
  - "337534094"
categories:
  - Blog Posts
tags:
  - eclipse
  - java
  - LT
---
Better late than never. I've been trying my hand at using Java generics to solve a nice little problem. For years I've been annoyed by the stupid copy paste reuse involved with JavaBeans event handling. If you are unfamiliar with it, stop reading now or learn about it elsewhere because this post is about a replacement based on Java generics, which is also a topic you should know about before reading further.

You have been warned.

First of all my generic replacement is not a drop in replacement because it breaks the JavaBeans spec. It has to do that because the folks that produced this spec embedded typenames into method names and interface names (instead of using generics which was not part of Java at the time). This is roughly how it works now:

- Create a subclass of EventObject (there is no interface!!!): FooEvent
- Create an interface FooEventListener with a method foo(FooEvent e)
- Now in the class that produces the FooEvents, add two methods: addFooEventListener(FooEventListener l) and removeFooEventListener(FooEventListener l)
- Also add a fireEvents method that iterates over all the listeners and calls the foo method

The problem(s) with this approach:

- The three methods you add to the event producer are always the same, except for the name which has the name of the Listener interface embedded!
- Worse they should be threadsafe. Many developers actually don't know this and produce thead unsafe code!
- Oh and the Listener interface has the type of the event embedded in its name as well!

All of this is mandated by the JavaBeans spec and tools actually depend on this (through reflection) to hook event sources up to event sinks.

Java 5 has an interesting new feature called generics which is otherwise known as parametrized types. With parametrized types you can do nice stuff like this:

```
<code>
public class GenEvtMgr&lt;LT, T&gt; {
	private final List listeners = new LinkedList();

	public void fire(T e) {
		for (EvtListener i : listeners) {
			i.eventFired(e);
		}
	}

	public void addEventListener(LT l) {
		listeners.add(l);
	}

	public void removeEventListener(LT l) {
		listeners.remove(l);
	}
}

public interface EvtListener&lt;ET&gt; extends EventListener {
	void eventFired(ET e);
}

public interface GenEvtProducer {
	GenEvtMgr getEventManager();
}
</code>
```

What this does is actually pretty simple. It defines a reusable GenEvtMgr to handle the bureaucracy of handling all the
Listeners. It's a generic class with two parameters, a LT and T where T is the actual event type and LT is an EvtListener parametrized with T again.

EvtListener is a generic event listener with only one method to handle events of type T. Finally producers of T events need to be able to provide a manager so there's a GenEvtProducer interface as well.

And some code to test the above ...

```
<code>
public class EventTester implements GenEvtProducer {
	private final GenEvtMgr</code><code>&lt;</code><code>EvtListener</code><code>, SomeEvent&gt; mgr =
		new GenEvtMgr</code><code>&lt;</code><code>EvtListener</code><code>, SomeEvent</code><code>&gt;</code><code>();

	public GenEvtMgr&lt;</code><code>EvtListener</code><code>, SomeEvent</code><code>&gt;</code><code> getEventManager() {
		return mgr;
	}

	public void go() {
		mgr.fire(new SomeEvent(this));
	}

	public static void main(String[] args) {
		EventTester test = new EventTester();
		GenEvtMgr</code><code>&lt;</code><code>EvtListener</code><code>, SomeEvent</code><code>&gt;</code><code> eventManager
			= test.getEventManager();
		eventManager.addEventListener(new EvtListener () {
			public void eventFired(SomeEvent e) {
				System.err.println("Foo");
			}
		});
		eventManager.addEventListener(new EvtListener () {
			public void eventFired(SomeEvent e) {
				System.err.println("Bar");
			}
		});

		test.go();
	}
}

</code>
```

So we create implementation of GenEvtProducer. The implementation has a GenEvtMgr object parametrized with SomeEvent which is our EventObject subclass (not listed above). We can add listeners, remove listeners and fire events simply by calling the manager. Finally in the main method two listeners are created and calling the go method produces foo bar as expected.

Is this ideal? No. There's several problems.

- It's not threadsafe, that's easy to fix.
- The type of GenEvtMgr is a bit complicated, eclipse makes it easy though with infer type and autocomplete.
- All users of the manager class have access to the fireEvent method as well which is something you may not necessarily want to expose.
- The Listener interface only has one method, the JavaBeans specallows for more than one.

The last problem might be a bit hard to solve but you might wonder how desirable that is. It's sort of logical to have one handler per event. Most of the time, Listeners with multiple methods are in fact an attempt to avoid having to deal with implementing multiple events and the associated bureaucracy of having to create all sorts of code for registering and calling listeners. With the code above this is now a lot easier. Some trivial extensions of the code above are to create an event producer that can produce events of multiple types, each with their own manager and listeners (e.g. use a map of T.class to GenEvtMgr).  But I'll leave that sort of thing as an exercise to the reader.