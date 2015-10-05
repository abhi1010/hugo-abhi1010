+++
categories = ["code"]
tags = ["zsh", "bash"]
date = "2015-09-28T08:46:09+08:00"
title = "Powerline for zsh"
+++

{{< figure src="/images/powerline-for-zsh.png" caption="Powerline" >}}

I was having a lot of trouble getting [*powerline*](https://github.com/carlcarl/powerline-zsh) to work on my mac machine. 
No matter what I tried, I was getting errors like the following:

{{< highlight console >}}
    .oh-my-zsh/themes/powerline.zsh-theme:100: character not in range
{{< /highlight >}}

Finally got it to work after multiple attempts on `bash` and `zsh`.

All I had to do was set `LC_ALL` to **en_US.UTF-8**. It would set all the locales to `en_US.UTF-8` which
would allow `powerline` fonts work properly. 

{{< highlight bash >}}
$ export LC_ALL="en_US.UTF-8"                                                                                                     22:58:06 
$ locale 
LANG=
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
{{< /highlight >}}

After this, run the following command to test your fonts again. 

{{< highlight bash >}}
LC_CTYPE=en_US.UTF-8 echo '\u2603'
{{< /highlight >}}

Your command should work with or without `LC_CTYPE=en_US.UTF-8`. Here's what you expect to see now.

{{< highlight bash >}}
    ☃
{{< /highlight >}}

