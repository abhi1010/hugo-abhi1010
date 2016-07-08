+++
categories = ["code", "continuous delivery", "tips"]
tags = ["python"]
date = "2016-07-05T23:26:44+08:00"
description = "Gitlab CLI API reference"
keywords = ["gitlab", "gitlab api", "gitlab cli", "python"]
title = "Gitlab CLI API reference"

+++

Here's a short tutorial on setting up gitlab cli for yourselves. 
It is extremely user friendly and you can take almost any action that you need.
Anything that the UI provides is also available over cli or web services -
both of which have examples here. 

Let's get started.

## gitlab cli

### Installing the gitlab CLI

    # http://narkoz.github.io/gitlab/configuration
    gem install gitlab

### Configuration

```bash
export GITLAB_API_ENDPOINT='http://gitlab.com/api/v3'
export GITLAB_API_PRIVATE_TOKEN='YOUR_TOKEN_'
```

### Available commands

```bash
$ gitlab
+-----------------+
|   Help Topics   |
+-----------------+
| Branches        |
+-----------------+
| Commits         |
+-----------------+
| Groups          |
+-----------------+
| Issues          |
+-----------------+
| Labels          |
+-----------------+
| MergeRequests   |
+-----------------+
| Milestones      |
+-----------------+
| Namespaces      |
+-----------------+
| Notes           |
+-----------------+
| Projects        |
+-----------------+
| Repositories    |
+-----------------+
| RepositoryFiles |
+-----------------+
| Snippets        |
+-----------------+
| SystemHooks     |
+-----------------+
| Users           |
+-----------------+
```



### Sample CLI commands

```bash
# Check the list of Projects
$ gitlab projects

# Based on the response, we know reconwisev2 is ID 487928
# Let's find out the list of labels in it
$ gitlab labels 487928
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
|                                                      Gitlab.labels 487928                                                      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| closed_issues_count | color   | description        | name         | open_issues_count | open_merge_requests_count | subscribed |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 2                   | #ff0000 | null               | !Blocker     | 0                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 2                   | #0033cc | null               | #AWS         | 8                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 27                  | #428bca | null               | #Bug         | 2                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 3                   | #0033cc | null               | #Feature     | 29                | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 7                   | #5843ad | null               | #Improvement | 22                | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 1                   | #428bca |                    | #Support     | 1                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 28                  | #f0ad4e | null               | $GH          | 12                | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 0                   | #f0ad4e |                    | $IFAST       | 4                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 25                  | #ff0000 | null               | 1-Critical   | 7                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 2                   | #ad4363 | null               | 2-Important  | 20                | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 5                   | #ad4363 | null               | 3-Normal     | 18                | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 2                   | #d491a5 |                    | 4-Trivial    | 6                 | 0                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 0                   | #a8d695 | null               | ^In-Progress | 3                 | 1                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
| 0                   | #69d100 | Completed/Finished | ^Resolved    | 0                 | 1                         | false      |
+---------------------+---------+--------------------+--------------+-------------------+---------------------------+------------+
```

### Sample CURL commands


**Check the list of Projects**

    https://gitlab.com/api/v3/projects/?private_token=YOUR_TOKEN

This will return you a big JSON with the list of your projects in gitlab.

Based on the response, we know that the project is ID 487928
Let's find out the list of labels in it.

    https://gitlab.com/api/v3/projects/487928/labels/?private_token=YOUR_TOKEN

The response is a bit like this:

```json
[

    {
        "name": "!Blocker",
        "color": "#ff0000",
        "description": null,
        "open_issues_count": 0,
        "closed_issues_count": 2,
        "open_merge_requests_count": 0,
        "subscribed": false
    },
    {
        "name": "#AWS",
        "color": "#0033cc",
        "description": null,
        "open_issues_count": 8,
        "closed_issues_count": 2,
        "open_merge_requests_count": 0,
        "subscribed": false
    },
    {
        "name": "#Bug",
        "color": "#428bca",
        "description": null,
        "open_issues_count": 2,
        "closed_issues_count": 27,
        "open_merge_requests_count": 0,
        "subscribed": false
    },
    ....
```

More documentation is available [here](https://github.com/gitlabhq/gitlabhq/tree/master/doc/api)
