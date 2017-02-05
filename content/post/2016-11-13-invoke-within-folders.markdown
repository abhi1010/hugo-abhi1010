+++
description = "Running invoke from other folders"
title = "Running invoke from other folders"
date = "2016-11-13T00:33:29+08:00"
categories = ["code"]
keywords = ["invoke", "python", "pyinvoke", "python", "invoke"]
tags = ["tips", "python"]
+++

While working on big projects, sometimes, you have `invoke` tasks lying around 
in different places. It wouldn't make sense to merge them together 
but rather help each other out as and when needed. 

One such way for this would be to search for invoke tasks from other folders
and run them directly when they can be used.

I had to go for this approach for a monolithic repo where multiple projects 
were being built in mostly similar style with minor modifications.
All of them would have the same set of commands along with same style of running those commands.
I didn't want to set up the same `invoke` task for all individual projects but rather
a common set of tasks that could be re-used by each one of them. 


Hence, here's what I did:

1. I knew for a fact that most sub-projects needed the same command to build themselves. 
I didn't want to use the same command over and over again in each of the projects. 
I would rather use the command in the general space and override it only when a sub-project
 requires a special version of the build command.
2. When the general `invoke` was called to do any task, it would first check
whether, the sub-project for which the command was to run, the command was already
available for the given sub-project itself.
  - If yes, this would mean that sub-project intends to 
override the default command in it's own style
  - If no, then the default version is to run

_Here's the simplilfied version of the code._

```python
import subproces
import os

@contextmanager
def cd(path):
    old = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(old)


@task
def build():
    folder_to_run_the_command_on = '/home/folder'
    with cd(folder_to_run_the_command_on):
        print('Finding tasks...')
        # List all the possible commands that you can run on that folder
        res = subprocess.check_output(['invoke', '-l'])
        # does it contain this command that we need to run?
        if 'build'  in res:
            print('Found the build command in "{}" folder'.format(folder_to_run_the_command_on)
            run('invoke build')
        else:
            # we need to run the generic version of build command
            build_internal()
```


