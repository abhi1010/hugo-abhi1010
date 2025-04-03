+++
date = "2008-03-08 22:30:00+00:00"
title = "Creating Custom Web Controls"
type = "post"
draft = false
tags = ["c-sharp"]
categories = ["code"]
description = "How to create custom web controls"
keywords = ["custom web controls", "asp.net", "C#"]
+++
How do you extend a control? Let's figure it out.


**Why would you want to extend existing controls?**

Because some functionality may not exist exactly as you may need it. For example, let's take up ImageButton control example. It is a great control but it falls short when it comes to real world scenario. Mostly websites do a hover image clickable button where the text or background color of the button changes once you hover your mouse over it.



**How to Extend?**



_I assume that you use C# code but there is not going to be any difference even if you wanted to do in VB.Net. _



Create a project for creating custom web control library. It automatically includes a C# class that says something like







    <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> WebCustomControl1 : WebControl











Now ask yourself, what do you want to extend? A GridView? Replace WebControl with GridView. Let's follow our example with Hover Image Button Control. If you recall .Net already has ImageButton control that accepts one url for the image to be shown for that button, let's extend that one to include two Images rather than just one. In that case I would replace WebControl with ImageButton since I am going to extend ImageButton control. Let's call it HoverImageButton. Hence, the line changes to some thing like this:






    <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> HoverImageButton : ImageButton











The class also includes a property called Text for you so that you can see that and figure out how to use properties in custom web controls. It also includes attributes that start off just before the property itself. It is used by Visual Studio for showing this property on Properties pane. It is definitely a very useful feature.





You can change this property to anything you like. Since we are creating a HoverImageButton control we want a property to save another url for the hover image's source. Let's change Text to "ImageHoverUrl". ImageButton already has a property called "ImageUrl" and it belongs to "Appearance" group in Visual Studio Properties window. Notice the similarity in "ImageHoverUrl" and ImageUrl so that they appear together in Properties window. Sometimes, little deeds go a long way.





**Writing JS file**





Now let's add a javascript file to the project. Add one function called "ShowImageHoverButton()" that takes in two parameters, the control's id and the new image to be shown for that control. The control image's source is changed everytime when this function is called. We can call this function on mouse out and on mouse over events.





That's all you need to do for this control.





**Linking JS and Custom Control them together**





This is a very simple process. You have the javascript file and you know for sure that the control will be loaded into the webpage, so you need a mechanism inside the control so that you can tell that "hey, include this javascript file whenever you have this control on a page".





This is how you do that.

{{< gist bfb075b6787d2616fde6 >}}



Please note that the name of the javascript file is "HoverImageButtonJS.js". ExtendedControls is the name of the project/assembly that I have created for this custom web control.





How to assign javascript functions to the control?





Now the next problem is how would you tell the control that call this javscript function function on "mouseover"? We use OnInit function for this process. We override the function and make use of the control's Attributes property.





What is Attributes property for anyway? Well, it adds any extra "property" or "style" that you may want to add to the control when it is rendered to the client.





Let's see how that's done.

{{< gist d0b66ef7b0f076e88042 >}}



Over here, I have told the class to include `"onmouseover=ShowImageHoverButton(this, 'IMAGE_SOURCE')"` as a property.





This is how it is rendered on the client browser:



{{< gist 6df972bf94b736545419 >}}



**Add the javascript file also to the AssemblyInfo.cs class**





For the control library to properly include the js file, you have to add the js file in AssemblyInfo.cs class as well. This is how it is done:











    [assembly: WebResource(<span style="color:#006080;">"ExtendedControls.HoverImageButtonJS.js"</span>, <span style="color:#006080;">"text/javascript"</span>)]











**Test Drive!**





That's all. A few simple steps and your control is ready to be tested. Still, let's not rush and see the steps required:







  * Add this control's library to any web project.



  * Register the dll on web.config. This makes the control available automatically on all the pages.







{{< gist 88222d3f94911fbec6f4 >}}





  * Go to the design view of any page. Open up the Toolbox pane and you will automatically see the name appear "HoverImageButton". Double click and you are ready to go!!





**Easy as it may sound but it may not be that smooth a ride for you.**





Just take care of few pointers and you should be fine. Here they go:







  * The JScript file that you have added sometimes doesn't get linked properly to the control. Right click on the js file and check it's properties. It's compile action should be "Embed Content" rather than anything else. That way everytime you compile this control, this js file gets "embedded" into the control's library.



  * Take care of the naming convention for the js file.




    * If your control's namespace is ExtendedControls, then while "Registering" it in the control's class you should give the JS file's name as "ExtendedControls.CustomControl_JS.js" where "CustomControl_JS.js" is the name of the javascript file. Basically, another shortcut to learn it is whatever is the name of the project/assembly that you are creating, you have to append that name before the file name. **Follow this logic strictly, otherwise you will be left high and dry. **




  * You should also remember to register this name inside AssemblyInfo.cs class ("ExtendedControls.CustomControl_JS.js" as per our example here).



  * If you want Visual Studio Design support then remember to add the attributes that define where can you see the custom properties of this control in the "Properties" pane.



  * Whenever you are putting your code files inside some folder, try to keep the JS files in the root folder.




    * When I tried putting them inside the folder it did not work, i took them out to the root folder and it worked instantly. I have not tried changing the JS file names but I am sure you can figure out some solution.



**Here's all the code in case somebody needs it:**

{{< gist 135e9bbf44f3d9a53cb8 >}}
