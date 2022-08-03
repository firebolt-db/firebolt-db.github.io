---
layout: default
title: Keboola
description: Learn how to connect Keboola to Firebolt.
nav_order: 8
parent: Data integration and transformation
grand_parent: Integrations
---

# Connecting to Keboola

Keboola is a cloud ETL / ELT platform for interconnecting diverse data sets. It is used to extract and manipulate varied data sets and write the results to a destination system.

When integrated with Firebolt, Keboola is used to funnel data to the AWS S3 bucket that is used for staging your Firebolt databases.

## To get started

We recommend that you follow the guidelines for [Keboola’s suggested configuration for Firebolt](https://help.keboola.com/components/writers/database/firebolt/)

## Credentials

Keboola requires the following credentials to work with Firebolt:

| Parameter              | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Username**           | Your Firebolt username / email                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Password**           | Your Firebolt password                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **Database Name**      | The identifier for your Firebolt database                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **AWS API Key ID**     | An AWS key to access your database. You can create these credentials by following [the AWS guide](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#temporary-access-keys). We advise against using AWS root access when integrating Keboola for Firebolt. For security reasons, it is better to set up a dedicated AWS user role for Keboola. For help setting up an AWS user role and policies, please see [this Keboola guide](https://help.keboola.com/components/extractors/storage/aws-s3/). |
| **AWS API Key Secret** | The secret access key for accessing your database. You can obtain this key by following the same steps as the AWS API Key ID                                                                                                                                                                                                                                                                                                                                                                                           |
| **AWS Staging Bucket** | The name of your AWS S3 bucket.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

Firebolt's connector with Keboola will use the designated default engine for your database.

{: .note}
Firebolt identifiers normally evaluate all identifiers as lowercase characters, however some integrated Keboola data sources could have case-sensitive requirements. In this scenario, you can use double quotes to ensure case-sensitive identifiers. For more information, please see [Firebolt's identifier requirements](../../general-reference/identifier-requirements.md).
