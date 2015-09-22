---
layout: post
title:  "Tail Recursion"
date:   2014-12-29 18:56:32
categories: Programming Languages
---
<p align="justify">
When executing the following simple factorial code which is written 
in Scala language, one can come across Stack Overflow with default Jvm settings. 
</p>

<p align="justify">
On my local machine which is Windows 7 with Java HotSpot(TM) 64-Bit Server VM (build 24.71-b01, mixed mode) when I evaluate this line
I get :
</p>
{% gist cgonul/3effeeca32ffb959cf18 %} 

How ever I can use the same stack over and over with the following Scala code. With this
implementation a new stack frame is not generated in the call stack on recursive calls since you do not have to
post evaluate the operand before the subroutine call ([function calls are not stack frames](http://ezrakilty.net/research/2009/11/function_calls_are_not_stack_frames.html) )
So you do not have to store it in the stack frame as far as I understand.
And evaluating the same line gives me :
{% gist cgonul/512853bcd446d68014f3 %} 

without having the call stack being overflowed.

