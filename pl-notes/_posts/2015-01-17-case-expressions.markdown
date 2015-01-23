---
layout: post
title:  "007. Case Expressions"
date:   2015-01-17 10:18:05
categories: Programming Languages
---
# Some Examples of One-of Types in SML #

{% highlight  sml%}
datatype suit = Club | Diamond | Heart | Spade

datatype rank = Jack | Queen | King | Ace | Num of int

val card1 = (Club,Num 2)
val card2 = (Diamond, Jack)
val card3 = (Heart, Ace)

(*
This data type named id can represent a student. 
A new comer student does not necessarily has to 
have a student id. 

So this kind of student will be represented by his/her
name. However when the student has a student id, 
we can represent him/her with this integer.
*)

datatype id =   StudentNum of int 
              | Name of string * (string option) * string

val student1 = StudentNum 19913770
val student2 = Name ("Caglar", NONE, "Gonul")
val student3 = Name ("Mehmet", NONE, "Mahmutoglu")
val student4 = Name ("Sinan", NONE, "Ersan")
val student5 = Name ("Mehmet", SOME "Ersin", "Saracoglu")
{% endhighlight %}

<p align="justify">
When we consider the example of datatype id, this binding adds a new type called id and
two constructors StudentNum and Name. A constructor can be thought as a function for creating
values of the new type. One important question is how do we get the underlying variant.
</p>

# Getting the Data Stored in a Datatype Binding #

<p align="justify">

Lets consider how to get the student id of student1. First we need the consider if student1 is
a type of StudentNum or Name. Once we know its variant we can extract the data.
In the notes it says like  :
</p>

> Recall how we have done this so for lists and options, which are also one-of types: We had functions for
testing which variant we had (null or isSome) and functions for getting the pieces (hd, tl, or valOf), which
raised exceptions if given arguments of the wrong variant

<p align="justify">
So I look at the implementation code in SML and I see something very interesting. Here is what I see 
when I look basic list implementations.
</p>

{% highlight  sml%}

(* List *)
exception Empty
fun null [] = true
  | null _ = false
fun hd (h :: _) = h
  | hd [] = raise Empty
fun tl (_ :: t) = t
  | tl [] = raise Empty
  
{% endhighlight %}

<p align="justify">
The hd implementation use some kind of pattern matching. When the variable bind this pattern ,
the underlying language implementation (I guess) can extract the data out of it. 

Pattern matching is something that is implemented on the underlying programming language. Case
expressions is an implementation of pattern matching. With case expressions we can check the 
variant and if its pattern matches with the following case expression we can extract the data
out of it. Case expressions are one of the powerful tools for the language user since :
</p>

1. The language user can never mess up and try to extract something from the wrong variant.
2. If a case expressions forget a variant, then the type-checker will give a warning message.
3. If a case expression uses a variant twice, then the type-checker will give an error message since one of the branches could never possibly be used.


<p align="justify">
I think the example that will be given below is important. It is a very very simple language 
construct which can execute arithmetic expressions. Lets dig in.
</p>

{% highlight  sml%}

(*
A datatype exp which can be used to represent 
an arithmetic expression
*)
datatype exp = 
	 Constant of int
       | Negate of exp
       | Add of exp * exp
       | Multiply of exp * exp
       | Division of exp * exp

val x1 = Constant 19
val x2 = Constant 20
val x3 = Constant 21
val x4 = Constant 22

val y1_of_add_x1_x2 = Add (x1,x2)
val y2_of_add_x3_x4 = Add (x3,x4)

val z1_of_multiply_y1_y2 = Multiply (y1_of_add_x1_x2,y2_of_add_x3_x4) 

(*
A function which can be used to evaluate an expression
*)
fun eval e =
    case e of
	Constant i => i
      | Negate e2 => ~(eval e2)
      | Add (e1,e2) => (eval e1) + (eval e2)
      | Multiply (e1,e2) => (eval e1) * (eval e2)
      | Division (e1,e2) => (eval e1) div (eval e2)     

(*
A function which can return the list of all the constants in 
an expression
*)

fun fetch_constants e =
    case e of
	Constant i => [i]
      | Negate e2 => fetch_constants e2
      | Add (e1,e2) => fetch_constants e1 @ fetch_constants e2
      | Multiply (e1,e2) => fetch_constants e1 @ fetch_constants e2  
      | Division (e1,e2) => fetch_constants e1 @ fetch_constants e2    

(*
A bool function indicating whether there is at least one multiplication
in the expression.
*)

fun has_mult e =
    case e of
	Constant i => false
      | Negate e2 => has_mult e2
      | Add (e1,e2) => has_mult e1 orelse has_mult e2
      | Multiply (e1,e2) => true
      | Division (e1,e2) => has_mult e1 orelse has_mult e2
  
{% endhighlight %}

<p align="justify">
We can also use nested case expressions. Here is an example.
</p>

{% highlight  sml%}

datatype oper = mult | add

datatype tree = Node of oper * tree * tree
	      | Leaf of int


val l1 = Leaf 1
val l2 = Leaf 2
val l3 = Leaf 3
val l4 = Leaf 4
val l5 = Leaf 5

val n1 = Node (mult,l1,l2)
val n2 = Node (add,l3,l4)
val n3 = Node (mult,n2,l5)
val n4 = Node (add,n1,n3)

(*
A simple function to print a tree
*)

fun oper_to_string operation =
    case operation of
	mult => "*"
      | add => "+" 

fun print_tree tree =
    case tree of 
	Leaf e => " |" ^ Int.toString (e) ^ "| "
     | Node (ope, t1, t2)  => " ( " ^ print_tree t1 ^ oper_to_string(ope) ^ print_tree t2 ^ " ) " 

(*
A simple function to evaluate a tree
*)

fun eval_tree tree =
    case tree of
	Leaf e => e
      | Node (ope, t1, t2) => case ope of
				  add => eval_tree t1 + eval_tree t2
				| mult => eval_tree t1 * eval_tree t2 

{% endhighlight %}