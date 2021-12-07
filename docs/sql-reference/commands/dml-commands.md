---
layout: default
title: DML commands
nav_order: 3
parent: SQL commands reference
---

# Data manipulation language (DML) statements

## INSERT INTO

Inserts one or more values into a specified table. Specifying column names is optional.

{: .note}
The INSERT INTO operation is not atomic. If the operation is interrupted, partial data ingestion may occur.

**Syntax**

```sql
INSERT INTO <table_name> [(<col1>[, <col2>][, ...])]
{ <select_statement> | VALUES ([<val1>[, <val2>][, ...]) }
```

| Parameter                                                                                                                | Description                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| `<table_name>`                                                                                                           | The target table where values are to be inserted.                                                                                    |
| `(<col1>[, <col2>][, ...])]`                                                                                             | A list of column names from `<table_name>` for the insertion. If not defined, the columns are deduced from the `<select_statement>`. |
| <p><code>&#x3C;select_statement></code></p><p>--OR--</p><p><code>VALUES ([&#x3C;val1>[, &#x3C;val2>][, ...])]</code></p> | You can specify either a `SELECT` query that determines values to or an explicit list of `VALUES` to insert.                         |

**Example: extracting partition values using the INSERT INTO command**

In some cases, your files, stored on AWS S3, may be organized in partitions. Assume we have files with the following paths in S3:

```
s3://my_bucket/xyz/2018/01/part-00001.parquet
s3://my_bucket/xyz/2018/01/part-00002.parquet
...
s3://my_bucket/abc/2018/01/part-00001.parquet
s3://my_bucket/abc/2018/01/part-00002.parquet
```

Our goal is to extract a value called `c_type` which is stored in the 2nd path segment of each file path.

For example, the following file in S3:

```
s3://my_bucket/xyz/2018/01/part-00001.parquet
```

Has the following `c_type` value:

```
xyz
```

Assume we have an external table that was created using the following DDL:

```sql
CREATE EXTERNAL TABLE my_external_table
(
    c_id    INT,
    c_name  TEXT
)
CREDENTIALS = (AWS_KEY_ID = '*****' AWS_SECRET_KEY = '******')
URL = 's3://my_bucket/'
OBJECT_PATTERN= '*.parquet'
TYPE = (PARQUET)
```

And, also, a FACT table was created using the following DDL which we want to ingest data into:

```sql
CREATE FACT TABLE my_table
(
    c_id    INT,
    c_name  TEXT,
    c_type  TEXT
) PRIMARY INDEX c_id
```

We are going to extract the data for `c_type` from a metadata column in our external table called `source_file_name`. We can accomplish this by using the following `INSERT INTO` query:

```sql
INSERT INTO my_table (c_id, c_name, c_type)
SELECT
    c_id,
    c_name,
    SPLIT_PART(source_file_name, '/', 1) AS c_type
FROM my_external_table
```

{: .note}
We have specified 1 in the `SPLIT_PART` function since the bucket name is not included in the `source_file_name.`

## **Checking and validating INSERT INTO status**

If an `INSERT INTO` statement fails or a client is disconnected, Firebolt might ingest an incomplete data set into the target table. Here are some steps you can use to determine the status of an ingestion operation and ensure it ran successfully. This may come in handy if you suspect your statement failed for any reason.

* Before running any queries, first check to make sure that the `INSERT INTO` query has completed. This can be done by viewing the information schema through the [`running_queries`](../../general-reference/information-schema/running-queries.md) view:

```sql
SELECT * FROM catalog.running_queries
```

You should see results similar to this:

![](../../.gitbook/assets/running\_queries.png)

If you see your `INSERT INTO` statement under the `QUERY_TEXT` column, then that means the operation is still running. You should wait for it to finish before attempting any other steps.

* If the INSERT INTO statement has completed, check that the external table and the target fact or dimension table are equal. _\*\*_

The SQL statement below counts the rows in an external table `my_extable` and a fact or dimension table, `fact_or_dim_table`. It compares the results and returns that result of the comparison as `CountResult`. A `CountResult` of 1 is true, indicating the row count is equal. A value of 0 is false, indicating the row count is not equal and ingestion may be incomplete.

```sql
SELECT (SELECT COUNT(*) FROM my_extable)=(SELECT COUNT(*) FROM fact_or_dim_table) AS CountResult;
```

This statement assumes the fact or dimension table ingested all of the rows from the external table, and not a partial subset.

* If the counts are not equal, [`DROP`](https://docs.firebolt.io/sql-reference/commands/ddl-commands#drop) `` the incomplete target table, create a new target table, change the `INSERT INTO` query to use the new target, and then run the query again.
