+++
date = "2015-11-04 07:49:00+00:00"
title = "Lambda Basics with Python using Github Webhooks or API Gateway"
type = "post"
tags = ["python", "aws", "lambda", "github", "git"]
categories = ["code", "continuous delivery"]
description = "How to execute an aws lambda command on git push"
keywords = ["aws lambda", "python", "aws", "lambda", "github", "git", "api gateway", "git push"]
draft = true
+++

I recently needed to call a command whenever there was a push on my Github repo.
Since this was related to AWS tasks, I figured `aws lambda` is a good candidate.
Here I will talk about the steps I took to enable all of this using aws lambda, python.
As a side note, I will also elaborate on using API gateway to call upon the lambda itself.

In a nutshell, what I will talk about:

- Create **SNS** Topic
- Create **IAM user** who can Publish
- Setup **GitHub webhook**
- Create **Lambda function**
- Setup **API Gateway** url that can call lambda function


# Create SNS Topic

Go to [AWS Console](https://ap-northeast-1.console.aws.amazon.com/sns/v2/home?region=ap-northeast-1#/home) and click on Create Topic.

{{< figure src="/images/lambda_basics_sns_1.png" caption="Creating an API" >}}

Note down the `ARN` because you will need that.
In my case it is something like `arn:aws:sns:ap-northeast-1:XXXXXXXXXXXX:commits_1`


# Create IAM user
We need to setup an IAM user who can publish onto this SNS we just created.
As a shortcut you can just create a simple user and initialize it with full access rights for testing purposes.

**Once on IAM page click on "Create New Users" button at the top.**
{{< figure src="/images/lambda_basics_iam_1.png" caption="Creating new IAM user" >}}

**It will then allow you to download credentials if you want**
{{< figure src="/images/lambda_basics_iam_2.png" caption="Creating new IAM user" >}}

## Add permissions

Once an IAM user is created, by default there are no permissions attached to the account.
**You can add permissions by going to permissions tab and clicking on "Attach Policy" button**.
{{< figure src="/images/lambda_basics_iam_3.png" caption="Attach Policy" >}}


# Setup GitHub webhook

We need to assign a webhook for each Git commit. So let's do the following:

- Navigate to your GitHub repo
- Click on “Settings” in the sidebar of that repo
  - It has to be an actual repo settings, not profile settings
- Click on “Webhooks & Services”
- Click the “Add service” dropdown, then click “AmazonSNS”
  - You will need the account details for the IAM user you just created
  - The trigger will be delegated through this given IAM user

**Add SNS Webhook**
{{< figure src="/images/lambda_basics_webhooks_1.png" caption="" >}}

**Add Account details from IAM user**
{{< figure src="/images/lambda_basics_webhooks_2.png" caption="" >}}


# Create Lambda function

Now that we have creater a user, assigned a trigger on Github, we need to create a function
that will be run on an actual trigger.
Let's create a lambda function by going to [AWS Lambda](https://ap-northeast-1.console.aws.amazon.com/lambda/home?region=ap-northeast-1#/functions) and
clicking on "Create a Lambda Function".

Filter by SNS in the given samples because we want to see SNS functions.
{{< figure src="/images/lambda_basics_lambda_1.png" caption="" >}}
_Ensure that you select your SNS as the event source._

Create a Lambda function with the following code:

```python
import json
print('Loading function')

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    message = event['Records'][0]['Sns']['Message']
    print("From SNS: " + message)
    return message
```
{{< figure src="/images/lambda_basics_lambda_2.png" caption="Python code" >}}

# Testing the setup so far

## Testing GitHub webhook

Now that we have setup **Lambda, SNS, and Github** so far, it is time to test the setup.

Go to the "Webhooks and Services" under you repo settings and click on "Amazon SNS" that is
viewable at the bottom of that page. You will then be able to test the service.
{{< figure src="/images/lambda_basics_results_1.png" caption="" >}}
There's a button at the top right "Test service". Once you click it, GitHub will confirm that the message is indeed sent.

## Checking AWS

Now that we have been able to send the message, we also need to confirm that the lambda was actually called.

This can be done by looking at CloudWatch logs. Any lambda run will be logged under CloudWatch.
Even normal logging is also available there.
{{< figure src="/images/lambda_basics_results_2.png" caption="Going to CloudWatch" >}}
{{< figure src="/images/lambda_basics_results_3.png" caption="Checking the lambda logs" >}}

# Setup API Gateway

After all this is done, we can even **create an API along with a public facing URL**
where all these services can be called (apart from just GitHub), if you'd like.
So let's do that.

## Create API

{{< figure src="/images/lambda_basics_api_1.png" caption="Creating an API" >}}

## Create Resource

{{< figure src="/images/lambda_basics_api_2.png" caption="Creating Resource" >}}

## Create Method

{{< figure src="/images/lambda_basics_api_3.png" caption="Creating Method for GET" >}}

{{< figure src="/images/lambda_basics_api_4.png" caption="Assign Lambda function to GET" >}}

## Test your GET Method

Now this API can be tested easily by just calling upon this URL:

  https://XXXXXXXXXXXX.execute-api.ap-northeast-1.amazonaws.com/test/mirror/

{{< figure src="/images/lambda_basics_api_5.png" caption="Check your Response from Lambda using GET" >}}



# Misc

## Using CLI

Try the following command to get the list of your lambda functions:

```bash
$ aws lambda --profile lambda.s3.1 --region ap-northeast-1 list-functions
```

```json
{
    "Functions": [
        {
            "CodeSize": 317,
            "FunctionArn": "arn:aws:lambda:ap-northeast-1:XXXXXXXXXXXX:function:lambda_1",
            "MemorySize": 128,
            "Role": "arn:aws:iam::XXXXXXXXXXXX:role/lambda_basic_execution_1",
            "Handler": "lambda_function.lambda_handler",
            "Runtime": "python2.7",
            "CodeSha256": ".....",
            "FunctionName": "lambda_1",
            "Timeout": 183,
            "LastModified": "2015-11-15T07:49:28.367+0000",
            "Version": "$LATEST",
            "Description": "An Amazon SNS trigger that logs the message pushed to the SNS topic."
        },
        {
            "CodeSize": 316,
            "FunctionArn": "arn:aws:lambda:ap-northeast-1:XXXXXXXXXXXX:function:lambda_2",
            "MemorySize": 128,
            "Role": "arn:aws:iam::XXXXXXXXXXXX:role/lambda_basic_execution_1",
            "Handler": "lambda_function.lambda_handler",
            "Runtime": "python2.7",
            "CodeSha256": ".......",
            "FunctionName": "lambda_2",
            "Timeout": 3,
            "LastModified": "2015-11-14T14:03:00.083+0000",
            "Version": "$LATEST",
            "Description": "An Amazon SNS trigger that logs the message pushed to the SNS topic."
        }
    ]
}

```

## Custom Policy for Lambda Access

Validate Policy
You can either just give "AmazonSNSFullAccess" to the user _lambda.s3.1_ or add the following Policy
onto **User->Permission->Add Inline policy->custom policy->Select->Policy Document**

```yaml
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws:sns:ap-northeast-1:YOUR_NUMBER:Commits_1"
      ],
      "Effect": "Allow"
    }
  ]
}
```
