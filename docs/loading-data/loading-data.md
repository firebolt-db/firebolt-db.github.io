---
layout: default
title: Loading data
description: Understand options for loading data into Firebolt from your data lake.
nav_order: 8
has_children: true
has_toc: false
---

# Loading data

Loading data into Firebolt is described in the [Getting started tutorial](../getting-started.md) and consists of three steps.

1. Create an *external table* as a connector from Firebolt to your external data source. For more information, see [Working with external tables](working-with-external-tables.md).  
In the table definition, you specify credentials that allow Firebolt to read from the data source. For more information, see [CREATE EXTERNAL TABLE](../sql-reference/commands/create-external-table.md) and [Using AWS roles to access S3](configuring-aws-role-to-access-amazon-s3.md).

2. Create a fact or dimension table to store the data in Firebolt to be queried. For more information, see [Working with tables](../working-with-tables.md).  

3. Run an `INSERT INTO` command using a general purpose engine to load data from the external data source into the fact or dimension table. For more information, see [INSERT INTO](../sql-reference/commands/insert-into.md).

For information about using Apache Airflow to incrementally load data chronologically or based on triggers, see [Continuously loading data](continuously-loading-data.md).
