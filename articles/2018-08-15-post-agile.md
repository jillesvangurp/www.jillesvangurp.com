---
title: "Post Agile: embracing asynchronous processes"
description: The use of asynchronous communication tools and processes in increasingly distributed teams are resulting in a new way of developing software that for lack of a better word is post agile.
tags: 
  - agile
  - post-agile
  - scrum
---
Originally published on [dev.to](https://dev.to/jillesvangurp/post-agile-embracing-asynchronous-processes-ifa).

Like many people my age in this industry (software development, if that was not clear), I remember how things worked before the internet and before agile. Programming in these days meant using expensive tools that came with stacks of books that sat on your desk. Google and Stackoverflow did not exist. Having internet in the workplace was not very widespread. I learned to program using the Basic manual that came with my commodore 64. Agile was not a thing.

Things have changed since then and mostly for the better. Kent Beck's [Extreme programming](http://www.extremeprogramming.org/) was a book and idea I was very enthusiastic about when it came out. Around that time I was doing a Ph. D. in the field of Software Engineering. I even referenced it in my 2003 Ph. D. thesis. The agile movement (Kent Beck was of course one of the [Agile Manifesto](http://agilemanifesto.org/) signees), revolutionized development in many ways.

# Bad Agile

Everybody is claiming/pretending to be agile these days. So, the word has become somewhat meaningless. Every bank, insurer, and shitty little software shop is doing Agile. Capital A Agile of course because they are doing things "by the book". Anyone who knows anything about Agile would know this is exactly the wrong thing to do. I've been in the same room with some of the manifesto signees at various conferences, lectures, workshops, etc. and I've heard them spell this out. Agile is a set of tools and a way of working that you use and adapt to your needs. Use the books as a starting point, not the end state. If you know nothing, you might as well start by doing this.

I've grown somewhat tired of the "you're doing it wrong" camp that snuffs out any criticism of things like Scrum, which I would argue has become somewhat toxic in our industry. People either hate scrum or love it and mostly for the wrong reasons (either way). Broadly speaking, people dislike the wide spread practice of its mindless application, the constant bickering in its pointless meetings, and the emotional drain and wasted energy over arguments on how to do it "right", whatever that means. Personally, this is a thing that I've witnessed on pretty much any project I've been involved with in the last 15 years. Anecdotical evidence suggests I'm not alone. 

For better or worse, Scrum has nominally replaced waterfall as something that is easy enough to grasp for organizations to restyle themselves as Agile without actually changing that much. That doesn't mean that Scrum or Agile are bad but Scrum in particular seems to have become the tool of choice for bad agile implementations. Scrum even has its own term for this: scrumbutt. 

There's a lot of bad agile going on in our industry. Most software developing companies are just as boring, stupid, and ineffective as 20 years ago. Government IT projects still go spectacularly wrong. Banks still sink tons of money in misguided projects. Companies like Lidl still allow themselves to get ripped off by companies like SAP (to the extent of a sweet [0.5 Billion](https://news.ycombinator.com/item?id=17541092)). For the record, I blame both companies for this.

Everybody prays to the church of Agile now and there are hordes of self styled Agilists/Agile coaches/etc to help you figure out how to do it right. A lot of companies employ some of those people pre-emptively to ensure they do things "by the book", which of course defeats the purpose.

Whatever your point of view on this, a trend in our industry is that things are changing again and people are looking beyond agile at different and relatively new ways of organizing software development. If only to distinguish themselves from all the people doing bad Agile. 

Agile is close to 20 years old now. You are not going to improve things by not changing things and shaking things up a little. Some people have started referring to this as post agile. Whatever it is, scrum is definitely not a part of it.

# History and evolution of Agile

When the Agile manifesto was signed, most people were in fact not doing Agile or anything remotely close to it. Agile was a new thing then and somewhat controversial. People were doing all sorts of things and were generally confusing and conflating processes and modeling techniques and requirements engineering methodology and tools. Universities mostly taught waterfall then. 

In the late nineties and early 2000s people attempted to standardize modeling languages. The result, UML, was widely popular for a while and companies like Rational (later acquired by IBM) tried to make it the center-point of the development process. The result, [Rational Unified Process](https://en.wikipedia.org/wiki/Rational_Unified_Process) was was considered modern and hip then and given the timing a bit of a counter move against Agile. Rational and RUP ended up in the hands of IBM; arguably one of the least agile companies in existence at the time (and today). Blue suits/white shirts were very much still a thing at IBM then. Standards, certification, training, and related consulting business were booming. 

UML and RUP perpetuated the dogmas of waterfall, which was to first do detailed designs (using UML, of course) after doing requirements specifications (also using UML, how convenient) and before doing implementation work and before testing would commence. Briefly that too was supposed to be done using UML with something called model driven development. Thankfully, MDA and the associated range of (now) abandonware to do that no longer comes up a lot in serious discussions about software development these days.

But RUP was also a stepping stone towards Agile. Rational unified tried to be iterative as well. This really meant you got to do waterfall multiple times in a project; once a quarter or so. Rational's premise was that this required tools, lots of tools. Very complex tools that required lots of consulting. This is why IBM bought them and they made a lot of money getting organizations to implement RUP, training software architects and selling expensive licenses for software. Back in those days, any self respecting software architect had some boxes and books with the Rational logo prominently in sight. They'd be wielding impressive looking diagrams and there would typically be a lot of architecture and design documentation with more diagrams.

Agile was hugely disRUPtive, mostly in the sense that it popped that bubble. Sorry about the bad pun. It just melted away in the space of about 5 years. Between 2000 and 2005, UML slowly disappeared from our lives. I haven't used UML tools in ages and can't say I miss them.

Iterative development is of course as old as waterfall. The original paper by Royce on waterfall [Managing the development of large software systems](http://www-scf.usc.edu/~csci201/lectures/Lecture11/royce1970.pdf) from 1970 is actually still a pretty good read and was soon complemented by papers on spiral and iterative development.

Feedback loops are a good thing; every engineer knows this. In fact, Royce brought up iterations in that paper! Literal quote from the paper: "Attempt to do the job twice - the first result provides an early simulation of the final product". Royce was trying to be Agile in 1970. Of course his work got dumbed down to: lets first do requirements; set those in stone and turn them into design and implementation and maybe do a bit of testing/bugfixing before we throw it over the wall and walk away. [Fun fact, the word waterfall does not appear in Royce's paper!](https://pragtob.wordpress.com/2012/03/02/why-waterfall-was-a-big-misunderstanding-from-the-beginning-reading-the-original-paper/) The original paper on waterfall does not mention waterfalls, at all. Don't blame Royce for waterfall. Waterfall was never a thing, from day 1.

What the agile manifesto and movement accomplished was that the waterfall bubble was burst and iterative development became the norm. Having a lot of design documentation in UML slows you down when iterating and makes it hard to do that. If iterating is your goal, you can't lose time doing that. People figured out that the added value of this typically incomplete and out of date documentation was questionable. 

The result was that UML became a thing for whiteboards and from there an entirely optional thing that these days is not a topic that comes up in software planning at all. Same with requirements documentation. This was a bit of a black art to begin with. With agile people figured out that it's much easier to specify small deltas of what you want changed against what you have right now instead of specifying the whole thing up front. Which you inevitably would get wrong anyway. 

Getting rid of project bureaucracy like that allowed for shorter cycles and faster iterations and focused development around working prototypes. Extreme programming was about taking that to the (at the time) extreme of doing sprints that were as short as a few weeks. This was unheard of in an industry where projects could spend months or years without even producing working code.

# Agile brought a revolution in tools

Tools such as issue trackers empowered this. [Bugzilla](https://www.bugzilla.org/) was the first popular one that got a lot of traction. This happened roughly around the time that Agile became a thing. Issue trackers turned requirements into a new way of working. Instead of writing specifications, you instead specify change requests in the form of issues that are tracked. Initially this was used for bugs but very soon this expanded to track essentially all sorts of changes. Similarly, wikis took the place of design and product documentation.

Agile spawned the adoption and development of a lot of new tools; many of which had their origins in open source communities. These days any decent project has an issue tracker, some kind of decentralized version control system (usually Git), CI tooling, wikis, communication tools like irc or slack, etc. These tools are essential and they continue to change how people are working. Some of these tools are run in the cloud by companies like Atlassian, Gitlab, and Github. The recent acquisition of the latter by Microsoft shows how important these tools have become.

The open source world was always distributed and could never rely on meetings. Consequently they adopted tools and processes that supported their way of working. Early projects used things like mailing lists and news groups; and version control systems like CVS, RCS, and later things like Subversion and Git. Likewise, Irc predates Slack by several decades and continues to be the preferred way of communicating in some projects. The practice of pull requests on Github/Gitlab that is now common in enterprise projects emerged out of the practice of exchanging patches via mailing lists and news groups. Eventually Git was created to make this process easier and Github created a UI for it.

Many of these tools were not common (or even around) when the Agile manifesto was signed. However, Agile people embraced these tools and also spawned the Devops movement which integrated operations experience and responsibilities into teams. Devops brought even more tools to the table. Things like deployment automation, docker, kubernetes, PAAS, SAAS, chatops, etc.

All these tools and their associated practices are slowly resulting in a post agile world. 

# Meetings are synchronization bottlenecks

Agile replaced waterfall with structured processes to organize development in an iterative way. The above mentioned tools mostly came later. An unintended side effect of agile was lots of new meetings. Talk to any engineer about things like Scrum and you'll essentially be ticking off what meetings they have to do: sprint plannings, estimations, retrospectives, reviews, and of course standups. The schoolbook implementations of Scrum are essentially endless cycles of such meetings. Most engineers I know hate meetings and/or see them as a necessary evil at best.

With post agile people are discovering that the added value of meetings is questionable and that tools exist that facilitate getting rid of them. One of my favorite .com era surviving companies, despair.com, still sells a great poster with the following slogan: [Meetings. None of us is as dumb as all of us.](https://despair.com/products/meetings?variant=2457301507). I've been to more than a few scrum related meetings that reminded me of that poster.

Meetings are inherently synchronous in both time and (usually) space. They require heads in a room at a specific moment. This is highly disruptive because people have to stop what they are doing, go to the meeting, and discuss and decide things together, and come to a decision. Video conferencing tools kind of suck for this and remote attendees are typically at a huge disadvantage in such meetings.

# Going asynchronous

With post agile, people are keeping the tools they adopted from OSS teams and some of the practices of Agile. However they are abandoning meetings and generally eliminating synchronization bottlenecks in their processes. This is similarly liberating as saying goodbye to convoluted out of date UML diagrams, crappy requirements specifications, and the glacial pace of waterfall style development. I have many friends and colleagues that are working in distributed teams that span the globe.

There are a couple of practices that are key to post agile. The key enabler is continuous deployment or continuous releases. Simply put: if stuff is ready, you make it available right away in order to keep feedback loops as short as possible. The OSS community figured this out first. Mozilla nightly builds have been a thing for pretty much as long as their open source products have been around. Frequent releases are essential for gathering feedback via an issue tracker. You don't wait until after the next retrospective in two weeks or whatever arbitrary milestone you have to get that feedback. And you use tools and automated processes to make sure this happens in a controlled and predictable way.

Continuous deployment requires a high degree of automation. It requires continuous integration: aka. automatically assessing whether you are fit to ship right now. Every change triggers a CI build. CD eliminates release management as a role and CI relieves product managers from having to manually test and approve releases.

Continuous integration in turn requires having tests that can run automatically that cover enough of the product that people feel confident that things work as they intend. The goal of automated tests is to prevent having manual testing on the critical path of releasing any software.

Another thing that continuous deployment requires is the ability to branch and merge changes. In order to keep the production branch stable and releasable, it is essential to keep work in progress on branches until it is good enough. 

Git is the key enabler for this and another tool that emerged out of the OSS world. Before Git, version control systems were huge organizational bottlenecks. Branching was a royal pain in the ass and sufficiently complicated that subsequent merging required lots of planning. Organizations frequently were bottle-necked on merges. This was mitigated with commit freezes and similar practices. [Linus Torvalds](http://gph.is/1fkwrno) has been running the largest OSS project in the world (Linux) for nearly 25 years and all this planning and coordination around branches and merges annoyed him enough that he invented Git. Git codifies and improves the asynchronous change management that the Linux development community has been practicing.

Of course Linux still continues to rely on mailing lists for using git. Linux developers exchange git patches (i.e. textual exports of commits, not just diffs) via email. However, a company called [Github](https://github.com) emerged that made Git more user friendly for the masses and introduced us to a key tool for post agile: the Pull Request. It's essentially the same thing but the flow of reviewing and merging is supported with a nice web UI.

Pull requests are an asynchronous way to manage changes in software. Back when agile started out version control was done doing CVS (subversion was still in beta) and branching was considered a very dangerous ritual that was best avoided. Entire companies were getting by without either version control systems or branches.  

Pull requests, CI, and CD are powerful tools that can remove a lot of synchronization bottlenecks in software development. You initiate work on a topic via an issue tracker, after discussion in that tool, on  mailing lists, or slack/skype/irc/whatever, you then create a branch and start work. When done you create a pull request (PR). Relevant stakeholders provide feedback (after being assigned or @tagged). Meanwhile CI confirms things are ready to merge. When the PR is approved, it is merged. This in turn triggers an automated deployment. Start to finish the life of a software change can be completely asynchronous. People synchronize on tickets in issue trackers and pull requests and escalate via asynchronous communication tools. When stuff goes wrong the relevant PR is identified, the git history and issue trackers are used to figure out what happened and if needed a new PR is created to either revert or fix the issue. Tools facilitate decision making, planning, auditing, automation and affect all life cycles of the traditional waterfall model.

# Asynchronous enables distributed teams

Going asynchronous can cut down on meetings and eliminates Sprints as a necessity or a meaningful unit of work and allows you to iterate in hours instead of weeks. Asynchronous also enables you to distribute the work geographically. Meetings are an obstacle for this because they require people to be in the same place and timezone. Neither is practical if you have people on all continents. By going asynchronous, people can coordinate work and synchronize via issues, pull request, and slack while the decision making around releases, deployments, etc. is automated.

This enables you to get rid of essentially all Agile related meetings. All of them. This is why I believe that going asynchronous and distributed effectively moves us to a post Agile world. Standups are not practical in a distributed team, so those go. Having lengthy sprint plannings and estimation sessions over video calls are not practical either. Sprints themselves are no longer necessary. And so on.  

# Should you go post Agile?

Should everybody now jump on the bandwagon and start doing post agile? I'd argue that, no, you should only do things that fit your context. Just like you were supposed to do with Agile. What is helpful though is reflecting on where you are with your organization in terms of what you are doing, what you are trying to accomplish, what tools and processes you have, what your bottlenecks are, and how you are evolving your processes and tools over time. You probably already use a lot of the tools and practices mentioned above.

I see distributed teams and companies as the key drivers of the post agile world. Asynchronous tools and practices are a key enabler for that. There are numerous economical advantages to going distributed that may cause people to be interested in becoming more distributed and less bottlenecked on meetings. For example, hiring is easier when people don't have to move to your central office. You have access to a global pool of talent. Not having to have expensive offices in expensive places like San Francisco or London is also a huge plus. Not wasting double digit R&D budget percentages on meetings and associated traveling is also a big gain. Sticking everybody in meeting rooms for a whole day every two weeks for scrum related planning and ceremony is 10% of your development budget. In places like San Francisco we are talking significant chunks of investor cash being spent on that as engineers are expensive there.

If you want to tap into these benefits, you need to think about how you can integrate asynchronous in your current processes. It's perfectly alright to continue to do Scrum and practice post agile practices at the same time. Many companies do this. It's not about jumping ship but about reflecting on what you are doing and why and how that is working. Personally, I've long preferred Kanban style processes because they are easier to align with doing things asynchronously. Whatever you do, please don't be dogmatic about it.

