---
layout: post
title:  "Ruby Fun Problems"
date:   2015-09-19 18:03:05
categories: Ruby
---

# Question 1 #

> Find out how to access files with and without code blocks. What is the benefit of the code blocks?

__Answer__

{% highlight  ruby%}
#With code blocks
File::open('yozloy.txt','w') do |f|
  f << 'Some contains'
end

#Without code blocks
newFile = File::open('yozloy.txt','w')
newFile << 'Some contains'

{% endhighlight %}

The difference is when we use code blocks the language implementation automatically closes the file handle. 
Other wise closing the file handle is the programmer's responsibility.

{% highlight  ruby%}
def open(fname)
  self.do_open(fname)
  if block_given?
    yield(self) # This will 'run' the block with given parameter
    self.close
  else
    return self # This will just return some value
  end
end
{% endhighlight %}

# Question 2 #
> How would you translate a hash to an array ?

__Answer__

By using __to_a__ method

# Question 3 #
> Can you iteate throug hash ?

__Answer__

Yes by using __each_pair__ iterating through hash is possible.

# Question 3 #
> You can use use Ruby arrays as stacks. What other common data structures do arrays support ?

__Answer__

Queues, sets, trees.

# Question 4 #
> Prints the content of an array of sixteen numbers , four numbers at a time, using just each. Now do the same with each_slice in Enumarable.

# Question 5 #
> Implements the Tree class using hashes.

# Question 6 #
> Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. You will need to do a simple regular expression
match and read lines from a file. Include line numbers.

# Question 7 #
> Modify the csv application to support an each method to return a CsvRow object. Use method_missing on that CsvRow to return a value for the column for a giving heading.

For example for the file :

{% highlight  ruby%}
#csv
one, two
lions, tigers

#your call,
csv = RubyCsv.new
csv.each {|row| puts row.one} # should print lions
{% endhighlight %}



