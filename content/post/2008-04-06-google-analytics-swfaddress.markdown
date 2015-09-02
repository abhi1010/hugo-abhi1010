+++
date = "2008-04-06 05:32:00+00:00"
title = "Google Analytics & SWFAddress"
type = "post"
tags = ["flash"]
categories = ["code", "tips"]
+++

Recently found a bug slash issue with Google Analytics new javscript software (post-urchin v5). I had written the internal documentation for the company standards and somehow when those standards were put into practice, SWFAddress feature of flash stopped working the moment google analytics feature was enabled. Worst of all, the web pages failed to load! To cap it off, the website was working perfectly fine on Firefox 2, 3 and IE 7!! It was having trouble only on IE6.

I tried a lot of ways but none seem to worked. Finally found a blog that remotely talked about SWFAddress!

Well, the problem turns out that SWFAddress uses **ExternalInterface.call()** instead of getUrl() function internally and they don't go well together if used together.

The solution was simple, since flash is using SWFAddress feature, every getUrl should be replaced with ExternalInterface.call(). Needless to say, everything seemed perfect again.
