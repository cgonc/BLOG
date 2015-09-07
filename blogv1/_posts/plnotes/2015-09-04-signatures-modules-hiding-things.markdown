---
layout: post
title:  "Modules Signatures And Hiding Things in SML"
date:   2015-09-04 16:25:33
categories: Programming Languages
---

A module in SML is a container for a kind of logic. It contains similar bindings 
for a specific logic for example rational operations.

In sml we can define a module with the following keywords: __Structure__ , __struct__

{% highlight  sml%}
Structure module_name =
struct 
	bindings... 
end
{% endhighlight %}

A signature on the other hand is a type for a structure. Programming with signatures in SML can be 
similar programming with interfaces in Java in some ways. 

The value of programming with signatures ,is hiding the implementation details. Signatures can
be used to achieve this and this is considered a valuable software practice.

{% highlight  sml%}
signature MATHLIB =  sig  
val fact : int -> int 
val half_pi : real  
end  

(*Implementation*)
structure MyMathLib :> MATHLIB =  
struct  
fun fact x = … 
val half_pi = Math.pi / 2.0 
fun doubler x = x * 2 end 
{% endhighlight %}

In the following  example the doubler function can not be reached from outside clients.

One thing that the signature keyword of the SML language can be described as follows.
In a classic implementation of rational numbers there is an invariant which is not to 
allow zero denominator. So the implementation should handle the situation by appropriately 
throwing an exception.

But the following implementation of the signature RATIONAL_A is violating this invariant. 
Because the datatype rational can be accessed from the client code.
{% highlight  sml%}
signature RATIONAL_A = 
sig 
datatype rational = Whole of int | Frac of int*int
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end

structure Rational1:> RATIONAL_A= ...
{% endhighlight %}

So a client can make a call like this :

{% highlight  sml%}
Rational1.Frac(1,0) (*This complicates things in SML*)
Rational1.Frac(3,~2)
{% endhighlight %}

This complicates things. However SML has a solution for this. The solution is to hide more.
{% highlight  sml%}
signature RATIONAL_B = 
sig 
type rational (*An abstract data type*)
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end
structure Rational1:> RATIONAL_B = 
...
{% endhighlight %}

By declaring the type rational as abstract, we can prevent clients can not directly call
the data type __Frac__ or __Whole__. These are just implementation details and they are being hidden 
from the clients. This means the type exists but clients do not know its definition.

So the signatures is for forcing the implementation has a specific type, the implementation can
hide various implementation details including data types which are declared as abstract in 
signature definition.





 

