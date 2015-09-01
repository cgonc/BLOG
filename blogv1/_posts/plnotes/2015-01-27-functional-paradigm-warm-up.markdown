---
layout: post
title:  "Functional Paradigm Warm-up"
date:   2015-01-27 10:16:05
categories: Programming Languages
---
# Some Terms #
<p align="justify">
First class or first class citizen means that functions can be treated as variables. They can
be passed to other functions, returned from functions, assigned like variables.
Higher-order function just refers to a function that
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
This simple math expression can be ported to sml. However when I port it to sml
I realize I wrote a more general purpose function definition. The definition of f 
can be used for any function not just g like so: 
</p>

{% gist cgonul/1e9614c9e65eb8e39883 %} 

And when we evaluate the values we get the following results :

{% highlight sml %}
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
It is not as easy and as natural as it is in SML, defining a function like f in an imperative language. 
More examples can be given in SML language.
</p>

 * __n_times__ function takes a function and two integers. Calls the function f  decrementing n
  over and over till the integer reaches zero. like so f(f(f(f(f(f(x))))))
  
This one is mind bending but after understanding how it works it is beautiful.
{% gist cgonul/827f3793950f744db8f9 %}

# Anonymous Functions #

<p align="justify">
Functional languages always have a way of defining anonymous functions. Here is a simple
example for it in SML.
</p>
{% gist cgonul/f08cf13befcff0df13b2 %}

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
A simple map and filter implementations in SML language :

{% gist cgonul/8d421d23541e74df1af8 %}

And evaluating the values of the above example :

{% highlight java %}
(*---EVALUATION---*)
val map = fn : ('a -> 'b) * 'a list -> 'b list
val filter = fn : ('a -> bool) * 'a list -> 'a list
val x1 = [1,2,3,4,5] : int list
val x2 = [2,4,6,8,10] : int list
val x3 = [3,4,5,6,7] : int list
val x4 = [1] : int list
val it = () : unit

{% endhighlight %}
<p align="justify">
When observing the evaluation of map function one can see its type which takes a function whose type is 
( take any type of 'a' and return any type of 'b' ) , and (a list type of 'a') and returns a list type of 'b'.
It is really powerful for a language that makes your variables automatically generic for you.
</p>

# Fold #

Fold is also a very popular function in functional paradigm. Generally its idea is 
traverse a recursive data structure onto an accumulator.

{% gist cgonul/116fb11c268fc0a603b8 %}

# Function Composition #

Function composition is also very common in functional paradigm.
o operator is a syntactic sugar for concatenating function calls.
It seems handy. 

 * __compose__ The basic idea can be seen in this function. It takes two functions as a parameter 
   and returns a function which takes an argument x and returns a f ( g x ) so for example : 
   this call (fn x=> x * 2, fn y => y + 4) has a value which is equivalent to a function 
   which increments its parameter by four and double the result.
 * __sqrt_of_abs__ and __sqrt_of_abs_equals__ functions has the same value.
 * __sqrt_of_abs_cur__ is the curried form of it.

{% gist cgonul/436d32dad2d0561b7ef9 %}

# Currying and Partial Application #

Currying form is common in functional paradigm. Since functions are treated as ordinary variables we can assign 
an anonymous function to a variable. I think with the curried form we have more options when defining functions
 
 * __fold__ is the curried form of fold.
 * Since we have the curried form of fold in our hand, we can easily define a sum function 
   which gives the summation of an integer list from that definition, and also a product function 
   which gives the product of an integer list.
 
{% gist cgonul/2311af7ed98035b197a6 %}
