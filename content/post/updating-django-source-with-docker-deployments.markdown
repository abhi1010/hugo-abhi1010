+++
categories = ["code", "continuous delivery"]
tags = ["docker", "django"]
date = "2015-09-04T00:11:51+08:00"
description = ""
keywords = []
title = "updating django source with docker deployments"
draft = true
+++

While deploying docker multiple times, you may not want to copy over your `Django` source code every time you do a deployment.

## Setting up `supervisord`

Luckily there is an easy way to manage this. Since you are working with `Django`, there is a good chance that you are also managing the processes (like `uwsgi`) with `supervisord`.

Here are some of the steps that you can take with `supervisord`

- Set up a new process in `supervisord`
- Do not allow it to _`autorestart`_ since it will be a one-shot process
- Call another script in any format to update the source code
  - As an example, I use `bash` to update my source code through `git`

Here's a sample code:

{{< highlight bash >}}
    [program:source-updater]
    redirect_stderr=true
    stdout_logfile=/shared/source_code_updater.log
    directory = /ws/
    command = /ws/source_code_updater.sh
    autorestart=False
{{< /highlight >}}

## Updating the source code

Few things are important to note in a `docker` deployment:

- Not every commit needs to be deployed
- Filter your commits to only allow _deployable_ code to be updated on `docker`
- Include regression, unit and system tests to be part of your build process
- Once everything has been confirmed to be working, tag your code so that you know it is worthy of going to docker
- Another way would be to manage this process through branches and merge only if everything passes
- `docker` deployments would build off this merged branch or tagged version
- This way even if you have made 10 commits while fixing a bug and are still in the process of fixing it, you know it won't go to `docker` deployment

With that idea, do a checkout and update the source code according to specific tag:

{{< highlight bash >}}
    git checkout -f tags/your_tag_name
    git pull origin tags/your_tag_name
{{< /highlight >}}


