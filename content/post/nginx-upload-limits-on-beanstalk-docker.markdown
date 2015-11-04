+++
categories = ["code", "continuous delivery"]
tags = ["nginx", "beanstalk", "docker"]
date = "2015-09-04T00:14:35+08:00"
title = "Nginx Upload limits on Beanstalk Docker"
description = "How to modify nginx settings on aws beanstalk docker"
keywords = ["aws", "beanstalk", "docker", "nginx"]
+++

If I am not wrong, `nginx` only allows you to upload up till max 2Mb of data by default. If you are doing a `docker` deployment on `beanstalk` you may to remember to change that not once but twice!

As you may know already, `beanstalk` creates an `EC2` instance to manage the `docker` environment.  
Since `EC2` needs to manage the `docker` environment and serve the web interface as well, it does so by having another `nginx` instance to serve the `nginx` within `docker`.
Hence, if you had to modify the `nginx` settings to allow bigger uploads, **you'd have to modify the settings for `nginx` on both - `docker` as well as `EC2`**.

{{< highlight python >}}
    # max upload size
    client_max_body_size 10M;   # adjust to your liking
{{< /highlight >}}

Also, if you don't want to have any limit at all for uploads, then just change the `client_max_body_size` to 0.

{{< highlight python >}}
    # max upload size
    client_max_body_size 0;
{{< /highlight >}}
