---
layout: post
title:  "Meeting With Io"
date:   2015-10-05 12:42:05
categories: Io
---

In Io language everything is an object.Everything is a kind of storm-trooper.
Every interaction with an object is a message so you give orders (messages) to storm-troopers
You do not instantiate classes, you clone other objects called prototypes like all storm-troopers are altered clones
of Boba Fett's father (Jango Fett).

Objects remember their prototypes like storm-troopers remember their father clone.

Objects have slots. These slots can be a value holder or a method holder.

A message returns the value of in a slot or invokes the method in the slot.

If an object can't respond to a message, it sends the message to its prototype.

{% highlight  io%}
//A message for creating a list object
l := list(1,2,3,"4")

//A message example for creating a map 
map := Map clone
map atPut("one",1)
map atPut("two",2)
map atPut("three"3)

//Common map messages
map asList
map keys
map size

{% endhighlight %}

Io is a strong, dynamically typed language like Ruby. 

0 is not true or false. Empty string is not false. Nil is not false.  

__slotNames__ message is used to list all slot names.

__:=__ operator is used for the first time creation.

__=__ operator is used for assigning after creation.

__::=__ (colon colon equals) is used for creating a setter.

{% gist cgonul/a571aba7e9f1afb84f34 %}

A semicolon operator concatenates two distinct messages.


By typing __OperatorTable__ one can list the avaliable operators.

{% highlight  io%}

Io 20110905
Io> OperatorTable addOperator("xor",11)
==> OperatorTable_0x1cfd0f0:
Operators
  0   ? @ @@
  1   **
  2   % * /
  3   + -
  4   << >>
  5   < <= > >=
  6   != ==
  7   &
  8   ^
  9   |
  10  && and
  11  or xor ||
  12  ..
  13  %= &= *= += -= /= <<= >>= ^= |=
  14  return

Assign Operators
  ::= newSlot
  :=  setSlot
  =   updateSlot

To add a new operator: OperatorTable addOperator("+", 4) and implement the + message.
To add a new assign operator: OperatorTable addAssignOperator("=", "updateSlot") and implement the updateSlot message.

Io> true xor := method(bool, if(bool,false,true))
==> method(bool,
    if(bool, false, true)
)
Io> false xor := method(bool, if(bool, true, false))
==> method(bool,
    if(bool, true, false)
)
Io> false xor false
==> false
Io> false xor true
==> true
Io> true xor false
==> true
Io> true xor true
==> false
Io>

{% endhighlight %}

A message includes three parts : the __sender__, the __target__, the __arguments__.
In Io the sender sends a message to the target. The target executes the message.
Io has special keywords for accessing and calling __sender__ , __target__, __message name__ and __message arguments__

In Io the arguments is not evaluated when passing to a function. This power (the time of evaluation) is in programmers hand.
An example of this and important facts about message reflection and state reflection can be found in the following example :

{% gist cgonul/b5c0631aeac6c97887ae %}

The flow of control in io when you send a message to an object which is the core concept in every operation in Io language.
Io do the following when you send an object to a message :

 1. Compute the arguments, inside out. These are just messages.
 2. Get the name, target and sender of the message.
 3. Try to read the slot with the name of the message on the target.
 4. If the slot exists, return the value or call the method attached to it.
 5. If the slot does not exist, try to reach the prototype and do the same operation on the prototype. 
This is called forwarding. You can override forward slot of the Object prototype but doing so changes the way all of the forwarding mechanism inside the language.

Some examples of Io's concurrency library :

{% gist cgonul/2b3f399885c4e1512f8a %} 

In Io dealing a DSL is fairly easy. The following is an investigation of creating a DSL language for JSON and printing a JSON tree.

{% gist cgonul/c32ab48f6a01d70b9646 %} 





