+++
date = "2007-11-23 07:52:00+00:00"
title = "Dynamically increase Label size [AutoSize]"
type = "post"
draft = false
tags = ["c-sharp"]
categories = ["code"]
description = "How to dynamically increase label size in asp.net"
keywords = ["asp.net", "C#", "windows forms"]
+++

Recently I had to work on a windows form where the Labels are added dynamically onto the form. Some of you may think that setting AutoSize to true would fix the problem but it works only when you already have added that Label control onto the form, not when you are adding it dynamically.

Despair not, there's still a solution. Just create a label and set it's text first then call this function:

{{< gist e8390c5868a86998a7d5 >}}

If you do some testing it may not work on Compact Framework. Here's how to get around that issue again.

{{< gist f488949a5d79b6d86544 >}}
