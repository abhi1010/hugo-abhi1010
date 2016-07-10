+++
categories = ["code", "tips"]
date = "2016-06-22T21:17:56+08:00"
description = "How to manage and share TODOs in Fedora"
keywords = ["fedora", "todo", "aha", "bash", "python", "invoke"]
tags = ["bash", "tips", "python"]
title = "Using TODO in Fedora"

+++

I recently started using Fedora for work and had to manage a lot of tasks on various projects.
The list was big enough and there's no proper support for Evernote in linux, my trusty todo list manager
or ToDo list manager by AbstractSpoon. Decided to try post-it notes but my list was changing on an 
ad-hoc basis. Finally came across an [extension Todo.txt](https://extensions.gnome.org/extension/570/todotxt/). 

Turned out this was just what I was looking for. I started putting all of my tasks in it, with proper categorization.
Behind the scenes it is an extremely simple app which has only two files, both saved in `~/.local/share/todo.txt/` folder.
 
 - done.txt
 - todo.txt
 
The tasks are initially put as simple text in **todo.txt** and are moved to **done.txt** once marked complete.
It is extremely useful that todo.txt app has UI as well as the files which are user friendly.

## Finding tasks completed in the last week

During weekly meetings I found it difficult to mention all the tasks that
I had been working on for the whole of the previous week. Thinking about todo
tasks, I thought of using a bash script to print out the tasks from the last 
 8 days. After all, the files did contain a whole long list of tasks.

Here was the idea that I had in mind:

- Read **done.txt** and **todo.txt**
- Highlight the tasks differently from both files so it's easy to
 see what has been completed already
  - Chose green color for done and red for todo
- Highlight the categories differently - chose yellow
- Show all the tasks completed in the last 8 days
  - Also provide the option to chose any number of days
  - Helps on those days when I wanna see more than 8 days
- Show all the tasks in todo

Here's the script for that:

```bash
todos()
{
    TODOFILE=~/.local/share/todo.txt/todo.txt
    DONEFILE=~/.local/share/todo.txt/done.txt
    # echo $TODOFILE
    # echo $DONEFILE "\n"

    lastXdays()
    {
        search()•
        {
            DAY=$1
            cat $TODOFILE | GREP_COLOR="1;31" grep --color=always ' [a-Z[].*' | GREP_COLOR="3;33" grep --color=always  "\+.*"
            egrep $(date '+%Y-%m-%d' --date=$DAY' days ago') $DONEFILE | GREP_COLOR="1;32" grep --color=always ' [a-Z].*' | GREP_COLOR="03;33" grep --color=always  "\+.*"
        }
        END=$1
        for i in $(seq 0 $END)
            do
                search $i
            done

    }
    # First arg, if given, or default value of 8
    DAYS=${1:-8}
    lastXdays $DAYS | sort -u
}
```


Now, when I run this command, it gives me the following:

{{< figure src="/images/todo-in-fedora.png" caption="My TODOs" >}}
 

## Sharing the tasks

I work with different teams which means sharing with them the latest updates 
on different days of the week. I used to run my `todos` command on bash
before going for the meeting but I realized this was getting very mundane and 
I was spending a lot of time remembering the tasks I had done. 

I decided to make it easy by sharing the tasks with the rest of the team
automatically. Enter `crontab` and _python's_ `invoke`.

Here are the steps we will need:

1. Setup cronjob
2. Cron job will call upon a bash script
3. Bash script will call _python_'s invoke
  * Here we call upon a bash script to provide us the results of `todos`
  in bash and then use that to send an email based on the `--mailgroup`
4. Simply taking the output of `todos` in _bash_ will give us a lot of
unreadable characters. Especially the ones where we try and color code
 the response so it's easy on the eyes - **3;33**
5. You can install `aha` to convert the ANSI terminal colors to html color
 codes. This way when we mail the contents to team members, it will display
 properly.

### crontab


```bash
45 09 * * 1 /usr/bin/bash /PATH_TO_BASH_SCRIPT/crons.sh --mailgroup=<TEAM_MAIL>
```

### crons.sh

The `crons.sh` itself is really simple, which calls upon the `invoke` task:

```bash
# ----- crons.sh --------
# Activate the virtual env
source ~/code/venvs/ve_opt/bin/activate

# Go to the directory containing the invoke script
cd ~/code/scripts/

# Run the invoke, pass the cmd line params, as is (which means mailgroup)
inv share_todos $*
```

### tasks.py

Now it is time for contents of `invoke`'s **tasks.py**. 
We want to ensure that the font is big enough. 

```python
@task
def share_todos(mailgroup):
    process_out = subprocess.check_output(['/FULL_PATH_TO/_htmltodos.sh'])\
        .replace('<body>',
                 '<body style="font-weight:900; font-size:1.3em;">')
    mail(
        process_out,
        "My todos @ {}".format(datetime.datetime.now().strftime('%c')),
        mailgroup
```


### _htmltodos.sh

We will use `aha` to convert the ANSI terminal colors to html color codes.
Also, we will replace some color codes that `aha` creates because 
it is not really nice looking. 

```bash
#!/usr/bin/bash
source ~/.bashrc

todos | /usr/local/bin/aha | sed -e 's/color:olive/color:DeepSkyBlue; font-style:italic;/g' -e 's/color:green;/color:LimeGreen;/g' -e 's/<pre>/<pre style="color:gray;">/g'
exit 0
```

### The result


{{< figure src="/images/todo-in-email.png" caption="The email look" >}}
 