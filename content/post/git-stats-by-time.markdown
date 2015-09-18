+++
categories = []
date = "2015-09-17T11:06:06+08:00"
description = ""
keywords = []
title = "git stats by time"
draft = true
+++


Recently had an interest in seeing how many LOC were committed to the code base over a particular period of
time. Decided to use the following bash script for finding coding stats:

{{< highlight bash >}}

git log   --since="1 year ago" --pretty=tformat: --numstat | awk '{ if ( $2 != 0 && $1 != 0 ) print $0 }' |
    gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s removed lines: %s total lines:
    %s\n", add, subs, loc }'


{{< /highlight >}}
