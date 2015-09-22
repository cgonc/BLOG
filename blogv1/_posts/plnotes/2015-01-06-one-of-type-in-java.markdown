---
layout: post
title:  "One of Type Examples"
date:   2015-01-06 16:40:05
categories: Programming Languages
---
<p align="justify">
In object oriented programming one of types can be implemented using subclassing.
Consider this very simple Scala function. The return type of the max function is
a one-of-type. It can be either none or an integer depending whether there is a 
maximum or not.
</p>
{% gist cgonul/c8ff0cf66695412c8fd4 %} 

<p align="justify">
We can port this simple Scala function into Java.
<br>
<br>
We need an Option class. We can define None and Some as the subclass of this
Option class so we can pass any of the two types whenever we want. 
It is one of the examples of polymorphism. We can pass one of the two 
sub-type to a super type.
</p>

{% gist cgonul/b52bc558d78fb7d2bb97 %} 

{% highlight  java%}
Maximum of a non-empty list is : Some [x=50]
Maximum of an empty list is : None

{% endhighlight %}

As it can be seen from TestOption class the return type of the max function can be
either ***None*** or ***Some Int***.

# Some Examples of One-of Types in SML #
{% gist cgonul/496256a65c91b112dee4 %} 

__Datatype id__ , adds a new type called __id__ and
two constructors __StudentNum__ and __Name__. A constructor is a function for creating
values of the new type in SML. 




