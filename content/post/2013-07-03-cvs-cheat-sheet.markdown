+++
date = "2013-07-03 07:28:00+00:00"
title = "CVS Cheat Sheet"
type = "post"
tags = ["bash", "cvs"]
categories = ["code", "tips"]
+++


I've worked on CVS for a long time now and figured out that I'd save a lot of time if I started writing alias or functions for the numerous tasks that I did on them. I will put down some of them here so you may benefit from them.

_Silently update and inform about the status of the files (recursive)_

<blockquote>cvs -q -n update
> 
> </blockquote>

_Same as earlier but will only do so for the current folder_

<blockquote>cvs -Q -n update -l
> 
> </blockquote>

_Finds out the cv[s] [m]odified list of files while also indentating them nicely with only the important data pulled out_

<blockquote>cvs -Q status | egrep "File: " -A 4 | egrep -v "Up-to-date" | egrep "File: " -A 3 | sed -e "s/ Status:/\t\tStatus:/" -e "s/,v$/\n-------------------------------------------------------------------------\n/" -e "s/.*${PWD##*/}\//Location:\t\t /" -e "s/Attic\///" | egrep "Location:|Repository|Status:|File:|--------
> 
> </blockquote>

_Recursively add all files to CVS for committing from the current directory_

<blockquote>find . -type d -print | grep -v CVS | xargs cvs add
> 
> </blockquote>

_Doing a side by side diff (change the value of -W according to the width of the screen)_

<blockquote>cvs -Q diff -t -y --suppress-common-lines -W 190 $*
> 
> </blockquote>

_Merging code from one branch to another_

<blockquote># Creates a command that you can use to "merge" your code from dev head to this current branch.   
# Ideally you want to run this command from a folder where you want the code to merge to....   
merge()   
{   
BRANCH=$(cat CVS/Tag | cut -c2-)   
CMD=$(echo cvs update -j $BRANCH -j Version_2_17_dev .)   
echo $CMD   
}   

> 
> </blockquote>
