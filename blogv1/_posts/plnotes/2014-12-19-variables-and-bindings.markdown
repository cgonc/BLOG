---
layout: post
title:  "Variables and Bindings"
date:   2014-12-19 11:25:05
categories: Programming Languages
---

A variable is a symbolic name under the abstraction of a memory location. 
Under the concept of the programming language paradigm we can see two distinct behaviours :

1. Imperative Languages : Created variables can be accessed or changed during their lifetime.
2. Pure Functional Languages: There is no mutation. Variables are bound to a single expression 
and keep a single value during their entire lifetime and also functions are treated as variables.

Type system can be strong (Java) or weak (C), can be static (Java) or dynamic (Ruby)

ML has a strong static type system. An ML program is a sequence of bindings. Each binding gets type-checked and then evaluated. 
What type a binding has, depends on a static environment. 
At a certain line of the code, a static environment is roughly __the types__ of the preceding bindings in the file.
How a binding is evaluated depends on a __dynamic environment__. 
A dynamic environment can be described as the __values__ of the preceding bindings in the file.
For type checking we use the __static environment__. When a variable is type checked, the current static environment is mutated into something that holds the type of the current variable.
For evaluating we use the __dynamic environment__. When a variable is evaluated, the current dynamic environment is mutated into something that holds the value of the current variable. 

