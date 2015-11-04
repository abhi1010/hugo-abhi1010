+++
date = "2013-11-09 23:51:00+00:00"
title = "Reading Excel in C#"
type = "post"
tags = ["c-sharp", "excel"]
categories = ["code"]
description = "How to read Excel in C#"
keywords = ["excel reading code", "C#", ".NET"]
+++


Recently had to work on an Excel and update its content when some events were triggered on a Bloomberg terminal. I couldn't find any code for reading the excel file using C# so thought of putting that up.

There were a few things to learn:



	
  * Excel support is not available by default so make sure to add Microsoft.Office.Interop.Excel as a reference

	
  * Sometime indexing to reference the Workbooks or Worksheets may not work so try out other values

	
  * 

	
    * I remember this was not a problem with Visual Studio 2010 but something must have happened in Visual Studio 2012




	
  * It is also possible to try Workbook names to try and retrieve them


Please follow the shortened code to read an Excel file after the break.

<!-- more -->

{{< gist ee13f57720471c8feea2 >}}







