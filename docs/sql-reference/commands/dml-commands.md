---
layout: default
title: DML commands
description: Reference for the SQL DML commands available in Firebolt.
nav_order: 3
parent: SQL commands reference
---

# DML commands
Firebolt supports `INSERT INTO`.

## INSERT INTO

Inserts one or more values into a specified table. Specifying column names is optional.

{: .note}
The `INSERT INTO` operation is not atomic. If the operation is interrupted, partial data ingestion may occur.

#### Syntax

```sql
INSERT INTO <table_name> [(<col1>[, <col2>][, ...])]
{ <select_statement> | VALUES ([<val1>[, <val2>][, ...]) }
```

| Parameter | Description|
| :---------| :----------|
| `<table_name>`| The target table where values are to be inserted. |
| `(<col1>[, <col2>][, ...])]`| A list of column names from `<table_name>` for the insertion. If not defined, the columns are deduced from the `<select_statement>`. |
| `<select_statement>`<br>--OR--<br> `VALUES ([<val1>[, <val2>][, ...])]` | You can specify either a `SELECT` query that determines values to or an explicit list of `VALUES` to insert.|

### Extracting partition values using INSERT INTO

In some applications, such as Hive partitioning, table partitions are stored in Amazon S3 folders and files using a folder naming convention that identifies the partition. To extract partition information from the file path and store it with the data that you ingest, you can use the value that Firebolt automatically saves to the `source_file_name` metadata column for external tables. You can use a string operator in your `INSERT INTO` statement to extract a portion of the file path, and then store the result of the extraction in a virtual column in the fact table. For more information about metadata columns, see [Using metadata virtual columns](../../loading-data/working-with-external-tables.md#using-metadata-virtual-columns).

Using the `source_file_name` metadata column during an `INSERT INTO` operation is one method of extracting partition data from file paths. Another method is to use the `PARTITION` keyword for a column in the external table definition. For more information, see the [PARTITION](ddl-commands.md#partition) keyword explanation in the `CREATE EXTERNAL TABLE` reference.

#### Example

Consider an example where folders and files in an S3 bucket have the following consistent pattern for partitions:

```
s3://my_bucket/xyz/2018/01/part-00001.parquet
s3://my_bucket/xyz/2018/01/part-00002.parquet
s3://my_bucket/abc/2018/01/part-00001.parquet
s3://my_bucket/abc/2018/01/part-00002.parquet
[...]
```

The `xyz` and `abc` portions of the S3 path above correspond to a value called `c_type`, which we want to store in the fact table alongside the values that we ingest from the parquet file in that partition.

In this example, the DDL statement below defines the external table that is used to ingest the data values for `c_id` and `c_name` from the Parquet files.

```sql
CREATE EXTERNAL TABLE my_ext_table (
  c_id    INT,
  c_name  TEXT,
)
CREDENTIALS = (AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/MyRoleForFireboltS3Access1')
URL = 's3://my_bucket/'
OBJECT_PATTERN= '*.parquet'
TYPE = (PARQUET)
```

To use `source_file_name` to extract a portion of the folder name. The first step is to create an additional column, `c_type`, when we create the fact table that is the target of the `INSERT INTO` operation. The `c_type` column will store the values that we extract.

```sql
CREATE FACT TABLE my_table
(
    c_id    INT,
    c_name  TEXT,
    c_type  TEXT
) PRIMARY INDEX c_id
```

The example below shows the `INSERT INTO` statement that performs the ingestion and populates `c_type` with a value extracted from the partition file path.

The `SELECT` clause uses the `SPLIT_PART` function on the external table's `source_file_name` metadata column, inserting the result into the   `c_type` column. The `source_file_name` metadata value contains the path and file name, without the bucket. For example, data values ingested from the `s3://my_bucket/xyz/2018/01/part-00001.parquet` file have a corresponding `source_file_name` value of `xyz/2018/01/part-00001.parquet`. The function shown in the example below returns `xyz` because the index is 1. For more information, see [SPLIT_PART](../functions-reference/string-functions.md#split_part).

```sql
INSERT INTO my_table (c_id, c_name, c_type)
SELECT
    c_id,
    c_name,
    SPLIT_PART(source_file_name, '/', 1) AS c_type
FROM my_external_table
```

## Checking and validating INSERT INTO status

If an `INSERT INTO` statement fails or a client is disconnected, Firebolt might ingest an incomplete data set into the target table. Here are some steps you can use to determine the status of an ingestion operation and ensure it ran successfully. This may come in handy if you suspect your statement failed for any reason.

* Before running any queries, first check to make sure that the `INSERT INTO` query has completed. This can be done by viewing the information schema through the [`running_queries`](../../general-reference/information-schema/running-queries.md) view:

```sql
SELECT * FROM catalog.running_queries
```

You should see results similar to this:

![](../../assets/images/running_queries.png)

If you see your `INSERT INTO` statement under the `QUERY_TEXT` column, then that means the operation is still running. You should wait for it to finish before attempting any other steps.

* If the INSERT INTO statement has completed, check that the external table and the target fact or dimension table are equal. _\*\*_

The SQL statement below counts the rows in an external table `my_extable` and a fact or dimension table, `fact_or_dim_table`. It compares the results and returns that result of the comparison as `CountResult`. A `CountResult` of 1 is true, indicating the row count is equal. A value of 0 is false, indicating the row count is not equal and ingestion may be incomplete.

```sql
SELECT (SELECT COUNT(*) FROM my_extable)=(SELECT COUNT(*) FROM fact_or_dim_table) AS CountResult;
```

This statement assumes the fact or dimension table ingested all of the rows from the external table, and not a partial subset.

* If the counts are not equal, [DROP](https://docs.firebolt.io/sql-reference/commands/ddl-commands#drop) the incomplete target table, create a new target table, change the `INSERT INTO` query to use the new target, and then run the query again.

## COPY TO (Beta)

A `COPY TO` statement copies results from a query operation to an Amazon S3 bucket. This command is currently in beta stage and is being further developed.&#x20;

**Syntax**

```sql
COPY ( <select_query> )
TO ' <bucket/prefix> '
CREDENTIALS = <awsCredentials>
[ TYPE = CSV | TSV | JSON | PARQUET ]
[ COMPRESSION = GZIP | NONE ]
[ INCLUDE_QUERY_ID_IN_FILE_NAME = TRUE | FALSE ]
[ FILE_NAME_PREFIX = <text> ]
[ SINGLE_FILE = FALSE | TRUE ]
[ MAX_FILE_SIZE = 16000000 ]
[ OVERWRITE_EXISTING_FILES = FALSE | TRUE ]
```

| Parameter | Description |
| :-------- | :---------- |
| `<select_query>`  | Any valid `SELECT` statement used to query a data table.|
| `<bucket/prefix>` | The path to an S3 location where the query results are to be stored.|
| `<awsCredentials>`| The authentication credentials for accessing your AWS S3. This can be an access key and secret key, or you can use IAM credentials. More information on obtaining these can be found in our [documentation](../../loading-data/configuring-aws-role-to-access-amazon-s3.html)|
| `COMPRESSION`     | Defaults to GZIP compression format for file exports. If `NONE` is specified, file exports will not be compressed.|
| `INCLUDE_QUERY_ID_IN_FILE_NAME` | Specifies if a query ID is included in the file name. Defaults to `TRUE`. If `TRUE`, files are exported as `<query_id>.[type].gz`, for example `123ABCXY2.parquet.gz`. If `FALSE`, files as exported as `output.[type].gz`, for example, `output.parquet.gz`. We recommend including `<query_id>` or providing a unique name for exported files to avoid potential overwriting errors.|
| `FILE_NAME_PREFIX`              | A string to use as a custom file name. The default is an empty string. The specified string is appended to the file name, based on the `INCLUDE_QUERY_ID_IN_FILE_NAME` parameter.<br> If `INCLUDE_QUERY_ID_IN_FILE_NAME` is `TRUE`, the exported file name would be `<query_id><file_name>.[type].gz`.<br> If `FALSE`, the specified string would replace the default “output” file name, for example: `<file_name>.[type].gz`. |
| `SINGLE_FILE`                   | Specifies if the export should be a single or multiple files. Defaults to `FALSE`.<br> If `FALSE`, the export is split based on the `MAX_FILE_SIZE` value.<br> Exported files are appended with “_” to represent the number of the file in the series, starting with 0 and incrementing up. For example: `123ABCXY2_0.parquet.gz`<br>If `TRUE`, an error is generated if the file exceeds the value in `MAX_FILE_SIZE`. |
| `MAX_FILE_SIZE`                 | Specifies the max file size in bytes for files uploaded to the S3 bucket.<br> The default value is 16000000 (16 MB). The maximum file size allowed is 5000000000 (5 GB) |
| `OVERWRITE_EXISTING_FILES`      | Specifies whether exported files should overwrite existing files in the S3 location if they have matching names. Defaults to `FALSE`.<br> Files that do not have matching names are not affected.                                                                                                                              |

**Example 1 - COPY TO with default parameters**

The example below shows a `COPY TO` statement without any parameters. This generates a compressed csv file with the file name format `<query_id>.csv.gz` in the S3. If the data output were to exceed 16MB, the statement would generate multiple files with each being named as `<query_id>_<index>.csv.gz`.

```
COPY (
	SELECT *
	FROM test_table
	LIMIT 100
	)
	TO 's3://my_bucket/'
	CREDENTIALS = (AWS_ROLE_ARN = '*******');
```

**Returns**: `s3://my_bucket/16B903C4206098FD.csv.gz`

The newly created csv file is saved to the S3 location specified in the `TO` clause

**Example 2a - different variations of output filenames**

You can specify a single output file that will be named as the query ID. This example below generates a single json file:

```
COPY (
    SELECT *
        FROM test_table
        LIMIT 100
    )
    TO 's3://my_bucket/'
        TYPE=JSON
        COMPRESSION=NONE
        CREDENTIALS=(AWS_KEY_ID='****' AWS_SECRET_KEY='****')
        INCLUDE_QUERY_ID_IN_FILE_NAME=TRUE
        SINGLE_FILE=TRUE
        MAX_FILE_SIZE=5000000
        OVERWRITE_EXISTING_FILES=TRUE;
```

**Returns:** `s3://my_bucket/16B90E96716236D0.json`

**Example 2b**

In the example below, a string is appended to the file name by using the `FILE_NAME_PREFIX` parameter.

```
COPY (
    SELECT *
        FROM test_table
        LIMIT 100
    )
    TO 's3://my_bucket/'
        TYPE=JSON
        COMPRESSION=NONE
        CREDENTIALS=(AWS_KEY_ID='****' AWS_SECRET_KEY='****')
        INCLUDE_QUERY_ID_IN_FILE_NAME=TRUE
        FILE_NAME_PREFIX='_result'
        SINGLE_FILE=TRUE
        MAX_FILE_SIZE=5000000
        OVERWRITE_EXISTING_FILES=TRUE;
```

**Returns:** `s3://my_bucket/16B90E96716236D6_result.json`

**Example 2c**

If you prefer not to use the query ID, you can label your output file by setting `INCLUDE_QUERY_ID_IN_FILE_NAME` to false and designating a string in `FILE_NAME_PREFIX`.

```
COPY (
    SELECT *
        FROM test_table
        LIMIT 100
    )
    TO ‘s3://my_bucket’
        TYPE=JSON
        COMPRESSION=NONE
        CREDENTIALS=(AWS_KEY_ID='****' AWS_SECRET_KEY='****')
        INCLUDE_QUERY_ID_IN_FILE_NAME=FALSE
        FILE_NAME_PREFIX='result'
        SINGLE_FILE=TRUE
        MAX_FILE_SIZE=5000000
        OVERWRITE_EXISTING_FILES=TRUE;
```

**Returns:** `s3://my_bucket/result.json`

**Example 2d**

If no file name is specified and the `<query_id>` is not used, exported files will be named “output”.

```
COPY (
    SELECT *
        FROM test_table
        LIMIT 100
    )
    TO ‘s3://my_bucket’
        TYPE=JSON
        COMPRESSION=NONE
        CREDENTIALS=(AWS_KEY_ID='****' AWS_SECRET_KEY='****')
        INCLUDE_QUERY_ID_IN_FILE_NAME=FALSE
        SINGLE_FILE=TRUE
        MAX_FILE_SIZE=5000000
        OVERWRITE_EXISTING_FILES=TRUE;
```

**Returns:** `s3://my_bucket/output.json`
