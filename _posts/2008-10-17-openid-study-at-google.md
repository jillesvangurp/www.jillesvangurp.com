---
id: 499
title: OpenID study at Google
date: 2008-10-17T19:31:34+00:00
author: Jilles
layout: post
guid: http://www.jillesvangurp.com/?p=499
permalink: /2008/10/17/openid-study-at-google/
dsq_thread_id:
  - "336377710"
categories:
  - Blog Posts
tags:
  - google
  - IDP
  - oauth
  - openid
  - YYY
  - ZZZ
---
Google and Yahoo have both posted a usability study for federated and openid logins. Basically both of them hint at keeping things simple and as easy to use for the user. Google has a quite nice suggestion about the UI but they all but stop at going all the way.

We've done a lot of thinking on this topic regarding the [demo and youtube](https://www.jillesvangurp.com/2008/10/09/local-interaction-demo-on-youtube/) movie I linked last week. We have a similar problem that our users have to login, somehow and then login again for OAuth like authentication with e.g. Facebook for extra features.

I really like Google's UI but would like to suggest a few simplifications:

Basically the site should ask:

With what openid identity, email address or username do you wish to login (excuse ascii art)?

```text
-------------------------------- ------
| http://www.jillesvangurp.com | | OK |
-------------------------------- ------

```

The user will enter whatever seems right and the server will make a best effort to authenticate with whatever the user provides. Then the server checks the following rules (using AJAX of course) against the address/username

- address/username known, not an IDP -> ask for the password
- address//username known & an IDP -> redirect to IDP. Let user choose username optionally when returning to the site so the user can login with either short login name or IDP identifier.
- not known & an IDP -> redirect to IDP, on return create an account on the fly with info IDP provides
- not known, not an IDP -> show create account form, let user pick a  username if email address was entered. Optionally, point out how to sign up with an OpenID provider and of course allow login with a different ID.

This is as simple as it gets. Basically, the only problem is the user entering a username that is in use by somebody else. A password field will show and login will fail.

The failure should look like this.
Login failed because the user and password are incorrect. You can either:

- try another password
- try another openidurl, email address or username
- sign up with us or one of these Identity providers: XXX, YYY, ZZZ

This is as simple as it gets and it still supports a wide variety of login mechanisms.

Advantages:

- Only one question that the user should be able to answer: who am I?
- Using OpenID is rewarded by easy login
- Worst case, user still has to provide a password.
- Can support any kind of authentication, including non password based ones.
