---
layout: post
title:  "Call-backs"
date:   2015-02-17 10:26:05
categories: Programming Languages
---

 * We have variable named __cbs__ which basically hold the callbacks. 
 * The function named onKeyEvent takes a function and but that function into the callback list.
 * The function named onEvent takes a parameter and call the callbacks one by one with that parameter.
 * We start to define our callbacks after we define timePressed variable. So our closures have timePressed
   variable which they can change.
 * __printIfPressed__ function is the callback registering function. The behaviour of the callbacks is
 determined by the variable named i. When we call the callback, if i equals to the callback function 
 parameter an action occurs which is print something here but it can be anything. 

{% gist cgonul/af3705757ac436599d76 %} 

It is like observer pattern.
![Observer](https://octodex.github.com/images/daftpunktocat-thomas.gif)
