---
layout: post
title:  "Case Expressions"
date:   2015-01-17 10:18:05
categories: Programming Languages
---

Before explaining the case expressions, let's consider some useful examples of one-of-types in SML. 

# Some Examples of One-of Types in SML #
{% gist cgonul/496256a65c91b112dee4 %} 

<p align="justify">
When we consider the example of datatype id, this binding adds a new type called id and
two constructors StudentNum and Name. A constructor can be thought as a function for creating
values of the new type. One important question is how do we get the underlying variant.
</p>

# Getting the Data Stored in a Datatype Binding #

<p align="justify">

Lets consider how to get the student id of student1. First we need the consider if student1 is
a type of StudentNum or Name. Once we know its variant we can extract the data.
In the notes it says like  :
</p>

> Recall how we have done this so for lists and options, which are also one-of types: We had functions for
testing which variant we had (null or isSome) and functions for getting the pieces (hd, tl, or valOf), which
raised exceptions if given arguments of the wrong variant

<p align="justify">
After reading this notes I wonder how SML implements hd tand tl functions. 
So I look at the implementation code in SML and I see something very interesting. Here is what I see 
when I look basic list implementations.
</p>

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

<p align="justify">
The hd implementation use some kind of pattern matching. When the variable bind to this pattern ,
the underlying language implementation (I guess) can extract the data out of it. 
<br><br>
Pattern matching is something that is implemented on the underlying programming language. Case
expressions is an implementation of pattern matching. With case expressions we can check the 
variant and if its pattern matches with the following case expression we can extract the data
out of it. Case expressions are powerful since :
</p>

1. The language user can never mess up and try to extract something from the wrong variant.
2. If a case expressions forget a variant, then the type-checker will give a warning message.
3. If a case expression uses a variant twice, then the type-checker will give an error message since one of the branches could never possibly be used.


<p align="justify">
Let's use case expressions in two beautiful examples. 
I think the first example that will be given below is important. 
In my personal opinion this example can be thought
of a very simple language which can execute simple arithmetic operations. The operations are type checked
and then assigned on to variables and than evaluated. The type of exp is a recursive data type. It can
naturally be thought as a tree. I think it is beautiful and simple. 
</p>

 * __eval__ function is for evaluating an expression
 * __fetch_constants__ function returns the list of all the constants in an expression tree.
 * __has_mult__ function indicates whether there is at least one multiplication in the expression. 
 
{% gist cgonul/88da06eaf191d66d4d5c %}
 
<p align="justify">
We can also use nested case expressions. Here is an example.
</p>
 * __oper__ datatype is a one-of-type which can be a mult or an add
 * __tree__ datatype is also a one-of-type which can be a _Node_ of a tuple of _(oper * tree * tree)_ __OR__
   a _Leaf_ of an __integer__
 * __oper_to_string__ function takes an operation and returns the string representation of it.
 * __print_tree__ prints the expression tree
 * __eval_tree__ function can evaluate the expression to its integer result where nested case expression is 
 used.
 
{% gist cgonul/e3844ff288b11282025e %}

