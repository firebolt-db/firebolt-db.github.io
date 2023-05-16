---
layout: default
title: Firebolt Proof of concept guidelines
description: Make the necessary preparations for your Firebolt PoC
nav_exclude: true
search_exclude: true
nav_order: 12
---

# Firebolt proof of concept guidelines

## This document will help you through the steps to set up for a proof of concept of Firebolt.

### **Accessing data in S3**

The data that will be used in the proof of concept should be made available in an S3 region (any region is fine). The more data you provide, the better we can ensure that the proof of concept results are the most accurate when compared to your production workload.

The following policy should be granted to the S3 bucket:

```json
   ```javascript
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObject",
            "s3:GetObjectVersion"
         ],
         "Resource":"arn:aws:s3:::<bucket>/<prefix>/*"
      },
      {
         "Effect":"Allow",
         "Action":"s3:GetBucketLocation",
         "Resource":"arn:aws:s3:::<bucket>"
      },
      {
         "Effect":"Allow",
         "Action":"s3:ListBucket",
         "Resource":"arn:aws:s3:::<bucket>",
         "Condition":{
            "StringLike":{
               "s3:prefix":[
                  "<prefix>/*"
               ]
            }
         }
      },
      {
         "Effect":"Allow",
         "Principal":{
            "AWS":"arn:aws:iam::231290928314:root"
         },
         "Action":[
            "s3:GetObject",
            "s3:GetObjectTagging",
            "s3:PutObject",
            "s3:PutObjectTagging",
            "s3:ListBucket",
            "s3:GetBucketLocation"
         ],
         "Resource":[
            "arn:aws:s3:::<bucket>",
            "arn:aws:s3:::<bucket>/*"
         ]
      }
   ]
}
```
```

To alter the S3 bucket policy:

<aside>
💡 This S3 bucket will be accessed only once by us in order to copy the data into our own S3 bucket. Although this is a one-time operation, you are welcome to follow *[this AWS guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html)*. Firebolt will pay for data transfer costs if any are incurred.
</aside>


1. Connect to AWS console and click on the relevant S3 bucket.
2. Go to "Permissions" and then scroll down and edit "Bucket Policy".
3. Copy the policy mentioned above, make sure you replace "<bucket>"
with the actual bucket name.
4. Save changes.

### Sharing assets for the proof of concept

Please send us the following assets via email or on our Slack channel. Each asset should be sent in a `.sql` file.
1. **Schema** - This should include the DDL commands used to create the proof of concept database schema.
2. **Sample queries & average durations** - This should include a set of queries to be executed over your selected dataset, to benchmark against. These queries should be a good representation of queries you usually run, and/or slow queries that you would like to see improved. Please also mention (in a comment within the file) the current average duration of these queries, if available. 