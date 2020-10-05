---
title: Reactive Security Filter with Spring & Kotlin
published: true
description: Accessing Spring's reactor context from a co-routine to implement a simple security filter.
tags: kotlin, spring, security
---

Over the years, I've had to implement security filters a couple of time. Recently I had to add JWT token based API authentication to a Spring project.

Some complicating factors:

- It's the reactive variant of Spring, aka. Flux.
- Flux has a very complicated API surface.
- To not have to deal with that we use Kotlin & Co-routines. This too has a few rough edges still as it is very new.
- Servlet Filters don't work when using Flux because they are inherently synchronous. So we have to do things the Flux way.

So, I spent a good amount of time to figure out how to do this correctly and this is another instance of me **documenting by blogging** so I don't have to google my way through the maze of cryptic documentation again. Also, I hope others might find this useful.

## High-level design

The design for my solution is fairly simple. I never really liked Spring Security as it mainly gives me headaches. Also I have custom requirements now and more coming that just won't fit in what it does that easily (I speak from experience). But I imagine it does something similar.

So instead:

- We use simple JWT tokens that are signed, have a payload with things like a userId, and need to be checked as part of our Authentication and Authorization logic. Standard stuff these days. 
- Any request that includes an Authorization header, we want to grab the JWT token from there, validate it, and create a `SecurityContext` object. This object forms the basis for our authorization logic.
- The Authorization logic lives in an `AuthorizationService` that is called to run checks from our business logic. When that happens, it needs to grab the `SecurityContext` check whether we authenticated, grab the userId, and figure out the set of roles and privileges (beyond the scope of this article) the principal has.

So, in short, we need something that creates the security context and stuffs it in a place where the AuthorizationService can grab it. Since we use co-routines on top of Flux, that place is the Flux Reactor Context and we want to get to that via the `coroutineContext` that is part of the co-routine scope all our logic executes in.

## The filter

Spring Flux offers two ways to implement something similar to the good old `ServletFilter`, which is what you'd use when we were all still doing synchronous IO with Tomcat. One of these is called `WebFilter`, this appears to be the most useful of the two, since crucially it returns something called a `ServerWebExchange`, which in a somewhat convoluted way gives us access to the request `Flux` and the ability to interact with the Spring Reactor `Context`. The best way to think of that is as a `ThreadLocal` like construct for Flux where we can park custom data and access it downstream. Via the `coroutines-reactor` library, we gain a few feature to access this via the co-routine scope.

The other way to filter is via `HandlerFilterFunction` which looks like it's a bit more limited as it does not provide an obvious way to do anything with Flux (correct me if I'm wrong) but would be a better fit if you use the Spring's router DSL.

```kotlin
@Component
class AuthorizationWebFilter(val tokenService: TokenService): WebFilter {
    override fun filter(exchange: ServerWebExchange, chain: WebFilterChain): Mono<Void> {
        val jwtToken = tokenService.parseHeader(
            exchange.request.headers["Authorization"]?.firstOrNull())
        val context = tokenService.createSecurityContext(jwtToken)

        return chain
            .filter(exchange)
            .subscriberContext {
                it.put(FormationSecurityContext::class.java, context)
            }
    }
}
```

This is where Spring's API gets a little weird. This reads different then what it actually does and this threw me off for an while. The key here is that you call `subscriberContext` on the return value of `.filter(exchange)`. To me this reads like: first do the request logic and then mess with the context. Luckily, what it does is different and the context gets modified before the logic kicks in. Just a bit of API weirdness. 

The put method is weirder. Especially in combination with how we are getting values from the reactor Context. Intellij suggests a type of `Any` for both key and value. This is a lie and just where the Java type system fell a bit short, I guess. The correct types for this are `Class<T>` and `T`. So, it's a map indexed by the class of the value. In our case that would be `FormationSecurityContext`.

A final gotcha is that unlike most `Map` implementations, put does not manipulate a Context but creates a new one. I initially had this because I assumed put did not have a return value.

```kotlin
 subscriberContext {
    // this is wrong!
    it.put(FormationSecurityContext::class.java, context)
    it
}
```

So, that looks like a deceptively easy bit of code but it was made hard by a lack of documentation, and Spring not following the principle of the least amount of surprise, which makes all this hard to discover.

## Getting the value out on the other side

Now that we have our security context, we want to use it. For this I implemented a simple DSL to check auth in places where we need that. This is the Kotlin way and I prefer it over annotations and/or AOP based madness.

```kotlin
// ReactorContext is still experimental
@ExperimentalCoroutinesApi
@Component
class AuthorizationService(val roleRepository: RoleRepository) {
    /**
     * Runs the block if the authorization checks succeeed or throws a `NotAuthorizedException`.
     */
    suspend fun <T> authorize(privilege: Privilege,ownerId: String, block: suspend ()->T):T {
        val reactorContext = coroutineContext[ReactorContext]
        val securityContext = reactorContext?.context?
            .get(FormationSecurityContext::class.java)
        if(securityContext == null) {
            // should not happen; means our AuthorizationWebFilter is broken
            throw IllegalStateException("no context")
        } else {
            if(!securityContext.isAuthenticated) 
              throw NotAuthorizedException(AuthProblemCode.JWT_MISSING)
            // additional auth checks beyond the scope of this article
            checkAuth(privilege,ownerId,securityContext.user
              ?: throw IllegalStateException("no user"))
            return block.invoke()
        }
    }
}
```

To use this, you simply do something like this:

```kotlin
suspend fun getUserProfile(userId: String): UserProfile =
    authorizationService.authorize(UserProfilePrivilege.GET_USER_PROFILE, userId) {
        userRepository.findUser(userId)?.toUserProfile() ?: throw NotFoundException(userId)
    }
```

It's a suspend function because we are using this from Flux based flow. In this case, we are actually using the Expedia GraphQL integration for Spring, which is definitely beyond the scope of this article but quite easy to set up.

But if you weren't, you could do something like this to create an endpoint:

```kotlin
coRouter {
    GET("/user/{userId}") {
        ok().contentType(MediaType.APPLICATION_JSON)
            .bodyValueAndAwait(userProfileSerice.getUserProfile( it.pathVariable("userId")))
    }
}
```

The `bodyValueAndAwait` extension function takes our suspending function and turns it into a Spring `Mono`, so Spring Reactor does the right things with Flux.
