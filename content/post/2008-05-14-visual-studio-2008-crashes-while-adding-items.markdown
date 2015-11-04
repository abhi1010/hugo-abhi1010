+++
date = "2008-05-14 21:43:00+00:00"
title = "Visual Studio 2008 crashes while adding items"
type = "post"
tags = ["c-sharp", "visual studio"]
categories = ["code"]
description = "How to fix visual studio crashes when adding items"
keywords = ["visual studio crash", "C#", ".NET"]
+++


Had this problem cropping up since months where I was trying to add items to Visual Studio 2008 Toolbox and it kept crashing.

Finally got a work around, you should start it in safe mode. Here's the procedure:

    
    devenv /safemode


Then use Choose Items on toolbox and run through each of the tabs. Once you
accept any exceptions raised on loading controls, you can then open Visual
Studio normally and add items.

The reason for this has to be pretty simple - I have installed way too many beta/refresh version on Visual Studio 2008, something had to give up. I can't really complain.
