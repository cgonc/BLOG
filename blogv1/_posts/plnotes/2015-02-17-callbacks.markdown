---
layout: post
title:  "Call-backs"
date:   2015-02-17 10:26:05
categories: Programming-Languages
---

<p align="justify">
Here is a classic example of callback implementation in SML .	
</p>

 * We have variable named __cbs__ which basically hold the callbacks. 
 * The function named onKeyEvent takes a function and but that function into the callback list.
 * The function named onEvent takes a parameter and call the callbacks one by one with that parameter.
 * We start to define our callbacks after we define timePressed variable. So our closures have timePressed
   variable which they can change.
 * __printIfPressed__ function is the callback registering function. The behaviour of the callbacks is
 determined by the variable named i. When we call the callback, if i equals to the callback function 
 parameter an action occurs which is print something here but it can be anything. 


{% highlight mambo %}
(*
A list named cbs for holding the callbacks.
The elements of the list are actually closures.

The body of the closure is a function which takes an 
int and produces something without returning anything.
*)
val cbs : (int -> unit) list ref = ref []

(*
This function is for registering callbacks. Registering is 
simple. It is just adding the closure to the closure callback list.
So onKeyEvent takes a function of type (int -> unit) and returns unit

Most importantly, the type of onKeyEvent places no restriction on what 
extra data a callback can access when it is called. Since a closure can 
access its environment when it is defined, any environment when it is 
defined can be accessed at the calling time of the closure.
*)
fun onKeyEvent f =
    cbs := f :: (!cbs)

(*
This function loops through the cbs list and call the closures one by one
with a parameter.
*)
fun onEvent i =
    let
	fun loop closures =
	    case closures of
		[] => ()
	      | c::cs' => (c i; loop cs')
    in
	loop (!cbs)
    end

(*
Client implementation.
*)

(*
This code block is for keeping track of how many times the event occurs.
Every time onEvent is called this closure will be called.
And the closure increments the timePressed variable by one. 
In here the environment which the closure will change, includes timePressed 
variable.
*)
val timePressed = ref 0
val _ = onKeyEvent ( fn _ => timePressed := (!timePressed) + 1)

(*
This code block is registering a callback which simply prints out i.
*)

fun printIfPressed i =
    onKeyEvent (fn j => 
		   if(i = j)
		   then print ("you pressed " ^ Int.toString i ^ "\n")
		   else ())

val _ = printIfPressed 4
val _ = printIfPressed 5
val _ = printIfPressed 6
val _ = printIfPressed 7

(*----THE OUTPUT----*)
- use "callbacks.sml";
[opening callbacks.sml]
val cbs = ref [fn,fn,fn,fn,fn] : (int -> unit) list ref
val onKeyEvent = fn : (int -> unit) -> unit
val onEvent = fn : int -> unit
val timePressed = ref 0 : int ref
val printIfPressed = fn : int -> unit
val it = () : unit
- onEvent 1;
val it = () : unit
- onEvent 4;
you pressed 4
val it = () : unit
- onEvent 5;
you pressed 5
val it = () : unit
- onEvent 8;
val it = () : unit
- timePressed;
val it = ref 4 : int ref
- onEvent 7;
you pressed 7
val it = () : unit
- timePressed;
val it = ref 5 : int ref
- 
{% endhighlight %}

