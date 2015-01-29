---
layout: post
title:  "006. Records in SML"
date:   2015-01-07 21:42:05
categories: Programming-Languages
---
In SML we can examine tuple operations with this sample code.I personally sometimes need a data structure
which can hold different types in one variable easily. It is actually very handy that a strongly
typed programming language can support data structures which can hold different types of variables.
{% highlight  ml%}
val tuple1 = (1,2,3,4,"horse")
val tuple2 = ([2,3,4],"apple",1.3)
{% endhighlight %}

The repl output of this simple code can be seen below.
{% highlight  ml%}
val tuple1 = (1,2,3,4,"horse") : int * int * int * int * string
val tuple2 = ([2,3,4],"apple",1.3) : int list * string * real
val it = () : unit
{% endhighlight %}

<p align="justify">
Records is a powerful future of SML language. 
<br>
<br>
Records like tuples can hold different types. The only difference is they hold the data by name.
It is somewhat similar to Map implementations in Java.
</p>

{% highlight  ml%}
val record1 = {name = "CAGLAR", surname = "GONUL", age = 34, gender = "MALE"}
{% endhighlight %}

<p align="justify">
A record is also an example of each-of-type like a tuple. We can access the elements of a record by name like #name record1.
A tuple is in fact a record. That is, all the syntax for tuples is just a convenient way to write down and use records.
You can see it from the way of accessing elements in a tuple. We access the elements in a tuple like #1 tuple1.
So they are the same.
</p>

{% highlight  ml%}
val someTuple  = ("a",1,"b",2)
val someRecord = {1 ="a", 2=1, 3="b", 4=2}

[opening Records.sml]
val someTuple = ("a",1,"b",2) : string * int * string * int
val someRecord = ("a",1,"b",2) : string * int * string * int
{% endhighlight %}

As it can be seen from the REPL output, they have evaluated to the same thing.