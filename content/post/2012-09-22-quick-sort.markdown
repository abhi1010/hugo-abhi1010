+++
date = "2012-09-22 14:24:00+00:00"
title = "Quick Sort"
type = "post"
tags = ["sorting", "algo", "c++"]
categories = ["code"]
series = ["Algorithm"]
+++

Quick Sort is an efficient divide and conquer algorithm performed in two phases - partition and sorting phase.

Here are few pointers to remember about Quick Sort:

  * Partitioning places all the elements less than the pivot in the left part of the array and greater elements in the right part
  * Pivot element stays in its place
  * After partitioning no element moves to the other side, of the pivot
  *     * This allows you to sort the elements, to the left or right of the pivot, independent of the other side
  * Complexity is O(n log n)
  * Often fast for small arrays with a few distinct values, repeated many times
  * It is a conquer-and-divide algo; with most of the work happening during partitioning phase
  * If you had to choose the optimum pivot then it should the median of the given array
  * Not a stable sort
<!-- more -->

## Testing Notes

  * Currently we have only one version of the code. We may try to do another version that is not recursive because putting the functions on stack will take up some memory and time
  * Another version could be trying to use the pivot from the middle and then compare how do the random numbers compare against the sorted numbers

## Code

As usual the [code](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/QuickSort.cpp) is available here:

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)

## Numbers

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
<td >0.072972
</td>
<td >0.72972
</td> </tr> <tr >
<td >1K
</td>
<td >2.74698
</td>
<td >0.274698
</td> </tr> <tr >
<td >1M
</td>
<td >4640.77
</td>
<td >0.464077
</td> </tr> <tr >
<td rowspan="3" >**Sorted**
</td>
<td >10
</td>
<td >0.042773
</td>
<td >0.42773
</td> </tr> <tr >
<td >1K
</td>
<td >1.84335
</td>
<td >0.184335
</td> </tr> <tr >
<td >1M
</td>
<td >2473.42
</td>
<td >0.247342
</td> </tr> </tbody> </table>
