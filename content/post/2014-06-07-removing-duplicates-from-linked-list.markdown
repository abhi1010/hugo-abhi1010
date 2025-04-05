+++
date = "2014-06-07 16:50:12+00:00"
title = "Removing Duplicates from Linked List"
type = "post"
tags = ["c++", "algo", "linked list"]
categories = ["code"]
description = "How to remove duplicate entries from a linked list"
keywords = ["duplicates", "linked list"]
+++

Duplicates can be removed in many ways:




  * Create a new Linked List containing only unique items


  * Iterate through the Linked List and keep removing items that are being repeated


The internal structure itself for the algo can either be map or set based. When using map the Node itself can be saved thereby making your life easier if you are creating a new Linked List. However sets can be very useful if we are just iterating through the Linked List and simply deleting items that are being repetetive. This is also a great spacesaver. Hence we decided to go down this path.


# Code


As usual the [code](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/Node.cpp) is available here:

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)

Here's a small sample as to how to do it:

{{< gist abhi1010 e2b7117c20d0f591896f >}}


