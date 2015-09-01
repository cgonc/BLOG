---
layout: post
title:  "Tail Recursion"
date:   2014-12-29 18:56:32
categories: Programming Languages
---
<p align="justify">
It is not a big deal however I want to add this to my notes. When executing the following simple factorial code which is written 
in Scala language, one can come across Stack Overflow with default Jvm settings. 
</p>

<p align="justify">
On my local machine which is Windows 7 with Java HotSpot(TM) 64-Bit Server VM (build 24.71-b01, mixed mode) when I evaluate this line
I get :
</p>
{% gist cgonul/3effeeca32ffb959cf18 %} 

How ever I can use the same stack over and over with the following Scala code. With this
implementation a new stack frame is not generated in the call stack on recursive calls.
And evaluating the same line gives me :
{% gist cgonul/512853bcd446d68014f3 %} 

without having the call stack being overflowed with function calls.

