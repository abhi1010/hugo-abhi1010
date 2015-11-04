+++
categories = ["code"]
tags = ["django", "python", "code"]
date = "2015-09-04T00:17:10+08:00"
title = "Premailers for Django"
description = "What premailer to use for django"
keywords = ["premailer", "django", "python"]
draft = true
+++

I have been trying some premailers for `Django` and came across two options [***inlinestyler***](https://pypi.python.org/pypi/inlinestyler) and [***premailer***](https://pypi.python.org/pypi/premailer). 
Premailers are essentially helpers to update html content before you send out emails. For the best HTML e-mail delivery results, CSS should be inline.


Most of our code is mostly in html with almost all of the CSS styles within css files. However, that won't work very well with every app on the planet.
You can see a nice comparison table with on [campaignmonitor](https://www.campaignmonitor.com/css/) with all the details.
As you will notice, there are a lot of differences in how the css content is presented.
While working on an internal project, I needed to send out emails where the content was coming from the web pages, exactly as is. 
Instead of adding a long set of code trying to manage two types of views - one for web and another for emails I decided to use premailer approach.

# premailer

I settled on [***premailer***](https://pypi.python.org/pypi/premailer) as it was recommended by most of the people. 

Install it as follows:
{{< highlight bash >}}
pip install premailer=2.9.5
{{< /highlight >}}


Here's the code for `premailer` usage. Remember to use `external_styles` for linking your CSS files properly so that they are picked up as well.

{{< highlight python >}}
import premailer
from django.core.mail import send_mail

rendered_html = render(request, 'template.html', results)

def read_text(file_path):
    with open(file_path, 'rt') as file_placeholder:
        lines = file_placeholder.readlines()
        text = ''.join(lines)
        return text
        
content = rendered_html.content.decode('utf-8', 'ignore')
css = read_text(os.path.join(settings.BASE, 'static/styles.css'))

p = premailer.Premailer(content,
                        external_styles=os.path.join(settings.BASE, 'static/css/report_styles.css'))

send_mail('Report', YOUR_MAIL,
          FROM_EMAIL,
          RECIPIENT_LIST, 
          fail_silently=False,
          html_message=p.html)
{{< /highlight >}}

After setting it up, the email on gmail (which is quite strict) didn't look perfect.
I digged further on `premailer` and noticed that it was only converting the parts where class names were being used within the main html.
Any part that was using defaults through the CSS was being missed out. That was a bummer. 

# inlinestyler
I felt this trial may not work out so well but then I recalled about
 [***inlinestyler***](https://pypi.python.org/pypi/inlinestyler) and decided to give it another try.

Here's how to install it:

{{< highlight bash >}}
inlinestyler==0.2.1
{{< /highlight >}}

Sample Usage

{{< highlight python >}}
from inlinestyler.utils import inline_css
from django.core.mail import send_mail

rendered_html = render(request, 'confo_report/conf_rpt.html', results)

content = rendered_html.content.decode('ascii', 'ignore')
content = content.replace('"/STATIC', '"WEBSITE_NAME/STATIC')

message_inline_css = inline_css(content)

send_mail('Report', YOUR_MAIL,
          FROM_EMAIL,
          RECIPIENT_LIST, 
          fail_silently=False,
          html_message=message_inline_css)
{{< /highlight >}}

This worked out perfectly while even taking out the defaults from the css file and putting them in the html content for email, which is exactly what I was looking for.

Thus I finally I settled for `inlinestyler`. 

