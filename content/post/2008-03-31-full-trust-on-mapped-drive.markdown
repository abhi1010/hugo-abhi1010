+++
date = "2008-03-31 18:26:00+00:00"
title = "Full Trust on Mapped Drive"
type = "post"
tags = ["visual studio"]
categories = ["code", "tips"]
description = "How to have full trust on a mapped drive"
keywords = ["windows mapped drive", "full trust"]
+++

Sometimes, when opening a web project from another mapped drive (not your own computer's hard disk) Visual Studio may complain something like this:

    The project location is not trusted.
    
    Running the application may result in security exceptions when it
    attempts to perform actions which require full trust.


The problem here is that .Net does not want to fully adhere to all security policies as your hard disk to this mapped drive as well as it does not know what kind of data it might have. If you want it to fully trust this mapped drive then you will have to use caspol for this purpose. Here's how it is done:

    c:\>caspol -q -machine -addgroup 1 -url file://W:/* FullTrust -name "W Drive"

Once this new code group is in place, any new .NET processes you start will give any assemblies on the W drive full trust**.**
