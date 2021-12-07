---
layout: default
title: Airflow
nav_order: 1
parent: Other integrations
grand_parent: Integrations
---

# Connecting to Airflow

{: .note}
Interested in continuously loading data into Firebolt? See our [continuously loading data tutorial](../../loading-data/continuously-loading-data.md).

## Step 1: Install the latest Firebolt JDBC Driver

Download Firebolt’s JDBC driver from [here](../connecting-via-jdbc.md#downloading-the-driver).

Put the JDBC jar file in the server which runs Airflow (we have placed it under `/airflow/jdbc`).

## Step 2: Set up the JDBC connection in Airflow

### Prerequisites

Make sure you have:

1. The name of the database you would like to connect to in Firebolt.
2. The username and password used to log into Firebolt.
3. Airflow version 1.10.12 or later.

### Configuring the Connection

* Open Airflow UI. In the **Admin** tab click on **Connections**.
* Click **+** to create a new connection to Firebolt.
*   Configure the following parameters:

    | Parameter        | Description                                                                        | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                |
    | ---------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | `Conn Id`        | The connection identifier                                                          | For example: `firebolt_jdbc`                                                                                                                                                                                                                                                                                                                                                                                                                         |
    | `Conn Type`      | The connection type                                                                | `JDBC Connection`                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    | `Connection URL` | The connection String URL                                                          | <p><code>jdbc:firebolt://api.app.firebolt.io/&#x3C;db_name></code></p><p>Make sure to replace &#x3C;db_name> with the name of your database in Firebolt. This enables you to query the database using its default engine. If you wish to use another engine, use the following URL:</p><p><code>jdbc:firebolt://api.app.firebolt.io/&#x3C;db_name>?engine=engineName</code>Replace engineName with the name of the engine you would like to use.</p> |
    | `Login`          | Your Firebolt username                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
    | `Password`       | Your Firebolt password                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
    | `Driver Path`    | The full path in your Airflow server in which you've stored Firebolt's JDBC driver | In our case: `/airflow/jdbc/firebolt-jdbc-1.03-jar-with-dependencies.jar`                                                                                                                                                                                                                                                                                                                                                                            |
    | `Driver Class`   | The class of the JDBC driver                                                       | `com.firebolt.FireboltDriver`                                                                                                                                                                                                                                                                                                                                                                                                                        |
* Click on **Save**.

## Step 3: Create a DAG

We will create a DAG that runs a script on top of a Firebolt table.

Below is the Python DAG program:

```python
from airflow import DAG
from airflow.operators.jdbc_operator import JdbcOperator

default_arg = {'owner': 'airflow', 'start_date': '2020-10-20'}

dag = DAG('firebolt_dag',
          default_args=default_arg,
          schedule_interval=None)

firebolt_task = JdbcOperator(dag=dag,jdbc_conn_id='firebolt_db',task_id='firebolt_sql_task',sql=['query_sample.sql'])                     

firebolt_task
```

You can save it as a Python file, and place it under your dags folder to run it in Airflow. We use Airflow's JDBC operator to connect to Firebolt via JDBC and run a SQL script. The SQL script file contains a simple SELECT query. Feel free to use any query you want.

## Step 4: Run the DAG

* In Airflow's UI, go to the **DAGs** tab. Locate your DAG in the list (in our case we should look for `'firebolt_dag'`:

![](../../.gitbook/assets/screen-shot-2020-10-26-at-17.31.32.png)

* Click on the trigger button under Links to manually trigger the DAG. Once the DAG has started to run, click on it's Run Id to move to the graph view to track its progress. In our DAG we have a single step called `'firebolt_sql_task'`.

![](../../.gitbook/assets/dag\_runs\_list.png)

* In the DAG's graph view, the task should appear in green to confirm the DAG was completed successfully. Click on the task `'firebolt_sql_task'`:

![](../../.gitbook/assets/dag\_graph\_view.png)

* Click on **View Logs** to inspect the logs.
