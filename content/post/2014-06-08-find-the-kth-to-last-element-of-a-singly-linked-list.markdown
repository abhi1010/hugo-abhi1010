---
author: abhipandey1010
comments: true
date: 2014-06-08 07:49:47+00:00
layout: post
slug: find-the-kth-to-last-element-of-a-singly-linked-list
title: Find the Kth to Last Element of a Singly Linked List
wordpress_id: 253
categories:
- Linux
tags:
- Algo
- C++
- Linked List
---

+++
date = "2014-06-08 07:49:47+00:00"
title = "Find the Kth to Last Element of a Singly Linked List"
type = "post"
tags = ["c++", "algo", "linked list"]
categories = ["code"]
+++

It is possible to a recursive solutions but I will use a simple runner logic. Recursive solutions are usually less optimal.

Note here that, in our logic K=1 would return the last element in the linked list. Similarly, K=2 would return the second last element.

The suggested solution here is to use two pointers:

  * One pointer will first travel K items into the list
  * Once that is done, both the pointers start travelling together, one item at a time
  * They keep travelling until the end of linked list is found
  * In that situation, the first pointer is at the end of the list, but the second pointer would have only reached till Kth element - this is what you want

Let's have a look at the code:

{{< highlight c >}}    
Node* findKthToLastElement (Node* node, unsigned short k)
{
    Node* secondRunner = node;
    for(unsigned short i = 0; i < k; ++i)
    {
        if (secondRunner->next != NULL)
            secondRunner = secondRunner->next;
        else
            return NULL;
    }
    while (secondRunner)
    {
        secondRunner = secondRunner->next;
        node = node->next;
    }
    return node;
}
{{< /highlight >}}

https://gist.github.com/abhi1010/43e289a9877fb9293680




As usual the code is available [here](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/Node.cpp):

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)
