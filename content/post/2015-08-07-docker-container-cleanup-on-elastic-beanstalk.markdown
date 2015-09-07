+++
date = "2015-08-07T14:59:18-04:00"
title = "Docker Container cleanup on Elastic Beanstalk"
type = "post"
tags = ["aws", "beanstalk", "docker"]
categories = ["Linux"]
+++


Sometimes you may notice that old containers are not cleaned up from Beanstalk environment. This may be due to your container still running as a ghost on the background. One way to find out about this is to quickly look into your
`/var/lib/docker/vfs/dir` directory whether it has too many folders.

Next, find out what container processes you have going on.
`[root@ip dir]# docker ps -a`

You might see something like this:

    
{{< highlight bash >}}
    CONTAINER ID        IMAGE                              COMMAND             CREATED             STATUS              PORTS               NAMES
    1611e5ebe2c0        aws_beanstalk/staging-app:latest   "supervisord -n"    About an hour ago                                           boring_galileo
    e59d0dd8bba1        aws_beanstalk/staging-app:latest   "supervisord -n"    About an hour ago                                           desperate_yalow
    3844d0e18c47        aws_beanstalk/staging-app:latest   "supervisord -n"    2 hours ago         Up 8 minutes        80/tcp              pensive_jang
{{< /highlight >}}

Ideally, we want to "forcibly remove" all images (and hence the folders from `/var/lib/docker/vfs/dir` directory) that are not in use anymore.
Just run the following to test whether it works:

{{< highlight bash >}}
    docker rmi -f `docker images -aq`
{{< /highlight >}}

You might run into trouble where docker says that all those images already have a container that is running them. This means those container are orphaned but not killed as we thought them to be. Let's remove the shared volumes if any, for each one of them.

{{< highlight bash >}}
    docker rm -fv `docker ps -aq` 
{{< /highlight >}}


    docker rm -fv `docker ps -aq`
    

This will
	
  * kill the container
  * unlink the volumes


You should see a lot more space now on your beanstalk instance.
{{< highlight bash >}}
    [root@ip dir]# df -h
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/xvda1      7.8G  1.8G  5.9G  24% /
    devtmpfs        490M   96K  490M   1% /dev
    tmpfs           499M     0  499M   0% /dev/shm
{{< /highlight >}}
