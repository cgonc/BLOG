---
layout: post
title:  "Meeting With Ruby"
date:   2015-09-19 13:47:05
categories: Ruby
---

Ruby is dynamically typed, interpreted and object oriented. All of these programming language concepts can be explained wit a funny analogy which is a clown acrobat.
A clown acrobat is good at improvising when doing his performance as types are determined at runtime. 
This acrobat clown has an instructor which tells him what to do during his performance and that is the interpreter. 
The acrobat clown has lots of children, these children can be made during the performance so that is object oriented.

Ruby is interpreted (is an acrobat clown who has an instructor), dynamically typed (acrobat clown who likes improvising) and object-oriented (acrobat clown who has lots of children)
Every piece of code returns something in ruby. Acrobat clown always says something when his instructor gives him a command.
Ruby is a pure object-oriented language. He loves his children very much more than Java.
Although Ruby loves his children, there are two children that he does not like very much. These two children are Nil and False which evaluates to false in Ruby language.
The rest evaluates to true.

In logical operations using a & instead of && means evaluating both side of the operands. The acrobat clown likes to do extra work when some command is missing.

Duck typing in ruby is natural.
{% gist cgonul/fd00f6da0a824c550665 %}
The output :
{% highlight  ruby%}
quack quack!
quack quack!
quack quack!
quack quack. I am a duck. What?
quack quack. I am a duck. What?
quack quack. I am a duck. What?
{% endhighlight %}

Ruby is strongly typed which means the acrobat clown refuses to do the commands which can harm himself. So you can not tell an integer children to multiply himself with a string children.
Ruby arrays can hold different kinds of children. This behaviour is common in dynamically typed language.

Code blocks are like defining anonymous functions. It is like throwing some command to the acrobat clown for him to do the command later.
All of the children can be extended any time including the core children like FixNum.

{% highlight  ruby%}
class Fixnum
	def my_times 
		i = self;
		while i > 0
			i = i - 1
			yield
		end
	end
end

4.my_times {puts "come get some"}

#The output:
come get some
come get some
come get some
come get some
{% endhighlight %}

A sample tree implantation :
{% gist cgonul/09a2a1f983556c260f05 %}
The output : 
{% highlight  ruby%}
Print node names
one
two
three
six
seven
eight
four
five
Calculate the tree summation
36
Calculate the summation of child nodes for each node
Print out children summations
one : 35
two : 0
three : 30
six : 15
seven : 0
eight : 0
four : 0
five : 0
{% endhighlight %}

Ruby modules is somehow similar to Java interfaces. When a class defines a module, it automatically has the abilities of the module class.
It is like levelling up for the acrobat clown when a special command text is being learned. 
{% gist cgonul/f19658aa8a05e24555a4 %}

Note that in the module definition we have __objectname__ which is not defined until the module
is being used in __Person__ class. It is also a good example for the dynamic dispatch.

As stated above the acrobat clown likes to improvise when the commands are missing. To control the improvisation all you have to do is override method_missing.

Meta programming is an important part of the ruby language. 

{% gist cgonul/073a3d12fea880b88486 %}


