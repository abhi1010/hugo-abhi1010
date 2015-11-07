+++
date = "2015-08-07T14:59:18-04:00"
title = "Convert GitHub Wiki to Static Site with themes"
type = "post"
tags = ["github", "wiki", "pelican"]
categories = ["tips", "code"]
description = "How to convert any wiki to a static html site using Pelican"
keywords = ["github", "wiki", "pelican", "tips", "gitlab", "hugo"]
+++

I recently wanted to setup a wiki so that I could convert it into a static html site with a proper themes.
What could be a possible use case for such a requirement:

- Manage the documentation of a product internally through `git` but publish it for clients/world through static site
- Convert the uncolored wiki to a themed version
- Allow serving of the wiki through web application frameworks like `Django`
  - It may allow you to have authentication system as a first step hurdle to stop everybody from giving access

Anyways, I went about the whole process and decided to jot down everything. Here I am taking [D3 Wiki](https://github.com/mbostock/d3/wiki) as an example 
which I will be converting into a static site. Let's begin. 

{{< figure src="/images/wiki_to_static_1.png" caption="D3 Wiki using pelican" >}}

# Setup and requirements

What do we need to get started?

- We will need a static site generator 
    - Let's use [`pelican`](http://blog.getpelican.com) for this demo
- An actual wiki
    - Since we are going to demo how to convert a wiki to static we will use an 
    [existing wiki from github](https://github.com/showcases/projects-with-great-wikis)
    - Let's choose [D3 Wiki](https://github.com/mbostock/d3/wiki) for this instance
- Python environment so that _pelican_ and _fabric_ can be installed


## Virtual Environment with pelican

**Setup the virtual environment**
```bash
$ virtualenv ve_blog
$ source ve_blog/bin/activate
```



**Install pelican**

    $ pip install pelican

**Pelican Quickstart**

Setup pelican using `pelican-quickstart` so that all files are setup correctly for creating a static site.

```bash
$ pelican-quickstart

Welcome to pelican-quickstart v3.6.3.

This script will help you create a new Pelican-based website.

Please answer the following questions so this script can generate the files
needed by Pelican.

    
> Where do you want to create your new web site? [.] 
> What will be the title of this web site? D3 WIKI
> Who will be the author of this web site? abhi1010
> What will be the default language of this web site? [en] 
> Do you want to specify a URL prefix? e.g., http://example.com   (Y/n) n
> Do you want to enable article pagination? (Y/n) Y
> How many articles per page do you want? [10] 
> What is your time zone? [Europe/Paris] Asia/Singapore
> Do you want to generate a Fabfile/Makefile to automate generation and publishing? (Y/n) Y
> Do you want an auto-reload & simpleHTTP script to assist with theme and site development? (Y/n) Y
> Do you want to upload your website using FTP? (y/N) N
> Do you want to upload your website using SSH? (y/N) N
> Do you want to upload your website using Dropbox? (y/N) N
> Do you want to upload your website using S3? (y/N) N
> Do you want to upload your website using Rackspace Cloud Files? (y/N) N
> Do you want to upload your website using GitHub Pages? (y/N) N
Done. Your new project is available at /Users/apandey/code/githubs/d3wiki
```


## Get the wiki


```bash
$ git clone https://github.com/mbostock/d3.wiki.git

Cloning into 'd3.wiki'...
remote: Counting objects: 12026, done.
remote: Compressing objects: 100% (67/67), done.
remote: Total 12026 (delta 607), reused 552 (delta 552), pack-reused 11407
Receiving objects: 100% (12026/12026), 9.92 MiB | 1.49 MiB/s, done.
Resolving deltas: 100% (7595/7595), done.
Checking connectivity... done.
```

**Setting the wiki as content for pelican**

```bash
$ rmdir content
$ ln -s dr.wiki content
```

# Why simple pelican won't work and what to do

If you tried to simply call `pelican` command to build the static site, you will notice a lot of errors like:
 
```bash

$ fab build

RROR: Skipping ./请求.md: could not find information about 'NameError: title'
ERROR: Skipping ./过渡.md: could not find information about 'NameError: title'
ERROR: Skipping ./选择器.md: could not find information about 'NameError: title'
ERROR: Skipping ./选择集.md: could not find information about 'NameError: title'
Done: Processed 0 articles, 0 drafts, 0 pages and 0 hidden pages in 3.47 seconds.
```

The problem is that pelican expects some variables to be defined in each _markdown_ file before it can build the static file.
 Some of the variables are:
 
 - Title
 - Slug
 - Date
 
You may add your own [ones as well](http://docs.getpelican.com/en/3.6.3/content.html#file-metadata) that you want.
 However, for our initial purposes, we will keep it simple and just try to add these.
 
**Next**, how do we achieve this automation?
**`fab` is our answer.**

Let's write a function in python that will modify the markdown files and update them to add _Title, Slug, Date_

We will edit `fabfile.py` and add a new function `create_wiki`:


```
def create_wiki():
    files = []
    # Find all markdown files in content folder 
    for f in os.walk('./content/'):
        fpath = lambda x: os.path.join(f[0], x)
        for file in f[2]:
            fullpath = fpath(file)
            # print('f = {}'.format(fullpath))
            files.append(fullpath)
    filtered = [f for f in files if f.endswith('.md')]
    for file in filtered:
        with open(file, 'r+') as f:
            content = f.read()
            f.seek(0, 0)
            base = os.path.basename(file).replace('.md', '') 
            lines = ['Title: {}'.format(base.replace('-', ' ')),
                    'Slug: {}'.format(base),
                    'Date: 2015-08-07T14:59:18-04:00',
                    '', '']
            line = '\n'.join(lines)
            # Add the lines to the file
            f.write(line + '\n' + content)
        print(file)
    
    # build and serve the website
    build()
    serve()
```

Now you can call this function easily:

    fab create_wiki

The website can now be viewed at [http://localhost:8000](http://localhost:8000)

# What happened to the menu?

There is a minor issue here though, you will notice that the menu is not available - it is all empty.
It is an easy addition. We will need to add some lines to `publishconf.py` to say what the menu is gonna be.

For my example, I have chosen to show up the following for _D3_:

- API Reference
- Tutorials
- Plugins


```python
# We don't want all pages to show up in menu
DISPLAY_PAGES_ON_MENU = False

# Choose the specific pages that should be part of menu
MENUITEMS = ( 
    ('HOME', '/home.html'),
    ('API Reference', '/API-Reference.html'),
    ('Tutorials', '/Tutorials.html'),
    ('Plugins', '/Plugins.html'),
)
```

# Choosing themes

By default, pelican uses its own theme for the static site, but theme can be modified.
Let's choose `pelican bootstrap3` for our example here:
    
    git clone https://github.com/DandyDev/pelican-bootstrap3.git

Now, add the full path to the theme at the end of the `publishconf.py` file:

    THEME = "/Users/apandey/code/githubs/pelican_coders/all_themes/pelican-bootstrap3"

Finally, build your site again and serve:

    fab build
    fab serve


{{< figure src="/images/wiki_to_static_2.png" caption="Pelican Bootstrap3 theme" >}}

# Get all this code in github repo

I realize there maybe a few things going on here. You can get this whole setup as a project from 
my [github repo](https://github.com/abhi1010/d3wiki)

You will find all this code and setup so that your life is easier. Just start with d3 wiki along with virtual environment and you will be fine.
