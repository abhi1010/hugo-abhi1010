+++
date = "2013-06-11 07:05:00+00:00"
title = "Cursor Control in VIM Search"
type = "post"
tags = ["vim", "tips"]
categories = ["code"]
+++

Found a great way to search for keywords && control the location of cursor in vim. It is excellent if you want to do a particular task multiple times. Usually if you search the cursor will straight away take you to the start of search. What if you want to go to the end of the word you are searching for?

 

<blockquote>  
> 
> /pattern/e
> 
> </blockquote>

 

This takes you to the END of the keyword you are looking for. 

 

That’s not all. What if you want to go the second letter in that keyword? Change the pattern to as follows:

 

<blockquote>  
> 
> /pattern/s+1
> 
> </blockquote>

 

That’s great. But what if I want to go to the end of the keyword? 

 

<blockquote>  
> 
> /pattern/e
> 
> </blockquote>

 

Awesome. Let’s review it through examples. Let’s say our phrase is “the brown fox jumped over the lazy dog” and we originally want to search for “brown”.

 <table cellpadding="2" cellspacing="0" border="1" width="947" ><tbody >     <tr >       
<td width="185" valign="top" >         

**PATTERN**

      
</td>        
<td width="286" valign="top" >         

**CURSOR LOCATED AT BEGINNING OF**

      
</td>        
<td width="474" valign="top" >         

**DESCRIPTION**

      
</td>     </tr>      <tr >       
<td width="185" valign="top" >/brown
</td>        
<td width="286" valign="top" >brown fox….
</td>        
<td width="474" valign="top" >search and start at “brown”
</td>     </tr>      <tr >       
<td width="185" valign="top" >/brown/s+2
</td>        
<td width="286" valign="top" >own fox…
</td>        
<td width="474" valign="top" >start at “brown” but move 2 letters from ‘start’
</td>     </tr>      <tr >       
<td width="185" valign="top" >/brown/s-4
</td>        
<td width="286" valign="top" >the brown fox…
</td>        
<td width="474" valign="top" >start at “brown” but move 4 letters to the left from ‘start’
</td>     </tr>      <tr >       
<td width="185" valign="top" >/brown/e
</td>        
<td width="286" valign="top" >n fox….
</td>        
<td width="474" valign="top" >search for “brown” but move to the end
</td>     </tr>      <tr >       
<td width="185" valign="top" >/brown/e+2
</td>        
<td width="286" valign="top" >fox…
</td>        
<td width="474" valign="top" >search for “brown” but move 2 letters from the ‘end’
</td>     </tr>      <tr >       
<td width="185" valign="top" >/brown/e-1
</td>        
<td width="286" valign="top" >wn fox…
</td>        
<td width="474" valign="top" >search for “brown” but move 1 letter to the left from the ‘end’
</td>     </tr>   </tbody></table>
