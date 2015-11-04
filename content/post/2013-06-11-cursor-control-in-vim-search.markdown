+++
date = "2013-06-11 07:05:00+00:00"
title = "Cursor Control in VIM Search"
type = "post"
tags = ["vim"]
categories = ["code", "tips"]
description = "How to control cursor in vim"
keywords = ["vim", "cursor control", "vim search"]
+++

Found a great way to search for keywords && control the location of cursor in vim. It is excellent if you want to do a particular task multiple times. Usually if you search the cursor will straight away take you to the start of search. What if you want to go to the end of the word you are searching for?

 
    /pattern/e
 

This takes you to the END of the keyword you are looking for. 


That’s not all. What if you want to go the second letter in that keyword? Change the pattern to as follows:


    /pattern/s+1

That’s great. But what if I want to go to the end of the keyword? 

    /pattern/e

Awesome. Let’s review it through examples. Let’s say our phrase is “the brown fox jumped over the lazy dog” and we originally want to search for “brown”.

Pattern | CURSOR LOCATED AT BEGINNING OF | Description
------- | ------------------------------ | -----------
/brown| 	brown fox…. | search and start at “brown”
/brown/s+2 |	own fox… | start at “brown” but move 2 letters from ‘start’
/brown/s-4 	| the brown fox… | start at “brown” but move 4 letters to the left from ‘start’
/brown/e |	n fox…. | search for “brown” but move to the end
/brown/e+2 |	fox… | search for “brown” but move 2 letters from the ‘end’
/brown/e-1 	| wn fox… |	search for “brown” but move 1 letter to the left from the ‘end’ 


