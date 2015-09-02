+++
date = "2013-10-13 05:59:22+00:00"
title = "Ideas for Shared Memory in Linux"
type = "post"
tags = ["c#"]
categories = ["code"]
+++

I have been doing extensive research today regarding shared memory in linux before I embark on a new project in which shaving time off process communication latency is extremely important. I found some very interesting links as well. Let’s break them down:


<table style="border:thin solid lightblue;" >
<tbody >
<tr >

<td width="133" >**Topic**
</td>

<td width="354" >**Description**
</td>

<td width="151" >**Link**
</td>
</tr>
<tr >

<td width="133" >Theory/Explanation
</td>

<td width="354" >Some articles that explain how to get started
</td>

<td width="151" >[open-std](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2006/n2044.html)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >IPC Mechanisms – some recommendations. Mainly talks about softwares like Boost, dBus

dBus used to work using kernel levels but lately have come up with a patch that bypasses kernels
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/1906166/inter-process-communication-recommendation)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >What every programmer should know about memory
</td>

<td width="151" >[LWN](http://lwn.net/Articles/255364/)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Linux IPC
</td>

<td width="151" >[TLDP](http://www.tldp.org/LDP/tlk/ipc/ipc.html)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Cache Friendly Code
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/16699247/what-is-cache-friendly-code/16699282#16699282)
</td>
</tr>
<tr >

<td width="133" >Helpful Articles
</td>

<td width="354" >Which linux IPC technique to use?
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/2281204/which-linux-ipc-technique-to-use)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Inter process communication – talks about shared memory
</td>

<td width="151" >[ALP](http://www.advancedlinuxprogramming.com/alp-folder/alp-ch05-ipc.pdf)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Linux Poll Events on Shared Memory
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/11470322/cause-a-linux-poll-event-on-a-shared-memory-file)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Using semaphores in Shared Memory
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/10772860/semaphores-and-shared-memory-in-linux)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Sharing semaphores between Shared Memory
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/8359322/how-to-share-semaphores-between-processes-using-shared-memory?rq=1)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Sharing memory between processes
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/11583281/sharing-memory-between-two-processes)
</td>
</tr>
<tr >

<td width="133" >
</td>

<td width="354" >Reserving memory at kernel boot up (DMA)
</td>

<td width="151" >[Stackoverflow](http://stackoverflow.com/questions/647783/direct-memory-access-in-linux?rq=1)
</td>
</tr>
<tr >

<td width="133" >Extra
</td>

<td width="354" >IPC Shared memory samples
</td>

<td width="151" >[linuxgazette](http://linuxgazette.net/104/ramankutty.html)
</td>
</tr>
</tbody>
</table>

