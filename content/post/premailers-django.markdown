+++
categories = ["code"]
tags = ["django", "python"]
date = "2015-09-04T00:17:10+08:00"
title = "Premailers for Django"
draft = true
+++

I have been trying some premailers for `Django` and came across two options `inlinestyler` and `premailer`.

Finally I settled for `inlinestyler` even though it was the second one I tested. 


{{< highlight python >}}

    # TODO: This following section is for "premailer" which can be used for sending emails out, exactly as the webpage
    if False:
        import premailer
        a = render(request, 'confo_report/conf_rpt.html', results)
        print('render = {}; {}'.format(type(a), a))
        print('str version = {}'.format(str(a.content)))

        def read_text(file_path):
            with open(file_path, 'rt') as file_placeholder:
                lines = file_placeholder.readlines()
                text = ''.join(lines)
                return text
        print('BASE = {}'.format(settings.BASE))
        content = a.content.decode('utf-8', 'ignore')

        css = read_text(os.path.join(settings.BASE, 'static/rw/css/report_styles.css'))

        content = content.replace('<head>', '''<head>
        <style type="text/css">
        {}
        </style>'''.format(css))

        p = premailer.Premailer(content,
                                external_styles=os.path.join(settings.BASE, 'static/rw/css/report_styles.css'))
        print('\n\n\npremailer= {}'.format(p.html))
        from django.core.mail import send_mail

        if True:
            send_mail('Confo Report', 'abhishek@tilde.sg',
                      from_email='abhishek@tilde.sg',
                      recipient_list=['abhi.pandey@gmail.com'], fail_silently=False,
                      html_message=p.html)
        return a
    else:
        if False:
            a = render(request, 'confo_report/conf_rpt.html', results)
            print('render = {}; {}'.format(type(a), a))
            print('str version = {}'.format(str(a.content)))

            content = a.content.decode('ascii', 'ignore')
            content = content.replace('"/STATIC', '"http://recon.tilde.sg/STATIC')
            from inlinestyler.utils import inline_css
            message_inline_css = inline_css(content)

            from django.core.mail import send_mail

            if True:
                send_mail('Confo Report', 'abhishek@tilde.sg',
                          from_email='abhishek@tilde.sg',
                          recipient_list=['abhi.pandey@gmail.com'], fail_silently=False,
                          html_message=message_inline_css)
            return a

{{< /highlight >}}
