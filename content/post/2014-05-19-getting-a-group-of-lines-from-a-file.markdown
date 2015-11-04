+++
date = "2014-05-19 09:45:57+00:00"
title = "Getting a group of lines from a file"
type = "post"
tags = ["awk", "bash"]
categories = ["code", "tips"]
description = "How to grep for a group of lines with a boundary"
keywords = ["grep groups"]
+++

I've had this need quite a few times to pull out a section of logs that would begin with a particular line and end with another. grep is not exactly useful there because it only prints out sections based on line counters (using -A/B/C) lines based on a single search pattern.

I came up with a script that can run at almost same speeds using `grep/cat/awk`. `awk` is used to decide whether the end of the section has been reached or not. Some features of the script are:



	
  * Since `awk` script only toggles one variable it works seamlessly without delaying the actual work

	
  * Works on gzip files as well

	
  * If you do not want to depend on grep or are unsure how many lines may be between begin and end keyword then replace gunzip with zcat and grep with cat.

	
  * Usage: ``group filename printBeginKeyword printUntilKeyword NumOfLines``


Let's have a look at the script....

{{< gist 924a5f12f3067ba0b3af >}}
