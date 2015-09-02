+++
date = "2012-09-17 16:00:00+00:00"
title = "Insertion Sort"
type = "post"
tags = ["sorting", "algo", "c++"]
categories = ["code"]
series = ["Algorithm"]
+++

Insertion Sort has the following properties:



	
  * It works by moving elements one at a time

	
  * Works really well for small data sets

	
  * Consider going with this when the input data may already be sorted or partially sorted

	
  * 

	
    * The may not have to move the elements around, thereby saving precious cycles




	
  * Stable sort

	
  * 

	
    * Keeps the original order of elements with equal values





<!-- more -->


## Testing Notes





	
  * Had a very interesting time testing my code. I knew that swapping takes time. std::swap takes particularly longer. I disabled that from the beginning itself

	
  * Even more interesting was how I thought of fixing my code which was running slowly

	
  * Initially even running an array of size 1K was taking about 4s so I just made a minor change to remove "-- insertIndex ;" altogether and do the calculation in the previous line itself. That did the trick. Otherwise the code was taking hours and hours for 1M array size so I had to stop running it.

	
  * I even tried improving the code a bit futher by ensuring that I do not call insertIndex-1 many a times but that didn't really help - in fact made it worse again

	
  * Sorted runs will run much faster because there's no work to be done in those cases

	
  * 

	
    * Would be a nice algo to use if your data is mostly sorted







## Code


As usual the [code](https://github.com/abhi1010/Algorithms/blob/master/Algo_codes/InsertionSort.cpp) is available here:

[https://github.com/abhi1010/Algorithms](https://github.com/abhi1010/Algorithms)


## Numbers


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
