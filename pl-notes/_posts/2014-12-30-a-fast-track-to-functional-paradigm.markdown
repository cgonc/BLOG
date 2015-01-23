---
layout: post
title:  "003. Fast Track to Functional Paradigm"
date:   2014-12-30 18:56:32
categories: Programming Languages
---
<p align="justify">
This post includes some simple functions which is written in Scala language.
</p>

{% highlight Scala %}
def pow(x: Int, y: Int): BigInt = {
  def helper(y: Int, acc: BigInt): BigInt = {
    if (y == 0) acc
    else helper(y - 1, x * acc)
  }
  helper(y, 1)
}

def sum_list(xs: List[Int]): Int = {
  def helper(ys: List[Int], acc: Int): Int = {
    if (ys.isEmpty) acc
    else helper(ys.tail, ys.head + acc)
  }
  helper(xs, 0)
}

def append[T](xs: List[T], ys: List[T]): List[T] = {
  def helper(is: List[T], acc: List[T]): List[T] = {
    if (is.isEmpty) acc ::: ys
    else helper(is.tail, acc :+ is.head)
  }
  helper(xs, List())
}

def count_down(x: Int): List[Int] = {
  def helper(y: Int, acc: List[Int]): List[Int] = {
    if (y == 0) acc
    else helper(y - 1, acc :+ y)
  }
  helper(x, List())
}

def count_up(x: Int): List[Int] = {
  def helper(from: Int, acc: List[Int]): List[Int] = {
    if (from == x) acc
    else helper(from + 1, acc :+ from)
  }
  helper(1, List())
}

def max(xs: List[Int]): Option[Int] = {
  def helper(ys: List[Int], acc: Int): Int = {
    if (ys.isEmpty) acc
    else if (ys.head > acc) helper(ys.tail, ys.head)
    else helper(ys.tail, acc)
  }
  if (xs.isEmpty) None
  else Some(helper(xs, xs.head))
}

def factiorialTailRecursion(n: Int): BigInt = {
  def helper(x: Int, acc: BigInt): BigInt =
    if (x == 0) acc
    else helper(x - 1, x * acc)
  helper(n, 1)
}

pow(3, 30)                                                     //|res0: BigInt = 205891132094649
sum_list(List(1, 2, 3, 4, 5, 6))                               //|res1: Int = 21
append(List(1, 2, 3, 4), List(5, 6, 7, 8))                     //|res2: List[Int] = List(1, 2, 3, 4, 5, 6, 7, 8)
append(List("a", "b", "c", "d"), List("e", "f", "g"))          //|res3: List[String] = List(a, b, c, d, e, f, g)
count_down(5)                                                  //|res4: List[Int] = List(5, 4, 3, 2, 1)
count_up(5)                                                    //|res5: List[Int] = List(1, 2, 3, 4)
max(List())                                                    //|res6: Option[Int] = None
max(List(1, 2, 3, 4, 5, 6))                                    //|res7: Option[Int] = Some(6)   
{% endhighlight %}
