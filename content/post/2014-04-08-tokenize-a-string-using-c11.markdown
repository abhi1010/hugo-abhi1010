+++
date = "2014-04-08 07:00:00+00:00"
title = "Tokenize a String using C++"
type = "post"
tags = ["c++"]
categories = ["code", "tips"]
description = "How to tokenize a string using C++"
keywords = ["tokenize", "string tokenizer"]
+++


Here's a short snippet to split a string into multiple tokens; into a vector. As you will see that, if you run the code, boost version performs better because you can choose a number of delimiters to split your string instead of the vanilla version using the normal C++ code. Of course, you may also write your own code to do something like this but I was looking to do some short snippets.

{{< gist 554885a7235f4047dae6 >}}

I have **posted my code on [Stacked-Crooked](http://coliru.stacked-crooked.com/a/01e1c68ffd0199cd)** which you can view along with the output as well. It shows C++ doesn't perform so well.
