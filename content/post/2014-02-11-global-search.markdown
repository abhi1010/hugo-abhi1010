+++
date = "2014-02-11 14:56:00+00:00"
title = "Global Search in VIM"
type = "post"
tags = ["bash", "vim"]
categories = ["code"]
description = "How to do global search in VIM"
keywords = ["vim global search", "vim search"]
+++


You must be knowing about regular VIM search

    %s/SEARCH/REPLACE/CMD


However, sometimes you do not want to replace something but just see all instances of the a word or phrase. In such cases, global search is really useful when on vim. The syntax is simpler than normal search-replace:

    :[range]g[lobal]/{pattern}/[cmd]


This will show all instances of the "SEARCH" term within the VIM window. There's another version of the same command which is as follows:

    :[range]g[lobal]!/{pattern}/[cmd]

This is similar to the previous command but the only difference is that this command contains "!" which signifies that the command will be executed on all lines ``NOT`` matching the `pattern`.

One example here would be to delete all lines in a file containing a particular word:

    :g/deleteMe/d


There could be lot more actions (regular vim stuff) that you could do like yanking or indenting.
