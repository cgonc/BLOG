---
layout: post
title:  "Introduction to Variables and Bindings"
date:   2014-12-19 11:25:05
categories: Programming-Languages
---
<p align="justify">
Although it seems the simplest concept in programming languages, there are lots of concepts to be thought of when researching variables and bindings. 
It is natural that there is a large amount of abstraction when examining this concept.</p>
<p align="justify">
So basically a variable is a symbolic name under the abstraction of a memory location. 
Under the concept of the programming language paradigm we can see two distinct behaviours :

</p>
1. Imperative Languages : Created variables can be accessed or changed during their lifetime.
2. Pure Functional Languages: There is no mutation. Variables are bound to a single expression 
and keep a single value during their entire lifetime and also functions are treated as variables.

So in an imperative language like java the following code produces 

# x : 100 #
{% gist cgonul/4cfe232a2971fea9252d %}

One can wonder why the following java code produces 
# x : 5 #
{% gist cgonul/4888baf7099521f281bf %}

My idea is **Integer y = x** is a syntactic sugar for Integer y = new Integer(x). So it produces a new variable.

<p align="justify">
The type system determines the behaviour of variables and bindings but one can not generalize the overall
behaviour with straight lines since even if two languages has the same typing model, the behaviour can 
be different in the underlying language implementation.
Type system can be strong (Java) or weak (C), can be static (Java) or dynamic (Ruby)
I will document the type system exclusively
in my later posts. But as an example I can talk about ML.
<br><br>
ML has a strong static type system. An ML program is a sequence of bindings. Each binding gets type-checked and then evaluated. 
What type a binding has, depends on a static environment. A static environment is roughly the types of the preceding bindings in the file.
How a binding is evaluated depends on a dynamic environment. A dynamic environment can be described as the values of the preceding bindings in the file.
For type checking we use the static environment. When a variable is type checked, the current static environment is mutated into something that holds the type of the current variable.
For evaluating we use the dynamic environment. When a variable is evaluated, the current dynamic environment is mutated into something that holds the value of the current variable. 
</p>

A very simple programming language can be described by the following definitions.

* Types like Integer, String, Double
* Arithmetic and logical operators like addition, multiplication, division, subtraction, modulus and various logical operators
* Variables
* Conditionals 
* Boolean constants like true or false
* Closures
* Functions
* Function calls

In the upcoming posts I will dig into this definitions. The very important thing in these definitions is we first examine the syntax and 
after that the definition should be type checked at some point and lastly we should consider the evaluation strategy.
These operations and how they are done roughly determine the behaviour of the underlying programming language.

