---
title: Improving Build Speeds
published: true
description: Some tips for keeping your builds fast and why that matters.
tags: kotlin, spring, security
---

I wrote a [way too long HN comment](https://news.ycombinator.com/item?id=26564751) this morning and realized that I probably should turn that into a proper article. The [article that triggered me](http://dan.bodar.com/2012/02/28/crazy-fast-build-times-or-when-10-seconds-starts-to-make-you-nervous/) was a pretty old one on the importance of keeping builds fast. I could not agree more. And I have lots of wisdom to share on that front from having worked to keep builds fast for most of my career. Even though I develop mostly Kotlin these days, I also work with other tech stacks and pretty much all of the advice applies to almost any tech stack.

## Build Performance Matters

I've always been aggressive on trying to keep my Java and lately Kotlin builds fast. Anything over a few minutes in CI becomes a drain on the team. Basically, a productive team will have many pull requests open at any point and lots of commits happening on all of them. That means builds start piling up. People start hopping between tasks (or procrastinating) while builds are happening. Cheap laptops become a drain on developer productivity. Etc. All of this is bad. Maintain the flow and keep things as fast as you can. It's worth investing time in.

Some of the overhead is unavoidable unfortunately. E.g. the Kotlin compiler is a bit of a slouch despite some improvements recently. Many integration tests these days involve using docker or docker compose. That's better than a lot of fakes and imperfect substitutes. But it sucks up time. A lot of Kotlin and Spring projects involve code generation. This adds to your build times. Breaking builds up into modules increases build times as well. Be mindful of all this.

The rest of this article is a series of  performance tips not covered in the hacker news article. Most of it should apply to any tech stack; though some may have limitations with e.g. concurrency.

## Run Tests Concurrently

Run your tests concurrently and write your tests such that you can do so. Running thousands of tests sequentially is stupid. When using Junit 5, you need to set `junit.jupiter.execution.parallel.enabled=true` in `platform.properties` (goes in your test resources). Use more threads than CPUs for this as your tests will likely be IO limited and not CPU limited. Use  `junit.jupiter.execution.parallel.config.dynamic.factor=4` to control this in Junit 5.

If you are not maxing out all your cores, throw more threads at it because you can go faster. If your tests don't pass when running in parallel, fix it. Yes, this is hard but it will make your tests better.

## No Database or Other Expensive Cleanup

Don't do expensive cleanup and setup in tests. Set it up once. Doing repeated cleanup and setup takes time. Also integration tests become more realistic if they don't operate in a vacuum: your production system is not an empty system.

To enable being able to do this, randomize test data so that the same tests can run multiple times even if data already exists in your database. Docker will take care of cleaning up ephemeral data after your build. This also helps with running tests concurrently.

## Tests are Either Unit or Integration/Scenario Tests

Distinguish between (proper) unit tests and scenario driven integration tests as the two ideal forms of a test. Anything in between is going to be slow and imperfect in terms of what it does. This means you can either improve test coverage  (of code, functionality, and edge cases) by making it a proper integration test or faster by making it a proper unit test (runs in milliseconds because there is no expensive setup).

## Integration Tests Should be Scenario Driven

With integration tests, add to your scenarios to make the most of your sunken cost (time to set up the scenario). Ensure they touch as much of your system as they can to do this. You are looking for e.g. feature interaction bugs, Heisen-bugs related to concurrency, weird things that only happen in the real world. So make it as real as you can get away with. A unit test is not going to catch any of these things. That's why they are called integration tests. Make it as real as you can.

## Fix Flaky Tests

Fix flaky tests. This usually means understanding why they are flaky and addressing that. If that's technical debt in your production code, that's a good thing. Flaky tests tend to be slow and waste a lot of time.

## Fail Fast

Separate your unit and integration tests and make your builds fail fast. Compile + unit tests should be under a minute tops. So, if somebody messed up, you'll know in a minute after the commit is pushed to CI.

## Don't Sleep

Get rid of sleep calls in tests. This is an anti pattern that indicates either flaky tests or naive strategies for dealing with testing asynchronous code (usually both). It's a mistake every time and it makes your tests slow. The solution is polling and ensuring that each test only takes as much time as it strictly needs to.

## Use More Threads Than CPUs

Run with more threads than your system can handle to flush out flaky tests. Interesting failures happen when your system is under load. Things time out, get blocked, deadlocked, etc. You want to learn about why this happens. Fix the tests until the tests pass reliably with way more threads than CPUs. Then back it down until you hit the optimum test performance. You'll have rock solid test that run as fast as they can.

## Keep Your Tools up to Date

Keep your build tools up to date and learn how to use them. Most good build tools work on performance issues all the time because it's important. I use Gradle currently and the difference between now and even two years ago is substantial. Even good old Maven got better over time.

## Get Fast Build Machines

Pay for faster CI machines. Every second counts. If your laptop builds faster than CI, fix it. There's no excuse for that. I once quadrupled our CI performance by simply switching from Travis CI to AWS code build with a proper instance type. 20 minutes to 5 minutes. Exact same build. And it removed the limits on concurrent builds as well. Massive performance boost and a rounding error on our IT cost.

## Conclusion

Most of this advice should work for any language. Life is too short for waiting for builds to happen. With all of this, do as I say and not as I do. I am always battling slow builds in any project I join. Some of these things tend to be controversial in some teams. People get obnoxious and religious about using docker (or not), using in memory databases (or not). Adapt to your team. If you want fast, builds, understand why they are slow and how you can fix it. The above advice is just a range of tools you can use. Or not. Make using them a conscious choice at least. It's better than being fatalistic about accepting slow builds as a de-facto reality.

A version of this article was also published on [dev.to](https://dev.to/jillesvangurp/improving-build-speeds-262a).