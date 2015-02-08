---
layout: post
title:  "010. Lexical Scope"
date:   2015-01-30 10:26:05
categories: Programming-Languages
---
What does it mean :
 
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

In a language like sml f always increments its parameter by one because the value of x is one at
the moment where it is defined.

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

In javascript the situation is different. The value of f is evaluated when it is called.
At the time of the call the value of x equals 2 so f is a function which increments its parameter
by two. 

# Closures #

<p align="justify">
A closure is a closed language construct which has two parts, the code for the function
and the environment that was current when we created the function. It is like an ML pair,
just something with two parts however you can not access the parts of the pair separately.
All you can do is call the function.
</p>

Another example :

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

# Fold #

Fold is also a very popular function in functional paradigm. Generally its idea is 
traverse a recursive data structure onto an accumulator.

{% highlight sml %}
(*
Fold implementations
*)

fun fold (f, acc, xs) =
    case xs of 
	[] => acc
      | x::xs' => fold (f, f(acc,x) , xs')

val x = [1,2,3,4,5]
val max = fold ((fn (acc,x) => if x > acc then x else acc),hd x, x)
val sum = fold ((fn (acc,x) => x + acc), 0, x)
val product = fold ((fn (acc,x) => x * acc) ,1 ,x) 
{% endhighlight %}

# Function Composition #

Function composition is also very common in functional paradigm.

{% highlight sml %}
(*
Function compositon examples
*)

fun compose (f,g) = fn x => f (g x)
fun sqrt_of_abs i = Math.sqrt (Real.fromInt (abs i))

(*Equals*)
fun sqrt_of_abs_equals i = (Math.sqrt o Real.fromInt o abs ) i

(*Curied form*)
val sqrt_of_abs_cur = Math.sqrt o Real.fromInt o abs 

infix |> (* tells the parser |> is a function that appears between its two arguments *)
fun x |> f = f x
fun sqrt_of_abs_readable i = i |> abs |> Real.fromInt |> Math.sqrt
{% endhighlight %}

# Currying and Partial Application #

{% highlight sml %}
(*
Currying and Partial Application Examples
*)

val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

val isSorted = sorted3 3 4 5

(*
Curried form of fold
*)

fun fold f = fn acc => fn xs => 
		case xs of
		    [] => acc
		  | x::xs' => fold f (f(acc,x)) xs'

(*
We are now more elastic. 
For instance we can define a sum and a product variable like so
*)
val sum = fold (fn (acc,x) => x + acc) 0
val product = fold (fn (acc,x) => x * acc) 1

val x_sum = sum [1,2,3,4,5]
val x_product = product [1,2,3,4,5]

(*
Syntactic sugar for defining curried functions
*)

fun fold_s f acc xs =
    case xs of
	[] => acc
      | x::xs' => fold_s f (f(acc,x)) xs'

 
(*
More examples
*)

fun zip xs ys =
    case (xs,ys) of
	([],[]) => []
      | (x::xs',y::ys') => (x,y) :: (zip xs' ys')
      | _ => raise Empty

fun range i j = if i > j then [] else i :: range (i+1) j

val countup = range 1

fun duplicate_number_list xs = zip (countup (length xs)) xs

{% endhighlight %}
  
# Callbacks #

<p align="justify">
Here is a classic example of callback implementation in SML .	
</p>

{% highlight sml %}
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
		   if i = j
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
 