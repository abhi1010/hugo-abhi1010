+++
date = "2008-03-31 08:23:00+00:00"
title = "Tag your namespaces"
type = "post"
tags = ["c#"]
categories = ["code"]
+++

Recently discovered a nifty little feature on .Net and though of sharing it.

You can tag an assembly by giving it a name and then use this name throughout your class to access the classes inside this namespace.







    
    <span style="color:#0000ff;">using</span> asp=CompanyName.Data;








Now all the classes inside CompanyName.Data namespace can be accessed using the name asp (as if it was an instance of the namespace).

One thing to note, however, is that the classes inside this namespace cannot be accessed directly and the word "asp" has to be used.

Let's see an example to understand it.
{{< gist ad4f3fc47ffa870a48f9 >}}

This function, btw, is going through a namespace called `Company.AspFunctions` and we give it a tag `asp` to access all classes under it by its tag instead. Date_Format() fn is a static function inside Conn Class. Basically it takes your "asp style" datetime strings and returns you the correct date in `yyyyMMdd` format.
