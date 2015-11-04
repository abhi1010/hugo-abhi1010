+++
date = "2012-09-11 10:03:00+00:00"
title = "Counting Sort"
type = "post"
tags = ["sorting", "algo", "c++"]
categories = ["code"]
series = ["Algorithm"]
description = "Count Sort Implementation"
keywords = ["count sort", "algorithm"]
+++

Counting Sort is an integer sorting algorithm. It is not very famous when somebody talks about sorting algorithms but it is great when sorting integers. In fact, many a times it may even beat other Sorting Algorithms. The highlight of Counting Sort is that it creates a bucket array (to keep track of frequency of numbers) whose size is the maximum element in the provided array.

We are looking to compare most of the sorting algorithms to find out which one performs better under different circumstances. One of the ways is to compare the complexity for each algorithm. The other way is to compare how well they perform based on the input they are all provided. I will post my code on Github but will start with Counting Sort here.

_Here are some pointers about Counting Sort:_



	
  * Linear sorting algo with O(n+k) when the elements range from 1 to k

	
    * On




	
  * It is really good when the numbers range from 1 to n which means the max between them is not going to be very high






**_How do we compare all Sorting Algorithms?_**

We are going to look at the following scenarios across all Sorting Algorithms:



	
  * 10 numbers - Random + Sorted

	
  * 1000 numbers (1K) - Random + Sorted

	
  * 1,000,000 numbers (1M) - Random + Sorted

	
  * 20000 iterations for each one of these scenarios

	
  * For good measure we will look at the average time required to sort 100 numbers in each one of these cases

	
    * This will allow us to compare all algorithms against each other by looking at the average times

	
    * It means we will be multiplying the results of 10 numbers by 10 (to get the "average" for 100 numbers) and also





<!-- more -->

**Machine Setup**

The setup of my machine is as follows:

| Hardware: x86_64
| Processor: 16 x Intel(R) Xeon(R) E5540 2.53 GHz
| Compiler: gcc version 4.8.2 (GCC)
| Redhat Version: Red Hat 5.3

**The Source Code**

I am trying to do this all together in a single place so that it is easy for anybody to pick up the code, either for their own testing or going through the Sorting Algos. All of the source code for this can be found here:

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)

**Numbers**

Without further ado, let's delve into the numbers for Counting Sorts. Here's the result from the code:
<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >
</td>

<td style="width:25%;" >**# of Items in Array**
</td>

<td style="width:25%;" >**Time Taken**
</td>

<td style="width:25%;" >**Average for 100 numbers**
</td>
</tr>
<tr >

<td rowspan="3" >**Random**
</td>

<td >10
</td>

<td >0.022982
</td>

<td >0.22982
</td>
</tr>
<tr style="background-color:#efefef;color:#008000;" >

<td >1K
</td>

<td >1.21822
</td>

<td >0.121822
</td>
</tr>
<tr >

<td >1M
</td>

<td >1823.85
</td>

<td >0.182385
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.026815
</td>

<td >0.26815
</td>
</tr>
<tr style="background-color:#efefef;color:#008000;" >

<td >1K
</td>

<td >1.19146
</td>

<td >0.119146
</td>
</tr>
<tr >

<td >1M
</td>

<td >1612.58
</td>

<td >0.161258
</td>
</tr>
</tbody>
</table>




