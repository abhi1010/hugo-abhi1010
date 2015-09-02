+++
date = "2007-10-26 16:36:00+00:00"
title = "Use of yield statement"
type = "post"
tags = ["c#"]
categories = ["code"]
+++

It might be a little late for this to appear but I have no qualms in accepting that I have finally embraced yield statement and see it as an excellent way of writing codes.

I have had my fair share of writing small code fragments to read/process/write files and more often than that it is excel files. So I thought, there has to be an easier way than just creating common functions for Connections and processing functions - at that time yield statement came to the rescue. I have always had to read the excel file, one line after another - pretty much like a DataTable if you ask me.

The best way to put the whole process of reading the excel file is to automate reading, iterating and closing of the excel files. It is done by yield statement as I can "yield" the data of the excel through DataReader (OdbcDataReader in my case).

{{< gist 36ecc206fc5f61f4b4bc >}}

This way, the function is always common - it is always supposed to read the excel, iterate through it. The data that I need is always in the DataReader so I thought let's just return the data itself! The rest of the function is pretty much normal. The biggest gain is that I don't have to change the structure of the function. The same function can now be used for multiple excel sheets. Have a look at the code.
