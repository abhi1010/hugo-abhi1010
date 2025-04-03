+++
date = "2008-03-08 13:55:00+00:00"
title = "StringBuilder vs String joins"
type = "post"
draft = false
tags = ["c-sharp"]
categories = ["code"]
description = "Stringbuilder vs String joins"
keywords = ["Stringbuilder", "strings", "C#", ".net"]
+++


For those who do not want to waste their time, here's the gist for this whole article:
_StringBuilder performs better but you should try to use it when there's lot of concatenation involved (normally more than 7 joins - start thinking about StringBuilder._

Let's move on for the lesser mortals. There has been a lot of debate about using StringBuilder instead of adding string like

    <span style="color:#606060;">   1:</span> strVariable += <span style="color:#006080;">" Add this string to my variable string"</span>;

What's the darn difference?

If you remember your schooling concepts string objects are fixed, their values cannot be changed. So, how can you change the value of a string? Well, you do NOT change the value, you change the object altogether! Every time you assign a value a new object of type string is created with the given value and is returned to you. hence, you discard the old string and actually come up with a new string.

On the other hand, when you use StringBuilder, it is the same object, that you are working on. It keeps appending to the same object and the heap is not changed. Then why don't you use it always? Because there are "appending" costs. Everytime you append something, it is checked against the buffer and if it falls short of space needed, a new buffer is allocated. Let's see how that works inside the dll:



How about some proof?

Fortunately somebody did the hard work for all of us and actually came up with the statistics. You can find all of that over here:

[http://www.heikniemi.net/hc/archives/000124.html](http://209.85.175.104/search?q=cache:k9R6UE-q2nMJ:www.heikniemi.net/hc/archives/000124.html+http://www.heikniemi.net/hc/archives/000124.html&hl=en&ct=clnk&cd=1&gl=sg&client=firefox-a)
