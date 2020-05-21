---
title: Using Cloudfront, S3, & Route 53 for hosting a web site
description: Overview of how to work around a few issues when hosting a one page app using Cloudfront, S3 and Route 53
tags: AWS, Cloudfront, S3
--- 

This article was originally published on [dev.to](https://dev.to/jillesvangurp/using-cloudfront-s3-and-route-53-for-hosting-395o).

- [Basic setup](#basic-setup)  
- [Updating content](#updating-content)  
- [Cloudfront invalidations](#Cloudfront-invalidations)  
- [Url rewrites using S3](#url-rewrites-using-s3)  
- [Conclusion](#conclusion)

In the past few months, I've retired our nginx server and replaced it with Cloudfront, s3, Route 53, and amazon issued certificates to simplify hosting [www.inbot.io](https://www.inbot.io). This has been a bit more painful than I liked and there have been a few issues. This is mainly because the AWS documentation sucks and is fragmented over different products and generally represents a maze of misdirection.

Anyone from Amazon reading this, a helpful guid for somebody looking to combine your products for a basic use case like "Given a completely bog standard one page javascript website, this is how you host it on AWS" would be extremely  helpful. Instead you have bits and pieces of documentation for each of your products leaving all the other bits and pieces as an exercise to the reader. I had to refer to Stackoverflow because every documentation page you land to seems to be lacking some crucial details. I wasted some serious amounts of time figuring out this most basic of uses for these products.

The good news is that it does work once you figure out all the workarounds in each of their products. The benefit is that it simplifies your infrastructure for a simple one page app. We have no self hosted bits and pieces. Additionally, a CDN ensures that your users have a good experience downloading your website from a fast CDN instead of hitting your poor web server on the wrong side of the globe. The bad news is that the AWS UI is a bit lacking in usability and flexibility and doing some common things that you would do in e.g. nginx are not that easy.

So, to avoid me having to google this together again, I'm documenting what I had to do to make this work. Also, others may find this useful.

## Basic setup

First, thanks to Tiberiu Oprea for [this extremely helpful overview](https://medium.com/faun/how-to-host-your-static-website-with-s3-Cloudfront-and-set-up-an-ssl-certificate-9ee48cd701f9). This will get you pretty far. I'm not going to repeat everything that he says there and will instead focus some extra stuff I had to figure out separately. AWS people reading this, use this website as a reference on how to properly document your product.

Assuming you followed his instructions to the letter, you would end up with a Cloudfront + s3 setup (just replace `inbot.io` with your own domain):

- https certificates for `inbot.io` and `www.inbot.io` in the AWS certificate manager. One gotcha here is that it takes ages for Cloudfront to actually see those. Allow a few hours for this to be picked up. If you get it wrong, delete and try again. I lost half a day over this where I thought I was doing it wrong when in fact Cloudfront just is a bit stupid when it comes to actually asking for the current list of certificates. Eventually they showed up in the relevant drop down. Give it some time.
- An s3 bucket with the domain `www.inbot.io.s3-website-eu-west-1.amazonaws.com`. This is where you deploy your static content. I suggest using AWS cli for this.
- Another s3 bucket with the domain `inbot.io.s3-website-eu-west-1.amazonaws.com`. This bucket is configured to redirect to `www.inbot.io`. It has no content.
- Two matching Cloudfront setups for both buckets. Make sure you redirect http to https in Cloudfront.
- Two A records in Route 53 pointing for the domains with and without `www` at both Cloudfront setups.

Note that the **bucket names are important** for getting Route 53 to do the right things. So match the domain name in the bucket name and don't get creative here.

You can verify that everything redirects as required with a few simple curl commands:

```bash
# Cloudfront redirects to https
curl -v http://inbot.io 
# Cloudfront hits the S3 bucket and S3 redirects to https://www.inbot.io
curl -v https://inbot.io
```

If all this works alright, your browser will redirect `http://inbot.io/whatever/path` to `https://www.inbot.io/whatever/path` via two permanent redirects. So users typing in `inbot.io` end up on your website instead of a blank page, or worse, an S3 403 XML page. 

This seems like the AWS product people needs to get spanked a little. This is literally one of the most basic use cases a user of their products might have which is to host a simple website and it totally sucks. There's literally no website in this world that would not want this out of the box without having redirects for https and handling domains with and without www. This should not require two separate buckets and Cloudfront setups. This is madness. But at least it works.

## Updating content

One problem with Cloudfront is that TTLs are pretty long. This is helpful for caching things in a globally distributed CDN, but annoying when you need to fix a bug fix in your website and it takes hours or days for your users to actually get the fix. Addressing this requires some planning.

If you use something like Webpack, you should ensure the file names are hashed so this does not matter for most files. This leaves you one file that is still a problem: `index.html`. Since in our case this file is small, I ended up disabling TTL for this.

In our CI build we use AWS cli to interact with AWS. We use this command to upload our index.html like this:

```bash
aws s3 cp ./build/index.html ${S3_BUCKET} \
  --acl public-read \
  --cache-control max-age=0,no-cache,no-store,must-revalidate
```

S3 will respect these headers and start serving your new index.html as soon as you fix something. Cloudfront passes these headers to the browser as well.

For the other files, we use a reasonable TTL. We have a bunch of static files that rarely change and lots of webpack hashed artifacts that generate new files.

One gotcha here is to not use `aws sync --delete`. The problem here is that if you delete a file from s3 and the user still has an old `index.html` pointing to the old file hash, they will now run into 404s until they force reload the page in their browser. And of course assuming they even know how to do this; this poses some unique challenges on mobile.

## Cloudfront invalidations

You can force Cloudfront invalidations when you deploy new content. The main file to invalidate is `index.html`. This ensures that Cloudfront updates the CDN nodes world wide within a few minutes instead of doing it much slower after the next user tries to load the file for the first time. So, within minutes after updating this any browser that reloads our page, will hit Cloudfront to get the latests because it forwards the `max-age=0,no-cache,no-store,must-revalidate` and then get the latest version.

```bash
aws Cloudfront create-invalidation \
  --distribution-id ${CLOUDFRONT_ID} \
  --paths / /index.html /app/index.html
```

Of course keeping your index.html small will be helpful since loads from s3 are going to be a bit slower than cache hits from Cloudfront. This is OK since the bulk of our content is in the javascript and other files.

## Url rewrites using S3

We had a few url rewrites in our nginx. These caused us some headaches until I figured out how to use S3 Routing Rules. Part of the problem here is that we had some links that we distributed to users that broke without us knowing because things got lost during the redirects. For example, we have a reward program for referring new users. They click on a link that used to go to `http://inbot.io/join/XYZ` (we've since fixed that to at least go to `https`) where XYZ is a referral code that needs to be passed into the javascript that constructs the signup form on our website so it can be passed to our server. To redirect this, I added a rule to our S3 bucket's static content properties:

```xml
<RoutingRules>
  <RoutingRule>
    <Condition>
      <KeyPrefixEquals>join/</KeyPrefixEquals>
    </Condition>
    <Redirect>
      <Protocol>https</Protocol>
      <HostName>www.inbot.io</HostName>
      <ReplaceKeyPrefixWith>app/index.html#/join/</ReplaceKeyPrefixWith>
    </Redirect>
  </RoutingRule>
</RoutingRules>
```

Note, the protocol and hostname are essential, otherwise S3 will happily redirect you to the bucket url without SSL.

You can also use `RoutingRules` to fix nicer http errors for e.g. 403s that S3 throws when it can't find an object (how is that not a 404?). One of these days, I'll probably invest some time in using AWS cli or Cloudfront to do this in one command but I ended up clicking all of this together in the AWS ui.

So this fixed our issues. Note we are redirecting to `app/index.html#/join/XYZ`. I decided to get rid of our subdomain for the web app and simply host everything under `www.inbot.io`. Inside our web app, we use `#` paths (aka anchors) and everything is handled by our javascript.

## CORS header for our stellar.toml

Another issue we had that was that we have one file on our site that needs to have CORS headers set correctly. The file in question is the `stellar.toml` file that Stellar uses to figure out meta data about our cryptocurrency, the InToken. The how and why is not important but setting up CORS is a common requirement and something that is straightforward in nginx. This one had me pondering for a while. S3 does not provide a good solution for this. However, it turns out that in Cloudfront you can configure so-called cache behaviors for specific paths. In our case we added a behavior for `/.well-known/stellar.toml`, with the custom header. This location is where Stellar clients expect to find the meta data file. And since a lot of Stellar clients are browser applications, they need the CORS headers to be set correctly. If you want to read more about this, refer to the [Stellar documentation](https://www.stellar.org/developers/guides/concepts/stellar-toml.html).

## Conclusion

This setup is working pretty OK. We have a simple CI job that does most of this. I did use the AWS UI to click together the buckets and Cloudfront setup. You could probably use e.g. Cloudformation or some aws cli incantations for this but since this is a one time thing, I did not bother to automate this. The flip-side of that is that it is kind of a long process with many steps and quite easy to mess up.

Also, I'm not completely happy about having to do a lot of things in the AWS UI (painfully unusable). However, I can't bring myself to automating this hopefully one time setup. There are diminishing returns when it comes to automating this stuff.







