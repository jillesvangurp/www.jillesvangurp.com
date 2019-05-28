---
id: 1467
title: Jruby, ruby, constants, and making them not suck
date: 2013-01-16T15:52:44+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2013/01/16/1465-revision-2/
permalink: /2013/01/16/1465-revision-2/
---
I've been banging my head against the wall for a while before finding a solution that doesn't suck for a seemingly simple problem.

I have a project with mixed jruby and java code. In my Java code I have a bunch of string constants. I use these in a few places for type safety (and typo safety). Nothing sucks more than spending a whole afternoon debugging a project only to find that you swapped to letters in a string literal somewhere. Just not worth my time. 

So, I want to use the same constants I have in Java in jruby. Additionally, I don't want to litter my code with Fields:: prefixes. I just think that would suck big time. And finally, I want my ruby code to complain loudly when I make a typo with any of these constants. So ruby symbols don't solve my problem. Ruby constants don't solve my problem either. Attribute accessors are kind of not compatible with modules (need a class for that). So my idea was to simply add methods to the module dynamically.

So, I came up with the following which allows me to define a CommonFields module and simply include that wherever I need it.

<pre>
require 'jbundler'
require 'singleton'

java_import my.package.Fields
# hack to get some level of type safety
# simply include the Fields module where you need to use field names and 
# then you can simply use the defined fields as if they were methods that return a string
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

Basically all this does is add the Java constants to the module dynamically when you include it. After that, you just use the constant names and it just works (tm).
I also added a list of ruby symbols so, I can have fields that I don't yet have on the java side. This works pretty OK and I'm hoping jruby does the right things with respect to inlining the method calls.

Pretty neat and I guess you could easily extend this approach to implement proper enums as well. I spotted a few enum like implementations but they all suffer from the prefix verbosity problem I mentioned.

I'm relatively new to ruby so I was wondering what ruby purists think of this approach.