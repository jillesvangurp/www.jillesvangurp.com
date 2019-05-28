---
id: 1808
title: Reinventing logging
date: 2016-09-07T14:51:12+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2016/09/07/1807-revision-v1/
permalink: /2016/09/07/1807-revision-v1/
---
A few weeks ago I gave a presentation about our Elasticsearch + Logstash + Kibana (ELK) setup and how we are using that. I don't want to rehash all of that in a blog post but I would like to highlight something that we are doing with this setup that is somewhat unusual/new. It has changed the way we log and the value we get out of logging.

**Getting started**

We started out using Kibana just like everybody else: we had stuff that generated logs and put into elasticsearch and got some cheap success clicking together some pretty visualizations. Instead of grepping through files on a command line shell, we now have  dashboard where I can see everything that is happening in all our environments. I have a little pie diagram with three layers that breaks it down by environment, log level, and logger name. If you don't have that, you need it. I tend to look at this dashboard a couple of times per week to double check we don't have any ERROR messages. If we do, I have pretty much all the information in the dashboard to drill down where the problem is. This is what I call the gateway drug to using Kibana. It's valuable enough that once you have it you don't want to lose it. But it doesn't really change the way you do logging.

**Upgrading your logs: MDC**

Logging in Java is at the same time somewhat convoluted and insanely good (compared to other languages). There are several competing frameworks out there: log4j (1 and 2, very different beasts), Java's own logging framework, and Logback. And then there is SLF4j. SLF4J is more of a meta logging framework since it tries to unify what is out there. A good way to think about it is that you separate logging in your code from the configuration of where those logs go. Typically, different libraries that you depend do logging slightly different. SLF4J can help you ensure all those logs end up in the right place. At Inbot, we use SLF4J to create loggers and log messages, exceptions, etc. So, SLF4J is the main logging API we use. However, we use Logback to publish what gets logged such that they end up in Kibana. To do that, we use the Logback Logstash Layout which simply produces a json document for each message. This then gets sent to a Redis Appender which puts them in a Redis queue. Logstash then indexes whatever appears in this queue into Elasticsearch.

Logging frameworks in Java have something called the MDC, which is short for Mapped Diagnostic Context. The idea is that you can use it to add meta information to your log messages in the form of simple key-value pairs. Once you start using this, you'll wonder how you ever worked without it. It's insanely useful. We use it to tag all log messages with information about e.g. the user id, the request uri, the environment url, the user agent, the resource endpoint, etc. This way when something is logged, we get a lot of context. The nice thing with the Logback Logstash Layout that we use is that it uses the MDC to add fields to the json document. So instead of a json document with a timestamp, level, logger, and message field you get a much richer json document that also has all the custom attributes.

All these attributes end up in Elasticsearch and I can use these in Kibana. So, when we get a user complaining about some weird behavior, I can pull out exactly what happened when that user used our API. I can see what requests they did, any warnings/errors that were logged, what user agent they had, etc. Very nice to have when you are drilling down. 

**Application telemetry**

At some point, I stumbled upon a library simply called Metrics. It's a java library that allows you to define meters, timers, counters, gauges, and other forms of metrics that you then expose in your code. All these different metrics are registered with a MetricRegistry which you can then hook up to a Reporter that periodically publishes the metrics somewhere. The framework comes with different reporters and exporting to e.g. graphite is easy. However, since we were logging to Elasticsearch already, I did something unconventional: I simply created a new logger called METRICS and wrote a very simple Reporter class that logs a single message to this logger with all of the metrics attached in the MDC. The reporter kicks in once a minute on all of our servers and sends a single json document with a couple of hundred of metrics to Elasticsearch. Then in Kibana I can easily click together graphs to visualize the different metrics.

We monitor the number of connections to our redis, their duration. We do the same for Elasticsearch. We generally also measure known hot spots or problem areas in our code, and the duration of each request. With timers, you get several values like the average, as well as the moving avereage for the last minute, 5 minutes, and 15 minutes, and the total count. So we get a lot of metrics. Getting that into Kibana has added a lot of value since we can now monitor all sorts of things that happen in our application and correlate that in time to e.g. errors that happened. 

So for example, if a user is complaining about slowness, we can find out which requests for the user were slow and what the metrics looked like for the application server when that happened. So, we can see that it took 3 seconds to fulfill a request because our http connection pool was exhausted.

**Profiling your application**

Another thing we are doing is profiling different parts of our code. The old school way to do this is to have a very verbose DEBUG log that you can use to figure out what is going on. The problem is that typically you want this turned off because you don't want millions of DEBUG messages. With Kibana, we actually want as much information as we can handle. The only consideration is the cost to handle the data, not the verbosity. Another thing that is different is that we want to log such that it is easy to slice and dice. This means using the MDC rather than the message to log what is going on. So instead of having a gazillion variations of "X completed and took Y ms logged somewhere we log messages that have duration field and another field .  


