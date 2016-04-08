+++
categories = ["code"]
tags = ["bash"]
date = "2016-03-18T20:20:21+08:00"
description = "Use getopt or getopts"
keywords = ["getopt", "getopts", "bash", "linux"]
title = "getopt vs getopts"

+++
Should you use `getopt` or `getopts` in your bash scripts?

The answer can be a bit tricky but mostly straight forward.

## getopt

Generally, try to stay away from **getopt** for the following reasons:

- External utility 
- Traditional versions can't handle empty argument strings, or arguments with embedded whitespace
- For the loops to work perfectly, you must provide the values in the same sequence as the for loop itself; which is
very hard to control
- Mostly a way to standardize the parameters

The only time I could think of using _getopt_ is when I really want to use a long variable name and there's just a single one.

Here'a a sample for _getopt_

```bash
#!/bin/bash

#Check the number of arguments. If none are passed, print help and exit.
NUMARGS=$#
# echo -e \\n"Number of arguments: $NUMARGS"
if [ $NUMARGS -eq 0 ]; then
  HELP
fi

OPTS=`getopt -o vhns: --long verbose,dry-run,help,stack-size: -n 'parse-options' -- "$@"`

eval set -- "$OPTS"

while getopt dir:,env: FLAG; do
  case $FLAG in
    -dir)
      DIR=$OPTARG
      echo "-dir used: $OPTARG"
      ;;
    -env)
      PYENV=$OPTARG
      echo "-env used: $OPTARG"
      ;;
    h)  #show help
      HELP
      ;;
    \?) #unrecognized option - show help
      echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed."
      HELP
      ;;
  esac
done

shift $((OPTIND-1))  #This tells getopts to move on to the next argument.

```

## getopts

Whereas, **getopts** is:

- Portable and works in any POSIX shell
- Lenient with usage of "-a -b" as well as "-ab"
- Understands "--" as the option terminator

Here's a sample for _getopts_
```bash

SCRIPT=`basename ${BASH_SOURCE[0]}`

## Let's do some admin work to find out the variables to be used here
BOLD='\e[1;31m'         # Bold Red
REV='\e[1;32m'       # Bold Green

#Help function
function HELP {
  echo -e "${REV}Basic usage:${OFF} ${BOLD}$SCRIPT -d helloworld ${OFF}"\\n
  echo -e "${REV}The following switches are recognized. $OFF "
  echo -e "${REV}-p ${OFF}  --Sets the environment to use for installing python ${OFF}. Default is ${BOLD} /usr/bin ${OFF}"
  echo -e "${REV}-d ${OFF}  --Sets the directory whose virtualenv is to be setup. Default is ${BOLD} local folder (.) ${OFF}"
  echo -e "${REV}-v ${OFF}  --Sets the python version that you want to install. Default is ${BOLD} 2.7 ${OFF}"
  echo -e "${REV}-h${OFF}  --Displays this help message. No further functions are performed."\\n
  echo -e "Example: ${BOLD}$SCRIPT -d helloworld -p /opt/py27env/bin -v 2.7 ${OFF}"\\n
  exit 1
}

PYENV='/usr/bin'
DIR='.'
VERSION='2.7'

# In case you wanted to check what variables were passed
# echo "flags = $*"

while getopts p:d:v:h FLAG; do
  case $FLAG in
    d)
      DIR=$OPTARG
      ;;
    p)
      PYENV=$OPTARG
      ;;
    v)
      VERSION=$OPTARG
      ;;
    h)
      HELP
      ;;
    \?) #unrecognized option - show help
      echo -e \\n"Option -${BOLD}$OPTARG${OFF} not allowed."
      HELP
      ;;
  esac
done
``` 
 
## What if I really wanted long options with _getopts_? 

_getopts_ function can be used to parse long options by putting a dash character followed by a colon into the OPTSPEC. 
Sharing [the solution from this link](http://stackoverflow.com/a/7680682/142650).


```bash
#!/usr/bin/env bash 
OPTSPEC=":hv-:"
while getopts "$OPTSPEC" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                loglevel)
                    val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
                    ;;
                loglevel=*)
                    val=${OPTARG#*=}
                    opt=${OPTARG%=$val}
                    echo "Parsing option: '--${opt}', value: '${val}'" >&2
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${OPTSPEC:0:1}" != ":" ]; then
                        echo "Unknown option --${OPTARG}" >&2
                    fi
                    ;;
            esac;;
        h)
            echo "usage: $0 [-v] [--loglevel[=]<value>]" >&2
            exit 2
            ;;
        v)
            echo "Parsing option: '-${optchar}'" >&2
            ;;
        *)
            if [ "$OPTERR" != 1 ] || [ "${OPTSPEC:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
            fi
            ;;
    esac
done
 ```