---
title: Publish Kotlin multiplaform jars to a private maven repository in GCS
author: Jilles van Gurp
published: true
description: Creating a google cloud storage based maven repository for storing kotlin multiplatform jars.
tags: kotlin, multiplatform, gradle, gcs
---

A version of this article was also published on [dev.to](https://dev.to/jillesvangurp/publish-kotlin-multiplaform-jars-to-a-private-maven-2bdh).

A recurring topic on many projects for me is publishing private packages of some sort so that they can be used in other private projects. Historically this has always been a PITA to setup and involves either paying someone to provide you some SAAS solution or reserving a chunk of time to do devops. It's a reason I often dodge the issue by simply not bothering with maven repositories.

I code a lot of Kotlin in the last few years and that means I get to deal with gradle a lot. On many projects people dodge the need for private repositories by doing mono repositories with multi module gradle or maven repositories. I've always hated dealing with multi module gradle projects because things slow down a lot when you are waiting for builds to happen. As soon as you have n modules, everything now happens n times (compile, test, package, etc). And while build tools are great for making things repeatable, they do have the potential to suck the life out of you in terms of consuming all your time. Three minutes may sound like nothing but repeat that 10-20 times in a day and you have just lost an hour.

So, especially for things that don't change a lot wouldn't it be nice if you could park them in a separate project and just download the already compiled binary. The short answer to this completely rhetorical question is "well duh". That's where private maven repositories come in. 

## Multiplatform

Recently, Kotlin multiplatform became a thing. With Kotlin multiplatform, you cross compile Kotlin code to multiple platforms like IOS, Android, Linux, WebAssembly, Javascript, etc. using the Kotlin multiplatform gradle plugin. This makes a lot of sense if you are trying to reuse code between different platforms and a natural fit for this is extracting common code into a multiplatform library that you then need to put somewhere so you can actually use it. Somewhere like a private maven repository.

The last two weeks or so, I've been working on lots of new things since I joined [Formation](https://tryformation.com). One of those things is exactly this. We have android code and some server code written in Kotlin and are currently writing a lot more code. So, obviously Kotlin multiplatform has our interest since we want to do IOS soon as well. When I say "has our interest". 

What I really mean is I was stuck in Gradle hell for the past week trying to figure out this stuff from scraps of misleading, outdated, incomplete, or flat-out wrong documentation, stack overflow posts, etc. This stuff is very new and immature and technically only available in Beta so far. So, this is not unexpected.

I've been trying to figure out an easy strategy to deploy multiplatform artifacts via a private repository. We started with Github Packages because we are on Github and are making full use of their freemium layer; which is actually really great these days. We pay 0$ for a Github organization with as many private repositories as we need, we get CI/CD via Github actions and I've even managed to use Github Packages. Sadly, Github packages has evaded all my attempts to make it work with Kotlin multiplatform. Given the awesome price tag, I still think it's pretty nice but it seems this is a dead end (for now) for multiplatform at least. I also tried Jitpack with a public repository and had issues with that as well.

## GCS based repository

We currently deploy some server stuff in Google Cloud which provided me with another false start in the form of Google Artifacts, which is a package repository with maven functionality that is currently in some alpha release and therefore not something you can actually use yet. That's a bit of a bummer because presumably Google is going to be all over Kotlin multiplatform given their Android involvement (or they should be, big corporations have trouble with doing logical things like this).

So, two potential candidates for a private repository down, I was getting a bit frustrated until I remembered that I got some mileage out of setting up maven repositories via ssh some years ago (while I was still using maven) and more recently using an s3 bucket (also on a maven project). That led me down a rabbit hole of **"I wonder if I can do something with Google Storage for this ..."**.

In short, yes. Google storage is a lot less popular than S3, which caused me a few headaches piecing together what I actually needed to do. But eventually I figured it out:

```kotlin
plugins {
    // we're using the multiplatform plugin
    kotlin("multiplatform") version "1.3.72"
    // we want to publish our jars
    id("maven-publish")
}

// first you need set up your publishing repository
publishing {
    repositories {
        maven {
            url = if(publishLocal.toBoolean()) {
                // great for testing
                // gradle publish -PpublishLocal=true -Pversion=0.42
                uri("file:///${projectDir}/build/localrepo")
            } else {
                // this is what we do in github actions
                // GOOGLE_APPLICATION_CREDENTIALS env var must be set for this to work
                // either to a path with the json for the service account or with the base64 content of that.
                // in github actions we should configure a secret on the repository with a base64 version of a service account
                // export GOOGLE_APPLICATION_CREDENTIALS=$(cat /Users/jillesvangurp/.gcloud/jvg-admin.json | base64)
                uri("gcs://insert-your-bucket-name-here/releases")
            }
        }
    }
}

repositories {
    // if you want to depend on jars from your repo, add it like so
    maven { url = uri("gcs://insert-your-bucket-name-here/releases") }
    mavenCentral()
}

kotlin {
    jvm {
        // ...
    }
    js {
        // ...
    }
}
```

Just add that to your `build.gradle.kts` file. The multiplatform plugin actually integrates well with the publishing plugin so things should just work without further configuration. You may need to set artifactId, groupId and version somewhere of course.

The tricky bit is getting credentials to the plugin. Basically, see the comments for that. You need a service account credentials file stored locally and the `GOOGLE_APPLICATION_CREDENTIALS` environment pointing to that. I did this via the console but you should be able to do this via the command line if you prefer.

For good measure, I also added a local repo so I can test it actually does the right things before creating a mess in my bucket.

## Setting up CI to do this automatically

Then the next issue is setting up a github actions workflow to do this for us:

```yaml
name: Publish package to GitHub Packages
on:
  release:
    types: [created]
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: 1.8
      - name: Save google token
        run: echo "${{ secrets.GOOGLE_CLOUD_KEY }}" | base64 -d > ${{ github.workspace }}/google_tok.json
      - name: Publish package
        run: gradle -Pversion=${{ github.event.release.tag_name }} build publish
        env:
          #          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GOOGLE_APPLICATION_CREDENTIALS: ${{ github.workspace }}/google_tok.json

```

Basically, the way this works is that whenever I tag a release via Github's releases feature, it triggers this workflow to publish a set of jars to my gcs bucket. I simply added my token in base 64 as a secret to the github project:

```bash
cat mytoken.json | base64 | pbcopy
```

Then the first workflow step unpacks that and puts it into a file in the workspace. The second one adds the `GOOGLE_APPLICATION_CREDENTIALS` variable.

## Conclusions

Setting up a private repository like this is easy and cheap. It's was a PITA to piece together the relevant bits of documentation; so I wrote up an article documenting this both for my future self (I'll likely use this again) and for others to benefit from. I've been using this on two internal projects for a few weeks and we are currently using the artifacts in our Android project. Soon, we'll likely start experimenting with IOS as well.

The same instructions should also work for S3, although the credentials for that are a bit easier to deal with (just grab your key and secret and put them into Github secrets and use them as is).
