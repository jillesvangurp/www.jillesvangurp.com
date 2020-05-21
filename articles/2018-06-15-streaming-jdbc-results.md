---
title: Streaming results from a JdbcTemplate in Kotlin

description: Sometimes you just want to do a foreach thing in the results of a query do something without worrying about running out of memory, paging etc. 
tags: jdbctemplate, kotlin, streams, spring-boot
---

Originally published on [dev.to](https://dev.to/jillesvangurp/streaming-results-from-a-jdbctemplate-in-kotlin-474h).

I've been transitioning from using Hibernate to using JdbcTemplate in a Kotlin based Spring Boot 2.x project recently. The why and how of that I wrote down in another [article](https://dev.to/jillesvangurp/ripping-out-hibernate-and-going-native-jdbc-1lf2). One of the repository methods that I needed to move over was something like this:

```kotlin
    @Query("...")
    fun streamUserIds(): Stream<String>
```

One of the nice things with Spring Boot is that it does the right thing with generating a useful implementation that does the right thing. You can do Streams, Optionals, Lists, etc. JdbcTemplate does not really have anything similar. 


IMHO a somewhat strange omission in the JdbcTemplate API but easy to fix. After a bit of googling, I found this somewhat [helpful page](https://blog.apnic.net/2015/08/05/using-the-java-8-stream-api-with-springs-jdbctemplate/) with a solution that nearly worked but not quite. But it put me on the right track. 

So, I decided to share my implementation since I think it is a bit simpler and better:

```kotlin
    fun <T> queryStream(sql: String, converter: (SqlRowSet) -> T?, args: Array<Any>): Stream<T> {
        val rowSet = jdbcTemplate.queryForRowSet(sql, *args)

        class RowSetIter : Iterator<T> {
            var current: T? = null

            override fun hasNext(): Boolean {
                if (current != null) {
                    return true
                } else {
                    if (rowSet.next()) {
                        current = converter.invoke(rowSet)
                        return true
                    }
                }
                return false
            }

            override fun next(): T {
                if (hasNext()) {
                    val retVal = current
                    current = null
                    return retVal!!
                } else {
                    throw NoSuchElementException()
                }
            }
        }

        val spliterator = Spliterators.spliteratorUnknownSize(RowSetIter(), Spliterator.IMMUTABLE)
        return StreamSupport.stream(spliterator, false)
    }
```

All this does is wrap `SqlRowSet` with a simple iterator. `SqlRowSet` is a simple wrapper around the JDBC `RowSet` with sane exception handling that makes the above a bit less tedious. 

My implementation fixes a few issues that the code in the linked article has: 
- the exit condition was wrong and omitted the last row. 
- I like to do the heavy lifting in the `hasNext()` method instead of the `next()` method and make `next` rely on `hasNext()`. This also removes the need to call next on the first row. I've implemented some iterators before and this seems a good pattern for iterators. 
- It was attempting to stream rowset. This doesn't really make sense given that this is some lowlevel object representing a db cursor and all you are doing is returning the same object and calling `next()` on it. So instead, I'm using a lambda to convert each row to a `T`. So, whether you are mapping some entity or just extracting strings, it will work. And you can always make `T` a `Unit` if you really just want to iterate over the rows and not return anything.

Another gotcha is that you obviously can't close the connection before you stream because it needs to use the database cursor to get results. So, the proper way to solve this this is with a TransactionTemplate so you keep the connection open until after you are done streaming results from the DB:

```kotlin
transactionTemplate.execute {
    dao.queryStream("select user_id from table") { rs, _ ->
        // Map rows to a String
        rs.getString("user_id")
    }.forEach {
        // do something with each user_id
        println("User $it")
    }    
}
```

This will work whether you have 50 users or 50 million user ids. The code above should be easy to port back to Java if you need it to. I also shared this code as a [comment](https://gist.github.com/codebje/58d1b12e7a2d0ed31b3a#gistcomment-2616705) to the Github gist that was linked from the article that inspired this.

