---
layout: post
title:  "Case Expression Examples"
date:   2015-01-17 10:18:05
categories: Programming Languages
---

# hd and tl Implementation in SML Language #
SML implements __hd__ and __tl__ functions like this :

{% highlight  sml%}

(* List *)
exception Empty
fun null [] = true
  | null _ = false
fun hd (h :: _) = h
  | hd [] = raise Empty
fun tl (_ :: t) = t
  | tl [] = raise Empty
  
{% endhighlight %}

Pattern matching advantages :

1. The language user can never mess up and try to extract something from the wrong variant.
2. If a case expressions forget a variant, then the type-checker will give a warning message.
3. If a case expression uses a variant twice, then the type-checker will give an error message since one of the branches could never possibly be used.

# Example 1 #
{% gist cgonul/88da06eaf191d66d4d5c %}

 * __eval__ function is for evaluating an expression
 * __fetch_constants__ function returns the list of all the constants in an expression tree.
 * __has_mult__ function indicates whether there is at least one multiplication in the expression. 
 
 
# Example 2 #
 
{% gist cgonul/e3844ff288b11282025e %}

 * __oper__ datatype is a one-of-type which can be a mult or an add
 * __tree__ datatype is also a one-of-type which can be a _Node_ of a tuple of _(oper * tree * tree)_ __OR__
   a _Leaf_ of an __integer__
 * __oper_to_string__ function takes an operation and returns the string representation of it.
 * __print_tree__ prints the expression tree
 * __eval_tree__ function can evaluate the expression to its integer result where nested case expression is 
 used.

