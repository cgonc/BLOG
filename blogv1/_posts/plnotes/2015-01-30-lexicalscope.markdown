---
layout: post
title:  "Lexical Scope"
date:   2015-01-30 10:26:05
categories: Programming Languages
---
What does it mean ?
 
> The body of a function is evaluated in the environment where the function is defined, 
not the environment where the function is called.

<p align="justify">
So lets evaluate a simple example in sml where the body of a function is evaluated in 
the environment where the function is defined, not the environment where the function is called.
</p>

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

In javascript the situation is different. __The value of f is evaluated when it is called.__
At the time of the call the value of x equals 2 so f is a function which increments its parameter
by two.

__So the same example which is written in Javascript evaluates z to 7 instead of 6__

So If any one reading this part, I am in a dilemma. According to the teacher's notes Javascript should be
dynamically scoped. But Javascript is lexically scoped. I searched SO for a while and came accross this
link <http://stackoverflow.com/questions/19622805/lexical-scope-in-python-vs-ml> .

Any-ways in a dynamically scoped language you just have one current environment and you use it to 
evaluate function bodies. In a lexically scoped language your evaluations take place lexically where 
your bindings take place. In my personal opinion writing with a lexically scope language is easier and
more traceable.

Here is another example for lexical scope in SML .
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
  
# Abstract Data Types #

Here is a set implementation in SML.
{% gist cgonul/17ab9f383793b25a7a40 %}

# Mutation in ML References # 

A simple example of mutation in sml. It will be useful when discussing callbacks.

{% highlight sml %}

val x1 = ref 0
val x2 = x1

val _ = x2 := 7

(*THE OUTPUT*)
val x1 = ref 7 : int ref
val x2 = ref 7 : int ref
val it = () : unit
-
{% endhighlight %}			
 