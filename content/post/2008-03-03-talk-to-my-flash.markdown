+++
date = "2008-03-03 04:58:00+00:00"
title = "Talk to my... Flash?"
type = "post"
tags = ["flash"]
categories = ["database", "tips"]
+++

According to normal acceptable behaviour it is not possible to let flash talk to the computer, be it on desktop or web browser.

There are always ways around a problem and there's one in this case as well.



**Windows Forms**

If you wanted to access .net functions on windows form then probably a good way to do that would be through ShockWaveFlashObjects library. It wraps all the functions that are available in ShockWave Objects and makes them available to you in .Net type safe way.

The easiest of ways to send data back and forth would be through
"fscommand" function. The concept is to embed a flash file in windows form and then make use of fscommand function.

Tip: Remember to remove the blue window bondary at the top so the flash appears as if its a standalone object and not embedded inside another form!



**Websites**

If you wanted to talk over a web page then an easy way out would be to use AMF.Net software. It is a freeware and very easy to use as well. In the words of its official [website](http://amfnet.openmymind.net/overview/default.aspx):

_"AMF enables developers to build powerful flash-based applications driven by databases and rich business layers.
AMF.NET is a .NET gateway sitting between a Flash movie and .NET code. The goal of AMF.NET is to promote proper N-Tier development by allowing your existing business layer (written in .NET) to be consumed by Flash without requiring any modification."_
