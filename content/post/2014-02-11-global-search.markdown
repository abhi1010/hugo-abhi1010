+++
date = "2014-02-11 14:56:00+00:00"
title = "Global Search in VIM"
type = "post"
tags = ["bash", "vim"]
categories = ["code"]
+++


You must be knowing about regular VIM search

<blockquote>%s/SEARCH/REPLACE/CMD
> 
> </blockquote>

However, sometimes you do not want to replace something but just see all instances of the a word or phrase. In such cases, global search is really useful when on vim. The syntax is simpler than normal search-replace:

<blockquote>:[range]g[lobal]/{pattern}/[cmd]
> 
> </blockquote>

This will show all instances of the "SEARCH" term within the VIM window. There's another version of the same command which is as follows:

<blockquote>:[range]g[lobal]!/{pattern}/[cmd]
> 
> </blockquote>

This is similar to the previous command but the only difference is that this command contains "!" which signifies that the command will be executed on all lines ``NOT`` matching the `pattern`.

One example here would be to delete all lines in a file containing a particular word:

<blockquote>:g/deleteMe/d
> 
> </blockquote>

There could be lot more actions (regular vim stuff) that you could do like yanking or indenting.
