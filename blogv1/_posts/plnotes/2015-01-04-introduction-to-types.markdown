---
layout: post
title:  "Introduction to Types"
date:   2015-01-04 11:25:05
categories: Programming-Languages
---
<p align="justify">
A programming language should categorize its variables into some types at some point during the life cycle of 
a program. We can categorize the types into two as base types and compound types. Especially for the
compound types choosing the right kind for your data is crucial.
<br>
<br>
Base types : Programming languages have base types like int, bool, double, unit .
<br>
<br>
Compund types :  Compound types contains other types in their definition. Compound types are powerful.
To create a compound type we can use one of the following three options.
<br>
</p>

1. Each-of-type also known as product types . 
2. One-of-type also known as sum types . 
3. Self-reference-type also known as  recursive types . 

# Each-of-type #
<p align="justify">
Each of types are familiar to most of us. In SML a tuple (int * bool) is an each of type. In Java we can 
construct this type (a tuple) with objects.For example org.apache.commons.lang3.tuple.Pair<L,R> is the most 
famous one. 
<br>
A base types is also an each-of-type. 
A variable which is an each of type contains t1,t2,t3,..., and tn at the same time.
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

So our return type either includes a NONE type  or SOME Int List. 
This is a good example of a one-of-type.

{% highlight  java%}
fun is_prime (n) = 
    let
	fun helper (a) =
	    if (n mod a) = 0 andalso a <> 1 
	    then false
	    else
		if a = 1
		then true
		else
		    helper(a-1)
    in
	if n = 1 
	then false
	else
	    if n = 2
	    then true
	    else 
		if (n mod 2) = 0
		then false
		else
		    helper (floor ( Math.sqrt(Real.fromInt n) + 1.0 ) )
    end

fun get_prime_between (start , stop) =
    let
	fun helper (x , acc) =
	    if x = stop
	    then acc
	    else 
		if is_prime (x)
		then helper (x + 1, x::acc)
		else helper (x + 1, acc)
	val result = helper (start, [])
    in
	case result of
	    [] => NONE
	  | x::xs => SOME result 
    end
{% endhighlight %}

In the above example the value of the get_prime_between function can be __NONE__ or __SOME Int List__. 
It can hold one type and that one type can vary between these two like _OR_ statement.
At some sense, logical _AND_ operator may be associated with an each of type and logical _OR_ operator 
may be associated with a one-of-type. This is the reason that an each-of-type can sometimes be called as 
__product type__ and a one-of-type can sometimes be called as a __sum type__.

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