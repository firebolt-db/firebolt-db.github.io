---
layout: default
title: Getting started
description: Follow this getting started tutorial to create a database in a Firebolt data warehouse, load a sample data set from Amazon S3, and run queries over the data.
nav_order: 2
has_toc: true
---
# Getting started tutorial
{:.no_toc}
This tutorial teaches you how to create a database, ingest a sample dataset from Amazon S3 into Firebolt, and run fundamental analytics queries over the data. To perform this tutorial, you need an active Firebolt account. If you don't have one, [Schedule a call](https://www.firebolt.io/getting-started-now) to get set up, and [register for our hands-on Firebolt workshop](https://hi.firebolt.io/lp/hands-on-firebolt-workshop) to get an interactive, instructor-led tutorial on Firebolt. 

{: .note}
This tutorial uses Firebolt's sample dataset, from the fictional gaming company "Ultra Fast Gaming Inc." To recreate this full sample dataset, use the generator and SQL scripts found in the [sample dataset generator GitHub repository](https://github.com/firebolt-analytics/sample-dataset-generator).


1. Topic toC
{:toc}

## Create your first database
To start working with data, you first create a database and a *Firebolt engine*. An engine represents the compute resources that are attached to a database for a certain workload. A database always has one *general purpose engine* that can write to the Firebolt file format (F3) for data ingestion and run analytics queries. We use that single-engine set up in this tutorial. Many databases are set up with additional *analytics engines* that can only query, and are configured to optimize different query workloads. For more information, see [Working-with-engines](/working-with-engines/index.md).

**To create a database and engine**
1. From the **Databases** page, choose **New Database**.  

2. Enter a **Database name** (we use *Tutorial* in this topic) and leave `us-east-1` selected as the **Database region**.  

3. Under **Database engines**, leave the default engine selected. Firebolt will name the engine *Tutorial_general_purpose*.  

4. Choose **Create database**.  
![](assets/images/newdb.png)  
Firebolt adds your database to the **Databases** page. 


## Run your first query
Before we ingest the sample data and run a query over it, we'll go to the SQL workspace for the database and run a simple query to demonstrate how to start an engine. For more information about the SQL workspace, see [Using the SQL workspace](/using-the-sql-workspace/using-the-sql-workspace.md).

**To open your database, start an engine, and run a query**
1. From the **Database** page, find the database that you created in the list, and then choose the **Open in SQL workspace icon** (**>_**) next to the **Database name**.  

2. In the **Script 1** tab, type the simple query below that returns a list of databases in your account.  
```sql
SHOW DATABASES;
```  

3. Choose **Run Script** and note that the **Using** list indicates the engine that Firebolt uses to run the script, for example, `Tutorial_general_purpose`.  
![](assets/images/showdb.png)  

4. When Firebolt prompts you to start the engine, choose **Start Engine**. The engine will take a few minutes to set up.

## Ingest data
Ingesting data into Firebolt is a three-step process. You:

1. Create an external table.  

2. Create a fact or dimension table.  

3. Run an `INSERT INTO` command from the external table to the fact or dimension table.

### Create an external table
An *external table* is a special, virtual table that serves as a connector to your data source. After the external table is created, you ingest data by running an `INSERT INTO` command from that external table into a *fact table* or *dimension table*. The `INSERT INTO` command must run on a general purpose engine. After the data is available in fact and dimension tables, you can run analytics queries over those tables using any engine. Although it's possible, we don't recommend running analytics queries on external tables. For more information, see [CREATE EXTERNAL TABLE](/sql-reference/commands/create-external-table.md) and [Using AWS roles to access S3](/loading-data/configuring-aws-role-to-access-amazon-s3.md).

**To create an external table**
1. Choose the plus symbol (**+**) next to **Script 1** to create a new script tab, **Script 2**, in the SQL workspace.

2. Copy and paste the query below into the **Script 2** tab.
```sql
CREATE EXTERNAL TABLE IF NOT EXISTS ex_levels (
-- Column definitions map to data fields
-- in the source data file and are specified
-- as sources in the INSERT INTO statement for ingestion. 
    LevelID INTEGER,
    GameID INTEGER,
    Level INTEGER,
    Name TEXT,
    LevelType TEXT,
    NextLevel INTEGER NULL,
    MinPointsToPass INTEGER,
    MaxPoints INTEGER, 
    NumberOfLaps INTEGER,
    MaxPlayers INTEGER,
    MinPlayers INTEGER,
    PointsPerLap REAL,
    MusicTrack TEXT,
    SceneDetails TEXT,
    MaxPlayTimeSeconds INTEGER,
    LevelIcon TEXT
) 
-- The URL specifies the data source in S3.
-- All files in the location that match the OBJECT_PATTERN
-- will be processed during ingestion.
URL = 's3://firebolt-publishing-public/help_center_assets/firebolt_sample_dataset/'
-- These credentials specify a role or AWS key credentials
-- with permission to read from the S3 location.
-- These credentials are commented out for this tutorial because the bucket
-- is publicly accessible.
-- CREDENTIALS = ( AWS_KEY_ID = '******' AWS_SECRET_KEY = '******' )
OBJECT_PATTERN = 'help_center_assets/firebolt_sample_dataset/levels.csv'
TYPE = (CSV SKIP_HEADER_ROWS = 1);
```  

3. Choose **Run Script**.  
Firebolt creates the external table. When finished, the external table `ex_levels` appears on the object panel of the database.  
![](assets/images/exlevels.png)  

4. Choose the vertical ellipses next to **Script 2**, choose **Save script**, enter a name (for example, *MyExTableScript*) and then press ENTER to save the script.

### Create a dimension table
In this step, you'll create a Firebolt dimension table called `levels`, which you use in the next step as the target for an `INSERT INTO` command.

When creating a fact or dimension table, you will specify a *primary index*. Firebolt uses the primary index when it ingests data so that it is saved to S3 for highly efficient pruning and sorting when the data is queried. A primary index is required when creating a fact table, and recommended for dimension tables. For more information, see [Using primary indexes](/using-indexes/using-primary-indexes.md). 

The dimension table that we create in this step specifies the `LevelID` column for the primary index. For more information about choosing columns for a primary index, see [How to choose primary index columns](/using-indexes/using-primary-indexes.md#how-to-choose-primary-index-columns).

**To create a dimension table**
1. Create a new script tab.  

2. Copy and paste the query below into the script tab.  
```sql
CREATE DIMENSION TABLE IF NOT EXISTS levels
(
    LevelID INTEGER UNIQUE,
    GameID INTEGER,
    Level INTEGER,
    Name TEXT,
    LevelType TEXT,
    NextLevel INTEGER NULL,
    MinPointsToPass INTEGER,
    MaxPoints INTEGER, 
    NumberOfLaps INTEGER,
    MaxPlayers INTEGER,
    MinPlayers INTEGER,
    PointsPerLap REAL,
    MusicTrack TEXT,
    SceneDetails TEXT,
    MaxPlayTimeSeconds INTEGER,
    LevelIcon BYTEA,
    SOURCE_FILE_NAME TEXT,
    SOURCE_FILE_TIMESTAMP TIMESTAMP
) 
PRIMARY INDEX LevelID;
```  

3. Choose **Run Script**.  
Firebolt creates the dimension table. When finished, the table `levels` appears on the object panel of the database.  
![](/assets/images/dimensiontable.png)

### Use INSERT INTO to ingest data
You can now use the `INSERT INTO` command to copy the data from the external table into the dimension table. During this operation, Firebolt ingests the data from your source into Firebolt.

{: .note}
Use `source_file_name` in the `WHERE` clause to specify which records to load from Amazon S3 and improve the performance of the read from S3. 

**To run an `INSERT INTO` command that ingests data**
1. Create a new script tab.
2. Copy and paste the query below into the script tab.  
```sql
INSERT INTO levels
SELECT
    LevelID,
    GameID,
    Level,
    Name,
    LevelType,
    NextLevel,
    MinPointsToPass,
    MaxPoints, 
    NumberOfLaps,
    MaxPlayers,
    MinPlayers,
    PointsPerLap,
    MusicTrack,
    SceneDetails,
    MaxPlayTimeSeconds,
    DECODE(REPLACE(LevelIcon,'"',''),'BASE64'),
    SOURCE_FILE_NAME, 
    SOURCE_FILE_TIMESTAMP 
FROM ex_levels WHERE SOURCE_FILE_TIMESTAMP > (SELECT MAX(SOURCE_FILE_TIMESTAMP) FROM levels);
```
3. Choose **Run Script**.  
The query results pane indicates a **Status** of **Running** as shown below.  
![](assets/images/running.png)  
The **Status** changes to **Success** when the ingestion is complete as shown below.
![](assets/images/success.png)

## Query the ingested data
Now that the data has been ingested into the `levels` table, you can run analytics queries over the table that benefit from the speed and efficiency of Firebolt.

To verify that you inserted the data into the table, run a simple `SELECT` query like the one below.

```sql
SELECT
  *
FROM
  levels
```
The values shown in the query results pane should be similar to those shown below.
![](assets/images/results.png)

### Configure an aggregating index

An aggregating index enables you to take a subset of table columns and predefine dimensions and measures to aggregate. Many aggregations are supported&mdash;from `SUM`, `MAX`, and `MIN` to more complex aggregations such as `COUNT` and `COUNT(DISTINCT)`. At query runtime, instead of calculating the aggregation on the entire table and scanning all rows, Firebolt uses the pre-calculated values in the aggregating index. For more information, see [Using aggregating indexes](/using-indexes/using-aggregating-indexes.md).

From the `levels` fact table that you created in the previous step, assume you want to run a query to look at the `AVG(NumberOfLaps)`, grouped by `LevelType`. You can create an aggregating index to speed up these queries by running the statement below.

```sql
CREATE AGGREGATING INDEX
  levels_agg_idx
ON levels (
  LevelType 
  AVG(NumberOfLaps)
  );
```

After you run the script, you see the `levels_agg_idx` index listed in the object pane. Any queries that run over the `levels` table that combine any of these fields and aggregations defined in the index will now use the index instead of reading the entire table.
