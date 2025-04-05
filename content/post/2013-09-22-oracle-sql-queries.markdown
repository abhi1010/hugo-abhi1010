+++
date = "2013-09-22 08:48:00+00:00"
title = "Oracle SQL Queries"
type = "post"
tags = ["sql"]
categories = ["code", "database"]
description = "How to view all table in oracle sql server"
keywords = ["oracle sql", "sql queries"]
+++

Recently I found myself in a situation where I had to view all the tables in the Oracle Server.

I did some digging and came up with these helpful queries.

Query | Remarks
----- | -------
Select * from All_Tables | View all the tables in the Oracle Server
Select * from all_Views | View all the views in the Oracle Server
DESC table |	View all the columns of a given table. This function is used instead of the previous one mostly, but when this one doesn't work make sure you try the other one - I bet it will work.


Here's a short code for viewing all the columns of a given table.


{{< gist abhi1010 11365686 >}}
