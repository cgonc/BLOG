---
layout: post
title:  "Lexical Scope Notes"
date:   2015-01-30 10:26:05
categories: Programming Languages
---

# Example 1 #
 
> The body of a function is evaluated in the environment where the function is defined, 
not the environment where the function is called.

So lets evaluate a simple example in sml where the body of a function is evaluated in 
the environment where the function is defined, not the environment where the function is called.

{% highlight  sml%}
val x = 1              (*    x = 1     *)
fun f y = x + y        (*  f(y)= 1 + y *)
val x = 2              (*    x = 2     *)
val y = 3              (*    y = 3     *)
val z = f (x+y)        (*    z = f(5)  *)

(*---EVALUATION---*)
val z = 6 : int
{% endhighlight %}

In a language like sml __f always increments its parameter by one__ because the value of x is one __at
the moment where it is defined.__

Lets write the same example in javascript.

{% highlight  javascript%}
x = 1;                             // x = 1
function f (y) { return x + y }    // f = some closure
x = 2;                             // x = 2
y = 3;                             // y = 2
z = f (x+y)                        // f (y) = return 2 + y
                                   // z = 7

console.log('z : ' + z )

//The output of console log is :
z : 7
{% endhighlight %}

# Example 2 #

In javascript the situation is different. __The value of f is evaluated when it is called.__
At the time of the call the value of x equals 2 so f is a function which increments its parameter
by two.

__So the same example which is written in Javascript evaluates z to 7 instead of 6__

{% gist cgonul/4b84946cddfc1fe4c867 %}

And the evaluation resuls:

{% highlight java %}
1. x equels to 1
2. f (y) equals to a function which returns another function that is f(z) = 2*y + 1 + z
f (y) = fn z => 2*y + 1 + z
3. x equals to 3
4. g is a variable which equals to f(4)
g = fn z => 9 + z
So g is a function defined as g(z) = 9 + z
5. y equals to 5
6. z = 9 + 6 = 15

{% endhighlight %}	
  