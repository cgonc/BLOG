---
layout: post
title:  "Lexical Scope"
date:   2015-01-30 10:26:05
categories: Programming-Languages
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

{% highlight  sml%}

(*
Example 1
*)
val x = 1
fun f y =
    let
	 val x = y+1
    in
	 fn z => x + y + z
    end
val x = 3
val g = f 4
val y = 5
val z = g 6

(*
EVALUATION
1. x equels to 1
2. f (y) equals to a function which returns another function that is f(z) = 2*y + 1 + z
   f (y) = fn z => 2*y + 1 + z
3. x equals to 3
4. g is a variable which equals to f(4)
   g = fn z => 9 + z
   So g is a function defined as g(z) = 9 + z
5. y equals to 5
6. z = 9 + 6 = 15 
*)
{% endhighlight %}
  
# Abstract Data Types #

Here is a set implementation in SML.

{% highlight sml %}
(*
This example is demonstrating that a record of closures
that have the same environment is a lot like an object
in object-oriented programming :
	-- the functions are methods.
	-- the bindings in the environment are private fields and methods.

It suggests (correctly) that functional programming and 
object-oriented programming are more similar than they might
first appear.

The key to an abstract data type (ADT) is requiring clients to
use it via a collection of functions rather than directly accessing
its private implementation.

Thanks to this abstraction, we can later change how the data type is
implemented without changing how it behaves for the clients.

In an object-oriented language, you might implement an ADT by 
defining a class with all private fields (inaccessible to clients) 
and some public methods (the interface with the clients).

The same thing can be implemented in ML with a record of closures; the
variables that the closures use form the environment correspond to the
private fields.

This example is an implementation of a set of integers that supports creating 
a new bigger set and seeing if an integer is in a set. The sets are mutation-free
in the sense that adding an integer to a set produces an new different set.
*)

(*
A set is a record with three fields, each of which holds a function.
*)					  
datatype set = S of { insert : int -> set,
		      member : int -> bool,
		      size   : unit -> int,
		      members : unit -> int list}

(*
Once we construct the empty set implementation we can use its 
insert member function to add new elements and create new sets 
out of it.
*)
val empty_set =
    let
	fun make_set xs =
	    let	
		fun contains i = List.exists (fn j => i=j) xs
	    in
		S 	{ insert = fn i => if contains i
					   then make_set xs
					   else make_set (i::xs),
			  member = contains,
			  size   = fn () => length xs,
			  members = fn () => xs
			}
	    end
    in
	make_set []
    end
	
val S s01 = empty_set
val S s02 = (#insert s01) 34
val S s03 = (#insert s02) 35
val S s04 = (#insert s03) 36

val m04 = (#members s04)()
val size_04 = (#size s04)()

val t1 = (#member s04) 35
val t2 = (#member s04) 36
val t3 = (#member s04) 37

{% endhighlight %}			

# Mutation in ML References # 

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
 