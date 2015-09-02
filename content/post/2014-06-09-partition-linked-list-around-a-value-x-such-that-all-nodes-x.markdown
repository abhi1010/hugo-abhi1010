+++
date = "2014-06-09 15:02:07+00:00"
title = "Partition Linked List around a Value X"
type = "post"
tags = ["c++", "algo", "linked list"]
categories = ["code"]
+++

How do you partition a list around a value x, such that all nodes less than x come before all nodes greater than or equal to x?

Well, there are some solutions possible. The solution, I came up with, is a bit convoluted but let me tell the idea behind it. You want to track the following:



	
  * Two pointers to remember the beginning of the _lower_ and _higher_ series each

	
  * One pointer (_current_) to iterate through the Linked List

	
  * The list may itself start with higher or lower value compared to the _middleValue_. Thus we need to remember the beginning of the lower series (_lowerSeries_) as this is what we will send back


Now that we have this out of the way, let's look at the code:

<!-- more -->

{{< gist 3ada1d15b5bda319a54c >}}



### Code


As usual the code is available [here](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/Node.cpp):

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)
