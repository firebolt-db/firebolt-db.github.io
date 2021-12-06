# Setting up Airflow JDBC to Firebolt

{: .note}
Interested in continuously loading data into Firebolt? See our [continuously loading data tutorial](../loading-data/continuously-loading-data.md).

## Step 1: Install the latest Firebolt JDBC Driver

Download Firebolt’s JDBC driver from [here](connecting-via-jdbc.md#downloading-the-driver).

Put the JDBC jar file in the server which runs Airflow \(we have placed it under `/airflow/jdbc`\).

## Step 2: Setup the JDBC connection in Airflow

### Pre-requisites

Make sure you have:

1. The name of the database you would like to connect to in Firebolt.
2. The username and password used to log into Firebolt.
3. Airflow version 1.10.12 and above.

### Configuring the Connection

* Open Airflow UI. In the **Admin** tab click on **Connections.**
* Click **+** to create a new connection to Firebolt.
* Configure the following parameters:

  <table>
    <thead>
      <tr>
        <th style="text-align:left">Parameter</th>
        <th style="text-align:left">Description</th>
        <th style="text-align:left">Value</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="text-align:left"><code>Conn Id</code>
        </td>
        <td style="text-align:left">The connection identifier</td>
        <td style="text-align:left">For example: <code>firebolt_jdbc</code>
        </td>
      </tr>
      <tr>
        <td style="text-align:left"><code>Conn Type</code>
        </td>
        <td style="text-align:left">The connection type</td>
        <td style="text-align:left"><code>JDBC Connection</code>
        </td>
      </tr>
      <tr>
        <td style="text-align:left"><code>Connection URL</code>
        </td>
        <td style="text-align:left">The connection String URL</td>
        <td style="text-align:left">
          <p><code>jdbc:firebolt://api.app.firebolt.io/&lt;db_name&gt;</code>
          </p>
          <p>Make sure to replace &lt;db_name&gt; with the name of your database in
            Firebolt. This enables you to query the database using its default engine.
            If you wish to use another engine, use the following URL:</p>
          <p><code>jdbc:firebolt://api.app.firebolt.io/&lt;db_name&gt;?engine=engineName</code>Replace
            engineName with the name of the engine you would like to use.</p>
        </td>
      </tr>
      <tr>
        <td style="text-align:left"><code>Login</code>
        </td>
        <td style="text-align:left">Your Firebolt username</td>
        <td style="text-align:left"></td>
      </tr>
      <tr>
        <td style="text-align:left"><code>Password</code>
        </td>
        <td style="text-align:left">Your Firebolt password</td>
        <td style="text-align:left"></td>
      </tr>
      <tr>
        <td style="text-align:left"><code>Driver Path</code>
        </td>
        <td style="text-align:left">The full path in your Airflow server in which you&apos;ve stored Firebolt&apos;s
          JDBC driver</td>
        <td style="text-align:left">In our case: <code>/airflow/jdbc/firebolt-jdbc-1.03-jar-with-dependencies.jar</code>
        </td>
      </tr>
      <tr>
        <td style="text-align:left"><code>Driver Class</code>
        </td>
        <td style="text-align:left">The class of the JDBC driver</td>
        <td style="text-align:left"><code>com.firebolt.FireboltDriver</code>
        </td>
      </tr>
    </tbody>
  </table>

* Click on **Save**.

## Step 3: Create a DAG

We will create a DAG that runs a script on top of a Firebolt table.

Bellow is the Python DAG program:

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

* In Airflow's UI, go to the **DAGs** tab. Locate your DAG in the list \(in our case we should look for `'firebolt_dag'`:

![](../.gitbook/assets/screen-shot-2020-10-26-at-17.31.32.png)

* Click on the trigger button under Links to manually trigger the DAG. Once the DAG has started to run, click on it's Run Id to move to the graph view to track its progress. In our DAG we have a single step called `'firebolt_sql_task'`.

![](../.gitbook/assets/dag_runs_list.png)

* In the DAG's graph view, the task should appear in green to confirm the DAG was completed successfully. Click on the task `'firebolt_sql_task'`:  

![](../.gitbook/assets/dag_graph_view.png)

* Click on **View Logs** to inspect the logs.
