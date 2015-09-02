+++
date = "2014-04-08 07:00:00+00:00"
title = "Tokenize a String using C++"
type = "post"
tags = ["c++", "tips"]
categories = ["code"]
+++


Here's a short snippet to split a string into multiple tokens; into a vector. As you will see that, if you run the code, boost version performs better because you can choose a number of delimiters to split your string instead of the vanilla version using the normal C++ code. Of course, you may also write your own code to do something like this but I was looking to do some short snippets.

https://gist.github.com/anonymous/0465925390f3442a7691

I have **posted my code on [Stacked-Crooked](http://coliru.stacked-crooked.com/a/01e1c68ffd0199cd)** which you can view along with the output as well. It shows C++ doesn't perform so well.
