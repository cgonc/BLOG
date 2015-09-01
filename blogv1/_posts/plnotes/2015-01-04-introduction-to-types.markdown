---
layout: post
title:  "Types"
date:   2015-01-04 11:25:05
categories: Programming Languages
---
<p align="justify">
A programming language should categorize its variables into some types at some point during 
the life cycle of a program. 
We can categorize the types into two <strong> as base types and compound types.</strong> 
Especially for the compound types choosing the right kind for your data is crucial.
<br>
<br>
<strong>Base types :</strong> Programming languages have base types like int, bool, double, unit .
<br>
<br>
<strong>Compund types :</strong> Compound types contains other types in their definition. 
Compound types are powerful. To create a compound type we can use one of the following three options.
<br>
</p>

1. __Each-of-type__ also known as product types . 
2. __One-of-type__ also known as sum types . 
3. __Self-reference-type__ also known as  recursive types . 

# Each-of-type #
<p align="justify">
Each of types are familiar to most of us. In SML a tuple (int * bool) is an each of type. In Java we can 
construct this type (a tuple) with objects.For example org.apache.commons.lang3.tuple.Pair<L,R> is the most 
famous one. 
<br>
A base types is also an each-of-type. 
A variable which is an each of type contains t1,t2,t3,..., and tn at the same time.
In each of type the variable actually just have one kind of type however that type can be a multiple pair 
or something similar. I think the main difference will be more clear when defining one-of-type.
</p>

# One-of-type #
<p align="justify">
A variable which is one-of-type holds one of the t1,t2,...or tn, so a one-of-type has only one type 
during the life-cycle of the program but the type it holds can change. One of the ways that functional languages can cope
with this kind of type is using options. 
<br>
<br>
For example lets find the prime numbers between two numbers using SML language. If there is 
a prime number or some prime numbers between these two numbers we should return those integer values 
as list but if there is not we should return a NONE value. 
</p>

So our return type either includes a __NONE type__  or __SOME Int List.__ 
This is a good example of a one-of-type.

{% gist cgonul/d9dfac7551359ba64749 %}

An evaluation of get_prime_between function :

{% highlight  java%}
- get_prime_between(10,11);
val it = NONE : int list option
- get_prime_between(100,130);
val it = SOME [127,113,109,107,103,101] : int list option
- get_prime_between(130,132);
val it = SOME [131] : int list option
- get_prime_between(132,140);
val it = SOME [139,137] : int list option
{% endhighlight %}

In the above example the value of the get_prime_between function can be __NONE__ or __SOME Int List__. 
It can hold one type and that one type can vary between these two like _OR_ statement.
At some sense, logical _AND_ operator may be associated with an each of type and logical _OR_ operator 
may be associated with a one-of-type. This is the reason that an each-of-type can sometimes be called as 
__product type__ and a one-of-type can sometimes be called as a __sum type__.

# Self-reference-type #
<p align="justify">
This kind of type allows to describe recursive data structures. For instance a tree structure
which includes integer values for its nodes can be one of two types which is an int and
a tree itself. In functional paradigms as far as I can see it is common to represent lists
as trees. Here is an example of a basic self-reference-type.  
</p>

{% highlight  sml%}
(*
The datatype my_int_list can be of type empty or it can be a pair which is an int 
paired with of type my_int_list.
*)
datatype my_int_list = Empty | Cons of int * my_int_list
					 
val one_two_three = Cons(1,Cons(2,Cons(3,Empty)))

{% endhighlight %}

<p align="justify">
Javascript is quite natural when defining recursive data types. Below is an example of how to define 
a recursive Tree object in JavaScript.
</p>

<iframe width="100%" height="300" src="//embed.plnkr.co/tjEN3j8i0uzULbhWPZmI/script.js" allowfullscreen="allowfullscreen" frameborder="1"></iframe>

![Minion](http://octodex.github.com/images/minion.png)