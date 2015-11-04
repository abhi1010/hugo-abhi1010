+++
date = "2014-06-08 07:49:47+00:00"
title = "Find the Kth to Last Element of a Singly Linked List"
type = "post"
tags = ["c++", "algo", "linked list"]
categories = ["code"]
description = "How to find the Kth to Last Element of a Singly Linked List"
keywords = ["Singly Linked List", "Linked List", "kth element"]
+++

It is possible to a recursive solutions but I will use a simple runner logic. Recursive solutions are usually less optimal.

Note here that, in our logic K=1 would return the last element in the linked list. Similarly, K=2 would return the second last element.

The suggested solution here is to use two pointers:

  * One pointer will first travel K items into the list
  * Once that is done, both the pointers start travelling together, one item at a time
  * They keep travelling until the end of linked list is found
  * In that situation, the first pointer is at the end of the list, but the second pointer would have only reached till Kth element - this is what you want

Let's have a look at the code:

{{< gist 43e289a9877fb9293680 >}}


As usual the code is available [here](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/Node.cpp):

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)
