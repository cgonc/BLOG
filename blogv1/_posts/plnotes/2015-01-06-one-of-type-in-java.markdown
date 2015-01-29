---
layout: post
title:  "005. Implementing One-of-type in Java"
date:   2015-01-06 16:40:05
categories: Programming-Languages
---
<p align="justify">
In object oriented programming one of types can be implemented using subclassing.
Consider this very simple scala function.
</p>
{% highlight  scala%}
def max(xs: List[Int]): Option[Int] = {
  def helper(ys: List[Int], acc: Int): Int = {
    if (ys.isEmpty) acc
    else if (ys.head > acc) helper(ys.tail, ys.head)
    else helper(ys.tail, acc)
  }
  if (xs.isEmpty) None
  else Some(helper(xs, xs.head))
}
{% endhighlight %}

<p align="justify">
We can port this simple scala function into Java.
<br>
<br>
We need an Option class. We can define None and Some as the subclass of this
Option class so we can pass any of the two types whenever we want. 
I think it is one of the examples of polymorphism. We can pass one of the two 
sub-type to a super type.
</p>

{% highlight  java%}
/**
 * A very simple solution for implementing one-of-types in Java
 * A more detailed solution can be found at scala package
 *
 * @param <T>
 */
public abstract class Option<T> {
	
	/**
	 * @return true if the option is $none, false otherwise.
	 */
	public abstract Boolean isEmpty();
	
	/**
	 * @return true if the option is an instance of $some, false otherwise.
	 */
	public Boolean isDefined(){
		return !isEmpty();
	}
	
	/**
	 * @return the option's value.
	 */
	public abstract T get();
	
}
{% endhighlight %}

{% highlight  java%}
public class None<T> extends Option<T>{

	@Override
	public Boolean isEmpty() {
		return true;
	}

	@Override
	public T get() {
		throw new IllegalStateException("No such arguments");

	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("None");
		return builder.toString();
	}
}
{% endhighlight %}

{% highlight  java%}
public class Some <T> extends Option<T> {

	T x;
	
	public Some(T x) {
		this.x = x;
	}
	
	@Override
	public Boolean isEmpty() {
		return false;
	}

	@Override
	public T get() {
		return x;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Some [x=");
		builder.append(x);
		builder.append("]");
		return builder.toString();
	}

}
{% endhighlight %}

{% highlight  java%}
import java.util.ArrayList;
import java.util.List;

public class TestOption {

	public static Option<Integer> max(List<Integer> list){
		if (list.isEmpty()) {
			return new None<>();
		} else{
			Some<Integer> result = new Some<Integer>(helper(list,list.get(0)));
			return result;
		}
	}
	
	public static Integer helper(List<Integer> list,Integer acc){
		if(list.size()==0) {
			return acc;
		} else if (list.get(0) > acc){
			return helper (list.subList(1, list.size()) , list.get(0));
		} else {
			return helper (list.subList(1, list.size()) , acc);
		}
	}
	
	public static void main(String[] args) {
		List<Integer> someList = new ArrayList<Integer>();
		someList.add(10);
		someList.add(20);
		someList.add(30);
		someList.add(40);
		someList.add(50);
		
		List<Integer> anotherList = new ArrayList<Integer>();
		
		System.out.println("Maximum of a non-empty list is : " + max(someList));
		System.out.println("Maximum of an empty list is : " + max(anotherList));

	}
}
{% endhighlight %}

{% highlight  java%}
Maximum of a non-empty list is : Some [x=50]
Maximum of an empty list is : None

{% endhighlight %}


As it can be seen from TestOption class the return type of the max function can be
either ***None*** or ***Some Int***.




