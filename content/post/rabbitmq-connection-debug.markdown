+++
categories = []
date = "2015-10-07T23:26:53+08:00"
description = "Disk free space insufficient on rabbitmq"
keywords = ["rabbitmq", "disk space"]
title = "rabbitmq connection debug"
draft = "true"
+++


I was getting a lot of problems with `rabbitmq` 

=INFO REPORT==== 7-Oct-2015::23:16:34 ===
Disk free space insufficient. Free bytes:730202112 Limit:1000000000

=WARNING REPORT==== 7-Oct-2015::23:16:34 ===
disk resource limit alarm set on node 'rabbit@dev02-ws'.

**********************************************************
*** Publishers will be blocked until this alarm clears ***
**********************************************************



 [x] Received 'Hello World!'
 [*] Waiting for messages. To exit press CTRL+C
 [x] Received 'Hello World!'

/var/log/rabbitmq/rabbit@dev02-ws.log



