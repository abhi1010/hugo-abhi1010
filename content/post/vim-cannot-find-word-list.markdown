+++
date = "2015-10-31T20:48:16+08:00"
description = "How to fix the cannot find word list error while opening files on vim without using runtimepath"
keywords = ["vim", "spell", "neovim", "runtimepath"]
tags = ["vim"]
categories = ["tips"]
title = "vim cannot find word list"
+++

After installing [spf13 vim](http://vim.spf13.com/) every time I would open a file I had trouble with two things on my mac:
 
 - File opening would halt in the middle with the following error :  **Cannot find word list "en.utf-8.spl" or "en.ascii.spl"**
 - Syntax highlighting also failed thereafter
 
Here's what I would see:
 
```bash
$ vim release.sh 
Warning: Cannot find word list "en.utf-8.spl" or "en.ascii.spl"
Press ENTER or type command to continue
```

I googled a lot regarding this but didn't find anything straight forward.
When all options failed I recalled that it is looking for the spell files in a specific folder. 
Hence I decided to do a lookup for them:


    locate en.utf-8

I got a lot of options:

```bash
$ locate en.utf-8

/usr/local/Cellar/macvim/7.4-73/MacVim.app/Contents/Resources/vim/runtime/spell/en.utf-8.spl
/usr/local/Cellar/macvim/7.4-73/MacVim.app/Contents/Resources/vim/runtime/spell/en.utf-8.sug
/usr/local/Cellar/vim/7.4.712/share/vim/vim74/spell/en.utf-8.spl
/usr/local/Cellar/vim/7.4.712/share/vim/vim74/spell/en.utf-8.sug
/usr/share/vim/vim73/spell/en.utf-8.spl
/usr/share/vim/vim73/spell/en.utf-8.sug
```

One of the options was to change the `runtimepath` to let it know about the spell folders.

```bash
let &runtimepath=("~/.vim/,/usr/local/Cellar/vim/7.4.712/share/vim/vim74/spell/," . &runtimepath)
```


When that failed too and nothing else worked, I decided to copy out the file and give it a try:
 
 
    cp /usr/local/Cellar/vim/7.4.712/share/vim/vim74/spell/en.utf-8.spl ~/.vim/spell
    
To my surprise, that worked!