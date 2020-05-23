---

title: 'Data processing in Java: iterables-support'
date: 2012-11-15T11:56:56+00:00
author: Jilles van Gurp


permalink: /2012/11/15/data-processing-in-java-iterables-support/
categories:
  - Blog Posts
tags:
  - GB
  - IDE
  - python
  - SSD
---
I've been doing quite a bit of data processing lately. I work with geo tagged data such as POIs, tweets, images, Wikipedia articles etc. I'm interested in processing this data to explore the data and identify relations.

It used to be that Java was a really inconvenient language for this kind of thing and thus generally frowned upon. The reasons people often cite relate to the lack of expressiveness of the language and the generally high amount of boiler plate code you need to do even the most simple stuff.

This makes a compelling argument for using alternative languages such as python or ruby or for using Hadoop with some domain specific language like Pig on top. And indeed, I've used python for some data processing jobs and found that while it has its nice sides (e.g. expressive syntax) it also has some pretty strong arguments against it, which include generally less capable frameworks for e.g. http connectivity (dozens of frameworks to choose from, none of them coming close to Apache's [httpclient](http://hc.apache.org/) for Java). Other issues I ran into are poor performance, very limited concurrency options (compared to e.g. the java concurrent package), a quite weak standard library, awkward handling of utf-8, a json parser that is [sloooooow](http://liangnuren.wordpress.com/2012/08/13/python-json-performance/), an xml library that is both awkward and limited.

Hadoop is nice if you have a cluster to run it on but it is also a very complex beast that is not widely known for being particularly useable from a coding point of view (at the Java level that is) or a deployment point of view. In practice you have to use things like pig on top or as my old colleague [@sthuebner](https://twitter.com/sthuebner) prefers, something like Clojure and [Cascalog](https://github.com/nathanmarz/cascalog).

So, there's a tradeoff between convenience, performance, expressiveness, and other factors. Or is there? Having worked with Java extensively since 1996, I'm actually quite comfortable with the language, the standard APIs, and the misc. open source frameworks I've used over the years. I've dabbled with lots of stuff over the years but I always seem to come back to Java when I just need to get stuff done.

Java as a language is of course a bit outdated and not quite as fashionable as it once was. But despite the emergence of more powerful languages, it can be made to do quite useful things still and it can compensate for it's lack of language hipster-ness with robustness, performance and tons of libraries and add on features and the hands down best by far IDE support for any language. It's still got a lot going for it.



So, in my recent projects, I've switched back to using Java for my data crunching. I had several reasons for this:

- I like strong typing and getting good performance from the JVM (relative to e.g. the ruby or python interpreter). This is especially important for long running jobs. Having a job exit with an interpreter error after several hours of processing can be very frustrating. Also, I like working with Eclipse and am always baffled at the generally low standards people seem to have regarding their tools outside the Java community. Call me old fashioned but I like my auto completes, refactorings, quick fixes, auto imports, etc.
- I want to do most of the processing on my quad core laptop and utilize the fact that it has 8GB. I don't have a cluster available and I don't have endless amounts of time to waste on code that only runs at a small percentage of the speed it should be running.
- I wanted to see how far I can push the limit in terms of addressing the traditional concerns related to boiler plate code and lack of expressiveness in Java. Most of the criticism regarding this has been somewhat unfair [IMNSHO](http://www.urbandictionary.com/define.php?term=IMNSHO).
- Several of the concerns people have had with Java have been addressed in language changes introduced in 1.5 (generics, varags, foreach, static imports) and 1.7 (diamond operator, try with resources). While not world shocking or perfect, these new features do allow you to do some clever things and emulate a lot of the things that make competing languages popular.
- [Internal Domain Specific Languages](http://en.wikipedia.org/wiki/Domain-specific_language) as popularized by [Martin Fowler](http://martinfowler.com/tags/domain%20specific%20language.html) have lead to a renaissance in Java library design where library designers of e.g. Guava or [Hamcrest](http://code.google.com/p/hamcrest/) strive to make their libraries useful by offering convenient idioms and utility methods. [Guava](http://code.google.com/p/guava-libraries/) as such is pretty much unrivaled in breadth and scope by anything I've seen in the Ruby or Python communities.
- After years of passively consuming OSS software, I actually wanted to contribute back on Github. I've always felt a bit guilty about my OSS addiction on one hand and my lack of OSS contributions on the other hand. This is a common problem and the excuse of having a day job with incompatible goals for this is not the strongest.

So, I got to work and have been ramping up [a few small Github](https://github.com/jillesvangurp) projects to support my needs. One of these projects is called [iterables-support](https://github.com/jillesvangurp/iterables-support). Iterables-support is about taking the above mentioned language features and adding some much needed spit-shine to the Java API, most of which predates some or all of these language features. In other words, the standard Java API mostly does not reflect the recent language features that have been added.

Iterables-support started out as a little side project where I wanted to replace some of the repetitive boiler plate I had been writing over and over again to open a file stream, wrap it with a reader, and then a  buffered reader and then iterate over the lines in the file one by one and finally closing the stream in a finally block. This is a seemingly easy task that I've seen many Java developers mess up. Failing to close a stream exposes you to running out of file handles. Failing to specify character encodings exposes you to subtle encoding issues that only show up on certain platforms. Failing to handle exceptions properly may cause your loop to exit early. This is the kind of boiler plate that is easy to get wrong and that is essentially the same from project to project.

I ended up with something called a LineIterable, which implements Closeable and Iterable and iterates over lines ot (utf-8) text files. This makes it compatible with the try with resources language feature introduced in java 1.7 as well as the foreach loop introduced in java 1.5. So, what used to be a few dozen lines of boiler plate code becomes five lines of code (several of which are curly braces). Not bad and almost on par with how I would do this in python.

I didn't stop there and have continued to add to this project. My second biggest problem was replicating the producer consumer style concurrency I've used on several projects to (typically massively) speed up processing jobs. How this works is as follows: I loop over the input, and queue work items. A bunch of worker threads poll the queue to consume work and put their output on another queue. The main thread then polls that queue for results until done. Fairly straightforward and basically a text book implementation of the producer consumer pattern. Doing it properly is somewhat tricky however and requires quite deep knowledge about Java's concurrency package and synchronization primitives. Minimum, you are just looking at a whole bunch of boiler plate code. Maximum you are looking at figuring out obscure synchronization and locking issues as well. Been there done that: not fun.

Iterables-support provides a one line solution: ConcurrentProcessingIterable. You basically give it a Processor object and an input iterable and then simply iterate over the results. Very simple, very robust, and I've (hopefully) found and ironed out the most obvious bugs regarding e.g. deadlocks. Since I have by now processed many GB of data with this class whilst burning a hole in the table (my macbook runs quite hot if you max out the four CPU cores), I'm fairly confident that I have.

There are more goodies in Iterables-support that I added because it seemed handy. There's a FilteringIterable with several useful filters. There's a PeekableIterable, which allows you to peek at the next element in the iterator. I implemented a BlobIterable to solve the common problem of having to pick apart a large file with multi line xml content (e.g. a wikipedia dump) where you want to iterate over the blobs rather than the lines. You can combine and compose Iterables to do stuff.

To facilitate ease of use, there's an Iterables class that contains a bunch of static methods that take care of the bolerplate instantiation and composition of the above. Using those methods I can do quite powerful things in just a few lines of code. So it's almost like using a scripting language. But it's fast, concurrent, and type safe too.

This project is far from complete and there are loads of tricks that are popular with Ruby, python and Scala users that I can now start emulating. Inner classes are not ideal as a replacement for anonymous functions (aka closures) but they do get the job done.

I also owe some debt to other open source projects. The before mentioned Guava contains an Iterables class that partially overlaps with what my project does. There are several projects that try to provide a functional programming like environment on top of Java. E.g. [fun4j](http://www.fun4j.org/) is quite cool. [Functional Java](http://functionaljava.org/) is another one. I have limited experience with either framework but they obviously relate to what iterables-support does.