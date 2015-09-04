---
layout: post
title:  "Mutual Recursion"
date:   2015-09-01 17:20:33
categories: Programming Languages
---
Mutual recursion is the ability of a programming language to call functions each other.
So function __g__ can call __f__ and __f__ can call __g__.

A classic example can be found at the following gist :

{% gist cgonul/9230cb18b382334569ac %}

The type inferring process needs the sml keyword __and__ here since the static environment 
does not contain the function binding of __s_need_two__ at line __11__ of the code.

The __and__ keyword in a let binding allows us to expand static scopes non lexically.

Lets solve the same problem in javascript.

{% gist cgonul/b44f9200e14e6771310c %}

When executing the match function the variables are added to static environment so :

 1. s_need_one function is being added to static environment
 2. s_need_two function is being added to static environment
 3. Before all of these bindings xs is also being added to static environment.
 5. At the 22th line s_need_one function is called.
 6. The mutual recursion takes place with mutating the xs binding.
 7. The function call is terminated with returning a boolean variable;

