+++
date = "2013-04-25 07:02:00+00:00"
title = "Change Putty Window Title"
type = "post"
tags = ["bash", "putty"]
categories = ["code", "tips"]
+++

How to modify the Putty window title to a specific string?

By default, you'd like to have the window title to give you the full path to the folder you are working from (working directory). `PROMPT_COMMAND`will help you with that.

However, if you have too many windows where you are on the same folder then it may become confusing. To set your own title you'd like to use the `title()` function provided here. It sets the name to whatever you say.

Please note that `PS1` is only valid until you move your folders again. That is why the title() function also has to reset `PROMPT_COMMAND`.

Let's have a look at the script needed. Maybe you wanna put them in your .bashrc file.


{{< gist 8eed9133ed91cbb42854 >}}

