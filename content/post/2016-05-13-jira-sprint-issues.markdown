+++
tags = ["jira", "python"]
categories = ["code", "tips"]
date = "2016-05-13T21:17:56+08:00"
description = "Getting all types of issues from JIRA"
keywords = ["jira", "atlassian", "python", "sprint", "agile"]
title = "Getting list of Issues from JIRA under current sprint"

+++

When you are working on _Agile Boards in JIRA_, you may want to retrieve 
all the issues related to a particular board or the sprint. 
Usually you'd find issues in progress under the dashboard of the sprint itself.
 
_Python JIRA_ allows you only a few options:

- [incompleted issues](https://jira.readthedocs.io/en/latest/api.html#jira.JIRA.incompleted_issues)
- [completed issues](https://jira.readthedocs.io/en/latest/api.html#jira.JIRA.completed_issues)
- [removed issues](https://jira.readthedocs.io/en/latest/api.html#jira.JIRA.removed_issues)

As you will also notice from [jira docs](https://jira.readthedocs.io/en/latest/api.html#jira.JIRA.sprints) 
the `sprints` function in there only provides you sprints.

What it fails to provide is the issues under the sprint 
for which work through a different subquery under the hood.

The code here intends to provide a full list of all the issues, based on 
a sprint name - complete or incomplete - that belong to a given sprint name. 
You can modify the code easily to suit your needs.

## Requirements

First things first, you need to install jira through `pypi` for the code.

    pip install jira

## The code

```python
from jira.resources import Issue
from jira.client import JIRA

def sprints(username, 
            ldp_password,
            sprint_name,
            type_of_issues_to_pull=[
                  'completedIssues', 
                  'incompletedIssues',
                  'issuesNotCompletedInCurrentSprint',
                  'issuesCompletedInAnotherSprint']):
    def sprint_issues(cls, board_id, sprint_id):
        r_json = cls._get_json(
            'rapid/charts/sprintreport?rapidViewId=%s&sprintId=%s' % (
                board_id, sprint_id),
            base=cls.AGILE_BASE_URL)

        issues = []
        for t in type_of_issues_to_pull:
            if t in r_json['contents']:
                issues += [Issue(cls._options, cls._session, raw_issues_json)
                           for raw_issues_json in
                           r_json['contents'][t]]
        return {x.key: x for x in issues}.values()

    fmt_full = 'Sprint: {} \n\nIssues:{}'
    fmt_issues = '\n- {}: {}'
    issues_str = ''
    milestone_str = ''

    options = {
        'server': 'http://jira/',
        'verify': True,
        'basic_auth': (username, ldp_password),
    }
    gh = JIRA(options=options, basic_auth=(username, ldp_password))

    # Get all boards viewable by anonymous users.
    boards = gh.boards()
    board = [b for b in boards if b.name == sprint_name][0]

    sprints = gh.sprints(board.id)

    for sprint in sorted([s for s in sprints
                   if s.raw[u'state'] == u'ACTIVE'],
                key = lambda x: x.raw[u'sequence']):
        milestone_str = str(sprint)
        issues = sprint_issues(gh, board.id, sprint.id)
        for issue in issues:
            issues_str += fmt_issues.format(issue.key, issue.summary)

    result = fmt_full.format(
        milestone_str,
        issues_str
    )
    print(result)
    return result

```
You can call the function with the following command:

    sprints(<username>, <password>, <sprint_name>)

You will get results that are similar to the following:

> ```
Sprint: SPRINT_NAME

Issues:
- PROJECT-437: Description of the issue
- PROJECT-447: Description of the issue
```
