+++
categories = ["continuous delivery"]
tags = ["docker", "python", "deployment", "supervisord"]
date = "2015-09-03T22:33:33+08:00"
description = "How to allow multiple projects to use their own separate pythong virtual environments"
title = "Multiple Virtual Environments in Docker"
keywords = ["docker", "python", "deployment", "supervisord"]
+++

It may seem like a daunting task to have multiple python projects running in their own virtual environments in docker as you want to manage the running of the tasks from a single source - let's say `supervisord`.
However, all that is required here is to know that python automatically picks up the location of the virtual environments if you provide full path to the virtual environment's python.
 
For example, in my docker environment, I have virtual environment install at the following location:

    /ws/ve_envs/rwv1/
    
To enable a project with this virtual environment, I can run the following:

    /ws/ve_envs/rwv1/bin/python3.4 PYTHON_PROJECT_FILE_TO_RUN.py

Similarly, other projects can be set up in the same way. 

For example, for running `uwsgi` I provide the full path for python as follows:

{{< highlight bash >}}
[program:appName]
stdout_logfile = /var/shared/_uwsgi.log
command = /ws/ve_envs/project/bin/uwsgi --touch-reload=/ws/wsgi.ini --ini /ws/wsgi.ini
{{< /highlight >}}

You might want to read about `--touch-reload` in my [other post.]({{< ref "post/updating-django-source-with-docker-deployments.markdown" >}})