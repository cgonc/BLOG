---
layout: post
title:  "What To Do When Your Java Application Is Using a Large Percentage of CPU ?"
date:   2015-05-31 12:42:00
categories: jvm
---

High CPU utilization can be a sign of a bad thing or it can be caused by simply a CPU intensive operation.
Whether it is a bad thing or a normal thing, the first step in resolving the problem is to identify the cause.

This posts includes the notes about the first steps that a middle-ware person should take when a high CPU utilization 
takes place in a JVM application with an assumption that the JVM is running inside a Linux environment.

When the CPU strikes happens, basically one needs two kind of information to identify the cause: 

 1. Which thread in the JVM process consumes much of the CPU.
 2. What is the last thing that these threads do.

So in order to find the cause, first collect thread-level CPU usage.

For the collection of thread-level CPU usage you can run the following script. The script will run for 5 times
and in each iteration it sleeps for 10 seconds after collecting thread-level CPU dump.
{% gist cgonul/e8c9896523608b874982 %}

Second **at the same time** we need the stack traces of these threads so we can identify what are the last things that these threads are doing 
when the CPU strike happens. In order to capture this information we need a thread dump. We can use the following script in order to do
that. 

The script is using jstack in order to capture the thread dumps.
{% gist cgonul/19c45c9b651662559a20 %}

The script also includes a code for thread level CPU dumps. So one can run just the second script to capture both thread level CPU information and thread dumps.
One can also run the first script at the same time. By doing this he/she will have more thread level CPU information which may be a good thing to capture the right time of
the problematic case.

After collecting these two things in one hand you will have thread ids which consumes lots of CPU resource like this :

{% highlight java%}
Thu May 28 16:36:19 EEST 2015
top - 16:36:19 up 29 days,  5:21, 11 users,  load average: 3.89, 3.21, 3.21
Tasks: 686 total,   7 running, 679 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.2%us,  0.1%sy,  0.0%ni, 99.6%id,  0.1%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:  98993460k total,  5267348k used, 93726112k free,   214136k buffers
Swap: 16779884k total,        0k used, 16779884k free,   470416k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                                
 6681 jboss     19   0 4940m 3.5g  21m R 99.8  3.7   0:48.10 java                                                                                                                   
 6677 jboss     18   0 4940m 3.5g  21m R 96.0  3.7   0:47.79 java                                                                                                                   
 6679 jboss     18   0 4940m 3.5g  21m R 96.0  3.7   0:47.75 java                                                                                                                   
 6676 jboss     17   0 4940m 3.5g  21m R 94.0  3.7   0:47.96 java                                                                                                                   
 6678 jboss     18   0 4940m 3.5g  21m R 94.0  3.7   0:48.11 java                                                                                                                   
 6675 jboss     17   0 4940m 3.5g  21m S 92.1  3.7   0:47.84 java                                                                                                                   
 6680 jboss     17   0 4940m 3.5g  21m R 92.1  3.7   0:47.82 java                                                                                                                   
 6682 jboss     17   0 4940m 3.5g  21m R 92.1  3.7   0:47.79 java  
 
 Thu May 28 16:37:14 EEST 2015
top - 16:37:14 up 29 days,  5:22, 11 users,  load average: 8.14, 4.27, 3.56
Tasks: 686 total,   8 running, 678 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.2%us,  0.1%sy,  0.0%ni, 99.6%id,  0.1%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:  98993460k total,  5435456k used, 93558004k free,   214208k buffers
Swap: 16779884k total,        0k used, 16779884k free,   503152k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                                
 6680 jboss     16   0 4940m 3.5g  21m R 100.9  3.7   1:25.43 java                                                                                                                  
 6675 jboss     16   0 4940m 3.5g  21m R 99.0  3.7   1:25.46 java                                                                                                                   
 6678 jboss     16   0 4940m 3.5g  21m R 99.0  3.7   1:25.43 java                                                                                                                   
 6679 jboss     16   0 4940m 3.5g  21m R 99.0  3.7   1:25.23 java                                                                                                                   
 6682 jboss     16   0 4940m 3.5g  21m R 99.0  3.7   1:25.40 java                                                                                                                   
 6677 jboss     16   0 4940m 3.5g  21m R 95.2  3.7   1:25.01 java                                                                                                                   
 6676 jboss     16   0 4940m 3.5g  21m R 93.3  3.7   1:25.43 java                                                                                                                   
 6681 jboss     16   0 4940m 3.5g  21m R 89.4  3.7   1:25.52 java   
{% endhighlight %}

With a tool like TDA you can open the thread dump and see what these threads do.
In the above example one of the problematic thread with a pid of 6680 is doing garbage collection.
![Analyzing a thread dump](/assets/jvm/analyze_thread_dump_tda.png)