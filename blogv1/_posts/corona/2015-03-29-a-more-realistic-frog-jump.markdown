---
layout: post
title:  "A More Realistic Frog Jump"
date:   2015-03-29 14:42:05
categories: Corona
---

The original example and all the assets can be found from the wonderful Udemy course by J.A. Whye. 
Here is the link : <https://www.udemy.com/beginning-mobile-game-development>
I just took one of the examples of the course and try to a make a more realistic jump.

In the original animation example the frog is being transitioned to another location. My example also 
make the same transition except that the frog has a perspective. It reaches to the half way with a stretching factor
and with a growth factor as if it closes to the observer. It makes the other half to its original state. The lily pads
effect from the action of the frog. They first sink and then go up. Here is the gist :

{% gist cgonul/98467035f6e8da48d18d %}

Here is the result.
 
<iframe width="560" height="315" src="https://www.youtube.com/embed/f80dyeZlZGs" frameborder="0" allowfullscreen></iframe>
