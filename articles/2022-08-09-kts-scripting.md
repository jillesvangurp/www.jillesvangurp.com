---
title: Kts Scripting of Yaml & Json Dialects
published: true
description: How to make using Yaml and Json based DSLs more DRY and usable.
tags: kts, kotlin, elasticsearch, github
---

I've been using Kotlin for quite a few years now. And while I've been using Gradle with the Kotlin scripting support, I've not done much else with Kotlin's scripting ability until fairly recently.

Kotlin scripting (kts) allows you to write scripts with a slightly unfortunate ending of `.main.kts` that can be interpreted by the Kotlin compiler on the command line. Adding `#!/usr/bin/env kotlin` to your script tells your shell to use kotlin to execute the script. Any dependencies needed by the script are cached after the first use. So, running these script is generally pretty quick once you have all the jars you need.

## Scripting Github Actions

One of my team members, [Nikky](https://twitter.com/nikkyai), got annoyed with the verbosity and insane amount of copy-paste reuse needed to drive Github Actions. And true to her nature, promptly fixed it by using and contributing to [GitHub Actions Kotlin DSL](https://krzema12.github.io/github-actions-kotlin-dsl/)

This Kotlin DSL allows you to script github actions using kts. The idea is you write your actions as a `.main.kts` file, give it execute permissions and then it spits out Yaml files when you run it (one for each workflow that you configure). All the repetitive stuff? Use functions or variables or constants. So much nicer.

Here's a short example:

```kotlin
#!/usr/bin/env kotlin
@file:DependsOn("it.krzeminski:github-actions-kotlin-dsl:0.21.0")

import it.krzeminski.githubactions.actions.appleboy.SshActionV0
import it.krzeminski.githubactions.domain.RunnerType
import it.krzeminski.githubactions.domain.triggers.Push
import it.krzeminski.githubactions.domain.triggers.WorkflowDispatch
import it.krzeminski.githubactions.dsl.expressions.expr
import it.krzeminski.githubactions.dsl.workflow
import it.krzeminski.githubactions.Yaml.writeToFile

val branch = "production"
val environment = "our-environment"

val appServers = mapOf(
    "app1" to "192.168.0.152",
    "enrich1" to "192.168.0.248",
    "app2" to "192.168.0.43",
)
val bastionIp = "xxxxxxxx"
val deployKey = expr("secrets.DEPLOY_KEY")

fun sshAction(host: String, script: String): SshActionV0 {
    return SshActionV0(
        host = host,
        port = 22,
        username = "ubuntu",
        key = deployKey,
        proxyHost = bastionIp,
        proxyPort = 22,
        proxyUsername = "ubuntu",
        proxyKey = deployKey,
        script = script
    )
}

workflow(
    name = "Deploy to $branch",
    on = listOf(
        Push(branches = listOf(branch)),
        WorkflowDispatch()
    ),
    sourceFile = __FILE__.toPath(),
    targetFileName = "deploy_${branch}_$environment.yml",

    ) {

    job(
        id = "publish-telekom-$branch",
        runsOn = RunnerType.UbuntuLatest
    ) {

        appServers.forEach { (name, ip) ->
            uses(
                name = "restart-$name-$branch-$environment",
                action = sshAction(ip, "/opt/formation/bin/restart")
            )
        }
    }
}.writeToFile(true)
```

Note how we use a loop to call the sshAction function three times. This script generates a Yaml file which is much longer and repeats the action three times. Not DRY and super brittle. And that's on top of the complete lack of type checks, auto-completion, etc. Doing this with kts is so much nicer, much less error prone, and much quicker to figure out.

The little `writeToFile(true)` spits out the Yaml and tells it to add a consistency check that ensures the committed Yaml matches the script output. So, modifying the kts script and then forgetting to run it will fail the action.

There is much more to this library of course. A lot of github actions are supported out of the box (see [here](https://krzema12.github.io/github-actions-kotlin-dsl/supported-actions/) for an overview) and you can add support for additional extensions pretty easily; or just pass in a map.

Also, you can of course produce more than one action from a single kts script. We use this to configure actions for e.g. pull requests and merges to master. The latter has some continuous deployment related actions but of course they share a lot of code. Likewise, most of our actions include a slack notification and share a lot of configuration. With Yaml, you end up with a lot of duplication. With kts, you can get rid of all that duplication.

Finally, not having to deal with Yaml's weird syntax is a big plus. Manually editing Yaml seems very brittle, verbose, and error prone.

## Applying my new knowledge to kt-search

I've been working on [kt-search](https://github.com/jillesvangurp/kt-search), my Kotlin Multi-Platform client for Opensearch and Elasticsearch for a while. Somehow, it never occurred to me that using that in combination with kts is such an obvious thing to do.

So, that was easily remedied and I now have a [companion library](https://github.com/jillesvangurp/kt-search-kts) that combines that with `kotlinx-cli` to make writing scripts very straightforward.

Here's a little script that checks status of your Elasticsearch/Opensearch cluster:

```kotlin
#!/usr/bin/env kotlin

@file:Repository("https://jitpack.io")
@file:Repository("https://maven.tryformation.com/releases")
@file:DependsOn("com.github.jillesvangurp:kt-search-kts:0.1.3")

import com.jillesvangurp.ktsearch.ClusterStatus
import com.jillesvangurp.ktsearch.clusterHealth
import com.jillesvangurp.ktsearch.kts.addClientParams
import com.jillesvangurp.ktsearch.kts.searchClient
import com.jillesvangurp.ktsearch.root
import kotlinx.cli.ArgParser
import kotlinx.coroutines.runBlocking

val parser = ArgParser("script")
val searchClientParams = parser.addClientParams()
parser.parse(args)

val client = searchClientParams.searchClient

// now use the client as normally in a runBlocking block
runBlocking {
    val clusterStatus=client.clusterHealth()
    client.root().let { rootResp ->
        println(
            """
                Cluster name: ${rootResp.clusterName}
                Search Engine distribution: ${rootResp.version.distribution}
                Version: ${rootResp.version.number}
                Status: ${clusterStatus.status}
            """.trimIndent()
        )
    }
}
```

Several things that are happening here. It pulls in the `kt-search-kts` jar and it's dependency `kt-search` as well as a lot of other dependencies.

Then it creates a `kotlinx-cli` parser and adds the parameters we need to be able to set host, port, and other settings we need to get a search client. And then it calls the `searchClient` extension property on that to create the client with those settings.

And then we use it. You can do whatever you want with this:

- Run some queries
- Do some bulk indexing
- Use the snapshot APIs
- Configure cluster settings
- Index management

I've seen other scripting languages being used for this. Python and go seem to be popular options for this. IMHO, this is nicer. More type safety, less guessing, less verbosity.

## How to run these scripts

To run these scripts, you need to install kotlin 1.7.x via your package manager of choice. Homebrew works, there's a snap package, there's an arch package, etc. Whatever OS and package manager you use, you can probably make it run. And of course you can also use docker for this.

After that, just make sure the shebang is set correctly ('#!/usr/bin/env kotlin') and give your script execute permission:

```bash
chmod 755 myscript.main.kts
./myscript.main.kts
```

## Is it perfect?

Of course this is far from perfect. In my opinion, Jetbrains can and should make a big effort to make this way nicer.

- The `.main.kts` filename ending is silly. This should be just `.kts`. I'm sure there's a reason for this but I doubt it's a very good reason.

- Kotlin has a native compiler now that works on Linux, Mac, and Windows. And a growing ecosystem of multi-platform libraries. Pre-compiling scripts to binaries would be a nice option. Even pre-compiling them to executable jar files might be a nice thing and it would simplify the run-time dependencies.

- The import mechanism is a bit flaky and brittle and doesn't understand multi-platform dependencies. If you look at the build file of `kt-search-kts`, you will see it depends on `kt-search-jvm`. Adding the `-jvm` forces it to depend on the jvm variant. Reason: the dependency resolution in kts is not smart enough to add this by itself.

## Final verdict

These are just two examples of what you can do with kts. Out of the box, you can use the full Java standard library and as I show above, adding some additional dependencies is pretty easy. One of Kotlin's killer features is defining so-called internal Domain Specific Languages (DSLs). Basically, you abuse the Kotlin syntax to turn whatever framework you have into a mini DSL. My search client has DSLs for querying, index mappings, bulk indexing, etc. And the Github action library I use of course provides a DSL for Github actions.

Whatever you are dealing with, you can create a Kotlin DSL for it. If you have any Json dialect, checkout my [JsonDsl](https://github.com/jillesvangurp/kt-search) library, which is part of kt-search. With that you can create simple Kotlin classes to model your DSL using type safe properties and have a run-time modifiable map to add anything it doesn't model. Creating a Yaml version of this is very straightforward and likely something I might do at some point (pull requests welcome).

Once you have that, you can script whatever: Amazon Cloudformation, Ansible, Elasticsearch Queries, etc. So, while kts still has some rough edges, it is so much nicer than writing Yaml, ansible, or whatever other type unsafe, not quite-a-scripting-language, you are using currently. Minimal verbosity, maximum gains.

