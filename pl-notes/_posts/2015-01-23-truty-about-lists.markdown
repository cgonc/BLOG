---
layout: post
title:  "008. Truth about Lists"
date:   2015-01-23 15:49:05
categories: Programming Languages
---

<p align="justify">
Representing lists as a recursive date type is very common in functional languages. By representing
lists as recursive, functions that traverse the lists can be written very easily.
</p>

{% highlight  sml%}
(*
Lists are actually recursive datatypes
*)

datatype my_int_list = 
	 Empty
       | Cons of int * my_int_list

val x = Cons(1, Cons (2, (Cons (3,Empty))))

val y = Cons(10, Cons (11, Cons (12, Cons(13, Empty))))

fun sum_my_list list = 
    let
	fun helper xs acc =
	    case xs of 
		Empty => acc
	     | Cons(x,xs') => helper xs' acc+x
    in
	helper list 0
    end

fun append_mylist xs ys =
    case xs of
	Empty => ys
     | Cons (x,xs') => Cons (x , append_mylist xs' ys) 
 
{% endhighlight %} 
