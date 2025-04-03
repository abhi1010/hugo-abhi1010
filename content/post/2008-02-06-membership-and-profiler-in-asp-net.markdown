+++
date = "2008-02-06 19:34:00+00:00"
title = "Membership and Profiler in ASP.NET"
type = "post"
draft = false
tags = ["sql"]
categories = ["database"]
description = "Usage of ApplicationID in membership and profiler in asp.net"
keywords = ["sql", "database", "asp.net"]
+++


Whenever you are using Sql Membership and Profiler classes -
Trying to generate reports make sure your query's WHERE clause is using "indexed" column names at least.



Let's look at some of the more used tables. The index of some of the tables is given below:



**Table: aspnet_membership**




  * Clustered Index = `ApplicationID`, `LoweredEmail`

  * NonClustered = UserID


**Table: aspnet_users**




  * Clustered Index = `ApplicationID`, `LoweredUserName`

  * NonClustered Index = `ApplicationID`, `LastActivityDate`

  * Primary Key = `UserID `


**Table: aspnet_Profile**




  * Clustered Index = `UserID `

<blockquote>
Bottomline - try to use ApplicationID in your queries otherwise your queries, for sure, will not run over the index at all and make it slow. This comes in effect if you are expecting high volume.
</blockquote>