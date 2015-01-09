---
layout: post
title:  "004. Introduction to Types"
date:   2015-01-04 11:25:05
categories: Programming Languages
---
<p align="justify">
A programming language should categorize its variables into some types at some point during the life cycle of 
a program. 
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
construct this type with objects. For example org.apache.commons.lang3.tuple.Pair<L,R> is the most famous one.
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

> So our return type either includes a NONE type  or SOME Int List. 
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

<p align="justify">
In the above example the return type of get_prime_between function can be NONE or SOME Int List. It can hold one type and that 
one type can vary between these two like an or statement.
At some sense, logical and operator may be associated with a product operator and logical or operator may be associated with a sum operator.
Maybe the naming comes from this.
</p>

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

