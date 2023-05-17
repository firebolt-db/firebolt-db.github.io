---
layout: default
title: Firebolt Proof of Concept Guidelines
description: Preliminary technical guidelines for Firebolt's Proof of Concept process
nav_exclude: true
search_exclude: true
---

# Firebolt Proof of Concept Technical Guidelines

<aside>
This guide should be used after you have met with your Firebolt designated sales team.
* If you were trying to get to the Firebolt documentation homepage, please go to https://docs.firebolt.io
* If you are looking to try out Firebolt and have yet to contact us please go to https://www.firebolt.io/getting-started-with-firebolt-workshop
</aside>

## Step 1 - Provide access to S3
The data used in the POC should be made available in an S3 region (any region is fine). To ensure the Proof of Concept accurately reflects your production workload, it's recommended to have all or a significant portion of the data available.

<aside>
Firebolt pays for data transfer costs if such occurs. You can find additional information in [this
AWS guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html). 
</aside>

Please go through the following steps to grant us access to the relevant S3 bucket. You can find additional information in [this AWS guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/add-bucket-policy.html)

1. Connect to the AWS console and click on the relevant S3 bucket
2. Go to *Permissions* and then scroll down and edit *Bucket Policy*
3. Copy the following policy. make sure you replace `<bucket>` with the actual bucket name
    ```json
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::231290928314:root"
      },
      "Action": [
        "s3:GetObject",
        "s3:GetObjectTagging",
        "s3:PutObject",
        "s3:PutObjectTagging",
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "arn:aws:s3:::<bucket>",
        "arn:aws:s3:::<bucket>/*"
      ]
    }
  ]
}

    ```
4. Save changes

## Step 2 - Provide your Firebolt Proof of Concept team with the relevant assets

Please share the following assets with your Firebolt Proof of Concept team through your designated Slack channel or email.

<aside> Please make sure all files are saved as a `sql` file type (i.e, `file_name.sql`) </aside>

1. **Schema** - this file should include the DDL commands that we should use to create the desired database schema.
2. **Sample queries & average durations** - this file should include:
    1. *A set of queries to be executed over the data set* - These queries might be - 
        * A good representation of queries you usually run
        * Queries that are slow and you would like to see improved.
    2. For each query, add a comment in the file describing the average duration, or any additional metric that might be relevant.
