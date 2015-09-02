+++
date = "2014-05-26 14:19:15+00:00"
title = "Usage of typename"
type = "post"
tags = ["c++"]
categories = ["code"]
+++

What is wrong with the following code?
  

https://gist.github.com/anonymous/f1f2246d04a935794e44
  

The issue is very simple but hard to notice. If you try to compile this, you will get the following errors:


<blockquote>main.cpp:24:5: error: need 'typename' before 'OuterStruct<T2>::InnerStruct' because 'OuterStruct<T2>' is a dependent scope
OuterStruct<T2>::InnerStruct mUsingInner;
^
main.cpp: In function 'int main(int, char**)':
main.cpp:34:13: error: 'struct InnerStruct_Wrapper<int>' has no member named 'mUsingInner'
wrapper.mUsingInner = innerStrct;
^</blockquote>


<!-- more -->

**The Issue**

At least it straight away tells you something is wrong with `InnerStruct_Wrapper`. Here's what is happening:



	
  * The compiler does not know that mUsingInner in that line is actually a variable of type "OuterStruct<T2>::InnerStruct"

	
  * InnerStruct will only be known later when it is being instantiated

	
  * Compiler cannot figure out what InnerStruct means here. It could be a type or a member variable


**The Fix**

The only way here is to help the compiler by telling it beforehand that is going to be a class or struct type. The way to tell the compiler that something like this is supposed to be a type name is to throw in the keyword "typename". The "typename" keyword has to be used everytime you want to tell the compiler that it should expect a Type in its place.

One place where this is used quite a lot is when templates have to implement iterators.

**Full Code**

**_The full sample code, along with the fix_** is provided on [Stacked-Crooked](http://coliru.stacked-crooked.com/a/b0ab70c458370048).
