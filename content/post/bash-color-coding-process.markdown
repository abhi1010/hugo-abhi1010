+++
date = "2016-02-09T17:00:59+08:00"
title = "Color your process listings"
tags = ["bash"]
categories = ["code"]
description = "How to make your variables stand out from values in bash for processes" 
keywords = ["bash", "process", "linux terminal", "terminal", "process colors"]
+++


Many a times I am grepping for a process that is running on a prod server with lots of different configuration
parameters. However, since there are so many of them, it is very difficult to view a particular parameter itself
and find out what value was assigned to it. I wanted to make it easier on the eyes and decided to color code the 
parameters and separate them out from the values. 
Here's the bash function I pulled out. 

```bash
colorme()
{
  gawk 'BEGIN {RS=" --| -"; }{print $0}' \
  | sed -e 's/\([[:alpha:]]\+\)=/\1 /g' \
  | gawk 'BEGIN    {printf "-----------------\n" ; }
            {
                if (NF > 2) printf "\n\033[41;5;1m%s\033[0m\n", $NF ;
                printf "\033[40;38;5;82m  %30s  \033[38;5;198m %s \033[0m \n", $1, $2
            }'
}
```

The idea is as follows:

- Have a bash function that can be piped onto any command; perhaps `ps -ef`
- Paragraph style viewing for each process
- Break down every parameter into separate lines using `gawk`
- Use `sed` to convert config params in the `--rate=10` into something like `rate 10`, just like others
- Use `gawk` again to add colors on every pair of `key value` line
- Keys are right aligned, green in color and values are right aligned, red in color so it's very easy to view


Here is a sample command I wanted to test out.

```bash
/opt/py27env/bin/python manage.py main-service-name --daemonize \
    --alias-svc=mainsvc01 --application-id=app03/mainsvc01 --monitoring-service-name=mainsvc01 \
    --log-level=DEBUG --solace-session-prop-host=server.prod --solace-session-prop-username=testing \
    --solace-session-prop-password=testing --solace-session-prop-vpn=testing \
    --solace-session-prop-cache-name=test_dc \
    --rate=10
```

Here is the result from my tests:
{{< figure src="/images/bash_process_color_coding_1.png" caption="Color coded process listing" >}}
