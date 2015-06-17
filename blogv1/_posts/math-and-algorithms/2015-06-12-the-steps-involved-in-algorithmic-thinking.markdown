---
layout: post
title:  "The Steps Involved in Algorithmic Thinking"
date:   2015-06-12 13:54:00
categories: math-and-algorithms
---

There is a quote that needs to be shared. 

> “A person well-trained in computer science knows how to deal with algorithms : how
to construct them, manipulate them, understand them, analyse them. This
knowledge is preparation for much more than writing good computer programs: it 
is a general-purpose mental tool that will be a definite aid to the understanding of
other subjects, whether they be chemistry, linguistics, or music, etc. The reason
for this may be understood in the following way: It has often been said that a
person does not really understand something until after teaching it to someone 
else. 
Actually, a person does not really understand something until after 
teaching it to a computer, i.e., expressing it as an algorithm...
An attempt to formalize things as algorithms leads to a much deeper understanding than if we simply 
try to comprehend things in the traditional way.”
—Donald Knuth

We need to look to the concept of algorithmic thinking in a more broad way which consists of our everyday problems.
There are four steps in algorithmic thinking:

 1. Understanding the problem which involves activities like : 
    * Understanding the description of the problem, 
	* Determining the inputs and outputs, 
	* Doing a few examples by hand, 
	* Thinking about the special cases,
	
 2. Formulating it which involves activities like : 
	* Finding the best way to represent the input and output using data structures like graphs, strings, stacks, queues, dictionaries,
	* Determining what mathematical criterion corresponds to the desired output.
	* Writing appropriate amount of test cases for the correctness and the time efficiency of the algorithm.
 3. Designing an algorithm which involves activities like :
    * Finding whether the problem fits to a specific algorithm type like : greedy, divide and conquer, recursive etc.
	* Finding the best fit for the data structures which will be used in the algorithm.
	* Executing the test cases which has been written at step two and determining is the algorithm correct and efficient.
	* Making a decision if the problem is too hard, do we want an approximation algorithm like a randomized algorithm or a heuristic.<https://en.wikipedia.org/wiki/Heuristic_%28computer_science%29>
	* Even if you have written hundreds of thousands of test cases, you can not %100 sure about the correctness of the algorithm. 
The proof of a total correctness involves mathematical activities which is not always necessary in real life however to prove that it is not correct you just need one sample.
    * For the efficiency test of your algorithm, in most cases you need to define a growth function which represents the number of operations it takes for a specific input size.
	* It is very hard to determine the model of the exact running time of the algorithm for a specific input which involves advanced benchmarking knowledge for a specific architecture and environment and not commonly 
necessary in real life.
 4. Implementing the algorithm in a programming language :
	* Something to consider is that implementing an algorithm in some programming languages can be more natural than implementing in others.
	* Simply if you can implement it one language, theoretically you can implement it in other languge <http://simple.wikipedia.org/wiki/Church-Turing_thesis>
	* Implementing also involves running your test cases.
 5. After implementing the algorithm you can use it to solve the original problem.
