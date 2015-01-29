---
layout: post
title:  "001. Variables and Bindings"
date:   2015-01-04 11:25:05
categories: Programming Languages
---
<p align="justify">
Although it seems the simplest concept in programming languages, there are lots of concepts to be thought of when researching variables and bindings. 
There should be a large amount of abstraction when examining variables and bindings because if someone digs deep and goes to lower levels of abstraction, 
he/she will encounter memory address abstraction which vary widely among the underlying computer architecture and among the programming language on top of it.
</p>
<p align="justify">
So basically a variable is a symbolic name under the abstraction of a memory location. 
Under the concept of the programming language paradigm we can see two distinct behaviours :

</p>
1. Imperative Languages : Created variables can be accessed or changed during their lifetime.
2. Pure Functional Languages: There is no mutation. Variables are bound to a single expression and keep a single value during their entire lifetime.

So in an imperative language like java the following code produces 

# x : 100 #

{% highlight java %}
public class MutateMe {
	int x ;
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
}

public class Mutation {
	public static void main(String[] args) {
		MutateMe x = new MutateMe();
		x.setX(5);
		MutateMe y = new MutateMe();
		y = x;
		y.setX(100);
		System.out.println("x : " + x.getX());
	}
}
{% endhighlight %}

One can wonder why the following java code produces 

# x : 5 #

{% highlight java %}
public class WhyNotMutate {

	public static void main(String[] args) {
		Integer x = 5;
		Integer y = x;
		y = 100;
		System.out.println("x : " + x);
	}
}
{% endhighlight %}

My idea is **Integer y = x** is a syntactic sugar for Integer y = new Integer(x). So it produces a new variable.

<p align="justify">
ML has a strong static type system. An ML program is a sequence of bindings. Each binding gets type-checked and then evaluated. 
What type a binding has, depends on a static environment. A static environment is roughly the types of the preceding bindings in the file.
How a binding is evaluated depends on a dynamic environment. A dynamic environment can be described as the values of the preceding bindings in the file.
For type checking we use the static environment. When a variable is type checked, the current static environment is mutated into something that holds the type of the current variable.
For evaluating we use the dynamic environment. When a variable is evaluated, the current dynamic environment is mutated into something that holds the value of the current variable. 
</p>

A very simple programming language can be described by the following definitions.

* Types like Integer, String, Double
* Arithmetic and logical operators like addition, multiplication, division, subtraction, modulus and various logical operators
* Variables
* Conditionals 
* Boolean constants like true or false
* Closures
* Functions
* Function calls

In the upcoming posts we will dig into this definitions. The very important thing in these definitions is we first examine the syntax and 
after that the definition should be type checked at some point and lastly we should consider the evaluation strategy.
These operations and how they are done roughly determine the behaviour of the underlying programming language.

