+++
description = "How to add launcher shortcut in Fedora"
title = "Adding launcher shortcut in Fedora"
date = "2016-11-13T00:33:29+08:00"
categories = ["code"]
keywords = ["fedora launcher", "fed", "pyinvoke", "python", "invoke"]
tags = ["tips", "bash"]
+++

Many apps do not come pre-built in rpm format for Fedora so you'd have to download the **tar** file for it.
To run the app, you would have to go to the saved folder and then either double cilck or run the command through
command line. By default, that app won't be accessible through the `Super` key's universal search or
as a regular application in ***Show Applications**.

Fortunately, there's a way around and it is an easy one.

Fedora looks for `.desktop` files in `~/.local/share/applications/` folder.
Let's say we are trying to create a shortcut for Eclipse. We will then create
a file by the name `eclipse.desktop` in the given folder.
The contents will be as follows:


```config
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Eclipse
Comment=Eclipse starter
Exec=<FULL-PATH-TO-ECLIPSE=BINARY>
Icon=<FULL-PATH-TO-ECLIPSE-ICON>
Terminal=false
```


That's it. You are set!