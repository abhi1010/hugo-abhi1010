+++
date = "2012-09-13 10:37:00+00:00"
title = "Radix Sort"
type = "post"
tags = ["sorting", "algo", "c++"]
categories = ["code"]
series = ["Algorithm"]
+++

It is a non-comparative _integer_ sorting algorithm. It sorts data by grouping keys by the individual digits which share the same significant position and value. Think _Tens, Hundreds, Thousands_ etc. Some pointers about Radix Sort:

  * Even though it is an integer sorting algorithm, it is not restricted just to integers. Integers can also represent strings of characters
  * Two types of radix sort are: 
    * LSD (Least Significant Digit): Short keys come before long keys
    * MSD (Most Significant Digit) Sorting: Lexicographic Order. Better for strings.
  * Uses Counting Sort as Sub Routine (which takes extra memory) 
    * If memory is not really a concern, forget about this issue
  * Radix Sort, with at most d digits, takes O(d*(n+b)) time where b is the base
  * Use Radix Sort over Counting Sort when the numbers range from 1 to n-square for example.
  

**Numbers**

Let's look at the stats from the algorithm:

<table style="border-bottom:lightblue solid;text-align:center;border-left:lightblue solid;background-color:#efefef;width:100%;border-collapse:collapse;border-top:lightblue solid;border-right:lightblue solid;" border="1" > <tbody > <tr >
<td style="width:25%;" >
</td>
<td style="width:25%;" >**# of Items in Array**
</td>
<td style="width:25%;" >**Time Taken**
</td>
<td style="width:25%;" >**Average for 100 numbers**
</td> </tr> <tr >
<td rowspan="3" >**Random**
</td>
<td >10
</td>
<td >0.033351
</td>
<td >0.33351
</td> </tr> <tr style="background-color:#efefef;color:#008000;" >
<td >1K
</td>
<td >3.22004
</td>
<td >0.322004
</td> </tr> <tr >
<td >1M
</td>
<td >5650.9
</td>
<td >0.56509
</td> </tr> <tr >
<td rowspan="3" >**Sorted**
</td>
<td >10
</td>
<td >0.020659
</td>
<td >0.20659
</td> </tr> <tr >
<td >1K
</td>
<td >3.26273
</td>
<td >0.326273
</td> </tr> <tr >
<td >1M
</td>
<td >5683.91
</td>
<td >0.568391
</td> </tr> </tbody> </table>

**Code**

As always, the code is available at [https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms) for easier access.
