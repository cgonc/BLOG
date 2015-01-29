---
layout: post
title:  "009. Functional Paradigm Warm-up"
date:   2015-01-27 10:16:05
categories: Programming Languages
---
# Some Terms #
<p align="justify">
First class or first class citizen means that functions can be treated as variables. They can
be passed to other functions, returned from functions, assigned like variables.
Function closures basically includes a function body and an environment which the function body
can modify and is a very powerful thing. Higher-order function just refers to a function that
takes or returns other functions.
</p>

The idea of functional programming should also be noted:

* Do not use mutable data in most or all cases. 
* Use functions like you define variables.
* Embrace the style of using recursion and recursive data structures.
* Embrace the syntax that is closer to traditional mathematical definitions of functions, proofs etc.
* Using certain programming idioms related to laziness. (what ?)

# Taking Functions as Arguments #
Consider the basic elementary school example of basic functions:

<div>
$$g(x) = 3x $$
$$f(x) = 2x + g(x) $$
$$f(3) = ? $$
</div>

<p align="justify">
This simple math expression can be ported to sml. However when we port it to sml
I realize I wrote a more general purpose function definition. The definition of f 
can be used for any function not just g like so: 
</p>

{% highlight sml %}
fun g(x) = 3*x
fun f(x,l) = 2*x + l(x) 
fun z(x) = ~6*x + x*x
fun m(x) = x*x*x

val v1 = f(3,g)
val v2 = f(4,z)
val v3 = f(5,m)

(*
--EVALUATION RESULTS--
*)
val g = fn : int -> int
val f = fn : int * (int -> int) -> int
val z = fn : int -> int
val m = fn : int -> int
val v1 = 15 : int
val v2 = 0 : int
val v3 = 135 : int
val it = () : unit
{% endhighlight %}

<p align="justify">
It is not easy and as natural as SML, defining a function like f in an imperative language. 
More examples can be noted as.
</p>

{% highlight sml %}
fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x))

fun double x = x+x

val x1 = n_times(double,4,7) (* answer: 112 *)

fun increment x = x+1

val x2 = n_times(increment,4,7) (* answer: 11 *)

val x3 = n_times(tl,2,[4,8,12,16]) (* answer: [12,16] *)
{% endhighlight %}

# Anonymous Functions #

<p align="justify">
Functional languages always have a way of defining anonymous functions. Here is a simple
example for it.
</p>

{% highlight java %}
fun times_until_zero (f,x) =
    let
	fun inner (acc,value) =
	    if value <= 0
	    then acc
	    else inner (1+acc , f(value))
    in
	inner (0, x)
    end

fun randfun x = x - 1

val uz1 = times_until_zero (randfun,1000)

val uz2 = times_until_zero ((fn y => y - 1), 100)
{% endhighlight %}

<p align="justify">
When defining anonymous function one should be careful for not defining unnecessary 
function wrapping.
</p>

{% highlight sml %}
(*
This is unnecessary since there is a function for it namely tl
*)
fn y => tl y

{% endhighlight %}

# Map and Filter #

{% highlight sml %}


{% endhighlight %}