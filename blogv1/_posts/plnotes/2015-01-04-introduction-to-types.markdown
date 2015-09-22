---
layout: post
title:  "Types"
date:   2015-01-04 11:25:05
categories: Programming Languages
---

A programming language should categorize its variables into some types at some point during 
the life cycle of a program. 
We can categorize the types into two as __base types__ and __compound types__.

__Base types :__ Programming languages have base types like int, bool, double, unit .

__Compund types :__ Compound types contains other types in their definition. 
Compound types are powerful. To create a compound type we can use one of the following three options.


1. __Each-of-type__ also known as product types . 
2. __One-of-type__ also known as sum types . 
3. __Self-reference-type__ also known as  recursive types . 

# Each-of-type #

In SML a tuple (int * bool) is an each of type. A base types is also an each-of-type. 
A variable which is an each of type contains t1,t2,t3,..., and tn at the same time.
In each of type the variable actually just have one kind of type. Analogy: Each of this and this.


# One-of-type #

A variable which is one-of-type holds one of the t1,t2,...or tn, so a one-of-type has only one type 
during the life-cycle of the program but the type it holds can change. One of the ways that functional languages can cope
with this kind of type is using options. 

Fun example: Lets find the prime numbers between two numbers using SML language. If there is 
a prime number or some prime numbers between these two numbers we should return those integer values 
as list but if there is not we should return a NONE value. 

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


# Self-reference-type #

This kind of type allows to describe recursive data structures. For instance a tree structure
which includes integer values for its nodes can be one of two types which is an int and
a tree itself. 

{% highlight  sml%}
(*
The datatype my_int_list can be of type empty or it can be a pair which is an int 
paired with of type my_int_list.
*)
datatype my_int_list = Empty | Cons of int * my_int_list
					 
val one_two_three = Cons(1,Cons(2,Cons(3,Empty)))

{% endhighlight %}


Javascript is quite natural when defining recursive data types. Below is an example of how to define 
a recursive Tree object in JavaScript.


<iframe width="100%" height="300" src="//embed.plnkr.co/tjEN3j8i0uzULbhWPZmI/script.js" allowfullscreen="allowfullscreen" frameborder="1"></iframe>

![Minion](http://octodex.github.com/images/minion.png)