+++
date = "2012-10-06 14:26:00+00:00"
title = "Merge Sort"
type = "post"
tags = ["sorting", "algo", "c++"]
categories = ["code"]
series = ["Algorithm"]
description = "Merge Sort Implementation"
keywords = ["merge sort", "algorithm"]
+++

Merge Sort

  * Complexity is O(n log n)
  * Needs more space to merge - proportional to the size of the array
  * Stable Sort
  *     * Preserves the order of equal elements
  * Merge Sort does about 39% lower comparisons, in worst case, compared to Quicksort's average case
  * The algo almost always behaves in the same way; taking relatively the same amount of time, whether sorted or unsorted arrays
<!-- more -->

## Testing Notes

  * Started testing the algo with two versions.
  *     * First version creates two temporary arrays
    * First version creates only one temporary array
  * The sole difference between them is the one that makes second implementation better

## Code

As usual the [code](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/MergeSort.cpp) is available here:

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)

## Numbers

<table style="border-bottom:lightblue solid;text-align:center;border-left:lightblue solid;background-color:#efefef;width:100%;border-collapse:collapse;border-top:lightblue solid;border-right:lightblue solid;" border="1" > <tbody > <tr >
<td style="width:25%;" >

### Merge Sort

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
<td >0.047464
</td>
<td >0.47464
</td> </tr> <tr >
<td >1K
</td>
<td >5.41906
</td>
<td >0.541906
</td> </tr> <tr >
<td >1M
</td>
<td >8444.11
</td>
<td >0.844411
</td> </tr> <tr >
<td rowspan="3" >**Sorted**
</td>
<td >10
</td>
<td >0.027155
</td>
<td >0.27155
</td> </tr> <tr >
<td >1K
</td>
<td >4.47016
</td>
<td >0.447016
</td> </tr> <tr >
<td >1M
</td>
<td >6323.05
</td>
<td >0.632305
</td> </tr> </tbody> </table>

  


<table style="border-bottom:lightblue solid;text-align:center;border-left:lightblue solid;background-color:#efefef;width:100%;border-collapse:collapse;border-top:lightblue solid;border-right:lightblue solid;" border="1" > <tbody > <tr >
<td style="width:25%;" >

### Merge Sort 2

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
<td >0.033668
</td>
<td >0.33668
</td> </tr> <tr >
<td >1K
</td>
<td >3.89374
</td>
<td >0.389374
</td> </tr> <tr >
<td >1M
</td>
<td >7076.04
</td>
<td >0.707604
</td> </tr> <tr >
<td rowspan="3" >**Sorted**
</td>
<td >10
</td>
<td >0.019034
</td>
<td >0.19034
</td> </tr> <tr >
<td >1K
</td>
<td >2.7833
</td>
<td >0.27833
</td> </tr> <tr >
<td >1M
</td>
<td >4664.16
</td>
<td >0.466416
</td> </tr> </tbody> </table>
