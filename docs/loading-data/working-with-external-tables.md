---
layout: default
title: Working with external tables
description: Understand the role of external tables when loading data into Firebolt, and learn how to configure them to connect to your data lake.
nav_order: 1
parent: Loading data
---

# Working with external tables

Loading data into Firebolt is done using *external tables*. External tables are different from [fact and dimension tables](../working-with-tables.md). Firebolt uses an external table as a connector to your data source. No data is stored in Firebolt.

To create an external table, run the [CREATE EXTERNAL TABLE](../sql-reference/commands/create-external-table.md) command. After you create an external table, use the [INSERT INTO](../sql-reference/commands/insert-into.md) command to load the data from the external table into a fact or dimension table. Data that you ingest must be in the same AWS Region as the target Firebolt database.

{: .caution}
Although you can run a query over an external table to return query results, we don't recommend it. Such a query will be significantly slower than the same query run over the same data in a fact or dimension table because of the data transfer between Firebolt and your data store. We strongly recommend that you use external tables only for ingestion, specifying the table and its columns only in the `FROM` clause of an `INSERT INTO` statement.

## Workflows

1. For a simple end-to-end workflow that demonstrates loading data into Firebolt, see the [Getting started tutorial](../getting-started.html).  

2. For a workflow that demonstrates incrementally loading data into Firebolt, see [Incrementally loading data with Airflow](incrementally-loading-data.md).

## Supported file formats

Firebolt supports loading the following source file formats from S3: `PARQUET`, `CSV`, `TSV`, `JSON` ([JSON Lines](https://jsonlines.org/)), and `ORC`. We are quick to add support for more types, so make sure to let us know if you need it.

## Using metadata virtual columns

Firebolt external tables include metadata virtual columns that Firebolt populates with useful system data during ingestion. Firebolt includes these columns automatically. You don't need to specify them in the `CREATE EXTERNAL TABLE` statement.

When you use an external table to ingest data, you can explicitly reference these columns to ingest the metadata. First, you define the columns in a `CREATE FACT|DIMENSION TABLE` statement. Next, you specify the virtual column names to select in the `INSERT INTO` statement, with the fact or dimension table as the target. You can then query the columns in the fact or dimension table for analysis, troubleshooting, and to implement logic. For more information, see the example below.

The metadata virtual columns listed below are available in external tables.

| Metadata column name | Description | Data type |
| :--- | :--- | :--- |
| `source_file_name` | The full path of the row data's source file in Amazon S3, without the bucket. For example, with a source file of `s3://my_bucket/xyz/year=2018/month=01/part-00001.parquet`, the `source_file_name` is `xyz/year=2018/month=01/part-00001.parquet`. | TEXT |
| `source_file_timestamp` | The creation timestamp of the row's source file in S3. | TIMESTAMP |

For examples of metadata virtual column usage, see [Extracting partition values using INSERT INTO](../sql-reference/commands/insert-into.md#extracting-partition-values-using-insert-into) and [Incrementally loading data with Airflow](../loading-data/incrementally-loading-data.md).

### Example&ndash;querying metadata virtual column values

The query example below creates an external table that references an AWS S3 bucket that contains Parquet files from which Firebolt will ingest values for `c_id` and `c_name`.

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

The query example below creates a dimension table, which will be the target for the data to be ingested. The statement defines two additional columns, `source_file_name` and `source_file_timestamp`, to contain metadata values that Firebolt creates automatically for the external table.

```sql
CREATE DIMENSION TABLE my_dim_table_with_metadata
(
   c_id INT UNIQUE
   c_name TEXT,
   source_file_name TEXT,
   source_file_timestamp TIMESTAMP,
);
```

Finally, the `INSERT INTO` query below ingests the data from `my_external_table` into `my_dim_table_with_metadata`. The `SELECT` clause explicitly specifies the metadata virtual columns, which is a requirement.

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

An example `SELECT` query over `my_dim_table_with_metadata` shows that the source data file (minus the `s3://my_bucket` portion of the file path) and file timestamp are included in the dimension table for each row.

```sql
SELECT * FROM my_dim_table_with_metadata;
```

```bash
+-----------+---------------------+------------------------ +-----------------------+
| c_id      | c_name              | source_file_name        | source_file_timestamp |
+-----------+---------------------+-------------------------+-----------------------+
| 11385     | ClevelandDC8933     | central/cle.parquet     | 2021-09-10 10:32:03   |
| 12386     | PortlandXfer9483    | west/pdx.parquet        | 2021-09-10 10:32:04   |
| 12387     | PortlandXfer9449    | west/pdx.parquet        | 2021-09-10 10:32:04   |
| 12388     | PortlandXfer9462    | west/pdx.parquet        | 2021-09-10 10:32:04   |
| 12387     | NashvilleXfer9987   | south/bna.parquet       | 2021-09-10 10:33:01   |
| 12499     | ClevelandXfer8998   | central/cle.parquet     | 2021-09-10 10:32:03   |
[...]
```
