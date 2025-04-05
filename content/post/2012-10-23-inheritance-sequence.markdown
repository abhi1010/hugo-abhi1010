+++
date = "2012-10-23 14:21:00+00:00"
title = "Multiple Inheritance"
type = "post"
tags = ["c++"]
categories = ["code"]
description = "Multiple inheritance explained"
keywords = ["inheritance", "multiple inheritance"]
+++

What is the output to the following code?

{{< gist abhi1010 8fac0155f30551df8bca >}}

<!-- more -->

_Output_



    Foo FooToo Bar FootTooBar





_Why?_







  1. An instance of FooTooBar needs to be created according to main()



  2. To create that instance, we first need the base classes too, hence FooToo and Bar classes



  3. Now notice the keyword virtual everytime inheritance is defined




    * This does half the magic by ensuring that the member data instances are shared with any other inclusions of that same base in further derived classes



    * This is very handy for multiple inheritance






As an exercise you may try to remove virtual from some derived class and see what results you get.
