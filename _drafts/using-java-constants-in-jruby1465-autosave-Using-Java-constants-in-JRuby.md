---
id: 1472
title: Using Java constants in JRuby
date: 2013-03-21T18:33:51+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/01/16/1465-autosave/
permalink: /2013/03/21/1465-autosave/
---
I've been banging my head against the wall for a while before finding a solution that doesn't suck for a seemingly simple problem.

I have a project with mixed jruby and java code. In my Java code I have a bunch of string constants. I use these in a few places for type safety (and typo safety). Nothing sucks more than spending a whole afternoon debugging a project only to find that you swapped two letters in a string literal somewhere. Just not worth my time. Having ran into this problem with ruby a couple of times now, I decided I needed a proper fix. 

So, I want to use the same constants I have in Java in jruby. Additionally, I don't want to litter my code with Fields:: prefixes. In java I would use static imports. In ruby you can use includes, except that doesn't quite work for java constants. And also, I want my ruby code to complain loudly when I make a typo with any of these constants. So ruby constants don't solve my problem. Ruby symbols don't solve my problem either (not typo proof). Attribute accessors are kind of not compatible with modules (need a class for that). So my idea was to simply add methods to the module dynamically.

So, I came up with the following which allows me to define a CommonFields module and simply include that wherever I need it.

<pre>
require 'jbundler'
require 'singleton'

java_import my.package.Fields

# hack to get some level of type safety
# simply include the Fields module where you need to use 
# field names and  then you can simply use the defined 
#fields as if they were methods that return a string
module CommonFields
    @rubySpecificFields=[
      :foooo,
      :bar
    ]
    @rubySpecificFields.each do |field|
      CommonFields.send(:define_method, field.to_s) do
        return field.to_s
      end  
    end
    
    Fields.constants.each do | field |
      CommonFields.send(:define_method, Fields.const_get(field)) do
        return Fields.const_get(field)
      end
    end
end

include CommonFields
  
puts foooo, email, display_name
</pre>

Basically all this does is add the Java constants (email and display_name are two of the constants) to the module dynamically when you include it. After that, you just use the constant names and it just works (tm). I also added a list of ruby symbols so, I can have fields that I don't yet have on the java side. This works pretty OK and I'm hoping jruby does the right things with respect to inlining the method calls. Most importantly, any typo will lead to an interpreter error about the method not existing. This is good enough as it will cause tests to fail and be highly visible, which is what I wanted.

Pretty neat and I guess you could easily extend this approach to implement proper enums as well. I spotted a few enum like implementations but they all suffer from the prefix verbosity problem I mentioned. The only remaining (minor) issue is that ruby constants are upper case and my Java constant names are upper case as well. Given that I want to turn them into ruby functions, that is not going to work. Luckily in my case, the constant values are actually camel cased field names that I can simply use as the function name in ruby. So that's what I did here. I guess I could have lower cased the name as well.

I'm relatively new to ruby so I was wondering what ruby purists think of this approach.