---
title: OpenID, the identity landscape, and social networks
date: 2009-05-21T10:30:31+00:00
author: Jilles van Gurp


permalink: /2009/05/21/openid-the-identity-landscape-and-social-networks/
dsq_thread_id:
  - "425025902"
categories:
  - Blog Posts
tags:
  - BTW
  - google
  - nokia
  - NRC
  - openid
  - social networks
---
I'm still getting used to no longer being in nokia research center. One of my disappointments of being in NRC and being a vocal proponent of openid, social networks, etc. was that despite lots of discussion on this topic not much has happened in terms of me getting room to work on these topics or me convincing a lot of people about my opinions on these topics. I have one publication that is due out whenever the magazine involved gets around to approving and printing the article. But that's it.

So, I take great pleasure in observing how things are evolving lately and finding that I've been pushing the right topics all along. Earlier this week, Facebook became a relying party for OpenID. Outside the OpenID community and regular techcrunch readers, this seems to have not been a major news story. Since, just about anybody I discussed this topic with in the past few years (you know who you are) always insisted that "no way that a major network like Facebook will ever use OpenID". If you were one of those people: admit right now that you were wrong.

It seems to me that this is a result of fact that the social networking landscape is maturing. As part of this maturation process, several open standards are emerging. Identity and authentication are very important topics here and it seems the consensus is increasingly that no single company is going to own all 6-7 billion identities on this planet. So naturally any company with the ambition to potentially separate 6-7 billion individuals from their money for some product or service, will need to either work with multiple identity providers. 

So naturally such companies require a standard for doing so. That standard is OpenID. It has no competition. There is no alternative. There are plenty of proprietary APIs that only work with limited sets of identity providers but none like OpenID that can work with all of them.

Similarly, major identity providers like Google, Facebook are stuck at sharing a few hundred million users between them, they shift their attention to somehow involving all those users that didn't sign up with them. Pretty much all of them are OpenID providers already. Facebook just took the obvious next step in becoming a relying party as well. The economics are mindbogglingly simple: Facebook doesn't make money from verifying peoples identity but they do make money from people using their services. OpenID relying party means the group of people who can access their services just grew to the entire internet population. Why wouldn't they want that? Of course this doesn't mean that world + dog will now be a Facebook user but it does mean that one important obstacle has just disappeared.

BTW. Facebook's current implementation is not very intuitive. I've been able to hook up myopenid to my facebook account but I haven't actually found a login page where I can login with my openid yet. It seems that this is a work in progress still.

Anyway, this concludes my morning blogging session. Haven't blogged this much in months. Strange how the prospect of not having to work today is energizing me :-)