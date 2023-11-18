---
title: Rankquest Studio - Removing Barriers to Search Quality Testing
published: true
description: Introduction to Ranquest Studio, a new tool for testing search quality.
tags: search, ranking, searchquality
---

Search is ubiquitous on the modern internet. You see search boxes everywhere. Almost every website or app has a search field. The quality of the implementation of this feature is very important. Often this is the primary way for users to find things on a website. With websites that sell goods or services to their users, the quality of the search experience is directly connected to their revenue. A failure to build a good search experience means that users struggle to find what they need, or might even leave without ever seeing what you had to offer to them. A great search experience engages your users more and drives revenue for your product.

But, **why is it that so few companies measure how good their search really is?** Why won't they care more about the quality of the results that they deliver? And why aren't they taking action to improve what they are doing?

A few months ago, I presented [Rankquest Studio](https://rankquest.jillesvangurp.com) at the Elasticsearch meetup in Berlin. Rankquest Studio is a tool that I created to help you assess how good your search service or API really is. It does this by allowing you to create test cases for queries and providing metrics for your test cases. Rankquest Studio aims to remove any excuses you might currently have for not testing your search quality.

Getting started with Rankquest Studio is super easy. **Anyone can do this**. You simply create example queries for your search with the built-in search tool. And then you rate the hits for each of your searches using a simple star rating. And then you run a range of common metrics against these test cases. When you have a nice set of test cases, you export them and save them. With Rankquest Cli, integrating your exported tests is easy. As well. Simply point it at your configuration and test cases and it will run them and fail your build if the metrics drop below the configured thresholds.

Rankquest Studio is free and open source and available on [Github](https://github.com/jillesvangurp/rankquest-studio).

## Why won't companies test their search quality?

Qualitative benchmarking of any kind is hard and many companies struggle with assessing the quality of their search solutions. Everybody wants to be **data driven** but in the absence of good data, many companies fall back to operating in a more subjective, opinion driven mode.

Companies that do measure search quality, typically have a search team with experienced information retrieval and machine learning experts, and product owners and architects that ask for these metrics.

Many **small businesses don't have big teams or search relevance experts**. This is fine because tools like Elasticsearch and Opensearch are popular and easy to use. Backend teams often use these tools for creating advanced search features, keeping logs, and making recommendations. I've seen several companies use these tools effectively without much planning for search quality testing. They manage to create a pretty good search experience by improvising as they go.

But why do such companies overlook the importance of search quality? Especially when their earnings depend on it? Many of these businesses simply lack the expertise. They don't really know what search relevance experts do or the tools they use. Plus, many tools for improving search relevance are designed for experts, so they're not easy for beginners to use. These tools can be complex and expensive, and setting them up takes time and planning. This makes it harder for companies to start using them, so they often delay or make their own simple solutions. And that's if they are even aware at all that this is something they should be doing.

## Why another tool?

With Rankquest Studio, I wanted to **remove as many excuses as possible** for people to not test their search quality. Rankquest is designed to be easy to get started with.

There are of course several tools for this already. For example [Quepid](https://quepid.com/) is a popular option and the people behind that are excellent and I know quite a few of them.

However,tools like that are created by and for search relevance experts. This makes these tools somewhat **difficult to use for non-experts**. Additionally, a lot of these tools require lots of setup. Including, usually, running some kind of database somewhere. This further complicates trying out and taking into use these tools.

Finally, a lot of these tools are **tightly coupled to specific search products** such as Solr or Elasticsearch. You use these tools to test specific queries. While this is of course useful, this amounts to a form of whitebox testing where you make various assumptions about the internals of your product.

In my view, **search quality testing should be a blackbox test** that runs directly against your API without making any assumptions about what that it uses internally or how that works. For a product owner, the only thing that matters is if their queries produce the expected outcomes.

**Rankquest studio addresses all these issues** by providing a simple UI that you can figure out in a few minutes. The UI has an easy to understand flow of actions that minimizes the amount of work you have to do. It's free and there is no installation process and only minimal setup. Rankquest Studio is a web site that you open and use.

Because **it's a website**, all it needs is a simple web server to host its files. You can host it yourself, run it on your laptop, or you can just open it [here](https://rankquest.jillesvangurp.com). Data is kept in your browser's local storage. You can easily import and export your test cases, configurations, and metrics reports in json format from the UI. This is useful for sharing them and you can also keep them in a version control system.

There's a necessary bit of configuration that instructs Rankquest Studio how to talk to your search server. It makes no assumptions about how your product works; anything that returns a list of results should work. The bundled search plugins allow you to query rest services implementing a GET or POST Json API or talk to Elasticsearch. If that doesn't match what you need, you can implement your own plugins.

## Getting started with Rankquest Studio

<iframe width="560" height="315" src="https://www.youtube.com/embed/Nxr2UVs_n74?si=Kgc3eKYhej2AqAqO" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

To start, simply open [Rankquest Studio](https://rankquest.jillesvangurp.com).

Start by creating a **search plugin configuration**. A search plugin configuration tells Rankquest studio how to fetch results from your search service. Results must have an id and you can optionally extract a label from your results that is displayed (for human readability). Additionally, you need to specify what parameters are needed to use your search service. Finally, you specify a list of metric configurations that you want to measure. You can control their parameters and set a threshold for the expected/acceptable value.

If you want to explore what Rankquest Studio can do, you can play with one of the **built in demo configurations**. Rankquest Studio includes a small demo search engine that allows you to search across movie quotes. This is great for quickly getting a feel for how it works.

Once you have your configuration, you can start creating **test cases**. Simply use the search tool to run a search and then convert the list of results to a test case. Each new test case is initialized with a copy of the parameters you used for the search (the search context) and the results that it found.

You can fine tune your test cases in the Test Cases screen. Here, you can review your test cases, tag them, and add/remove more results, change the ratings of your results, and document your test cases with comments.

Once you have test cases, you can go to the metrics screen to **calculate metrics** for your test cases. If you click "Run Metrics", each of the metrics that you configured earlier is calculated for your test cases. The table with the output allows you to dig into the details for each metric and look at how individual test cases performed. Red metrics mean that they are under the threshold that you configured. Green means they are fine.

You can use tags to label and categorize your test cases. And of course, the metrics screen also supports tags. Using tags allows you to zoom in on problem areas and test improvements aimed at tackling specific issues or analyze why a particular set of queries is performing poorly. Simply tag the test cases you want to examine and then run your metrics.

You should export and backup your configuration, test cases, and metrics. A good idea is to **store your json files in a git repository**. Once you have exported everything, you can use the [command line version of Rankquest](https://github.com/jillesvangurp/rankquest-cli) to e.g. integrate ranquest into your CI builds. And of course being file based also means that it's easy to build your own tools around the file format.

Rankquest Studio includes lots of convenient features to add/remove hits to test cases, tagging, or convenient help buttons that explain the metrics and functionality. It's there to make your life easier.

## Rankquest Core

Rankquest Studio uses a library [rankquest-core](https://github.com/jillesvangurp/rankquest-core) that implements the search relevance metrics that Rankquest Studio uses. These include precision, recall, mean reciprocal rank, normalized distributed cumulative gain. These are common information retrieval metrics that say something about the quality of your search results and help you get a grip on your search quality. For example precision and recall are about users being able to find things that you have in your index and having the best results ranked high. For an overview of what each metric does, you can use the help function in Rankquest Studio.

[Rankquest Cli](https://github.com/jillesvangurp/rankquest-cli) of course uses the same library and enables you to work with your exported test cases on the command line. I've packaged that up using docker to make it super easy to use and **integrate rankquest into your build**. No installation required for this either!

```bash
# help
docker run -it --network host -v $(pwd):/rankquest jillesvangurp/rankquest-cli --help
# run the demo scripts included with rankquest-cli (requires elasticsearch)
docker run -it --network host -v $(pwd):/rankquest jillesvangurp/rankquest-cli -c demo/movies-config.json -t demo/testcases.json -v -f
```

## Conclusion

If you went to a lot of trouble to build a search service for your product, you should test its quality and strive to make it better. **What's stopping you?** Open [Rankquest Studio](https://rankquest.jillesvangurp.com) and start improving your search quality today. Let me know how it goes and what you think. Reach out if you need support or help or if you have any suggestions for improvements. And if you want an outside pair of eyes on your search experience to see how it can be improved, I'm available for consulting.

If you have ideas for more features, or want to add some functionality, please create a Github issue or a pull request.

