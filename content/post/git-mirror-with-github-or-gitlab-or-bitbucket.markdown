+++
categories = []
date = "2015-09-27T13:30:10+08:00"
description = ""
categories = ["continuous delivery", "code"]
tags = ["aws", "beanstalk", "deployment", "git"]
title = "Automated Git Mirror With GitHub or Gitlab or Bitbucket"
+++

# Experience with Gitlab CI

{{< figure src="/images/git_mirror_with_gitlab__ci.png" caption="Git Mirror from Gitlab to Bitbucket using Gitlab CI" >}}

Had to move from `BitBucket` to `Gitlab` which is really great, btw. However, there was one tiny issue here - `Gitlab` was not supported by `Shippable`.
As you may know already `Shippable` is a hosted cloud platform that provides hosted continuous integration. 
We use it in our current setup to do a full testing and deployment onto `AWS Elastic Beanstalk`.
  
Since we were moving to `Gitlab` I wanted to continue using `Shippable` for our prod deployments. `Shippable` only supports `Github` or `Bitbucket` and therein lies the problem.
`Gitlab` did not work with `Circl CI` or `Travis CI` or `Shippable` or `Wercker` so I tried using `Gitlab CI`. 

However, there were some issues with it:

- Runs the tasks as standalone but are not part of a `Docker` process
  - This means `Gitlab CI` does not work similar to `Circl CI` or `Travis CI` or `Shippable` or `Wercker`
- Sometimes CI takes long to be triggered even though it registers you to be running right after your commit
- The terms are a bit different compared to the other cloud based continuous integration sites
  - `Gitlab CI` supposedly tries to improve upon other tools but in the process ensures that you need to learn CI again if you want to use them

I tried using the same yaml was `Shippable` but it was just not working with too many errors being reported and not to mention, having to wait for an hour during the worst period to see results. 
`Shippable` on the other hand, would hand over the console and results within 5 minutes of my commits. Decided to ditch `Gitlab CI`.


# Using Git Mirror

Since `Gitlab CI` was clearing not working I decided to continue using `Shippable`. The only issue was, code had to exist in `Bitbucket`.
 For that, I needed a git mirror from `Gitlab` to `Bitbucket`. Looking into docs I found this link - [http://docs.shippable.com/using_gitlab/](http://docs.shippable.com/using_gitlab/).
 Other options mentioned setting up configs to add a mirror. For example, look here:
 
 - [http://stackoverflow.com/questions/21551929/how-to-make-a-github-mirror-to-bitbucket](http://stackoverflow.com/questions/21551929/how-to-make-a-github-mirror-to-bitbucket)
 - [git mirror sync as a service](https://github.com/git-mirror-sync/git-mirror-sync)
 - [http://stackoverflow.com/questions/22906917/how-to-move-git-repository-with-all-branches-from-bitbucket-to-github](http://stackoverflow.com/questions/22906917/how-to-move-git-repository-with-all-branches-from-bitbucket-to-github)
 
I had a major problem with all the options - every developer had to set it up for this to work on every commit.

I looked into webhooks and triggers on `Gitlab` but webhooks would have old code (unless I updated the code manually before loading).

**Finally, the only way I saw fit to fix this issue was the `Gitlab CI` itself.** I set up a git push as a one-step CI on `Gitlab` itself.
 This would do the following:
 
 - A commit on `Gitlab` leads to CI enabling this `git push --mirror` through the file `.gitlab-ci.yml`
 - When the commit is mirrored on `Bitbucket`, the webhook there is registered with `Shippable` which triggers the actual deployment through `shippable.yml`
 - In a way `Shippable` doesn't need to know anything about `Gitlab` which is great

Here's my ***`.gitlab-ci.yml`***

{{< highlight yaml >}}
stages:
  - deploy

Git MIRROR:
  stage: deploy
  script:
    - git push --mirror https://BITBUCKET_USERNAME:BITBUCKET_PASSWORD@bitbucket.org/group/repo.git
{{< /highlight >}}

*Note:* Remember to use variables in `Gitlab CI` to set up your bitbucket username and password.
  **This had to be done** because you can't have any ssh key from `Gitlab` to add it to `Bitbucket` 