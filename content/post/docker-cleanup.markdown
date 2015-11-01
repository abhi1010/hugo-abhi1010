+++
date = "2015-10-07T14:59:18-04:00"
title = "Forceful Docker Container cleanup on Elastic Beanstalk"
type = "post"
tags = ["aws", "beanstalk", "docker"]
categories = ["continuous delivery", "code"]
description = "How to delete the orphaned directories when normal docker commands don't work"
keywords = ["docker", "directories", "elastic", "elastic beanstalk"]
+++


***`Note`***: *_If you are not sure of what you are doing here, don't touch it. 
This is all sensitive stuff and a minor mistake can bring down your production._*


Sometimes, because of so many deployments happening and sharing volumes between dockers instances, the space runs out on production server. 

I found some ways to fix this but the most brutal way to leave the orphaned directories behind forever is to remove them. 
Such sadistic directories can be found at `/var/lib/docker/vfs/`.

We can automate the removal.

**First**, let's find the directories that we should ***`not`*** delete.

```bash
# These directories are in use
$ docker ps -q | xargs docker inspect | egrep "var.lib.docker.vfs"
```

You will see something like this:
```bash
$ docker ps -q | xargs docker inspect | egrep "var.lib.docker.vfs"
  "/etc/nginx/sites-enabled": "/var/lib/docker/vfs/dir/ed53e780472dbf5057780182bd12ae1cb7930fce73f5f7071bad1b456076dc95",
  "/var/log/nginx": "/var/lib/docker/vfs/dir/26c3ac02631b0eab5d6d3a4c5e6664b43974f217ca24b9369f3f12f186601147",
  "/ws": "/var/lib/docker/vfs/dir/ecd74d6b7e73c25d5e5f6b450a7b162bfb8e44c649c2af951843954538500dba"
```

# Fire Drill

**Find out all directories that should stay**

```bash
$ docker ps -q \
 | xargs docker inspect \
 | egrep "var.lib.docker.vfs" \
 | sed -e 's/.*dir.//g' -e 's/".*//g' \
 | sort \
 > /tmp/curr.dirs 
```

**Find out all directories within `/var/lib/docker/vfs/dir`**

```bash
$ sudo ls /var/lib/docker/vfs/dir/ | sort > /tmp/all.dirs
```

**Find out the directories from `all.dirs` that should be deleted (not in use by current docker instances)**

```bash
$ sdiff -s /tmp/all.dirs /tmp/curr.dirs
```



# Removing the directories for good

```bash
$ sdiff -s -w 300 /tmp/all.dirs /tmp/curr.dirs \
   | sed -e 's/. <//g' -e 's/^/\/var\/lib\/docker\/vfs\/dir\//g' \
   | xargs sudo  rm -rf 
```
