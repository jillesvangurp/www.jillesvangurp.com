---
title: Libra, blockchains, and the meaning of it all
description: Recently, Facebook announced their plans for launching their own blockchain platform and crypto currency, the Libra. In this longish article I want to explore what I think is happening and what it all means. As such, it is severely at risk of being both late and somewhat redundant as world plus dog seems to have an opinion on this. In writing this article, I want to reflect a bit on the bigger picture and also intend to distance myself a bit from the alarmist and populist hyperbole that has been circulating since Facebook announced Libra.
tags: libra, blockchain, opinion
---
Originally published on [dev.to](https://dev.to/jillesvangurp/libra-blockchains-and-the-meaning-of-it-all-1clc).

Recently, Facebook announced their plans for launching their own blockchain platform and crypto currency, the Libra. As I have done the technical work for [Inbot](https://inbot.io) to launch our own token on the Stellar blockchain, I'm of course very interested in what they are doing, why,  and how.

- [What problem does Libra solve?](#what-problem-does-libra-solve)
- [ Byzantine Consensus vs. PoS & PoW](#byzantine-consensus-vs-pos-amp-pow)
- [Smart Contracts](#smart-contracts)
- [Libra consortium ](#libra-consortium)
- [Privacy, KYC, and Financials](#privacy-kyc-and-financials)
- [Why is Facebook creating a new Blockchain?](#why-is-facebook-creating-a-new-blockchain)
- [Monetization](#monetization)
- [What happens next?](#what-happens-next)

In this article I want to explore what I think is happening and what it all means. As such, it is severely at risk of being both late and somewhat redundant as world plus dog seems to have an opinion on this. In writing this article, I want to reflect a bit on the bigger picture and also intend to distance myself a bit from the alarmist and populist hyperbole that has been circulating since Facebook announced Libra.

This is going to be a longish article. In short, I'm cautiously optimistic that Facebook is serious about Libra and is doing exactly the kind of things technically, legally, and practically that they ought to be doing to make this a success for them. Of course, I cannot vouch for their motivations; though I would assume it involves enriching themselves in some way.

First, let's get a few things out of the way. In debating this with others, I've noticed a lot of negative sentiment around the topic of crypto currencies, blockchains, and Facebook. A lot of this is for valid reasons and I partially share those sentiments. I'm a natural skeptic and despite my technical involvement with a blockchain based product, I'm not actually active as a crypto investor. I tend to look at this topic from both a technical and pragmatic angle. I don't consider myself a dreamer, utopian, or otherwise idealistic person.

Another part of this negativity is simply ignorance and people assuming they have a firm grip on this when arguably they don't. Luddites have been there at every step of the way from the invention of the wheel, to the industrial revolution (where the term [Luddites originates](https://en.wikipedia.org/wiki/Luddite)), the invention of radio, television, the internet, etc.

It's good to be skeptical and conservative but it would be foolish to dismiss Libra as just a fad. It won't blow over and whether you like this or not it looks like blockchains are here to stay in one form or another. For us, developers, technologists, etc. the main thing is to make sense of what is happening and upgrade our skill sets so we can make ourselves useful gluing together all the new bits and pieces of technology.

I think of the Libra announcement as a symptom of the entire market maturing and a necessary step for crypto currencies to become more mainstream. It's a combination of necessary, not unexpected, and inevitable for this to happen. More companies will follow and probably very soon now that there is a sense of urgency to not let Facebook 'win'.

**Disclaimer** I use the term blockchain loosely in this article and some people might take offense with that. Blockchains or blockchain like platforms share a few useful properties of having some cryptographically way of storing and protecting a record of transactions. For the purpose of this article I'll use the word blockchains to refer to that type of system.

## What problem does Libra solve?

Simply put, the existing financial system has been around since the late 1600s. It has served us well and it is ingrained in our legal systems and we're used to it.

However, it has issues. One of those issues is the level of control that resides in the hands of the banks and governments that control them and occasionally abuse the powers given to them. Another is the built in inefficiencies through our reliance on mechanisms that either predate the invention of computers (e.g. paper work) or date back to the early days of the invention of that. Additionally, poorly aligned incentives to be either cheap or fast cause banks to profit from delaying transactions and allow them to exploit their controlling position by e.g. charging excessively for transactions, denying service to some, or otherwise benefit from their exclusive position. Banks make stupendous amounts of money for essentially obstructing financial traffic. A notable thing about the Libra announcement is that banks do not feature at all in the consortium. This is not an accident. Libra is intended to make them redundant.

Blockchains provide a solution for administering ledgers, i.e. a record of transactions, that is by design impossible to cheat (assuming no bugs, compromised algorithms, etc.). Using a blockchain, much of the need to have banks goes away. Ledgers are of course nothing new. The ancient Sumerians had them and much of their remaining written material consists of ledgers. Same for the Egyptians, Romans, etc. Ledger technology is ancient.

The modern financial system invented in the 17th century introduced the notion of banks, central banks, stock exchanges, etc. that are powered by ledgers. Additionally, it introduced the notion of bits of paper to represent money, an IOU  by a bank or central bank that the bit of money is being administered correctly. The integrity of currency is core to our modern financial system and for the past century it has relied on governments and central banks overseeing the way people administer their ledgers. Necessarily, this involves independent bookkeeping, elaborate checks and balances when transacting, and rules and laws for conflict resolution when somebody inevitably cheats. Blockchains internalize much of the manual overhead by making it impossible to cheat. It removes the need for people to keep independent ledgers and thus reduces cost and friction associated with financial transactions.

Contrary to the popular belief, a simple database is not a drop in replacement. We've already had those for the last few centuries. First in paper form and for the last century or so in mechanical (the M in IBM stands for machines) and then digital form (i.e. a database). Blockchains have one key feature: they allow mutually distrusting users to have confidence that none of them is able to cheat or commit fraudulent transactions.

Not only is it cheaper to use a block chain but it is also faster. A good blockchain platform can transact in seconds or even faster. After that, the transaction is guaranteed to have happened. Additionally, because the cost is so low, it is possible to do very small transactions. This enables a whole range of use cases that is currently mostly outside the financial system.

Indeed, as Facebook notes in their marketing material, there are still billions of people that lack a bank account. Most of their business is conducted using cash, bartering, or a range of non block chain based payment solutions that have emerged to address this.

## Byzantine Consensus vs. PoS & PoW

From reading the whitepaper, it looks like Facebook is broadly copying the approach used by the likes of Stellar (which I'm very familiar with), Ripple, and a few others. Stellar is using a consensus model where validators agree on which transactions to accept. This process is fast because it does not involve e.g. mining and it awards a special status to the owners of these validators in the sense that they control what happens in the network.

Libra is implementing a so-called permissive variation of [Byzantine Fault Tolerant (BFT)](https://www.theblockcrypto.com/2019/06/19/a-technical-perspective-on-facebooks-librabft-consensus-algorithm/) algorithms. Permissive BFTs are emerging as a third alternative to the more established permission less BFTs like Bitcoin and Ethereum. There are two variants of this: Proof of Work (aka. mining) or Proof of Stake based networks. Respectively the three approaches accept transactions based on either who you are, what you did (PoW.), or how much you own (PoS.).

The way consensus works in permissive BFTs like Stellar is that if you choose to run a validator, you must configure a list of other validators that you trust and define a quorum of hpow many of those need to agree for a transaction to be valid for your node. Transactions on your validator are only accepted if there is consensus with the nodes you list and the validators they trust. This extended consensus network means that e.g. 50% attacks common in permission less network are very hard to perform unless you manage to hijack existing validators that are already trusted. It also means that as the number of validators that trust each other directly or indirectly, the network becomes more decentralized and it becomes harder to cheat. Facebook is following a similar model.

Like Stellar, Libra will launch with a consortium of validators and they intend to open up to more third party validators later. As the number of validators grows, the network will be more resilient against attempts by any of them to control the network. While anyone can launch a validator, the only validators that matter are those that are trusted by the existing ones. This is what it means to be permissive. Think of it as an invitation only kind of thing where whether you get an invite will be based on your merit, reputation, and trustworthiness. In the Stellar network an important driver for getting others to trust you are also factors such as your uptime, business relations with other validator owning organizations, etc. 

So, it would be wrong to characterize this as centralized where e.g. Facebook decides on who gets to join their network. This would be an oversimplification that seems to come up regularly in discussions of how Stellar and Ripple work and how Libra will work. E.g. Stellar actually has a growing number of validators that have to agree with each other. When there is no agreement (i.e. consensus), the network stops making progress.

This actually happened [recently](https://medium.com/stellar-developers-blog/may-15th-network-halt-a7b933103984) when several validator operators decided at the same time to do some maintenance and took down some of their nodes. As a result, the remaining nodes failed to find enough nodes to agree with and stopped accepting new transactions until the nodes came back online. While this sounds bad, this is actually a good safety feature. Stellar will choose halting over forking. Nobody lost their money. In their response to this incident, the Stellar Foundation actually made clear that they want to reduce the importance of their own validators in the network and identified this as a root cause for the failure. Their stated goal is to be able for their own validators to be taken offline without halting the consensus.

Similar Incidents with e.g. Ethereum instead resulted in unintentional forks or partitions (as opposed to intentional forks that also happen) where transactions on the wrong branch of the fork were lost. To mitigate against this, it is common to wait for several blocks before assuming a transaction has happened. Consequently, transactions can take very long to complete in Ethereum and Bitcoin.

In [CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem) terms, permissive Byzantine consensus favors Consistency and Partition Tolerance over Availability where permission less PoS and PoW based systems tend to sacrifice consistency instead. It's the key reason why Facebook picked this mechanism because it is both safe and fast and therefore meets their requirements of being suitable for their intended use case. Also, the notion of not having their network invaded by hostile validators is likely more of a feature for them and not a bug.

In terms of the existing financial system, what Facebook is doing is essentially a more efficient digital equivalent where the same types of entities responsible for making transactions happen now facilitate this by running validators that do this automatically. The same properties that made that good enough, also make permissive BFTs good enough provided the network has enough independent validators to be resilient against some of them misbehaving. Inevitably, there are going to be a lot of politics around this topic; just like in the existing financial system.

IMHO there will remain a role for permission less systems as stores of value and the interaction between different blockchain networks and diversity of platforms that mutually integrate with each other is going to be key to the long term robustness of the ecosystem.

## Smart Contracts

Unlike Stellar and Ripple, Facebook has smart contracts. These are similar to what you'd find in e.g. Ethereum (i.e. solidity). However, there are some differences. [Hackernoon](https://hackernoon.com/move-programming-language-the-highlight-of-libra-122a910d6e0f) has written a great overview of the essentials. Move, the language and vm in Libra provides all the essentials to provide strong guarantees about correctness and integrity.

The language, vm, and module system are designed to facilitate formal verification. This is very important because it allows for contracts and modules that are provably correct. This greatly simplifies auditing.
Unlike Solidity, the main smart contract language in Ethereum and similar blockchains, it does not support dynamic functions. This further simplifies reasoning about and auditing Move contracts.
Auditing has proven to be a significant hurdle with Ethereum. When Inbot was preparing an ICO early 2018, we were indeed preparing an ERC20 token. Ultimately we were to late and the market had already crashed by the time we were getting ready. Part of our concern was significant cost for auditing and a nagging concern that there might be bugs in our contracts still. Smart contract bugs are no joke and can have significant financial consequences.

The lack of smart contracts in Stellar is a feature, not a bug. Instead of smart contracts, Stellar (and Ripple) provide a set of primitive transaction types that you can combine to build financial products. However, it is inherently more limited than a full blown contract language. Libra actually makes a nice compromise here. By providing a language and module system with strong verification mechanisms, it allows for an ecosystem of verified modules to emerge that users may combine to build smart contracts. So, auditing should be similarly simple as Stellar for the basic use cases while still allowing for more complicated contracts to be written.

## Libra consortium

A blockchain is only as good as the people backing it. Facebook has gathered a strong consortium with major companies in it. Particularly, the presence of major existing payment providers like Visa, Mastercard, and Paypal, suggests that adoption could be quite rapid. Another thing worth pointing out is that these companies are competitors and that the financial stakes are very high for them. This further strengthens the argument that the consensus model that Libra is taking here is not about centralizing power but about facilitating mutually competing entities like this to collaborate.

I imagine many governments currently considering Facebook's actions regarding this, will be scrutinizing these arrangements. I think it is safe to assume that Facebook has considered this and that much of the technical architecture is actually intentionally trying to provide strong guarantees here and aimed to preempt a lot of the concerns.

The stated intention of Facebook is to create a legal entity called Calibra that will presumably control the platform. Crucially, this legal entity is a direct subsidiary of Facebook and will presumably control the financial reserve, intellectual property (i.e. patents), and technical direction. I am somewhat surprised that Facebook has chosen this path instead of setting up a foundation that is controlled by its members (like e.g. Stellar, Ethereum, and other blockchain platforms have done). This suggests that Facebook will have a special position in the platform.

## Privacy, KYC, and Financials

Facebook is under a lot of pressure from the public, press, and increasingly legal authorities over their lack of regard for their own user's privacy. A blockchain is by its nature very public and it is unclear how they are addressing privacy; despite their solemn promises that user transactions will be private.

Potentially all the transactions of all their users would end up being public domain information and certainly Facebook would be gathering a lot of financial data about their users. This obviously raises some red flags for those concerned with their privacy. The ability to trace back user payments to ads is potentially a gold mine for Facebook.

To comply with legal requirements, Facebook will have to apply AML and KYC policies. Arguably, they already know a lot about their users as it is today, which gives them a strong starting position. Requiring documentation in the form of selfies, copies of identity documents, and proof of address, will put them in a unique position of controlling a vast amount of very private data on their billions of users worldwide.

Worse, a centrally controlled platform like this is also of interest to intelligence agencies; and potentially a tool that may be used to control citizens. E.g. WeChat is a very popular payment platform in China and the Chinese government routinely punishes citizens by banning people from it; which severely limits their ability to do financial transactions in China because WeChat has largely replaced the use of traditional money. In creating Libra, Facebook seems to want to compete directly with platforms like that.

## Why is Facebook creating a new Blockchain?

Many users of existing blockchains may have raised a few eyebrows about Facebook building their own platform. However, I think I have a very rational explanation: none of the existing platforms has a level of maturity that would make it suitable for operating at the scale Facebook needs it to run.

Billions of users using Libra means an absolutely huge transaction volume. I doubt many of the established blockchains are anywhere near ready for such volumes. Both Ethereum and Bitcoin are as of yet still mining based and limited to a world wide transaction volume that ranges in the single, or at best, double digit numbers of transactions per second. Existing traditional payment platforms can handle thousands or tens of thousands of transactions.

Additionally, these are still limited to relatively large transactions as there are transaction fees involved. Facebook seems to intend to have a very low transaction cost in order to facilitate very small transactions and micro payments as well as traditional payments. E.g. they seem to highlight the lack of good payment solutions for third world countries where many people do not have banks or credit cards. All, this suggests that Facebook has a need to support a very high volume of transactions at a very low cost. 

So, clearly there is more going on here than just a not invented here syndrome. Facebook inventing their own platform of course gives them control and as pointed out there are plenty of reasons to not trust them with that level of control. But it is not like there is anything out there that they could have just taken and used.

## Monetization

Obviously, Facebook is a very valuable company and they are looking to make money through their platform. By design, transaction fees are going to be low. So, it would be wrong to assume that is going to be the primary revenue driver. Instead, it is likely that Facebook is looking to leverage their position as the controlling entity of Calibra to find alternative revenue streams.

They are creating an exclusive ecosystem that generates a lot of data. Access to this ecosystem will likely require buying into it. Additionally, controlling the large reserve that is needed to stabilize the Libra means an opportunity to make lots of money from simply investing these funds. Finally, day to day fluctuations in exchange rates and conversions to and from existing currencies create very lucrative opportunities to make money.

Finally, the value of Facebook as a holder of KYC and AML information means that they can provide guarantees to others about whom they are dealing with. As governments will inevitably want to crack down on money laundering, financing of terrorism and tax dodging, access to this information is going to be crucial for anyone looking to do business via their platform. The alternative of doing KYC and AML in house is likely to not scale and Facebook is uniquely positioned to provide very high quality information through their existing relationship with their billions of users.

## What happens next?

I expect Libra will trigger a lot of scrutiny. But, it will also act as a wakeup call. So far, blockchains have been operating in the margins of the financial and legal system. A combination of libertarian utopianism, greed, anarchism, etc. seems to be what has been driving things forward. Lately, there have been some increasingly serious attempts by e.g. IBM with World Wire, Bit Bond, WireX, and similar efforts to use blockchains for payments, securities, etc. However, most of these products are still relatively new and limited to low transaction volumes.

With Libra, Facebook will overnight create a new reality with potentially hundreds of millions of people getting involved directly or indirectly. This will represent a sharp increase in the use, and importance of blockchains for the financial plumbing of the world. We're now about to hit the elbow in the exponential curve where this will go from relatively small numbers to massive numbers. 

I expect that Facebook will get some competition very shortly and fully expect most of the tech giants are already in an advanced stage of planning counter moves. I'm talking about the likes of Apple and Google, both of which operate mobile phone based payment platforms; and Microsoft, Amazon, traditional banks, and in some cases small governments of nations not so eager to have their financial infrastructure be hijacked by any of these.

In short, I expect that we will have a frenzy of investments, speculation, and R&D activity around this topic over the next year. Anyone that matters in this space is going to want in on the action.If they were interested before, they will now be accelerating their attempts. None of these companies will be happy to sit back and watch Facebook eat their lunch.

Additionally, I expect e.g. the US and EU to have a thing or two to say about financial oversight. Short term, Libra seems to be well positioned to dodge some of this. However, clearly, there is already widespread support for legal action against Facebook and they risk further scrutiny with this announcement. In a way, they are forcing the agenda early, which I think is actually smart because it catches everyone unprepared.

My impression is that governments are too slow to respond in a timely fashion and that by the time they will be ready to legislate, there will be several too big too fail type platforms already as well as powerful lobbies that will aim to prevent them blocking this. Time is running out quickly and inaction just means the existing laws continue to apply.

Assuming, Libra gets through this initial phase, we will likely have several new blockchain based payment platforms starting to compete with each other within the next 1-2 years, each with large volumes of transactions and vast amounts of money flowing around.

One interesting thing here is that this will inevitably also create a need for inter blockchain traffic via exchanges. E.g. the Stellar platform seems to be already emerging as one of the platforms of choice for this kind of traffic. IBM's world wire is using it, several exchanges connect to it (or rather make use of its built in decentralized exchange), and several fintech companies are operating stable coins for both crypto and traditional currencies on it. The simplistic view of "there can be only one" is in my view not justified. There will be at least several platforms and they will inevitably be highly integrated with each other.

In summary, I believe that Facebook's moves with Libra are logical and very smart. For their level of ambition, Libra is the right platform to be building technically and they seem to have a strong consortium with which they are launching this.

I also believe that this actually strengthens the blockchain ecosystem and that it will lead to a lot of new things. Whether Facebook's Libra emerges as the dominant solution in this space is very much undecided. If that were to happen it would be because of a lack of initiative and vision by their competitors. Personally, I don't believe in this doom scenario and instead they will be one of several platforms that remain standing after the dust settles on this in a few years.

