---
layout: post
title:  "A Health Bar Using a Closure"
date:   2015-03-16 10:05:05
categories: Corona
---

We can use closures to isolate the variables. There is no need to share global variables among other functions
that do not need them. 

{% gist cgonul/0f4074208993c42a62f9 %}

We declare local variables and define a local function which modify these variables. We return this function so the outside 
environment modify these local variables using the returned closure. It is like a public method of an object as it is in 
object oriented paradigm. They are close to each other. 

We can also return multiple closures using lua's tables. So multiple public closures can be defined in one scope.
The whole code can be found in the following gist.

{% gist cgonul/e2fe7af41aabcf5d001d %}
 
 The whole project can be checked out from the following link : 
 
<https://github.com/cgonul/ProtectThePlanet.git>
 
<iframe width="560" height="315" src="https://www.youtube.com/embed/SW46vagFazU" frameborder="0" allowfullscreen></iframe>
