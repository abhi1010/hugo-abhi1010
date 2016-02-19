+++
date = "2016-02-04 15:02:07+00:00"
title = "How to setup a local pypi mirror"
type = "post"
tags = ["pip", "python"]
categories = ["code"]
description = "How to setup a local pypi mirror with quick installation"
keywords = ["python", "pip", "pypi"]
+++
It is quite easy to set up a local pypi server.

Some details can be found [here](https://pip.pypa.io/en/latest/user_guide/#installing-from-local-packages).
You can also use [devpi](http://doc.devpi.net/latest/quickstart-pypimirror.html) if you prefer but it 
seems overly complicated for a job that is easily achieved by pip.  

Let's look at how to use `pip` for local installation.
Firstly, it is possible to install all requirements beforehand in a separate directory. 
 We can use the following commands:

```bash
pip install --download DIR -r requirements.txt
```

If you prefer wheel, then use the following:

```bash
pip wheel --wheel-dir DIR -r requirements.txt
```

Now, when we want to install from this given directory `DIR`, then 
the following command can help:
```bash
pip install --no-index --find-links=DIR -r requirements.txt
```

If you are using these in a current setup and you feel it still slows you down then the reason would be 
one of the first few commands where the request is still going to the internet. 
If you want to speed up the whole process then perhaps you need to send out a request to the internet
only if a new package is available in the requirements.txt file otherwise you can skip that part altogether,
just leading onto `pip install --no-index`

This will make your installation a flash.

One quick and dirty way to maintain a local copy of requirements.txt file and figure out on every commit of code change
in the project, whether a new requirement has been added to that list. In that case, install it + update your local copy.

Here's a sample code to put all changes in a single line that you can feed into `pip install`
```bash
sdiff -s /tmp/1 /tmp/2 | sed -e 's/<//g' | awk 'BEGIN {ORS=" "} {print $1}'
```
Breaking it down:

- `sdiff` checks if there are any new changes
- `sed` ensures that you only get the relevant characters, not `<` or `>`
  - If you want you can put an `egrep` before `sed` to get only one side of the changes
- `awk` puts all the lines together into a space separated values that can be fed into `pip install`
