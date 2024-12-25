# 2024 in Review for jillesvangurp/kt-search

With the end of the year nearing, it's a good moment to look at how far **[kt-search](https://github.com/jillesvangurp/kt-search)** has come. This year was the first full year of stable releases. I released version 2.0 mid 2023 and since then, I've been getting more and more external contributions. So much that I decided to write up a little overview.

In 2024 13 external developers took the time to contribute pull requests to kt-search. Thank you! They contributed a total of 27 pull requests. We started the year with version 2.1.11. Since then, I've released 28 releases. Mostly whenever something is improved, I cut a release immediately. When somebody contributes something, their intention is, probably, to use it. So, I try to stay on top of this and be good about it. This doesn't always work out but I do my best.

The 2.1 series went all the way to 2.1.31. Then Kotlin 2.0 was released over the summer. Because this is a disruptive update, for people still on 1.9, I bumped the minor version at that point. Kotlin 2.0 also enabled me to finally deliver on the promise of making kt-search a proper multiplatform release. That landed a few versions later and I bumped the version once more to 2.3.0 only two months ago. As of that version, kt-search should work (almost) on every platform Kotlin can compile to. Support for the missing platforms was added by two contributors who created pull requests to support IOS and Linux.

As of Christmas day 2024 when I merged the (probably) last PR of the year, we are at 2.3.4.

## Before 2024: a brief history of kt-search

I started using Elasticsearch in 2012 after working with Solr and Lucene. Over the years, I developed several Java client libraries, including some open-source ones, to interact with Elasticsearch. Early on, Java lacked proper HTTP clients, relying instead on a client that joined the cluster—a mechanism that was later deprecated and, in my view, flawed. I maintained REST clients before Elasticsearch 1.0 but abandoned an OSS release for version 2.0 due to breaking changes in version 5 and my continued use of 1.x.

When I switched from Java to Kotlin around 2018, I wrote a little Kotlin library with extension functions around the official Elastic Java REST client to make that nicer to use. I added a little extensible Kotlin DSL for querying. I open sourced that client and it became moderately popular. That DSL still survives in kt-search and is now the core of the library.

When Elastic changed their license, the Opensearch fork happened as a response for that. And as a result the Java client was forked. Shortly after that Elastic deprecated their client and created a new one. This was disruptive to my work and I decided to cut loose from Java clients and Java completely and develop kt-search: a client that supports both Elasticsearch and Opensearch and that is designed to be multiplatform as well. It works anywhere Kotlin works.

Since technically this was a continuation of the old client (it reuses the search DSL and a few other things), I decided to tag the first version as 2.0 after a long series of release candidates, and 1.99.x pre-releases.

## Stability

2024 was the first year of stability. At the beginning of the year, things were generally stable and we were well into the 2.1 series of releases. Also, I have been using the client since the early 1.99 days in FORMATION.

To my pleasant surprise, I started seeing more and more pull requests from outside contributors throughout the year. This continued the trend from 2023 where there were already quite a few. And of course this signalled to me that I was doing something right with kt-search and motivated me to put more time in the project.

## External contributions

A total of **27 pull requests** were merged this year from external contributors. Here's an overview of pull requests that were made.

- [#100](https://github.com/jillesvangurp/kt-search/pull/100) - Convert refresh interval to duration by barbulescu
- [#101](https://github.com/jillesvangurp/kt-search/pull/101) - Reindex query by barbulescu
- [#103](https://github.com/jillesvangurp/kt-search/pull/103) - Reindex remote by barbulescu
- [#104](https://github.com/jillesvangurp/kt-search/pull/104) - Minor misspell fixes by barbulescu
- [#106](https://github.com/jillesvangurp/kt-search/pull/106) - Delete index failure by barbulescu
- [#108](https://github.com/jillesvangurp/kt-search/pull/108) - Improve nested query test by barbulescu
- [#112](https://github.com/jillesvangurp/kt-search/pull/112) - Add join field mapping by csh97
- [#115](https://github.com/jillesvangurp/kt-search/pull/115) - Add join query support by csh97
- [#121](https://github.com/jillesvangurp/kt-search/pull/121) - Add highlight query DSL by larsgraedig
- [#122](https://github.com/jillesvangurp/kt-search/pull/122) - Bulk routing by csh97
- [#128](https://github.com/jillesvangurp/kt-search/pull/128) - Maven improvements by dybarsky
- [#131](https://github.com/jillesvangurp/kt-search/pull/131) - Add script-based sorting by yonghee12
- [#132](https://github.com/jillesvangurp/kt-search/pull/132) - Analyze by mixify
- [#133](https://github.com/jillesvangurp/kt-search/pull/133) - MinimumShouldMatch by sinkyoungdeok
- [#134](https://github.com/jillesvangurp/kt-search/pull/134) - Fix highlight query by AnyRoad
- [#135](https://github.com/jillesvangurp/kt-search/pull/135) - Rescore by AnyRoad
- [#136](https://github.com/jillesvangurp/kt-search/pull/136) - Match all match none by AnyRoad
- [#137](https://github.com/jillesvangurp/kt-search/pull/137) - Date range aggregation by AnyRoad
- [#138](https://github.com/jillesvangurp/kt-search/pull/138) - Term agg key as string by AnyRoad
- [#139](https://github.com/jillesvangurp/kt-search/pull/139) - Add search after parameter by sinkyoungdeok
- [#142](https://github.com/jillesvangurp/kt-search/pull/142) - Sum aggregation by mixify
- [#147](https://github.com/jillesvangurp/kt-search/pull/147) - iOS support by lhoracek
- [#152](https://github.com/jillesvangurp/kt-search/pull/152) - Linux support by szaffarano
- [#153](https://github.com/jillesvangurp/kt-search/pull/153) - Add matched queries by AnyRoad
- [#157](https://github.com/jillesvangurp/kt-search/pull/157) - Bulk response by cdekok
- [#158](https://github.com/jillesvangurp/kt-search/pull/158) - Fix delete scroll by ewanmellor

Most of these pull requests are about adding explicit support for things that these contributors needed: query parameters on requests, DSL features, etc. This is great and exactly as intended: I designed kt-search to be easy to extend precisely so users don't get blocked on missing features. But it's great to see people contribute things that make make life better for everyone.

## My own contributions

As a contributor, I of course also merged some of my own contributions. I created **15 pull requests**:

- [#109](https://github.com/jillesvangurp/kt-search/pull/109) - More useful 4xx exceptions
- [#111](https://github.com/jillesvangurp/kt-search/pull/111) - Handle 429 error in update
- [#114](https://github.com/jillesvangurp/kt-search/pull/114) - Make retry delay configurable
- [#119](https://github.com/jillesvangurp/kt-search/pull/119) - Remove JSON DSL
- [#120](https://github.com/jillesvangurp/kt-search/pull/120) - Improve keywords config
- [#123](https://github.com/jillesvangurp/kt-search/pull/123) - Update dependencies
- [#125](https://github.com/jillesvangurp/kt-search/pull/125) - Patch updates
- [#126](https://github.com/jillesvangurp/kt-search/pull/126) - Move to external JSON DSL
- [#140](https://github.com/jillesvangurp/kt-search/pull/140) - Term query numbers and booleans
- [#141](https://github.com/jillesvangurp/kt-search/pull/141) - Highlighting docs
- [#143](https://github.com/jillesvangurp/kt-search/pull/143) - Kotlin 2.0 upgrade
- [#144](https://github.com/jillesvangurp/kt-search/pull/144) - Terms case insensitive
- [#150](https://github.com/jillesvangurp/kt-search/pull/150) - Ktor client 3 and WASM
- [#154](https://github.com/jillesvangurp/kt-search/pull/154) - See if it builds without headers
- [#156](https://github.com/jillesvangurp/kt-search/pull/156) - Improve terms aggregation

In addition to these pull requests, there have also been some commits straight to master by me. Mostly minor stuff. But worth calling out. There were 227 commits in total. A lot of that was just gardening, documentation, etc. But also some minor feature work.

## Looking Ahead

Thanks to all contributors for all their wonderful work. Looking ahead, I'm planning to keep on improving kt-search. It is never done. There are always more features to add, bugs to fix, new things to document.

However, things have been stable throughout the year and I want to keep it that way. Most of the contributions at this point are about adding features or updating things. The way I've designed this library is to make it such that the DSLs are easily extensible via json-dsl, which became a separate library as of [#119](https://github.com/jillesvangurp/kt-search/pull/119).

Nevertheless, there are a few trends that I'm seeing:

- Opensearch and Elasticsearch are growing further apart and are at this point **diverging more and more** with some unique new features. And more and more of my clients are defaulting to Opensearch as well. I might invest some time in supporting some of these features. But of course, there's nothing stopping you from using any of this with the extensible search DSL, of course. But having type safe, first class support is always nice.
- **Cloud connectivity** for both AWS Opensearch and Elastic Cloud could be improved. It works but only via simple basic authentication currently. Particularly Amazon uses some convoluted request signing mechanism and I lack access to an AWS cluster to test against. I use Elastic Cloud in FORMATION but have so far not implemented using OAuth since basic authentication works well enough.
- **Vector search** is an area that has seen a lot of feature work in the past few years. While I have support for some of these features, I would like to add more support to make it easier for users to start using this.
- Kotlin 2.0 is unlocking new language features. Like multiple context receivers. As these get released, I may add support for some of them.
- With **web assembly support** now there, I may start playing with that some more. One of the intriguing possibilities of having a multiplatform client is that it works in a browser too...
- In general, I see a trend with e.g. **ktor server** to target other platforms than just the JVM. WASM is getting more important on servers; and even the native Linux compiler is now stable enough that that becomes an option as well. Whichever you pick: kt-search should work there. I say should, there may very well be all sorts of platform specific bugs and limitations that I'm not aware off. Things should work and the integration tests are running on most platforms (except IOS). But at the same time, I don't use kt-search on a lot of different platforms. Let me know if you run into issues.
- The one feature I use in Elasticsearch that is not in Opensearch is producing maplibre compatible heatmaps as a map layer via aggregations straight from Elasticsearch. This is a feature I'd like to port to Opensearch and build out to have more support. I'd love to be able to **serve map layers straight from Elasticsearch or Opensearch**. FORMATION serves up a lot of map content and we jump through some hoops currently to get that in the browser. I'm considering implementing this via the client so I can proxy requests via our application server.
- **Aggregation support** has been gradually built out but is still quite tricky. I use them a lot for things like analytics in our product and I might put more time in this as well.

But those are just some my own ideas and plans. I'd love to hear your thoughts as well. Reach out or add tickets in the issue tracker. As ever, reach out if you are planning to do bigger pull requests so we can discuss and coordinate and avoid mutually wasting a lot of time.

**View the repository on GitHub: [jillesvangurp/kt-search](https://github.com/jillesvangurp/kt-search)**