---
title: Keep Your Dependencies Updated
published: true
description: Updating your dependencies removes technical debt and uncertainty and is something that you should practice.
tags: dependencies, software-engineering
---

Whenever I start work on a project that I haven't touched in a while or on somebody else's project, the first thing I do is update its dependencies.Imagine starting work on a project, only to find that its dependencies haven't been updated in a while. I've often found myself in this situation. I've also noticed that many developers tend to stick with what works and avoid updating because it is a hassle to do so.

Worse, when you point this out to engineers, many of them just shug and act like it cannot or should not be addressed. If it ain't broke, don't fix it. However, is that really true? Just because you don't know where the fixed bugs  are doesn't mean you don't have them. And what about compatibility breaking things where your code is building on top of now effectively deprecated and no longer maintained things?

This article tries to make an argument for updating frequently. It's actually less work this way and you stay on top of things. And you get to benefit from the hard work people do upstream of your code base.

## Technical debt

Technical Debt is one of those analogies that gets abused a lot in our industry. Usually it gets framed in terms of any technical issues being a form of debt that accumulates interest that at some point you need to confront and pay for. There's this notion that you can pay off your technical debt and that this has a known cost. Ward Cunningham, who invented wikis, was one of the contributors to the Agile Manifesto, is one of the first people to originally coin this analogy. He actually spoke of it in terms of investing in the future by spending resources on things like refactoring that mitigate the negative effects of technical debt.

I think of it as risk accumulation. You don't mitigate risk by taking more of it but by removing it. The more technical debt you have the higher the risk that you can't recover from having to deal with its effects. So, things like refactoring and other corrective maintenance activities are definitely a wise thing to do. Technical debt is something you pay forward by constantly investing in reducing it and balancing those investments against your overall R&D. Fix it now so you don't have to find out how expensive it is to fix it later. The risk here is that the cost becomes extremely high (unaffordable) and that it eventually kills your project. That's the risk you take by taking on lots of technical debt. You can be fatalistic about that or do something about it.

Out of date dependencies are a form of technical debt.

Newer versions of dependencies reflect the progressive learnings of the developers that produced them. They fix bugs, they address user feedback, they change things, add new functionality, and generally aim to make things better. More importantly, they support their latest and greatest and stop supporting their previous notion of that.

In practical terms this means that integrating their changes may cause some issues. You might be better off but it's still a bit of work. Not doing this work means you are taking on technical debt. It's risky

## The math of risky changes

The nice thing about risk is that it means dealing with probabilities that something bad might happen. Integrating changes of any kind has a certain risk that it might cause issues that you then have to address.. Each change you make has a potential non zero cost associated with integrating that change. Best case it just works and introduces no problems (the cost is 0). But sometimes there is a non-zero cost; and sometimes that is a high. The probability for this scales with the amount of change.

Since the probabilities for this are (initially) small change is that people get fooled into believing that these changes don't matter. But, math dictates that risk multiplies.

Let's model this. Instead of modeling the probability of things breaking, we're going to model things being fine. Let's assume 1 in a 100 changes is problematic. So, for each change you introduce there's a 99% chance that things are completely fine. We don't worry about the cost. Either it's 0$ or it is high.

What happens if you do 10 changes? Very easy, that's `0.99^10 = 0.9``. So, we can do a small amount of changes and it's very likely to be fine. What happens if we make 100 changes? `0.99^100 = 0.37`. So, now it's more than likely that integrating this amount of change is problematic. But you might get lucky.

And for a 1000 changes? It's 0.000043. Yikes! You get my point, this quickly converges on the chances of anything being anywhere near fine being infinitely close to zero. Nobody is that lucky. Large amounts of changes means you have your work cut out. 100% (well 99.99999%) guaranteed. I don't like those odds.

Of course we made an assumption that is probably wrong. Maybe 99%  is too optimistic or too pessimistic. This doesn't matter. It always asymptotically converges to zero when you multiply numbers that are smaller than 1. The lower the number, the faster that happens. I think 1 in a hundred is actually way too optimistic and the number is probably much lower. For example if the chance is more like 1 in 50 changes, the numbers change dramatically. Your odds for not encountering issues doing 10 changes drop to 0.81 and for 100 changes it drops to 0.13. The point here is that these seemingly small risks multiply to a very large probability of being problematic.

## Updating dependencies means integrating changes

Of course, when you update your dependencies, you are applying upstream changes from the dependencies you use. Those changes include bug fixes, new features, new bugs (sometimes), and possibly some API breaking changes. The more changes you apply, the lower the chance is that it will all integrate fine and the higher the chance that you have to make a lot of your own changes to address any issues. And as we've just seen, doing large amounts of changes is risky. The risk of you having to deal with very risky changes gets higher the further out of date you are. It's not a linear relation either. It goes from manageable to being very challenging really quickly.

The good news is that upstream developers probably have done a fair bit of testing and a lot of their other users will have been using the software and any bugs and issues they found are likely being addressed. Most of those changes are things you might want to care about. Overall, you might be better off with those changes integrated.

## Testing effort does not scale linearly

After you've fixed all the things that are broken after you finally updated  your dependencies, you of course have to test the changes you introduced. Sadly, the effort for integration testing does not scale linearly with the amount of change. A lot of people in this industry focus on code coverage with their tests and even if you have 100% coverage (which is rare), you should be aware that all that means is that you have great coverage for your unit tests.

Integration testing is not the same as unit testing. For a given unit with a small amount of code paths, you can feasibly test all of these and cover a decent range of parameters. For an integration test, you are testing the system as a whole and you have to consider all the things that changed and all the various ways those things can be invoked and parameterized. It's a combinatorial explosion of permutations of ways these things can be called, the order in which they get called, etc. It quickly becomes impossible to cover all of that.

Integration testing is hard. There's no such thing as 100% coverage of a system. You might hit all the code paths. But you are not going to be able to test all possible inputs. Doing integration testing manually is harder. It is very time consuming and expensive. And you are not going to find all the issues. You don't prove the absence of bugs by integration testing.

## The same math applies to testing!

You can use the same probability math to calculate the probability your changes are going to be fine. You apply a change and it's probably going to not cause any problems. You do some small amount of manual testing and you release it to production. In the unlikely case it causes issues, you can root cause it to the small amount of changes you performed and start looking there for a fix. The bottom line is that integrating a small amount of change has a low chance of introducing problems and when you do introduce problems, they'll be cheaper to fix because you know exactly where to look for potential root causes.

If you integrate thousands of changes, you'll have your work cut out. It's unlikely to not break your tests and you might have to do a lot of testing before you can push to production. In the process you'll uncover lots of issues and they each require a lot more effort to fix because it could be any of those thousands of changes that introduced it.

Deferring this effort by accumulating a lot of changes means it is going to be (much) more work. It's actively harmful. Back in the day when people still only released software after a lengthy waterfall style process, integration testing would take up a lot of time. This is why agile processes are so popular these days. And things like continuous deployments.


## The same math applies to LTS releases

Lots of people like the idea of using long term support (LTS) releases of things they depend on. The idea is simple. A vendor provides two versions of their software. One is their regular release with the latest and greatest that they've come up with and rubber stamped as stable. The other is a frozen in time release that might be years old that they occasionally apply a backport to. Long term is typically something like a few years at best.

What's a backport? It's the notion of applying selected upstream changes to an older version. As the math above suggests, this is likely to cause issues. You only do it for critical, and preferably small fixes.

Why not use LTS releases? Of course sometimes this is not optional (e.g. because of support contracts).. But, eventually they reach their end of life. When that happens you have nothing but bad choices. You can stick with a now unsupported dependency. Or you can deal with many years worth of changes and upgrade to the next LTS version.. And as I have now demonstrated, this can be risky. Opting out of these fixes is risky too. If anything breaks, it's now your problem. If upstream releases a feature you need. You have no other choice than a risky upgrade, patching things up yourself, or paying somebody else to do this for you.

This is why some companies charge lots of money for LTS releases of their stuff. It involves a lot of difficult engineering to backport anything and their paying customers can't afford to upgrade to a newer version. This is the ultimate vendor lock in. The older the release that they support, the more they can twist some arms to make customers pay for it. Who opts into this? Banks, insurers, and other risk averse companies that can afford to pay for somebody else to take care of keeping their decades old software stacks running. They are good at balancing risk and they can afford to spend gazillions on ancient software. It's a high price to pay. Can you afford that?

## Back to updating your dependencies

As I hope is clear now from the (simple and brutal) math above, your cheapest and by far lowest effort option is to simply keep your dependencies up to date, always. The more dependencies you have, the more important this is. Any time you update, there's of course a small chance of that introducing a problem.

We don't like problems so why risk problems and update anyway? Very simple: there's a difference between knowing there is a problem and suspecting there might be one. As soon as you know there is a problem you can do something about it, mitigate it, or plan to do something about it later. If you merely suspect there might be a problem but you are not doing anything about it, that's called technical debt. All you know is that technical debt accumulates and will get more expensive over time in a badly non linear way. A lot more expensive. Removing uncertainty is a good thing. Because at least now you can estimate the complexity of your problem.

## Dealing with problematic updates

When there is a problem with a dependency there are three possible ways forward:

It's a problem on your side and you fix it now. You do a bit of work and you move on. You are now fully up to date again. A job well done. You pay a price but it's worth it.
It's a problem on your side but fixing it simply is not a priority or too disruptive. You document the problem and create an issue to address it later and outline the strategy for doing so. You now have (some) technical debt but at least you know.
It's a problem with the upstream dependency that requires a fix on their side. You document the problem and maybe you engage with the upstream developers to collaborate on a fix. Minimum you identify the relevant issue on their side (document it), or you create one, or you help fix it. And then you wait for it to get fixed and apply the future version when it arrives.

Any software system that has out of date dependencies without valid documented reasons why is a system with a high probability of being very expensive to update.  And since it's all undocumented, you should bias towards assuming the worst. That three year old react project where the developers never updated a thing? You now have two viable choices:

Reimplement it. This will be expensive but you can sort of estimate the cost of that.
Try to modernize it. You might get lucky but you can't really know until you try.

This, is why many old projects die. Updating them becomes more and more expensive and less attractive. And eventually replacing becomes more attractive than fixing such projects. The price of large accumulated technical debt is that writing it off by scrapping the software becomes the lowest risk possibility.

## Upgrade often

I update my dependencies often and so should you. Patch releases are a no brainer. Nothing should break and it's usually easy to verify. What could possibly go wrong? Find it out by trying it. Minor releases are called minor for a good reason. You might reasonably expect that there will be no or little work to update to those. Major versions are riskier. Maybe don't grab the .0 release and read the release notes.. But don't wait too long either. At some point you'll have to sit down and do it. And who knows, the developers actually value backwards compatibility? Finding this out and knowing this is your job,

At minimum, just document why you cannot (yet) update a thing. If your reason is that you can't be bothered to even check, you are being negligent. Ignorance is never a good excuse for having technical debt. Try it and find out. You can always roll back and document. At least you will know. But of course for best results, just keep everything updated and deal with the minimal amount of work you have to do whenever you update. How often exactly is up to you. You get to balance risk and amount of work.

Updating often means a small number of dependencies might require a small number of changes. The odds are pretty good that it will be fine. And once in a while you just have to deal with the necessary cost of staying up to date instead of deferring the risk and cost and not even knowing about it.

I tend to update whenever I start working on something big or whenever something new gets released that I care about. Or whenever it's been too long. I actually follow release updates on Github for things I actively use. Whenever somebody releases something, it appears in my update feed and I know about it and can browse the release notes and action it. If there are going to be any issues, I want to know what those are as soon as I can.

Most decent dependency managers make staying up to date easy. On most of my Kotlin projects, I use the [refreshVersions](https://splitties.github.io/refreshVersions/) plugin for Gradle for this. Run `gradle refreshVersions``. It updates my versions.properties with a list of commented available new versions. I review them and apply updates and run our build and tests. If everything passes, I create a commit and I move on. If something doesn't work, I apply one of the strategies above. If I need to roll back, I document the reason in versions.properties, Great job for a friday afternoon or when I have a lost half hour between meetings.

This btw.  is also a great argument for using Linux distributions with rolling releases. I've been using [Manjaro](https://manjaro.org/) (an Arch Linux variant) on one of my computers. Works great for me. Stable, fast, and always up to date. Likewise, lots of people like Debian testing for the same reason. Anything with an LTS release means you will be going through the pain of updating  those to the next one every few years. Rolling releases are the way to go for stable and up to date software.

## Conclusion

Keeping your dependencies updated is a good practice in software development. I've shown you some math and arguments. Not updating because it is risky becomes a self fulfilling prophecy. It's technical debt.

Updating regularly reduces your technical debt, which can be costly and potentially detrimental to your project. Regularly updating your dependencies not only keeps your project up-to-date with the latest improvements and bug fixes, but also allows you to identify and address potential issues early on. This proactive approach saves you from the overwhelming task of dealing with a large number of changes at once. Make a habit of updating your dependencies often, and you'll find that the benefits far outweigh the effort. It's a small price to pay for the health and longevity of your project. And it's actually less work than waiting.


