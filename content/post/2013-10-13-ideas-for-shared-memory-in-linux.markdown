+++
date = "2013-10-13 05:59:22+00:00"
title = "Ideas for Shared Memory in Linux"
type = "post"
tags = ["c-sharp"]
categories = ["code"]
description = "Shared memory in linux"
keywords = ["shared memory"]
+++

I have been doing extensive research today regarding shared memory in linux before I embark on a new project in which shaving time off process communication latency is extremely important. I found some very interesting links as well. Let’s break them down:

Topic | Description | Link
------------ | ------------- | -------------
Theory/Explanation | Some articles that explain how to get started | [open-std](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2006/n2044.html) 
Content in the first column | Content in the second column | lkd
 | IPC Mechanisms – some recommendations. Mainly talks about softwares like Boost, dBus dBus used to work using kernel levels but lately have come up with a patch that bypasses kernels | [Stackoverflow](http://stackoverflow.com/questions/1906166/inter-process-communication-recommendation)
 | What every programmer should know about memory |	[LWN](http://lwn.net/Articles/255364/)
 | Linux IPC | [TLDP](http://www.tldp.org/LDP/tlk/ipc/ipc.html)
 | Cache Friendly Code  | [Stackoverflow](http://stackoverflow.com/questions/16699247/what-is-cache-friendly-code/16699282#16699282)
 | Helpful Articles 	Which linux IPC technique to use? | [Stackoverflow](http://stackoverflow.com/questions/2281204/which-linux-ipc-technique-to-use)
 | Inter process communication – talks about shared memory | [ALP](http://www.advancedlinuxprogramming.com/alp-folder/alp-ch05-ipc.pdf)
 | Linux Poll Events on Shared Memory | [Stackoverflow](http://stackoverflow.com/questions/11470322/cause-a-linux-poll-event-on-a-shared-memory-file)
 | Using semaphores in Shared Memory | [Stackoverflow](http://stackoverflow.com/questions/10772860/semaphores-and-shared-memory-in-linux)
 | Sharing semaphores between Shared Memory | [Stackoverflow](http://stackoverflow.com/questions/8359322/how-to-share-semaphores-between-processes-using-shared-memory?rq=1)
 | Sharing memory between processes | [Stackoverflow](http://stackoverflow.com/questions/11583281/sharing-memory-between-two-processes)
 | Reserving memory at kernel boot up (DMA) | [Stackoverflow](http://stackoverflow.com/questions/647783/direct-memory-access-in-linux?rq=1)
Extra | IPC Shared memory samples | [linuxgazette](http://linuxgazette.net/104/ramankutty.html) 

