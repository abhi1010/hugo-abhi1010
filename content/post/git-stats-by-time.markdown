+++
categories = ["code"]
tags = ["bash", "git"]
date = "2015-09-17T11:06:06+08:00"
title = "Git LOC Stats by Time Range"
description = "LOC stats using git"
keywords = ["LOC", "git stats"]
+++


Recently had an interest in seeing how many LOC were committed to the code base over a particular period of
time. After some tinkering around, mainly to find out the correct format for time ranges, decided to use the following bash script for finding coding stats.
Following sample is to find out lines added or removed during the year 2014. 


{{< highlight bash >}}
$ git log --after="2014-1-1" --before="2014-12-31" --pretty=tformat: --numstat 
    | awk '{ if ( $2 != 0 && $1 != 0 ) print $0 }' 
    | gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "Added lines: %s Removed lines: %s Total # of lines: %s\n", add, subs, loc }'

{{< /highlight >}}

The result will be as follows:

```
Added lines: 327505 Removed lines: 243860 Total # of lines: 83645
```

You will notice in the second line that I am doing the following:
{{< highlight console >}}
 if ( $2 != 0 && $1 != 0 ) 
{{< /highlight >}}

This is simply to discard off any commit numbers that were pure addition or deletion (with no corresponding delete or add in the same commit). 
It may also remove some numbers that were actually valid commits but mostly it is to protect ourselves against any library or API that we may have added or replaced during that time period.

For time range, you may even use something like `--since="1 year ago"` and that will also yield similar results.
