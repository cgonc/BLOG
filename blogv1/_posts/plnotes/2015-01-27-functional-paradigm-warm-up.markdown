---
layout: post
title:  "Functional Paradigm Warm-up"
date:   2015-01-27 10:16:05
categories: Programming-Languages
---
# Some Terms #
<p align="justify">
First class or first class citizen means that functions can be treated as variables. They can
be passed to other functions, returned from functions, assigned like variables.
Higher-order function just refers to a function that
takes or returns other functions.
</p>

The idea of functional programming should also be noted:

* Do not use mutable data in most or all cases. 
* Use functions like you define variables.
* Embrace the style of using recursion and recursive data structures.
* Embrace the syntax that is closer to traditional mathematical definitions of functions, proofs etc.
* Using certain programming idioms related to laziness. (what ?)

# Taking Functions as Arguments #
Consider the basic elementary school example of basic functions:

<div>
$$g(x) = 3x $$
$$f(x) = 2x + g(x) $$
$$f(3) = ? $$
</div>

<p align="justify">
This simple math expression can be ported to sml. However when I port it to sml
I realize I wrote a more general purpose function definition. The definition of f 
can be used for any function not just g like so: 
</p>

{% highlight sml %}
fun g(x) = 3*x
fun f(x,l) = 2*x + l(x) 
fun z(x) = ~6*x + x*x
fun m(x) = x*x*x

val v1 = f(3,g)
val v2 = f(4,z)
val v3 = f(5,m)

(*
--EVALUATION RESULTS--
*)
val g = fn : int -> int
val f = fn : int * (int -> int) -> int
val z = fn : int -> int
val m = fn : int -> int
val v1 = 15 : int
val v2 = 0 : int
val v3 = 135 : int
val it = () : unit
{% endhighlight %}

<p align="justify">
It is not as easy and as natural as it is in SML, defining a function like f in an imperative language. 
More examples can be given in SML language.
</p>

 * __n_times__ function takes a function and two integers. Calls the function f  decrementing n
  over and over till the integer reaches zero. like so f(f(f(f(f(f(x))))))
  
This one is mind bending but after understanding how it works it is beautiful.


{% highlight java %}

fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x))

fun double x = x+x

val x1 = n_times(double,4,7) (* answer: 112 *)

fun increment x = x+1

val x2 = n_times(increment,4,7) (* answer: 11 *)

val x3 = n_times(tl,2,[4,8,12,16]) (* answer: [12,16] *)

{% endhighlight %}

# Anonymous Functions #

<p align="justify">
Functional languages always have a way of defining anonymous functions. Here is a simple
example for it in SML.
</p>

{% highlight java %}
fun times_until_zero (f,x) =
    let
	fun inner (acc,value) =
	    if value <= 0
	    then acc
	    else inner (1+acc , f(value))
    in
	inner (0, x)
    end

fun randfun x = x - 1

val uz1 = times_until_zero (randfun,1000)

val uz2 = times_until_zero ((fn y => y - 1), 100)
{% endhighlight %}

<p align="justify">
When defining anonymous function one should be careful for not defining unnecessary 
function wrapping.
</p>

{% highlight sml %}
(*
This is unnecessary since there is a function for it namely tl
*)
fn y => tl y

{% endhighlight %}

# Map and Filter #
Simple map and filter implementations in SML language.

{% highlight java %}
(*
Simple map and filter implementations
*)

fun map (f, xs) =
    case xs of
	[] => []
      | x::xs' => (f x) :: map (f,xs')

fun filter (f, xs) =
    case xs of
	[] => []
      | x::xs' => if(f x) 
		  then  x :: filter (f, xs')
		  else filter (f, xs')

val x1 = [1,2,3,4,5]
val x2 = map ((fn y => y * 2), x1)
val x3 = map ((fn y => y + 2), x1)
val x4 = filter ((fn y => y < 2), x1)

(*---EVALUATION---*)
val map = fn : ('a -> 'b) * 'a list -> 'b list
val filter = fn : ('a -> bool) * 'a list -> 'a list
val x1 = [1,2,3,4,5] : int list
val x2 = [2,4,6,8,10] : int list
val x3 = [3,4,5,6,7] : int list
val x4 = [1] : int list
val it = () : unit

{% endhighlight %}
<p align="justify">
When observing the evaluation of map function one can see its type which takes a function whose type is 
( take any type of and return any type of b) , and (a list type of a) and returns a list type of b.
It is really powerful for a language that makes your variables automatically generic for you.
</p>

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
o operator is a syntactic sugar for concatenating function calls.
It seems handy. 

 * __compose__ The basic idea can be seen in this function. It takes two functions as a parameter 
   and returns a function which takes an argument x and returns a f ( g x ) so for example : 
   this call (fn x=> x * 2, fn y => y + 4) has a value which is equivalent to a function 
   which increments its parameter by four and double the result.
 * __sqrt_of_abs__ and __sqrt_of_abs_equals__ functions has the same value.
 * __sqrt_of_abs_cur__ is the curried form of it.

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

Currying form is common in functional paradigm. Since functions are treated as ordinary variables we can assign 
an anonymous function to a variable. I think with the curried form we have more options when defining functions
 
 * __fold__ is the curried form of fold.
 * Since we have the curried form of fold in our hand, we can easily define a sum function 
   which gives the summation of an integer list from that definition, and also a product function 
   which gives the product of an integer list.
 

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
