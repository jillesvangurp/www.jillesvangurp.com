---
title: Ripping out hibernate and going native JDBC

description: The how and why of getting rid of hibernate in a simple kotlin/spring boot 2.0 project
tags: hibernate, spring-boot, jdbctemplate
---
Originally published on [dev.to](https://dev.to/jillesvangurp/ripping-out-hibernate-and-going-native-jdbc-1lf2).

A few weeks ago, I found out that a bit of transactional database logic was misbehaving. After lots of fiddling, debugging, and going WTF?!, like you do, I figured out I was running into an issue related to transactional semantics: mysql transactions are not serializable unless you jump through a lot of hoops.

The bit of logic that was misbehaving was a simple a bit of of logic that I implemented to model a simple ledger of mutations. The idea here is that mutations have a single ancestor, are immutable, and their id is a content hash of several things including the ancestor_id and a sequence number.

The logic is brutally simple:
- look up the max sequence_number and corresponding mutation id
- use that to create the new mutation
- insert it into the table
- do all of the above in a single transaction to make sure the value I read is not stale and insert the value.

This nearly worked except transactions are not serializable in Mysql. This means that when you have multiple mutations at the same time, they each figure out the same ancestor and then try to insert into the db. We have suitable constraints in place to prevent this. So, transactions fail with a data integrity exception and roll back and the mutation is lost. Not what you want.

The solution: trap the exception and retry. This is where hibernate became part of my problem. We had done things the spring way meaning `@Transactional` on our logic and an `@Entity` that goes into an `@Repository`. Spring does a lot of AOP magic to make @Transactional work and together with hibernate manages a session that has proxied objects that represent your entity. This is great until it breaks. Then it becomes the opposite.

This makes addressing the above hard. First of all, adding isolation serializable to the transaction simply produces deadlocks in mysql. It does not work. This is a limitation with Mysql. If you want to you can trick it into locking tables and rows but good luck doing that via JPA. So, this was a matter of catch the exception, rerun the logic and hope it succeeds. I quickly figured out that this is impossible with `@Transactional` because the exception happens outside your code in AOP code. That is annoying of course. Solution, use `TransactionTemplate` with a try catch around that. Great, that looked like it was working except the next transaction also failed, and the next (I tried this with 10 retries). Reason: hibernate does not close the connection in between transactions and apparently does not reread the value from the db. It just reuses the value it already read. I tried fiddling with caching settings but never really figured out why this was not working. 

I spend a few days trying to make spring do this and e.g. jumping through hoops to get an entityManager and make it do what I want. It was fighting me all the way. I have no doubt this is solvable if I get another Ph. D. in convoluted framework design and doing a mind melt with whomever thought it was a good idea to have this mess of a gazillion abstract classes that extend abstract classes that extend more abstract classes that implement a gazillion interfaces. Gives me headache every time I start looking at Spring hibernate code. It's so convoluted. I admit, I'm not worthy, pilot error, etc. But the net result is I wasted enormous amounts of time trying to make this work and failed. If there's something obvious that I missed, do let me know in the comments below.

# Getting rid of hibernate

After a few days of misery trying to protect the existing investment in hibernate and make it work (sunk cost fallacy), I finally gave up and did what I considered on day 1 of this project but tragically did not: use JdbcTemplate. So, I created a branch called `fuckhibernate`. I'm one of those persons who doesn't hide his feelings in choosing names for branches or commit messages. My commit log by this time is testimony to the frustration levels I was experiencing and makes for some interesting reading. As this name indicates, the branch was created to get rid of hibernate, completely. As in F*** this S*** I don't want to deal with this again. It took me roughly one day of coding to do kill it off completely. Way less time than I wasted trying to fix broken magic. So, a good investment.

In the process I converted a lot of code to Kotlin. This is something that I've been doing for a while. All new code I write is Kotlin. 

The process I followed was very simple. I have the classic spring architecture where you have Services that use Repositories that store Entities. All the db stuff is in the repositories (non transactional) and the transactional logic is in Services. You can read up on how that works. 

I went repository by repository here. For each repository:
- I created a new DAO class with a JdbcTemplate injected with stub methods for all of the methods in the repository interface and switched over the service class to using that. 
- Delete all traces of hibernate annotations on the entity, convert it to a Kotlin data class, and refactor code a bit to be more Kotlin friendly (e.g. nullable vs optionals, properly use properties, and make them immutable). Once you drop hibernate, there is no need to have mutable classes. This is great and removes a lot of complexity. 
- Then I implemented the stubs one by one. This was straightforward. 
- I deleted the Repository class, got rid of any jpa annotations, and banged on the DAOs until all tests passed again.
- get rid of @Transactional in our service classes and use `TransactionTemplate` instead.

# Example

As an example, I have a small KV store table that I also ported using the same approach. It's for storing small json objects using some key. There's a service, a repository and an entity.

```kotlin
import java.time.Instant

data class KVEntry(
    val id: String = "",
    val data: String = "",
    val createdDate: Instant = Instant.now(),
    val lastModifiedDate: Instant = Instant.now(),
    val contentHash: String = "default"
)
```

I added `contentHash` to add optimistic locking based on Etags in the future where updates only succeed if your contenthash is correct. This avoids people overwriting values when their copy is stale. I've implemented a few kv stores against different databases and that is a useful feature. Note, you can trivially make this work against just about anything that is able to store key/value pairs. I've done redis, mysql, postgresql, voldemort db, couchdb, solr, and elasticsearch implementations in the past. This is used from a simple service class:


```kotlin
import io.inbot.ethclient.irn.IRN
// https://github.com/Inbot/inbot-utils
import io.inbot.utils.HashUtils
import org.springframework.stereotype.Component
import java.time.Instant

@Component
/**
 * Simple KV store.
 */
class KVService(
    val kvDao: KVDao
) {
    fun get(irn: IRN): KVEntry? {
        return kvDao.getById(irn.stringValue())
    }

    fun list(prefix: String): List<String> {
        return kvDao.findByPrefix(prefix)
    }

    fun put(irn: IRN, value: String) {
        val newEntry =
            KVEntry(irn.stringValue(), value, Instant.now(), Instant.now(), HashUtils.md5(irn.stringValue(), value))
        return kvDao.save(newEntry)
    }

    fun delete(irn: IRN) {
        kvDao.deleteById(irn.stringValue())
    }
}
```

Mostly the point with this service class was that I wanted to impose some structure on our keys by using an IRN (inbot resource name), which is a thing in our product. Also we handle content hashes in this class. The point of a DAO is absolutely no logic other than doing the db work. It's inspired by amazon's ARN's. You can roll your own or just use strings, maybe add a bit of methods to handle json serialization, etc. Since all db interactions are just one statement, there's no need for transactions here since you have autocommit true by default. Also missing is the implementation for an update method with optimistic locking.

The service class drives the DAO:

```kotlin
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.core.query
import org.springframework.stereotype.Component

@Component
class KVDao(val jdbcTemplate: JdbcTemplate) {
    fun getById(id: String): KVEntry? {
        return jdbcTemplate.query(
            "SELECT id, data, created_date, last_modified_date, content_hash FROM eth_kvstore WHERE id = ?",
            id
        ) { rs, _ ->
            KVEntry(
                rs.getString("id"),
                rs.getString("data"),
                rs.getTimestamp("created_date").toInstant(),
                rs.getTimestamp("last_modified_date").toInstant(),
                rs.getString("content_hash")
            )
        }.firstOrNull()
    }

    fun findByPrefix(prefix: String): List<String> {
        return jdbcTemplate.query(
            "SELECT id FROM eth_kvstore WHERE id like CONCAT('%',:id, '%')",
            mapOf("id" to "id")
        ) { rs, _ ->
            rs.getString("id")
        }
    }

    fun save(newEntry: KVEntry) {
        // do an upsert
        jdbcTemplate.update(
            "REPLACE INTO eth_kvstore (id, data, created_date, last_modified_date, content_hash) VALUES (?,?,?,?,?)",
            newEntry.id,
            newEntry.data,
            newEntry.createdDate,
            newEntry.lastModifiedDate,
            newEntry.contentHash
        )
    }

    fun deleteById(id: String) {
        jdbcTemplate.update("DELETE FROM eth_kvstore WHERE id = ?", id)
    }
}
```

This is where things get interesting. This is what hibernate normally generates for you. Yes, it's work writing this but no annotations, no complexity, no magic, etc. and it is not that bad. I'm sure there's ways to improve this further with some reflection hackery, more spring goodness. Spring 5 bundles several useful Kotlin extension methods as well. And there are named parameters, which I'm not using yet. So, this is not the final answer in simplicity. But fundamentally, this is good enough for me. It works, gets the job done, and no hibernate magic anywhere.

# Bye bye hibernate

After I gave all our entities the same treatment I simply swapped out `org.springframework.boot:spring-boot-starter-jpa:2.0.2.RELEASE` for `org.springframework.boot:spring-boot-starter-jdbc:2.0.2.RELEASE` in our dependencies. This gets rid of hibernate and the associated startup penalty. I shaved off about 10 seconds from a 40 second build by getting rid of hibernate. Good riddance!

# Solving the consistency problem

Of course just getting rid of hibernate did not solve my problem. But it made the fix trivially easy. Of course the first step was producing a test that reproduced the issues with an executor and a few threads trying to create mutations concurrently. That definitely reproduced the problem, reliably. 

Then I knocked out this ugly method in about 2 minutes that wraps the original (TODO make a prettier version with some recursion):

```kotlin
    fun mutateBalance(
        userId: String,
        transactionIdentifier: String,
        type: MutationType,
        description: String,
        createdDate: Instant,
        sourceIrn: IRN,
        updateLambda: (BalanceMutation) -> Unit
    ): BalanceMutation? {
        var tries = 0
        while (tries < 10) {
            try {
                val result = mutateBalanceInternal(
                    userId,
                    transactionIdentifier,
                    type,
                    description,
                    createdDate,
                    sourceIrn,
                    updateLambda
                )
                if (tries > 0) {
                    LOG.warn("succesful transaction after $tries tries")
                }
                return result
            } catch (e: DataIntegrityViolationException) {
                // if we violate constraints, retry
                if (tries++ < 10) {
                    // ugly sleep with some magical numbers to give the other transactions a chance to do their thing.
                    Thread.sleep(RandomUtils.nextLong(100, 1000))
                } else throw e
            }
        }
        // in our test we only get this if we are starved for db connections and are doing hundreds of concurrent transactions
        throw IllegalStateException("failed after $tries")
    }

    fun mutateBalanceInternal(
        userId: String,
        transactionIdentifier: String,
        type: MutationType,
        description: String,
        createdDate: Instant,
        sourceIrn: IRN,
        updateLambda: (BalanceMutation) -> Unit
    ): BalanceMutation? {

        return transactionTemplate.execute {
            // pseudo code below, real code omitted for brevity
            val previousMutation = DAO.getLatestMutationForUser(userId)
            // create newMutation that refers the previous one
            // this fails with a DataIntegrityException if another 
            // transaction uses the same previousMutation concurrently.
            DAO.save(newMutation)
        }
    }

```

This completely fixed our issues. Essentially all test runs I see a few retries indicating the problem is there and addressed. Sometimes it takes more than a few retries. If you push it hard enough you exhaust your connection and thread pool and stuff starts failing after 10 retries. With serializable transactions there would be no need for this code. Sadly, in 2018, mysql and serializable transactions are a problem so this code is needed. I'm actually considering cockroachdb for this reason but I like having hosted mysql in amazon RDS with backups a bit too much.

# Conclusions

I'm a little harsh on Hibernate here of course. This is on purpose since I am 1) very frustrated with it and 2) trying to provoke my readers a little. It's nothing personal ;-). Hibernate is of course fine for simple stuff and lots of people use it successfully and specialize in using it. However, in all the projects I've seen it used I observed a few things:

- People wielding it don't seem to understand SQL and are creating lots of performance bottlenecks with e.g. Eager loading (just don't), out of control joins, and JPA generally just creating hundreds of stupid queries. I love SQL; I use it all the time. For me JPA is straitjacket. 
- The object impedance mismatch causes people to over engineer their DB schemas. Inheritance is not a thing in databases, sorry. Do you really need 20 tables? How many of those columns are you actually selecting on?
- Transactional boundaries are poorly understood and basically people just copy paste `@Transactional` all over the place. Nice when it works, horrible when it breaks.
- It always breaks at some point and then the WTFs/minute rate really goes through the roof until somebody like me sits down and straightens things out. This is not fun work. Usually the symptoms are something like "it's slow", "why does this test suddenly not work", etc.

The bottom line is you don't need hibernate. I'd argue `TransactionTemplate` is a more safe way to do transactions in Spring than @Transactional since you can catch the exception more easily, have access to the transaction status, and you are not relying on AOP magic kicking in (or not if you call methods in the same class, interesting bugs when they happen). Spring's `JdbcTemplate` is easy to use and has been since Spring 3.x (I've been using Spring for about 10 years, not a newby). Kotlin gets rid of a lot of verbosity. Kotlin immutable data classes is definitely how I want all my DB entities to be. Other benefits: not having to worry about entity managers, hibernate sessions, and entity proxy weirdness, hibernate caching, and obfuscated transactional behavior (technically Spring not hibernate), mapping native sql to JPA's own query language, etc. I like code that does what it says.







