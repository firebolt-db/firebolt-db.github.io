---
layout: default
title: Firebolt POC Guidelines
description: Make the necessary preparations for your Firebolt PoC
nav_order: 12
---

# Firebolt POC Guidelines

## Thank you for considering Firebolt. We created this document to help both our teams work better together during the POC.

### **Accessing data in S3**

The data that will be used in the POC should be made available in an S3 region (any region is fine). Don’t hesitate to make all or a very large portion of the data available – the more data the better.

The following policy should be granted to the S3 bucket:

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
        "s3:PutObjectTagging"
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "arn:aws:s3:::<MY-BUCKET>",
        "arn:aws:s3:::<MY-BUCKET>/*"
      ]
    }
  ]
}
```

To alter the S3 bucket policy:

1. Connect to AWS console and click on the relevant S3 bucket
2. Go to "Permissions" and then scroll down and edit "Bucket Policy"
3. Copy the policy mentioned above, make sure you replace "MY-BUCKET"
with the actual bucket name
4. Save changes

<aside>
💡 This S3 bucket will be accessed only once by us in order to copy the data into our own S3 bucket. Although this is a one-time operation, you are welcome to follow *[this AWS guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html)*. Firebolt pays for data transfer costs if any are incurred.

</aside>

### Schema

Send us the DDL commands that should be used in order to create the POC database schema. You can do so by saving the code into a file and sharing it with us via email or on our Slack channel.

### Sample queries & average durations

In order for us to know what we should benchmark against, please provide a set of queries to be executed over the selected data set. These queries should be a good representation of queries you usually run, and/or queries that are slow and you would like to see improved.

You can  save the query code in a file and send it to us with the schema data. It's important for us to know how long these queries take to run in your current system.
