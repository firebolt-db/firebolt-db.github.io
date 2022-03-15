---
layout: default
title: Continuously loading data
description: Learn how to use Airflow to incrementally load data from Amazon S3 into Firebolt.
nav_order: 3
parent: Loading data
---

# Continuously loading data tutorial

This tutorial describes the steps for continuously loading data into Firebolt. In order to continuously load the data into Firebolt, we need to schedule the loading workflow. In order to achieve that, in this guide, we are using Apache Airflow which is a platform that enables to programmatically schedule and monitor workflows.

## Prerequisites

Before we start, make sure you have the following in-place:

1. An active Firebolt account.
2. Apache Airflow up and running.
3. A database. Follow the [Create your first database](../getting-started.html#create-your-first-database) section in the [Getting started tutorial](../getting-started.html).
4. An external table. Follow [Create an external table](../getting-started.html#create-an-external-table) section in the [Getting started tutorial](../getting-started.html).
5. A fact or dimension table to load your data into. In this tutorial, we have chosen to create a fact table. Continuously loading data into a dimension table is similar. On top of the columns required in the table's schema - make sure to add the following columns as well: `SOURCE_FILE_NAME` of type`TEXT`, and`SOURCE_FILE_TIMESTAMP` of type `TIMESTAMP`. Run the following command on the database created in step 1 in order to create the fact table required for this tutorial:

```sql
CREATE FACT TABLE IF NOT EXISTS lineitem_detailed
(       l_orderkey              LONG,
        l_partkey               LONG,
        l_suppkey               LONG,
        l_linenumber            INT,
        l_quantity              LONG,
        l_extendedprice         LONG,
        l_discount              LONG,
        l_tax                   LONG,
        l_returnflag            TEXT,
        l_linestatus            TEXT,
        l_shipdate              TEXT,
        l_commitdate            TEXT,
        l_receiptdate           TEXT,
        l_shipinstruct          TEXT,
        l_shipmode              TEXT,
        l_comment               TEXT,
        source_file_name        TEXT, -- required for cont. loading data
        source_file_timestamp   TIMESTAMP -- required for cont. loading data
) PRIMARY INDEX l_orderkey, l_linenumber;
```

## Step 1: Setup an Airflow connection to Firebolt

Apache Airflow supports several kinds of connectors. In this tutorial, we use the JDBC connector.

Perform the following steps [Setting up Airflow JDBC to Firebolt](../integrations/data-orchestration/setting-up-airflow-jdbc-to-firebolt.md):

* Install the latest Firebolt JDBC driver in Airflow. [Download Firebolt’s JDBC driver](../integrations/connecting-via-jdbc.md#download-the-latest-jdbc-driver), and save the JDBC jar file to the server that runs Airflow (we use `/airflow/jdbc`).
* [Set up the JDBC connection to Firebolt in Airflow](../integrations/data-orchestration/setting-up-airflow-jdbc-to-firebolt.md#set-up-the-jdbc-connection-in-airflow). In this guide, we assume the `Conn ID` is `firebolt_jdbc`.

## Step 2: Create a DAG for continuously loading data into Firebolt

Apache Airflow supports running DAG scripts written in Python. Below is a script that enables to continuously load data into Firebolt:

```sql
from airflow import DAG
from airflow.operators.jdbc_operator import JdbcOperator

default_arg = {'owner': 'airflow', 'start_date': '2020-10-20'}

dag = DAG('firebolt_continuous_load_dag',
          default_args=default_arg,
          schedule_interval='* * * * *')

data_load = JdbcOperator(dag=dag,
jdbc_conn_id='firebolt_jdbc',
task_id='data_ingestion',
sql=['INSERT INTO lineitem_detailed SELECT *, source_file_name, source_file_timestamp FROM ex_lineitem WHERE source_file_timestamp > ( SELECT MAX(source_file_timestamp) FROM lineitem_detailed )'])

data_load
```

### Load command

The script contains a single step called `data_load`. It connects to a database in Firebolt via a JDBC connector and runs the following [INSERT INTO](../sql-reference/commands/insert-into.md) command:

```sql
INSERT INTO lineitem_detailed SELECT *, source_file_name, source_file_timestamp
FROM ex_lineitem
WHERE source_file_timestamp > ( SELECT MAX(source_file_timestamp) FROM lineitem_detailed )
```

We use the `SOURCE_FILE_NAME` and `SOURCE_FILE_TIMESTAMP` external table metadata column to decide which files to load into Firebolt. We load only the new files that were added to S3 based on the `SOURCE_FILE_TIMESTAMP` column.

### Scheduling

Airflow scheduler can run each DAG according to a predefined schedule. The schedule is being determined by the`schedule_interval` DAG parameter. It supports either a [cron expression](https://en.wikipedia.org/wiki/Cron#CRON\_expression) or several predefined intervals (read more in the [Airflow documentation](https://airflow.apache.org/docs/apache-airflow/1.10.1/scheduler.html)). We have set it to `'* * * * *'` using a cron expression which instructs the Airflow scheduler to run the DAG every 1 minute.

## Step 3: Run the DAG

* In Airflow's UI, go to the **DAGs** tab. Locate your DAG in the list (in our case we should look for `'firebolt_continuous_load_dag'`):

![](../assets/images/DAG_image1.png)

* Turn the DAG on so it runs automatically every minute.

![](../assets/images/DAG_image2.png)

* Once the DAG has started to run, click on it's `Run Id` under the `Last Run` column to move to the graph view and track its progress.
* In the DAG's graph view, the task should appear in green to confirm the DAG was completed successfully. Click on the task `'data_load'`:

![](../assets/images/DAG_image3.png)

* Click on **View Logs** to inspect the logs.
