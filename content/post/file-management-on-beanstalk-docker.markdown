+++
categories = ["code", "continuous delivery"]
tags = ["docker", "nginx", "aws", "beanstalk"]
date = "2015-08-14T00:19:51+08:00"
title = "Sharing folders on Beanstalk Docker"
description = "How to share folders on Beanstalk Docker instance with EC2"
keywords = ["EC2", "folders", "beanstalk", "docker", "aws"]
+++

It is very easy to setup volume sharing in `docker`. You ideally want the following folders to be shared when a new `docker` is initialized for you:

- `/var/log` so that you can keep track of logs
- `nginx` specific folders because you will have two instances of `nginx` running - one on `docker` and another on `EC2`. This allows you to share logs
  - Also read [this post]({{< ref "post/nginx-upload-limits-on-beanstalk-docker.markdown" >}}) for related info
- your personal workspace or anything that you'd like to share 

Here's how you'd do it. The keyword is `VOLUME`... in your `Dockerfile`

{{< highlight python >}}
VOLUME [ \
    "/var/shared/", \ 
    "/etc/nginx/sites-enabled", \ 
    "/var/log/nginx", \
    "/ws/" \
]
{{< /highlight >}}

