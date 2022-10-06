---
layout: default
title: CREATE EXTERNAL TABLE
description: Reference and syntax for the CREATE EXTERNAL TABLE command.
parent: SQL commands
---

# CREATE EXTERNAL TABLE
{: .no_toc}

Creates an external table. External tables serve as connectors to your external data sources. External tables contain no data within Firebolt other than metadata virtual columns that are automatically populated with metadata. For more information, see [Working with external tables](../../loading-data/working-with-external-tables.md). Data that you ingest must be in an Amazon S3 bucket in the same AWS Region as the Firebolt database.

* ToC
{:toc}

## Syntax

```sql
CREATE EXTERNAL TABLE [IF NOT EXISTS] <external_table_name>
(
    <column_name> <column_type>[ PARTITION('<regex>')]
    [, <column_name2> <column_type2> [PARTITION('<regex>')]]
    [,...<column_name2> <column_type2> [PARTITION('<regex>')]]
)
[CREDENTIALS = (<awsCredentials>)]
URL = 's3://<bucket_name>[/<folder>][/...]/'
OBJECT_PATTERN = '<object_pattern>'[, '<object_pattern>'[, ...n]]]
TYPE = (<type> [typeOptions])
[COMPRESSION = <compression_type>]
```

| Parameter                  | Description |
|: ------------------------- |: ---------- |
| `<external_table_name>`    | An identifier that specifies the name of the external table. This name should be unique within the database. For identifier usage and syntax, see [Identifier requirements](../../general-reference/identifier-requirements.md). |
| `<column_name>`            | An identifier that specifies the name of the column. This name should be unique within the table.<br><b>Note:</b> If column names are using mixed case, wrap your column name definitions in double quotes (`"`); otherwise they will be translated to lower case and will not match the mixed case Parquet schema. |
| `<column_type>`            | Specifies the data type for the column. |
| `PARTITION`                | An optional keyword. When specified, allows you to use a regular expression `<regex>` to extract a value from the file prefix to be stored as the column value. For more information, see [PARTITION](#partition). |
| `CREDENTIALS`              | Specifies the AWS credentials with permission to access the S3 location specified using `URL`. For more information, see [CREDENTIALS](#credentials). |
| `URL` and `OBJECT_PATTERN` | Specifies the S3 location and the file naming pattern that Firebolt ingests when using this table. For more information, see [URL & OBJECT_PATTERN](#url-and-object_pattern). |
| `TYPE`                     | Specifies the file type Firebolt expects to ingest given the `OBJECT_PATTERN`. If a file referenced using `OBJECT_PATTERN` does not conform to the specified `TYPE`, an error occurs. For more information, see [TYPE](#type). |
| `COMPRESSION`              | See [COMPRESSION](#compression). |

### PARTITION

In some applications, such as Hive partitioning, table partitions are stored in S3 folders and files using a folder naming convention that identifies the partition. The `PARTITION` keyword allows you to specify a regular expression, `<regex>`, to extract a portion of the file path and store it in the specified column when Firebolt uses the external table to ingest partitioned data.

Using `PARTITION` in this way is one method of extracting partition data from file paths. Another method is to use the table metadata column, `source_file_name`, during the `INSERT INTO` operation. For more information, see [Example&ndash;extracting partition values using INSERT INTO](insert-into.md#extracting-partition-values-using-insert-into).

#### Guidelines for creating the regex
{: .no_toc}

* The regular expression is matched against the object prefix, not including the `s3://<bucket_name>/` portion of the prefix.
* You can specify as many `PARTITION` columns as you need, each extracting a different portion of the object prefix.
* For each `PARTITION` column, you must specify a regular expression that contains a capturing group, which determines the column value.
* When `<column_type>` is `DATE`, Firebolt requires three capturing groups that must be in the order of year, month, and day.
* Firebolt tries to convert the captured string to the specified `<column_type>`. If the type conversion fails, a `NULL` is entered.

In most cases, the easiest way to build a regular expression is as follows:

1. Count the number of folders in the path, not including the bucket name.
2. Concatenate the string `[^\/]+\/` according to the number of folders.
3. Prefix the regex with an additional `[^\/]+` for the file name.
4. Wrap the `[^\/]+` in the right folder with a capturing group parenthesis, such as `([^\/]+).`

For more information, see [Match groups](https://regexone.com/lesson/capturing_groups) on the RegexOne website. To test your regular expressions, online tools such as [regex101](https://regex101.com) are available.

#### Example&ndash;extract Hive-compatible partitions
{: .no_toc}

The example below demonstrates a `CREATE EXTERNAL TABLE` statement that creates the table `my_ext_table`. This table is used to ingest all files with a `*.parquet` file extension in any sub-folder of the S3 bucket `s3://my_bucket`.

Consider an example where folders and files in the bucket have the following consistent pattern, which is common for Hive partitions:

```
s3://my_bucket/c_type=xyz/year=2018/month=01/part-00001.parquet
s3://my_bucket/c_type=xyz/year=2018/month=01/part-00002.parquet
s3://my_bucket/c_type=abc/year=2018/month=01/part-00001.parquet
s3://my_bucket/c_type=abc/year=2018/month=01/part-00002.parquet
[...]
```

In the example `CREATE EXTERNAL TABLE` statement below, the `PARTITION` keyword in the column definition for `c_type` specifies a regular expression. This expression extracts the portion of the S3 path name that correspond to the `xyz` or `abc` within `c_type=xyz` or `c_type=abc`.

```sql
CREATE EXTERNAL TABLE my_ext_table (
  c_id    INT,
  c_name  TEXT,
  c_type  TEXT PARTITION('[^\/]+\/c_type=([^\/]+)\/[^\/]+\/[^\/]+')
)
CREDENTIALS = (AWS_ROLE_ARN = 'arn:aws:iam::123456789012:role/MyRoleForFireboltS3Access1')
URL = 's3://my_bucket/'
OBJECT_PATTERN= '*.parquet'
TYPE = (PARQUET)
```
When Firebolt ingests the data from a Parquet file stored in that path, the `c_type` column for each row contains the extracted portion of the path. For the files listed above, the extraction results in the following values. `c_id` and `c_name ` are values stored within the respective Parquet files, while `c_type` are values extracted from the file path.

| c_id       | c_name     | c_type |
|: --------- |: --------- |: ----- |
| 1ef4302294 | Njimba     | xyz    |
| 8b98470659 | Yuang      | xyz    |
| 98734hkk89 | Cole       | xyz    |
| 38cjodjlo8 | Blanda     | xyz    |
| 448dfgkl12 | Harris     | abc    |
| j987rr3233 | Espinoza   | abc    |

### CREDENTIALS

The credentials for accessing your AWS S3. Firebolt enables using either access key & secret or IAM role.

#### Syntax&ndash;authenticating using an access key and secret

```sql
CREDENTIALS = (AWS_KEY_ID = '<aws_key_id>' AWS_SECRET_KEY = '<aws_secret_key>' )
```

| Parameter          | Description                                             | Data type |
|: ------------------ |: ------------------------------------------------------- |: --------- |
| `<aws_key_id>`     | The AWS access key ID for the authorized app (Firebolt) | TEXT      |
| `<aws_secret_key>` | The AWS secret access key for the app (Firebolt)        | TEXT      |

{: .note}
In case you don't have the access key and secret to access your S3 bucket, read more [here](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) on how to obtain them.

#### Syntax&ndash;authenticating using an IAM role

Read more on how to configure the AWS role [here](../../loading-data/configuring-aws-role-to-access-amazon-s3.md).

```sql
CREDENTIALS = (AWS_ROLE_ARN = '<role_arn>' [AWS_ROLE_EXTERNAL_ID = '<external_id>'])
```

| Parameter         | Description                                                                                                                                   | Data type |
| :----------------- |: --------------------------------------------------------------------------------------------------------------------------------------------- |: --------- |
| `'<role_arn>'`    | The arn\_role you created in order to enable access to the required bucket.                                                                   | TEXT      |
| `'<external_id>'` | Optional. This is an optional external ID that you can configure in AWS when creating the role. Specify this only if you use the external ID. | TEXT      |

### URL and OBJECT_PATTERN

The`URL`and`OBJECT_PATTERN`parameters are used together to match the set of files from within the specified bucket that you wish to include as the data for the external table. The S3 bucket that you reference must be in the same AWS Region as the Firebolt database.

#### Syntax
{: .no_toc}

```sql
URL = 's3://<bucket>[/<folder>][/...]/'
OBJECT_PATTERN = '<object_pattern>'
```

| Parameters       | Description                                                                                                                          | Data type |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------------------ | :--------- |
| `URL`            | This is the URL of the specific bucket and path within the bucket where the relevant files are located (common path prefix).         | TEXT      |
| `OBJECT_PATTERN` | Specify the data pattern to be found in your data source. For example, \*.parquet indicates that all parquet files should be found. | TEXT      |

The following wildcards are supported:

* `'*'` matches any sequence of characters
* `'?'` matches any single character
* `[SET]` matches any single character in the specified set
* `[!SET]` matches any character, not in the specified set.

#### Example
{: .no_toc}

In the following layout of objects in a bucket, the data is partitioned according to client type, year, and month, with multiple parquet files in each partition. The examples demonstrate how choosing both URL and OBJECT\_PATTERN impacts the objects that are retrieved from S3.

```
s3://bucket/c_type=c_type=xyz/year=2018/month=01/part-00001.parquet
s3://bucket/c_type=c_type=xyz/year=2018/month=01/part-00002.parquet
...
s3://bucket/c_type=c_type=xyz/year=2018/month=12/part-00001.parquet
s3://bucket/c_type=c_type=xyz/year=2018/month=12/part-00002.parquet
...
s3://bucket/c_type=c_type=xyz/year=2019/month=01/part-00001.parquet
s3://bucket/c_type=c_type=xyz/year=2019/month=01/part-00002.parquet
...
s3://bucket/c_type=c_type=xyz/year=2020/month=01/part-00001.parquet
s3://bucket/c_type=c_type=xyz/year=2020/month=01/part-00002.parquet
...
s3://bucket/c_type=c_type=abc/year=2018/month=01/part-00001.parquet
s3://bucket/c_type=c_type=abc/year=2018/month=01/part-00002.parquet
...
```

Following are some common use cases for URL and object pattern combinations:

| Use cases  | Syntax  |
| :--- | :--- |
| Get all files for file type xyz     | *URL = 's3://bucket/c_type=xyz/'* <br> *OBJECT_PATTERN = '\*'*     |
|                                     | *URL = 's3://bucket/'<br>OBJECT_PATTERN = 'c_type=xyz/\*'*         |
| Get one specific file: `c_type=xyz/year=2018/month=01/part-00001.parquet` | *URL = 's3://bucket/c_type=xyz/year=2018/month=01/'<br> OBJECT_PATTERN = 'c_type=xyz/year=2018/month=01/part-00001.parquet'<br> <br> URL = 's3://bucket/c_type=xyz/year=2018/month=01/'<br> OBJECT_PATTERN = '\*/part-00001.parquet'*<br><br>As can be seen in this example, the `URL` is used to get only the minimal set of files (c_type files in the bucket from January 2018), and then from within those matching files, the `OBJECT_PATTERN` is matched against the full path of the file (without the bucket name).  |
| Get all parquet files for type xyz  | *URL = 's3://bucket/c_type=xyz/'<br> OBJECT_PATTERN = '\*.parquet'*  |

### TYPE

Specifies the type of the files in S3. The following types and type options are supported.

* `TYPE = (CSV [SKIP_HEADER_ROWS = {1|0}])`  
With `TYPE = (CSV SKIP_HEADER_ROWS = 1)`, Firebolt assumes that the first row in each file read from S3 is a header row and skips it when ingesting data. When set to `0`, which is the default if not specified, Firebolt ingests the first row as data.  

* `TYPE = (JSON [PARSE_AS_TEXT = {'TRUE'|'FALSE'}])`  
With `TYPE = (JSON PARSE_AS_TEXT = 'TRUE')`, Firebolt ingests each JSON object literal in its entirety into a single column of type `TEXT`. With `TYPE = (JSON PARSE_AS_TEXT = 'FALSE')`, Firebolt expects each key in a JSON object literal to map to a column in the table definition. During ingestion, Firebolt inserts the key's value into the corresponding column.  

* `TYPE = (ORC)`
* `TYPE = (PARQUET)`
* `TYPE = (TSV)`

#### Example
{: .no_toc}

Creating an external table that reads parquet files from S3 is being done with the following statement:

```sql
CREATE EXTERNAL TABLE my_external_table
(
    c_id INT,
    c_name TEXT
)
CREDENTIALS = (AWS_KEY_ID = '*****' AWS_SECRET_KEY = '******')
URL = 's3://bucket/'
OBJECT_PATTERN= '*.parquet'
TYPE = (PARQUET)
```

### COMPRESSION

Specifies the compression type of the files matching the specified `OBJECT_PATTERN` in S3.

#### Syntax
{: .no_toc}

```sql
[COMPRESSION = <compression_type>]
```

| Parameters            | Description                                                        |
| :-------------------- |:------------------------------------------------------------------ |
| `<compression_type>`  | Specifies the compression type of files. `GZIP` is supported. |

#### Example
{: .no_toc}

The example below creates an external table to ingest CSV files from S3 that are compressed using gzip. The credentials for an IAM user with access to the bucket are provided.

```sql
CREATE EXTERNAL TABLE my_external_table
(
    c_id INT,
    c_name TEXT
)
CREDENTIALS = (AWS_KEY_ID = 'AKIAIOSFODNN7EXAMPLE' AWS_SECRET_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY')
URL = 's3://mybucket/'
OBJECT_PATTERN= '*.csv.gz'
TYPE = (CSV)
COMPRESSION = GZIP
```

### CREATE EXTERNAL TABLE based on an AWS Glue table
In addition to other `CREATE EXTERNAL TABLE` clauses, the `META_STORE` clause provides information to connect to an AWS Glue database and table.

#### Syntax
{: .no_toc}

```sql
META_STORE = (TYPE='Glue' DATABASE_NAME=<db_name> TABLE_NAME=<table_name>)
```

| Parameter |Description| Data type |
|:--------- | :-------- | :--------- |
| `<db_name>`| The name of the database in AWS Glue. | TEXT      |
| `<table_name>` | The name of the table in AWS Glue. | TEXT      |

#### Additional AWS permissions
{: .no_toc}
To access AWS Glue, make sure that the principal that Firebolt uses to access the specified S3 location and Glue metastore is allowed the following actions in the AWS permissions Policy.

* `"s3:GetObject"`
* `"s3:GetObjectVersion"`
* `"s3:GetBucketLocation"`
* `"s3:ListBucket"`
* `"glue:GetTables"`

A [policy template](https://firebolt-publishing-public.s3.amazonaws.com/documentationAssets/templated_glue_policy.txt) is available to download.

* Replace `<bucket>`and`<prefix>`with the actual AWS S3 bucket name path and prefix where the AWS Glue data is stored.
* `<db_name>`with the name of the AWS Glue database.

#### Example
{: .no_toc}

An external table based on an AWS Glue table `'glue_table'` in `'glue_db'` database:

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS
  my_external_table
CREDENTIALS = ( AWS_KEY_ID = 'AKIAIOSFODNN7EXAMPLE' AWS_SECRET_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY' )
META_STORE = (TYPE='Glue' DATABASE_NAME='glue_db' TABLE_NAME='glue_table')
```
