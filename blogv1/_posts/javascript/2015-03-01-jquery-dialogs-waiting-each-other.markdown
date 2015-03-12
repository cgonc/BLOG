---
layout: post
title:  "Jquery Dialogs Waiting Each Other"
date:   2015-03-01 00:16:05
categories: Javascript
---

Sometimes when the web page loads, you need to show some messages to the user. The number of the
messages and the sequence of the messages may change according to a login state. 
For example sometimes the user account expires or an important action must be taken like the user
should validate his/her email. 

Jquery dialogs can be used to show these states to the user. The basic idea is to show the next 
dialog to the user when the previous dialog closes. So you can put the next dialog opener to the
close event of the previous dialog. However lets do it better.

 * dialog_sequencer function takes an array. If the array is empty, it will do nothing. Else it takes
   the head of the array and mutates the array into its tail. Extracts the name of the dialog and the options of the dialog 
   from the head. The basic idea is injecting a close attribute which calls the dialog_sequencer with the rest of the 
   dialog_sequence. So the next dialog is ready to be called with the appropriate close event which
   calls dialog_sequencer with the rest of the dialog_sequence and so on until there is not any dialogs.
 * When the user logs in, the dialog_sequence variable can be changed according to the login state. Some dialogs may be
   added, some of them may be extracted. And the behaviour can be achieved by calling the dialog_sequencer function 
   with this data.

{% gist cgonul/5b247fb7f34da6d92842 %} 

The live example can be found here :

<http://jsfiddle.net/cgonul/6ren0py0/2/>

<iframe width="100%" height="300" src="//jsfiddle.net/cgonul/6ren0py0/2/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>
