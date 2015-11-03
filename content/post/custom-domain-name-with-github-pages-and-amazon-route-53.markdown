+++
date = "2015-10-24T14:59:18-04:00"
title = "Setting up custom domain with Github Pages"
type = "post"
tags = ["aws", "route 53", "github"]
categories = ["continuous delivery", "code"]
description = "How to use AWS Route 53 to setup your custom domain for Github pages blog"
keywords = ["aws", "blog domain", "github", "route 53 domain", "custom github domain", "CNAME"]
+++

Let's take the example of my domain itself `abhipandey.com` that I want to serve from `abhi1010.github.io`. 
 We will need to do it in two steps:
 
 - Setup CNAME on github
    - So that github knows about your domain
 - Setup **A** record on AWS Route 53
    - So that domain can be registered
 
# Change CNAME


If we want to tell github about the domain name, it is rather simple: *create a CNAME file with the content being 
the name of the domain itself*
Do *note* here that the default redirect of your domain will be the value in your CNAME file.
 
Here's my [CNAME file](https://github.com/abhi1010/abhi1010.github.io/blob/master/CNAME) content:
 
    abhipandey.com

You don't really need **www**. If you do put _www.abhipandey.com_ github will figure out and redirect properly. 
The difference is abhipandey.com is a top-level domain (TLD), while _www.abhipandey.com_ is a subdomain.


Essentially:

> If your CNAME file contains _abhipandey.com_, then _www.abhipandey.com_ will redirect to _abhipandey.com_.

> If your CNAME file contains _www.abhipandey.com_, then _abhipandey.com_ will redirect to _www.abhipandey.com_.


# Creating A Record

{{< figure src="/images/custom-domain-name-with-github-pages-and-amazon-route-53_1.png" caption="Setting up A record" >}}

Next is to go to Amazon Route 53 console, and create an A record with the following IPs:

    192.30.252.153
    192.30.252.154


# Setup subdomain

{{< figure src="/images/custom-domain-name-with-github-pages-and-amazon-route-53_2.png" caption="Setting up subdomain" >}}

If you configure both an apex domain (e.g. _abhipandey.com_) and a matching www subdomain (e.g. _www.abhipandey.com_), 
GitHub's servers will automatically create redirects between the two.

You can also also look up [GitHub Tips](https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider/) for 
configuring an **A** record with your DNS provider.




