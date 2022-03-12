---
layout: default
title: DML commands
description: Reference for the SQL DML commands available in Firebolt.
nav_order: 3
parent: SQL commands reference
---

# DML commands
{: .no_toc}

* Topic ToC
{: toc}

## INSERT INTO

Inserts one or more values into a specified table. Specifying column names is optional.

{: .note}
The `INSERT INTO` operation is not atomic. If the operation is interrupted, partial data ingestion may occur. For more information, see [Checking and validating INSERT INTO status](#checking-and-validating-insert-into-status) below.

#### Syntax
{: .no_toc}

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
{: .no_toc}

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


### Checking and validating INSERT INTO status
{: .no_toc}

If an `INSERT INTO` statement fails or a client is disconnected, Firebolt might ingest an incomplete data set into the target table. Here are some steps you can use to determine the status of an ingestion operation and ensure it ran successfully. This may come in handy if you suspect your statement failed for any reason.

* Before running any queries, first check to make sure that the `INSERT INTO` query has completed. This can be done by viewing the information schema through the [`running_queries`](../../general-reference/information-schema/running-queries.md) view:

```sql
SELECT * FROM catalog.running_queries
```

You should see results similar to those shown below.

![](../../assets/images/running_queries.png)

If you see your `INSERT INTO` statement under the `QUERY_TEXT` column, the operation is still running. Wait for it to finish before attempting any other steps.

* If the `INSERT INTO` statement has finished, check that the external table and the target fact or dimension table have an equal number of rows.

The SQL statement below counts the rows in an external table, `my_extable`, and a fact or dimension table, `my_fact_table`. It compares the results and returns the comparison as `CountResult`. A `CountResult` of `1` is true, indicating that the row count is equal. A value of `0` is false, indicating the row count is not equal and ingestion might be incomplete. This statement assumes the fact or dimension table ingested all of the rows from the external table, and not a partial subset.

```sql
SELECT (SELECT COUNT(*) FROM my_extable)=(SELECT COUNT(*) FROM fact_or_dim_table) AS CountResult;
```

* If the counts are not equal, [DROP](https://docs.firebolt.io/sql-reference/commands/ddl-commands#drop) the incomplete target table, create a new target table, change the `INSERT INTO` query to use the new target, and then run the query again.

## COPY TO (Beta)

Copies (exports) the results of a `SELECT` query to an Amazon S3 location in the file format that you specify.

### Syntax
{: .no_toc}

```sql
COPY (<select_query>)
  TO '<s3_location>'
  CREDENTIALS = <aws_credentials>
[ TYPE = CSV | TSV | JSON | PARQUET ]
[ COMPRESSION = GZIP | NONE ]
[ INCLUDE_QUERY_ID_IN_FILE_NAME = TRUE | FALSE ]
[ FILE_NAME_PREFIX = <file_string> ]
[ SINGLE_FILE = FALSE | TRUE ]
[ MAX_FILE_SIZE = <bytes> ]
[ OVERWRITE_EXISTING_FILES = FALSE | TRUE ]
```

| Parameter | Description |
| :-------- | :---------- |
| `<select_query>`  | Any valid `SELECT` statement.|
| `<s3_location>` | The path to an S3 location where the query result file or files are saved. For example, `s3://my_bucket/my_folder`.|
| `CREDENTIALS` | The Amazon S3 credentials for accessing the specified `<s3_location>`. See [CREDENTIALS](#credentials) below.|
| `TYPE`            | Specifies the file type to save to S3. If omitted, `CSV` is the default. |
| `COMPRESSION`     | Specifies whether file compression is used. If omitted, defaults to `GZIP` compression format. If `NONE` is specified, exported files are not compressed.|
| `INCLUDE_QUERY_ID_IN_FILE_NAME` | Specifies whether a query ID is included in the file name. Each time the statement runs, Firebolt generates a new query ID. If omitted, defaults to `TRUE`, and Firebolt saves file names using the pattern `<query_id>.[type].gz`, for example, `123ABCXY2.csv.gz`. This allows Firebolt to generate unique file names by default. If `FALSE`, and `FILE_NAME_PREFIX` is not specified, files are exported with a generic `output` file name, for example, `output.csv.gz`.|
| `FILE_NAME_PREFIX`              | Specifies an optional string to use in the file name. If `FILE_NAME_PREFIX` is omitted and `INCLUDE_QUERY_ID_IN_FILE_NAME` is `TRUE`, the exported file name is in the pattern `<query_id><file_string>.<type>.gz`. If `FILE_NAME_PREFIX` is specified and `INCLUDE_QUERY_ID_IN_FILE_NAME` is set to `FALSE`, the specified string replaces `output` and the file is in the pattern `<file_string>.<type>.gz`. |
| `SINGLE_FILE`                   | Specifies whether the export should be a single file or multiple files. If omitted, the default is `FALSE`, and the export is split based on the `MAX_FILE_SIZE` value. Exported files are appended with `_<n>` incrementally to indicate the position in series, starting with `0`. For example, the first file in a series might be named `123ABCXY2_0.parquet.gz`. If `TRUE`, only a single file is written. If set to `TRUE` and the file exceeds `MAX_FILE_SIZE`, an error occurs. |
| `MAX_FILE_SIZE`                 | Specifies the max file size in bytes. If omitted, the default value is `16000000` (16 MB). The maximum file size that can be specified is `5000000000` (5 GB). |
| `OVERWRITE_EXISTING_FILES`      | Specifies whether exported files should overwrite existing files of the same name in the specified S3 location. If omitted, defaults to `FALSE`, and files of the same name are not overwritten. |

#### CREDENTIALS
{: .no_toc}

Firebolt needs permissions to write query results to the specified S3 location. You can specify IAM credentials using either the Amazon Resource Name (ARN) of an IAM role or AWS access keys, and the specified credentials must be associated with a user or role with permissions to write objects to the bucket.

#### Specifying an IAM Role
{: .no_toc}

Specify an AWS IAM Role ARN using the syntax shown below.

```sql
CREDENTIALS = (AWS_ROLE_ARN=<role_arn>) [AWS_ROLE_EXTERNAL_ID='<external_id>']
```

* `<role_arn>` is the ARN of a role that you have configured for Firebolt access to the specified `<s3_location>`, for example, `arn:aws:iam::123456789012:role/my-firebolt-access-role`.
* `<external_id>` is an optional arbitrary string that you assign to an IAM role when you create it, for example, `99291`.

For more information about creating roles for Firebolt, see [Using AWS roles to access Amazon S3](../../loading-data/configuring-aws-role-to-access-amazon-s3.md).

#### Specifying AWS access keys
{: .no_toc}

Specify access key credentials using the syntax shown below.

```sql
CREDENTIALS = (AWS_KEY_ID = '<aws_key_id>' AWS_SECRET_KEY = '<aws_secret_key>')
```

* `<aws_key_id>` is the AWS access key id associated with a user or role, for example, `AKIAIOSFODNN7EXAMPLE`.
* `<aws_secret_key>` is the AWS secret key, for example, `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`.

For more information about access keys, see [Programmatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) in the *AWS General Reference*.

#### Least privileged permissions
{: .no_toc}

The example AWS IAM policy statement below demonstrates the minimum actions that must be allowed for Firebolt to write query files to an example S3 location. A permissions policy that allows at least these actions for the `<s3_location>` that you specify in the `COPY TO` statement must be attached to the user or role specified in the `CREDENTIALS` clause.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::my_s3_bucket",
                "arn:aws:s3:::my_s3_bucket/*"
            ]
        }
    ]
}
```

### Examples
{: .no_toc}

* [COPY TO with defaults and role ARN](#copy-to-with-defaults-and-role-arn)
* [COPY TO with single file and AWS access keys](#copy-to-with-single-file-and-aws-access-keys)
* [COPY TO with custom file name prefix and ARN with external ID](#copy-to-with-custom-file-name-prefix-and-arn-with-external-id)
* [COPY TO with custom file name and overwrite set to TRUE](#copy-to-with-custom-file-name-and-overwrite-set-to-true)

#### COPY TO with defaults and role ARN
{: .no_toc}

The example below shows a `COPY TO` statement with minimal parameters that specifies an `AWS_ROLE_ARN`. Because `TYPE` is omitted, the file or files will be written in CSV format, and because `COMPRESSION` is omitted, they are compressed using GZIP  (`*.csv.gz`).

```sql
COPY (SELECT * FROM test_table)
  TO 's3://my_bucket/my_fb_queries'
  CREDENTIALS = (AWS_ROLE_ARN='arn:aws:iam::123456789012:role/my-firebolt-role');
```

Firebolt assigns the query ID `16B903C4206098FD` to the query at runtime. The compressed output is 40 MB, exceeding the default of 16 MB, so Firebolt writes 4 files as shown below.

```bash
s3://my_bucket/my_fb_queries/
  16B903C4206098FD_0.csv.gz
  16B903C4206098FD_1.csv.gz
  16B903C4206098FD_2.csv.gz
  16B903C4206098FD_3.csv.gz
```

#### COPY TO with single file and AWS access keys
{: .no_toc}

The example below exports a single, uncompressed JSON file with the same name as the query ID. If the file to be written exceeds the specified `MAX_FILE_SIZE` (5 GB), an error occurs. AWS access keys are specified for credentials.

```sql
COPY (SELECT * FROM test_table)
  TO 's3://my_bucket/my_fb_queries'
  TYPE=JSON
  COMPRESSION=NONE
  CREDENTIALS=(AWS_KEY_ID='AKIAIOSFODNN7EXAMPLE' AWS_SECRET_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY')
  INCLUDE_QUERY_ID_IN_FILE_NAME=TRUE
  SINGLE_FILE=TRUE
  MAX_FILE_SIZE=5000000000;
```

Firebolt writes a single file as shown below.

```bash
s3://my_bucket/my_fb_queries/
  16B90E96716236D0.json
```

#### COPY TO with custom file name prefix and ARN with external ID
{: .no_toc}

In the example below, because `FILE_NAME_PREFIX` parameter is specified, Firebolt adds a string to the query ID to form file names. The IAM role specified for `CREDENTIALS` also has an external ID configured in AWS, so the ID is specified.

```sql
COPY (SELECT * FROM test_table)
  TO 's3://my_bucket/my_fb_queries'
  TYPE=JSON
  COMPRESSION=NONE
  CREDENTIALS = (AWS_ROLE_ARN='arn:aws:iam::123456789012:role/my-firebolt-role' AWS_ROLE_EXTERNAL_ID='99291')
  FILE_NAME_PREFIX='_query_result';
```

Firebolt assigns the query an id of `16B90E96716236D6` at runtime and writes files as shown below.

```bash
s3://my_bucket/my_fb_queries/
  16B90E96716236D6_query_result_0.json
  16B90E96716236D6_query_result_1.json
  16B90E96716236D6_query_result_2.json
  16B90E96716236D6_query_result_3.json
  16B90E96716236D6_query_result_4.json
```  

#### COPY TO with custom file name and overwrite set to TRUE
{: .no_toc}

In the example below, `INCLUDE_QUERY_ID_IN_FILE_NAME` is set to `FALSE` and a `FILE_NAME_PREFIX` is specified. In this case, Firebolt writes files using only the specified `FILE_NAME_PREFIX` as the file name. In addition, `SINGLE_FILE` and `OVERWRITE_EXISTING_FILES` are set to `TRUE` so that the S3 location always contains a single file with the latest query results.

```sql
COPY (SELECT * FROM test_table)
  TO 's3://my_bucket/my_fb_query'
  TYPE=JSON
  COMPRESSION=NONE
  CREDENTIALS=(AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/my-firebolt-role')
  INCLUDE_QUERY_ID_IN_FILE_NAME=FALSE
  SINGLE_FILE=TRUE
  FILE_NAME_PREFIX='latest-fb-query-result'
  MAX_FILE_SIZE=5000000000
  OVERWRITE_EXISTING_FILES=TRUE;
```

Firebolt writes a single file as shown below.

```bash
s3://my_bucket/my_fb-query/
  latest-fb-query-result.json
```
