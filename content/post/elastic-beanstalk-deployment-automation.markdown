+++
categories = ["continuous delivery", "code"]
tags = ["aws", "beanstalk", "deployment", "docker", "python", "supervisord"]
date = "2015-09-04T00:17:10+08:00"
title = "Elastic Beanstalk Deployment Automation"
description = "How to automate beanstalk deployment"
keywords = ["aws", "beanstalk", "deployment", "docker", "python", "supervisord"]
+++

We are going to talk about a setup where **all you need to do it _commit_ your code and all the rest of the steps from unit tests to deployment can be taken care of by some externally hosted cloud platform that provides continuous integration.**
  In my case, it is going to be `Shippable` that I am using as a sample but you can use almost anything like `TravisCI` or `codeship`, for example.


# Setup

Here is the setup we will be looking at:

{{< figure src="/images/elastic-beanstalk-deployment-automation-arch.png" caption="Architecture" >}}

# Shippable for commits

We will use `shippable` for the following:

- Unit Tests
- Regression Tests
- Localized DB Tests
- Tagging of the source code if the commit passes all tests
- Deployment of the source code on `beanstalk` running `docker`

Login onto `shippable` and setup your project to be built. It uses webhooks with your repository like `GitHub` or `shippable` which are called on every commit.
You can create a `shippable.yml` file in your project which will be called on every commit. If you have used `docker` before, it might look familiar because they invoke a `docker` script to run the script within `shippable.yml`

Here is one of my sample files from the project that powers this blog:

{{< highlight bash >}}
language: python

install:
  - pip install Pygments

before_script:
  - git config --global push.default matching
  - mkdir -p themes
  - git clone git@github.com:abhi1010/abhi1010.github.io.git
  - cd themes
  - git clone https://github.com/abhi1010/hyde-a.git
  - cd ../

script:
  - hugo -d abhi1010.github.io/

after_success:
  - echo `pwd`
  - export NOW_HOUR=$(date +%d-%b-%H_%M)
  - git config --global user.email "abhi.pandey@gmail.com"
  - git config --global user.name "abhi1010"
  - git config --get remote.origin.url
  - git remote set-url origin git@github.com:abhi1010.github.io.git
  - cd abhi1010.github.io
  - git status -s
  - echo -e "a\n*\nq\n"|git add -i
  - git commit -am 'Automated build from Shippable - '$NOW_HOUR && git push


notifications:
     email:
         recipients:
             - abhi@boun.cr
         on_success: change
         on_failure: always

cache: true
{{< /highlight >}}

This script does the following tasks:

- Set `python` as the default language for the scripts to use
- Install `Pygments` using `pip`
- My blog is done using three repos - so it does a _git clone_ for each
- Calls on hugo to create the static site
- Commits the changes made in static content to `GitHub`

Once it works, you will see the following on `shippable` site:

{{< figure src="/images/elastic-beanstalk-deployment-automation-2.png" caption="Shippable Build Status" >}}

## Unit Tests

You may also want to set up unit tests and regression tests as part of your _scripts_
Just do the following then


{{< highlight yaml >}}
script:
  -  py.test-3.4 tests/test.py --maxfail=3 -s --full-trace --tb=long --junitxml=../shippable/testresults/pytests.xml
{{< /highlight >}}


## Git Tagging
If the tests pass in _scripts_ only then does `shippable` go to **after_success** section.
Over there, you might want to tag your source code, so that `docker` will only pull the tagged and approved commits from `shippable`, not every commit - which is very important.

Here's how to do that:

{{< highlight bash >}}
after_success:
  - git tag -f recon_prod master
  - git push -f --tags
{{< /highlight >}}


# Deployment
Once you have approved your code commit, it is time to deploy it to `docker` on `beanstalk`.
I like to keep deployment scripts in another bash script, so that deployment can be done in various other ways as well, if needed.


{{< highlight bash >}}
after_success:
  - main/scripts/deploy.sh
  - echo 'CODE DEPLOYED'
{{< /highlight >}}

Or, you may choose to have the "deployment" script from another project, if you wish. It allows you to separately maintain all the moving parts.

{{< highlight bash >}}
rm -rf cd eb-reconwise
echo 'Deploying New Dockers'
git clone https://github.com/abhi1010/deplyment_project.git
cd deplyment_project/
chmod +x deploy.sh
eb use beanstalk_env_name
./deploy.sh
echo 'Deployment Complete'
{{< /highlight >}}

## Dockerfile

Now first what we need is setting up `docker` on beanstalk.

{{< highlight bash >}}
  FROM abhi1010/base_docker
  MAINTAINER abhi1010 <codersdigest@gmail.com>

  ENV DEBIAN_FRONTEND noninteractive

  ENV WS '/ws'
  ENV CURR_HOME '/root'
  WORKDIR $WS

  RUN git clone https://github.com/abhi1010/dockerprj.git \
   && . $WS/ve_envs/rwv2/bin/activate \
   && $WS/prj/rw/manage.py collectstatic --noinput

  COPY supervisor-app.conf $WS/

  RUN \
      cp $WS/supervisor-app.conf /etc/supervisor/supervisord.conf \
   && chown -R www-data:www-data /var/lib/nginx

  VOLUME ["/var/shared/", "/etc/nginx/sites-enabled", "/var/log/nginx", "/ws/"]

  EXPOSE 80
  CMD ["supervisord", "-n"]
{{< /highlight >}}

This does the following tasks:

- Run a base `docker` from a custom image - where all apps and project requirements have already been installed and configured. It helps me save a lot of time during deployments.
- Download the source code using `RUN` - which I update using another method.
  - You can view detail on this [method here]({{< ref "post/updating-django-source-with-docker-deployments.markdown" >}})
- Copy the `supervisord` config as well
- Set the right user rights for `nginx`
- Setup folders to be shared using `VOLUME`
- Expose port 80 so that this `docker` container can be used as a web container
- Set `cmd` so that it allows `supervisord` to be used for running the container

## Beanstalk Configuration

Once we have the `Dockerfile` ready, we need to set up the configuration for `beanstalk` so that during deployment, other steps can be taken care of as well. Some of the things to keep in mind in `beanstalk` setup are:
### Tips

- All `beanstalk` configuration has be kept in a folder called **`.ebextension`**
- `beanstalk ec2` instance maintains a folder internally to run the scripts while setting up `docker` for you so that the instance can be ready for you
  - It is totally possible to _plug_ your own scripts into `beanstalk` initialization setup so that you can _program_ a custom `EC2` instance for yourself
  - Folder to place your scripts are `/opt/elasticbeanstalk/hooks/appdeploy/post` and `/opt/elasticbeanstalk/hooks/appdeploy/pre`
  - Scripts placed in the folders are read in alphabetical order
- You can increase the timeout of your `docker` initialization setup if it takes too long due to multiple steps
{{< highlight python >}}
option_settings:
    - namespace: aws:elasticbeanstalk:command
      option_name: Timeout
      value: 1800
{{< /highlight >}}

### User Accounts
- You can also add any user account if you'd like pragmatically and make sure they are *always* part of the `EC2` instance that you are creating
  - Create a file called `00001.ftp.config`
  - Use `pre` folder to setup accounts

{{< highlight bash >}}
files:
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/0001_create_users.sh":
    mode: "000755"
    owner: root
    group: root
    content: |
      #!/usr/bin/env bash
      echo 'About to Add user gh-user'
      adduser gh-user
      runuser -l gh-user -c 'mkdir ~/.ssh'
      runuser -l gh-user -c 'chmod 700 ~/.ssh'
      runuser -l gh-user -c 'touch ~/.ssh/authorized_keys'
      runuser -l gh-user -c 'chmod 600 ~/.ssh/authorized_keys'
      runuser -l gh-user -c 'echo "ssh-rsa r4CBI2cWQohEwBkGw9CcW0vWfnlAcKkrCnsJvwe/+kG5w9J8gJdnNQ8BFB+q+kQ6fWl+1kw7b+8jah5q0nNpOzLbed+Rzse1BoOIjsSXqN/L7AW8y61PVBULcVAVBKCrVy0U5zifv/e6a5+dsUD3WLiD3yXTgPDcZoqQqPYkurCx5ZzxLylKfXfL37k7sz00e+Tu/Y+J9xXdI9j3G5bU9rmIe4SH4mK4BCMRQ6zCHqAzAXZtnmN5U1XR3XrfMtuDLvVgcOlEpXIMl9q2kco0ZCdMkYoSzf3Yj" >> ~/.ssh/authorized_keys'
{{< /highlight >}}

### Pre-installing Packages
- You should also install any package that you'd like on all `EC2` instances

{{< highlight bash >}}
files:
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/0003_packages.sh":
    mode: "000755"
    owner: root
    group: root
    content: |
      #!/usr/bin/env bash
      yum install -y git

{{< /highlight >}}

### Sharing volumes between `docker` and `EC2`

- Ensure that folder sharing is enabled between `EC2` and `docker` instances
  - This goes into file `Dockerrun.aws.json`


{{< highlight bash >}}
{
   "AWSEBDockerrunVersion": "1",
  "Volumes": [
    {
      "HostDirectory": "/var/shared",
      "ContainerDirectory": "/var/shared"
    }
  ],
  "Ports": [
    {
      "ContainerPort": "80"
    }
  ],
   "Logging": "/var/log/"
 }
{{< /highlight >}}

### Folder and files structure

- Finally, make sure that your folder files are setup as follows:


{{< highlight bash >}}
$ (master) tree -a
.
|-- .ebextensions
|   |-- 0000_users.config  # setup extra users
|   |-- 0002_packages.config  # install external packages
|   |-- 0004_bash.config  # I like to manage all
|-- .elasticbeanstalk
|   |-- config.yml  # AWS connection details
|-- .gitignore
|-- Dockerfile  # Docker instance
|-- Dockerrun.aws.json   # folder sharing
|-- updater.sh  # script to update any code

{{< /highlight >}}


### `.elasticbeanstalk` folder for `aws` configs

- You might be wondering what's `.elasticbeanstalk` folder. It is the folder that's responsible for taking your `AWS` secret key and access id for doing the actual deployment. If you don't set it up, AWS will ask you every time.
  - For setting it up, you just need to call `eb config` one time, it creates the folder for you with all the details, including connection details. You can then make it part of your `git` commits
  - Make sure it is secure

And that's it! Once you commit your code, `shippable` will run the tests, tag your code and finally download this _deployment_ project and deploy it to `beanstalk` through `docker` containers.
