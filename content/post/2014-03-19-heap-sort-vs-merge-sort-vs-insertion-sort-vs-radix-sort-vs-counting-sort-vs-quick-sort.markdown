+++
date = "2014-03-19 05:42:00+00:00"
title = "Heap Sort vs Merge Sort vs Insertion Sort vs Radix Sort vs Counting Sort vs Quick Sort"
type = "post"
tags = ["sorting", "algo", "c++"]
categories = ["code"]
series = ["Algorithm"]
+++


I had written about sorting algorithms (Tag: [Sorting](http://codersdigest.wordpress.com/tag/sorting/)) with details about what to look out for along with their code snippets but I wanted a do a quick comparison of all the algos together to see how do they perform when the same set of input is provided to them. Hence I started working on a simple implementation for each one of them. I have now put together all of them in a single project on GitHub. I ensured that they all have the same set of procedures during their run. Some of the items I wanted to ensure was:



	
  * Same input array

	
  * Same number of iterations. Each iteration having the same input

	
  * Each algo being timed the exact same way as another


Some of the algorithms being tested were:

	
  * [Heap Sort](http://codersdigest.wordpress.com/2012/10/06/merge-sort/)

	
  * [Merge Sort](http://codersdigest.wordpress.com/2012/10/06/merge-sort/)

	
  * [Insertion Sort](http://codersdigest.wordpress.com/2012/09/18/insertion-sort/)

	
  * [Radix Sort](http://codersdigest.wordpress.com/2012/09/13/radix-sort/)

	
  * [Counting Sort](http://codersdigest.wordpress.com/2012/09/11/counting-sort/)

	
  * [Quick Sort](http://codersdigest.wordpress.com/2012/09/22/quick-sort/)




## How did we ensure Equality?





	
  * Created a simple base class for all algorithms: ``AlgoStopwatch``

	
  * 

	
    * Responsible for benchmarking everything

	
    * Provide a function called ``doSort()`` that would allow derived classes to implement their algorithm

	
    * Ensures that every algorithm has a name and description - to help us distinguish




	
  * Another class to help manage the testing of all the algorithms: ``AlgoDemo``

	
  * 

	
    * All instances are created here for the algorithms

	
    * The input array is provided by this class to all algorithms







## Code


As usual the code for the project is available here:

**[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)**

It can be run using Visual Studio without any changes.

<!-- more -->


## Numbers


Looking at the numbers below, it may be hard to compare the actual values. Hence I decided to `normalize` them by calculating how much time will be required to sort `100 numbers` using the same rate as the actual numbers. They are provided for all algorithms on the right-most column.
<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Merge Sort](http://codersdigest.wordpress.com/2012/10/06/merge-sort/)



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

<td >0.047464
</td>

<td >0.47464
</td>
</tr>
<tr >

<td >1K
</td>

<td >5.41906
</td>

<td >0.541906
</td>
</tr>
<tr >

<td >1M
</td>

<td >8444.11
</td>

<td >0.844411
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.027155
</td>

<td >0.27155
</td>
</tr>
<tr >

<td >1K
</td>

<td >4.47016
</td>

<td >0.447016
</td>
</tr>
<tr >

<td >1M
</td>

<td >6323.05
</td>

<td >0.632305
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### Merge Sort 2



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

<td >0.033668
</td>

<td >0.33668
</td>
</tr>
<tr >

<td >1K
</td>

<td >3.89374
</td>

<td >0.389374
</td>
</tr>
<tr >

<td >1M
</td>

<td >7076.04
</td>

<td >0.707604
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.019034
</td>

<td >0.19034
</td>
</tr>
<tr >

<td >1K
</td>

<td >2.7833
</td>

<td >0.27833
</td>
</tr>
<tr >

<td >1M
</td>

<td >4664.16
</td>

<td >0.466416
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Insertion Sort](http://codersdigest.wordpress.com/2012/09/18/insertion-sort/)



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

<td >0.006095
</td>

<td >0.06095
</td>
</tr>
<tr >

<td >1K
</td>

<td >0.369859
</td>

<td >0.0369859
</td>
</tr>
<tr >

<td >1M
</td>

<td >323.878
</td>

<td >0.0323878
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.005022
</td>

<td >0.05022
</td>
</tr>
<tr >

<td >1K
</td>

<td >0.11696
</td>

<td >0.011696
</td>
</tr>
<tr >

<td >1M
</td>

<td >122.427
</td>

<td >0.0122427
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Heap Sort 1](http://codersdigest.wordpress.com/2012/10/17/heap-sort/)



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

<td >0.013543
</td>

<td >0.13543
</td>
</tr>
<tr >

<td >1K
</td>

<td >3.22043
</td>

<td >0.322043
</td>
</tr>
<tr >

<td >1M
</td>

<td >4770.14
</td>

<td >0.477014
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.007507
</td>

<td >0.07507
</td>
</tr>
<tr >

<td >1K
</td>

<td >0.625425
</td>

<td >0.0625425
</td>
</tr>
<tr >

<td >1M
</td>

<td >633.142
</td>

<td >0.0633142
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Heap Sort 2](http://codersdigest.wordpress.com/2012/10/17/heap-sort/)



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

<td >0.019352
</td>

<td >0.19352
</td>
</tr>
<tr >

<td >1K
</td>

<td >3.86284
</td>

<td >0.386284
</td>
</tr>
<tr >

<td >1M
</td>

<td >8914.22
</td>

<td >0.891422
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.011289
</td>

<td >0.11289
</td>
</tr>
<tr >

<td >1K
</td>

<td >3.49712
</td>

<td >0.349712
</td>
</tr>
<tr >

<td >1M
</td>

<td >6661.45
</td>

<td >0.666145
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;margin-left:0;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Heap Sort 3](http://codersdigest.wordpress.com/2012/10/17/heap-sort/)



</td>

<td style="width:25%;" >**# of Items in Arraytrong>**
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

<td >0.016266
</td>

<td >0.16266
</td>
</tr>
<tr >

<td >1K
</td>

<td >0.968032
</td>

<td >0.0968032
</td>
</tr>
<tr >

<td >1M
</td>

<td >900.004
</td>

<td >0.0900004
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.012845
</td>

<td >0.12845
</td>
</tr>
<tr >

<td >1K
</td>

<td >3.08637
</td>

<td >0.308637
</td>
</tr>
<tr >

<td >1M
</td>

<td >3839.23
</td>

<td >0.383923
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [QuickSort](http://codersdigest.wordpress.com/2012/09/22/quick-sort/)



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

<td >0.072972
</td>

<td >0.72972
</td>
</tr>
<tr >

<td >1K
</td>

<td >2.74698
</td>

<td >0.274698
</td>
</tr>
<tr >

<td >1M
</td>

<td >4640.77
</td>

<td >0.464077
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.042773
</td>

<td >0.42773
</td>
</tr>
<tr >

<td >1K
</td>

<td >1.84335
</td>

<td >0.184335
</td>
</tr>
<tr >

<td >1M
</td>

<td >2473.42
</td>

<td >0.247342
</td>
</tr>
</tbody>
</table>

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Counting Sort](http://codersdigest.wordpress.com/2012/09/11/counting-sort/)



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

<table style="text-align:center;background-color:#efefef;width:100%;border-collapse:collapse;border:lightblue solid;" border="1" >
<tbody >
<tr >

<td style="width:25%;" >


### [Radix Sort](http://codersdigest.wordpress.com/2012/09/13/radix-sort/)



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

<td >0.033351
</td>

<td >0.33351
</td>
</tr>
<tr style="background-color:#efefef;color:#008000;" >

<td >1K
</td>

<td >3.22004
</td>

<td >0.322004
</td>
</tr>
<tr >

<td >1M
</td>

<td >5650.9
</td>

<td >0.56509
</td>
</tr>
<tr >

<td rowspan="3" >**Sorted**
</td>

<td >10
</td>

<td >0.020659
</td>

<td >0.20659
</td>
</tr>
<tr >

<td >1K
</td>

<td >3.26273
</td>

<td >0.326273
</td>
</tr>
<tr >

<td >1M
</td>

<td >5683.91
</td>

<td >0.568391
</td>
</tr>
</tbody>
</table>
