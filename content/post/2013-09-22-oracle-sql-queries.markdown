+++
date = "2013-09-22 08:48:00+00:00"
title = "Oracle SQL Queries"
type = "post"
tags = ["sql"]
categories = ["code", "database"]
+++

Recently I found myself in a situation where I had to view all the tables in the Oracle Server.

 

I did some digging and came up with these helpful queries.

 <table cellpadding="2" cellspacing="0" border="1" width="1083" ><tbody >     <tr >       
<td width="591" valign="top" >         

**Query**

      
</td>        
<td width="490" valign="top" >         

**Remarks**

      
</td>     </tr>      <tr >       
<td width="591" valign="top" >Select * from All_Tables 
</td>        
<td width="490" valign="top" >View all the tables in the Oracle Server
</td>     </tr>      <tr >       
<td width="591" valign="top" >Select * from all_Views
</td>        
<td width="490" valign="top" >View all the views in the Oracle Server
</td>     </tr>            <tr >       
<td width="591" valign="top" >         
    
    DESC <em>table</em>


      
</td>

      
<td width="490" valign="top" >View all the columns of a given table. 
          


          
This function is used instead of the previous one mostly, but when this one doesn't work make sure you try the other one - I bet it will work.
</td>
    </tr>
  </tbody></table>





Here's a short code for viewing all the columns of a given table.



https://gist.github.com/abhi1010/11365686
