---
layout: post
title:  "Type Inference"
date:   2015-09-01 16:24:33
categories: Programming Languages
---
Static type checking is the process of rejecting a code before it runs if it does not 
type check. So you can not assign an integer value to a string variable. 

In statically type languages every binding has a type before the program runs.

Some languages like ML has the ability to infer types from the existing information.

The algorithm behind it [__Hindley-Milner__](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system)
and the [__proof__](https://web.archive.org/web/20120324105848/http://www.cs.ucla.edu/~jeff/docs/hmproof.pdf)
seems very complex but the idea is fairly simple and can be outlined as follows :

1. The types are evaluated lexically (top down). For example
if a type involves a binding which is not defined in the preceding bindings which
is the static environment than a compile error occurs. This is not true with mutual recursion.
2. When evaluating the type of a binding, the type inferencer gather all the necessary 
facts of the preceding bindings. 
3. If it is impossible to infer a type than a compiler error will occur.
4. If the type has no constraint on it, it can be any type which is a cool thing. 

