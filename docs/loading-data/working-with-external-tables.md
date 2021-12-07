---
layout: default
title: Working with external tables
nav_order: 1
parent: Loading data
---

# Working with external tables

Loading data into Firebolt is done using EXTERNAL TABLEs. Those tables are different from [fact and dimension tables](../concepts/working-with-tables.md) since the data is stored externally in Amazon S3 and not inside the database. Using external tables, Firebolt can access files stored in your S3 bucket with ease and allow you to load those files into Firebolt.

In order to create an external table, run the [CREATE EXTERNAL TABLE](../sql-reference/commands/ddl-commands.md#create-external-table) command. After you create an external table, use the [INSERT INTO](../sql-reference/commands/dml-commands.md#insert-into) command to load the data from the external table into a fact or dimension table.

{: .note}
You can run a query over an external table in Firebolt to return query results directly from external data. A direct query like this over an external table will be significantly slower than the same query run over the same data in a fact or dimension table. We strongly recommend that you use external tables only for ingestion, specifying the table and its columns only in the `FROM` clause of an `INSERT INTO` statement. 

## Workflows

1. For a simple end-to-end workflow that demonstrates loading data into Firebolt, see the [getting started tutorial](../).
2. For a workflow that demonstrates continuously loading data into Firebolt, see the [continuously loading data tutorial](continuously-loading-data.md).

## Supported file formats

Firebolt supports loading the following source file formats from S3: `PARQUET`, `CSV`, `TSV`, `JSON`, and `ORC`. We are quick to add support for more types, so make sure to let us know if you need it.

## Using metadata virtual columns

Firebolt external tables include metadata virtual columns that Firebolt populates with useful system data during ingestion. Firebolt includes these columns automatically. You don't need to specify them in the `CREATE EXTERNAL TABLE` statement.

When you use an external table to ingest data, you can explicitly reference these columns to ingest the metadata. First, you define the columns in a`CREATE FACT|DIMENSION TABLE` statement. Next, you specify the virtual column names to select in the `INSERT INTO` statement, with the fact or dimension table as the target. You can then query the columns in the fact or dimension table for analysis and troubleshooting. For more information, see the example below.

The metadata virtual columns listed below are available in external tables.

| Metadata column name | Description | Data type |
| :--- | :--- | :--- |
| `source_file_name` | The full path of the row's source file in Amazon S3. For Kafka-connected external tables, this is `NULL`. | TEXT |
| `source_file_timestamp` | The creation date of the row's source file in S3. For Kafka-connected external tables, this is `NULL`. | TIMESTAMP |

### Example - querying metadata virtual column values

The query example below creates an external table that references an AWS S3 bucket that contains Parquet files for Firebolt to ingest.

```sql
CREATE EXTERNAL TABLE my_external_table
  (
    c_id    INT,
    c_name  TEXT
  )
  CREDENTIALS = (AWS_KEY_ID = 'AKIAIOSFODNN7EXAMPLE' AWS_SECRET_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY')
  URL = 's3://my_bucket/'
  OBJECT_PATTERN= '*.parquet'
  TYPE = (PARQUET);
```

The query example below creates a dimension table to be the target for data ingestion.

```sql
CREATE DIMENSION TABLE my_dim_table_with_metadata
(
   c_id INT UNIQUE
   c_name TEXT,
   source_file_name TEXT,
   source_file_timestamp TIMESTAMP,
);
```

The query example below uses `my_external_table` to ingest the Parquet data into `my_dim_table_with_metadata`. The statement explicitly specifies the metadata virtual columns in the `SELECT` clause, which is a requirement.

```sql
INSERT INTO
    my_dim_table_with_metadata
SELECT
    *,
    source_file_name,
    source_file_timestamp
FROM
    my_external_table;
```

Finally, the query example below retrieves all records in `my_dim_table_with_metadata.`

```sql
SELECT * FROM my_dim_table_with_metadata;
```

The query returns output similar to the following.

```bash
-------------------------------------------------------------------------------
|c_id     |c_name             |source_file_name        |source_file_timestamp
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
|12385    |ClevelandDC8933    |cle.parquet             |2021-09-10 10:32:03
|12386    |PortlandXfer9483   |pdx.parquet             |2021-09-10 10:32:04
|12387    |NashvilleXfer9987  |bna.parquet             |2021-09-10 10:33:01
|12388    |ClevelandXfer8998  |cle.parquet             |2021-09-10 10:32:03
[...]
```
