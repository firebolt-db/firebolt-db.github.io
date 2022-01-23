---
layout: default
title: DDL commands
nav_order: 4
parent: SQL commands reference
---

# DDL commands
{: .no_toc}

* Topic ToC
{:toc}

## ALTER ENGINE

The `ALTER ENGINE` command enables you to update the engine configuration.

##### Syntax
{: .no_toc}

```sql
ALTER ENGINE <engine_name> SET
    [SCALE TO <scale> [ABORT = TRUE|FALSE ]]
    [SPEC = <spec> [ABORT = TRUE|FALSE]]
    [AUTO_STOP = <minutes]
    [RENAME TO <new_name>]
    [WARMUP = <warmup_method>]
```

| Parameter                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Mandatory? Y/N |
| :----------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------- |
| `<engine_name>`                                             | Name of the engine to be altered.                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Y              |
| `SCALE = <scale>` | Valid scale numbers include any `INT` between 1 to 128.<br> <br> `ABORT` is an optional parameter (default=false):<br> <br> `ABORT=FALSE` means that currently running queries aren’t aborted. The old engine only terminates once the new engine scale is ready, and the running queries are complete.<br> <br> `ABORT=TRUE` means that once the new engine is ready, the old engine is terminated, and running queries in it are aborted. | N              |
| `SPEC = <spec>`   | Indicates the EC2 instance type, for example, 'm5.xlarge'<br><br>`ABORT` is an optional parameter (default=false) <br><br>`ABORT=FALSE` means that currently running queries aren’t aborted. The old engine only terminates once the new engine scale is ready, and the running queries are complete.<br> <br>`ABORT=TRUE` means that once the new engine is ready, the old engine is terminated, and running queries in it are aborted.          | N              |
| `AUTO_STOP = <minutes>`                                     | The number of minutes after which the engine automatically stops, where 0 indicates that `AUTO_STOP` is disabled.                                                                                                                                                                                                                                                                                                                                                                     | N              |
| `RENAME TO <new_name>`                                      | Indicates the new name for the engine.<br> <br>For example: `RENAME TO new_engine_name`                                                                                                                                                                                                                                                                                                                                                                         | N              |
| `WARMUP =<warmup_method>`                                   | The warmup method that should be used, the following options are supported:<br><br> `MINIMAL` On-demand loading (both indexes and tables' data).<br><br>`PRELOAD_INDEXES` Load indexes only (default).<br><br>`PRELOAD_ALL_DATA` Full data auto-load (both indexes and table data - full warmup).                                                                                                                                  | N              |

## Example&ndash;change engine scale
{: .no_toc}

```sql
ALTER ENGINE my_engine SET SCALE TO 1
```

## ALTER TABLE DROP PARTITION

The `ALTER TABLE DROP PARTITION` enables you to delete data from a fact table by dropping a partition.

##### Syntax
{: .no_toc}

```sql
ALTER TABLE <table_name> DROP PARTITION <partition_expr>
```

| Parameter          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Mandatory? Y/N |
| :------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------- |
| `<table_name>`     | Name of the table to be altered.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Y              |
| `<partition_expr>` | The partition expression. The following expressions are supported: <br><br> * Literal (or a comma-separated list of literals) <br><br> * A function applied on a literal.<br><br>The following functions are supported: [EXTRACT](../functions-reference/date-and-time-functions.html#extract), and [DATE_FORMAT](../functions-reference/date-and-time-functions.md#date_format") <br><br> * A combination of the 2 above <br><br> The partitions that match the provided expression will be dropped. In-case a partition key is composed of multiple values - all the values must be provided to perform the drop. | Y              |

For usage examples and additional details read more [here](../../working-with-partitions.md).

## CREATE ENGINE
Creates an engine (compute cluster).

##### Syntax
{: .no_toc}

```sql
CREATE ENGINE [IF NOT EXISTS] <engine_name>
[WITH <properties>]
```

Where `<properties>` are:

* `REGION = '<aws_region>'`
* `ENGINE_TYPE = <type>`
* `SPEC = '<spec>'`
* `SCALE = <scale>`
* `AUTO_STOP = <minutes>`
* `WARMUP = [ MINIMAL | PRELOAD_INDEXES | PRELOAD_ALL_DATA ]`

| Parameter                                                            | Description                                                                                                                                                                                                                                                                                                                                          | Mandatory? Y/N |
| :-------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------- |
| `<engine_name>`                                                      | An identifier that specifies the name of the engine.<br><br> For example: `my_engine`                                                                                                                                                                                                                                                   | Y              |
| `REGION = '<aws_region>'`                                            | The AWS region in which the engine runs.<br><br> If not specified, `'us-west-2'` is used as default.                                                                                                                                                                                                                                    | N              |
| `ENGINE_TYPE = <type>`                                               | The engine type. The `<type>` can have one of the following values: 1. `GENERAL_PURPOSE` <br><br> 2.  `DATA_ANALYTICS`<br><br> If not specified - `GENERAL_PURPOSE` is used as default.<br><br> Usage example: <br><br>`CREATE ENGINE ... ENGINE_TYPE = GENERAL_PURPOSE`   | N              |
| `SPEC = '<spec>'`                                                    | The AWS EC2 instance type, for example, `'m5d.xlarge'`.<br><br>If not specified, `'i3.4xlarge'` is used as default.                                                                                                                                                                                           | N              |
| `SCALE =`<br>`<scale>`          | Specifies the scale of the engine.<br><br>The scale can be any `INT` between 1 to 128.<br><br> If not specified, 2 is used as default.                                                                                                                                                      | N              |
| `AUTO_STOP = <minutes>`                                              | Indicates the amount of time (in minutes) after which the engine automatically stops. The default value is 20.<br><br>Setting the `minutes` to 0 indicates that `AUTO_STOP` is disabled.                                                                                                                                    | N              |
| `WARMUP =`<br>`<warmup_method>` | The warmup method that should be used, the following options are supported: `MINIMAL` On-demand loading (both indexes and tables' data).<br><br>`PRELOAD_INDEXES` Load indexes only (default). `PRELOAD_ALL_DATA` Full data auto-load (both indexes and table data - full warmup). | N              |

##### Example&ndash;create an engine with (non-default) properties
{: .no_toc}

```sql
CREATE ENGINE my_engine
WITH SPEC = 'c5d.4xlarge' SCALE = 8
```

## CREATE DATABASE
Creates a new database.

##### Syntax
{: .no_toc}

```sql
CREATE DATABASE [IF NOT EXISTS] <database_name>
[WITH <properties>]
```

Where `<properties>` are:

* `REGION = '<aws_region>`
* `ATTACHED_ENGINES = ( '<engine_name>' [, ... ] )`
* `DEFAULT_ENGINE = 'engine_name'`
* `DESCRIPTION = 'description'`


| Parameter                                      | Description                                                                                                                                                                                                                                                                                                                                                                             | Mandatory? Y/N |
| :---------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |: -------------- |
| `<database_name>`                              | An identifier that specifies the name of the database.<br>For example: `my_database`                                                                                                                                                                                                                                                                                  | Y              |
| `REGION = '<aws_region>'`                      | The AWS region in which the database is configured.<br><br>If not specified, `'us-west-2'` is being used as default.                                                                                                                                                                                                                                                      | N              |
| `ATTACHED_ENGINES = ( <engine_name> [ ... ] )` | A list of engine names, for example: `ATTACHED_ENGINES = (my_engine_1 my_engine_2)`. The specified engines must be detached from any other databases first.                                                                                                                                                                                                     | N              |
| `DEFAULT_ENGINE = engine_name`                 | An identifier that specifies the name of the default engine. If not specified, the first engine in the attached engines list will be used as default. If a default engine is specified without specifying the list of attached engines or if the default engine is not in that list, the default engine will be both attached to the database and used as the default engine. | N              |
| `DESCRIPTION = 'description'`                  | The engine's description (up to 64 characters).                                                                                                                                                                                                                                                                                                                                         | N              |

##### Example&ndash;create a database with (non-default) properties
{: .no_toc}

```sql
CREATE DATABASE IF NOT EXISTS my_db
WITH region = 'us-east-1' description = 'Being used for testing'
```

## CREATE EXTERNAL TABLE
Creates an external table. External tables serve as connectors to your external data sources. External tables contain no data within Firebolt other than metadata virtual columns that are automatically populated with metadata. For more information, see [Working with external tables](../loading-data/working-with-external-tables.md).

##### Syntax
{: .no_toc}

```sql
CREATE EXTERNAL TABLE [IF NOT EXISTS] <external_table_name>
(
    <column_name> <column_type>
    [, <column_name2> <column_type2> [, ...n] ]
    [, <partition_column_name> <partition_column_type> PARTITION('<regex>')
)
[CREDENTIALS = (<awsCredentials>)]
URL = 's3://<bucket>[/<folder>][/...]/'
OBJECT_PATTERN = '<object_pattern>'[, '<object_pattern>'[, ...n]]]
TYPE = (<type> [typeOptions])
[COMPRESSION = <compression_type>]
```

| Parameter                                       | Description                                                                                                     |
|: ----------------------------------------------- |: --------------------------------------------------------------------------------------------------------------- |
| `<external_table_name>`                         | An ​identifier​​ that specifies the name of the external table. This name should be unique within the database. |
| `​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​<column_name>` | An identifier that specifies the name of the column. This name should be unique within the table.               |
| `<column_type>`                                 | Specifies the data type for the column.                                                                         |
| `<partition_column_name>`                       | See [Extract partition data](ddl-commands.md#extracting-partition-data)                                                |
| `CREDENTIALS`                                   | See [CREDENTIALS](ddl-commands.md#credentials)                                                                      |
| `URL` and `OBJECT_PATTERN`                      | See [URL & OBJECT\_PATTERN](ddl-commands.md#url-and-object_pattern)                                                |
| `TYPE`                                          | See [TYPE](ddl-commands.md#type)                                                                                    |
| `COMPRESSION`                                   | See [COMPRESSION](ddl-commands.md#compression)                                                                      |

All Firebolt identifiers are case insensitive unless double-quotes are used. For more information, see [Identifier requirements](../../general-reference/identifier-requirements.md).

### Extracting partition data
{: .no_toc}

When data is partitioned, the partition columns are not stored in the S3 files. Instead, they can be extracted from the file path within the bucket. ​

##### Syntax
{: .no_toc}

```sql
[<column_name> <column_type> PARTITION('<regex>')]
```

| Parameter                                                 | Description                                                                                                                                                                                                |
|: --------------------------------------------------------- |: ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​<partition_column_name>` | An identifier that specifies the name of the column as it would appear in the external table (should match the hive partition name). As with any column name, this name should be unique within the table. |
| `<partition_column_type>`                                 | Specifies the data type for the column.                                                                                                                                                                    |
| `'<regex>'`                                               | The regex for extracting the partition value out of the file path in S3.                                                                                                                                   |

#### Guidelines for creating the regex
{: .no_toc}

* You do not have to reference all the partitions in your data; you can specify only the columns that you wish to include in the external table.
* You can extract the column value from the file name, but not from its path.
* For each column, a regular expression that contains a capturing group must be specified, so Firebolt can treat the captured string as the column value.
* When the column data type is `date`, Firebolt expects three capturing groups in the order of year, month, and day.
* The regular expression is matched against the file path, not including the `s3://bucket_name/` prefix.
* Firebolt tries to convert the captured string to the specified type. If the type conversion fails, the value is treated as NULL.

In most cases, the easiest way to build a regular expression is as follows:
1. Count the number of folders in the path, not including the bucket name.
2. Concatenate the string `[^\/]+\/` according to the number of folders.
3. Prefix the regex with an additional `[^\/]+` for the file name.
4. Wrap the `[^\/]+` in the right folder with a capturing group parenthesis, i.e `([^\/]+).` See the examples below for both hive-compatible and non-compatible partitions extractions.

Here is a good explanation about [matching groups](https://regexone.com/lesson/capturing\_groups), and an [online tool](https://regex101.com) to test your regular expressions.

##### Example&ndash;extract hive-compatible partitions
{: .no_toc}

Consider the following layout of files in a bucket - data is partitioned according to client type, year, and month, with multiple parquet files in each partition. The parquet files don't contain the corresponding columns, but the columns can be extracted, along with their values, by parsing the file paths, as we will see in the next section.

```
s3://my_bucket/c_type=xyz/year=2018/month=01/part-00001.parquet
s3://my_bucket/c_type=xyz/year=2018/month=01/part-00002.parquet
...
s3://my_bucket/c_type=abc/year=2018/month=01/part-00001.parquet
s3://my_bucket/c_type=abc/year=2018/month=01/part-00002.parquet
```

Creating an external table using the following format:

```sql
CREATE EXTERNAL TABLE my_external_table
(
    c_id    INT,
    c_name  TEXT,
    c_type TEXT PARTITION('[^\/]+\/c_type=([^\/]+)\/[^\/]+\/[^\/]+')
)
CREDENTIALS = (AWS_KEY_ID = '*****' AWS_SECRET_KEY = '******')
URL = 's3://my_bucket/'
OBJECT_PATTERN= '*.parquet'
TYPE = (PARQUET)
```

Results with an external table in the following structure:

| c\_id | c\_name   | c\_type |
|: ----- |: --------- |: ------- |
| 1     | name\_a   | xyz     |
| 2     | name\_b   | xyz     |
| ...   | ...       | ...     |
| 100   | name\_abc | xyz     |

##### Example&ndash;extract non-hive compatible partitions
{: .no_toc}

In some cases, your S3 files may be organized in partitions that do not use the = format. For example, consider this layout:

```
s3://my_bucket/xyz/2018/01/part-00001.parquet
s3://my_bucket/xyz/2018/01/part-00002.parquet
...
s3://my_bucket/abc/2018/01/part-00001.parquet
s3://my_bucket/abc/2018/01/part-00002.parquet
```

In this case, you can use the advanced `PARTITION(<regex>)` column definition to create the columns and extract their values.

To create the same external table as we did in the hive-compatible case, use the following statement:

```sql
CREATE EXTERNAL TABLE my_external_table
(
    c_id INT,
    c_name TEXT,
    c_type TEXT PARTITION('[^\/]+\/([^\/]+)\/[^\/]+\/[^\/]+')
)
CREDENTIALS = (AWS_KEY_ID = '*****' AWS_SECRET_KEY = '******')
URL = 's3://my_bucket/'
OBJECT_PATTERN= '*.parquet'
TYPE = (PARQUET)
```

As in the previous example, the values for the columns `c_id` and `c_name` are extracted from the record in the parquet file, and the values for the `c_type` column is extracted from the file path, according to the specified type and regular expression.

{: .note}
The partition values can be extracted during the `INSERT INTO`command as well. Read more [here](dml-commands.md#example-extracting-partition-values).


### CREDENTIALS
{: .no_toc}

The credentials for accessing your AWS S3. Firebolt enables using either access key & secret or IAM role.

##### Syntax&ndash;authenticating using an access key and secret
{: .no_toc}

```sql
CREDENTIALS = (AWS_KEY_ID = '<aws_key_id>' AWS_SECRET_KEY = '<aws_secret_key>' )
```

| Parameter          | Description                                             | Data type |
|: ------------------ |: ------------------------------------------------------- |: --------- |
| `<aws_key_id>`     | The AWS access key ID for the authorized app (Firebolt) | TEXT      |
| `<aws_secret_key>` | The AWS secret access key for the app (Firebolt)        | TEXT      |

{: .note}
In case you don't have the access key and secret to access your S3 bucket, read more [here](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) on how to obtain them.

##### Syntax&ndash;authenticating using an IAM role
{: .no_toc}

Read more on how to configure the AWS role [here](../../loading-data/configuring-aws-role-to-access-amazon-s3.md).

```sql
CREDENTIALS = (AWS_ROLE_ARN = '<role_arn>' [AWS_ROLE_EXTERNAL_ID = '<external_id>'])
```

| Parameter         | Description                                                                                                                                   | Data type |
| :----------------- |: --------------------------------------------------------------------------------------------------------------------------------------------- |: --------- |
| `'<role_arn>'`    | The arn\_role you created in order to enable access to the required bucket.                                                                   | TEXT      |
| `'<external_id>'` | Optional. This is an optional external ID that you can configure in AWS when creating the role. Specify this only if you use the external ID. | TEXT      |

### URL and OBJECT_PATTERN
{: .no_toc}

The`URL`and`OBJECT_PATTERN`parameters are used together to match the set of files from within the specified bucket that you wish to include as the data for the external table.

##### Syntax
{: .no_toc}

```sql
URL = 's3://<bucket>[/<folder>][/...]/'
OBJECT_PATTERN = '<object_pattern>'[, '<object_pattern>'[, ...n]]]
```

| Parameters       | Description                                                                                                                          | Data type |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------------------ | :--------- |
| `URL`            | This is the URL of the specific bucket and path within the bucket where the relevant files are located (common path prefix).         | TEXT      |
| `OBJECT_PATTERN` | Specify the data patterns to be found in your data source. For example, \*.parquet indicates that all parquet files should be found. | TEXT      |

The following wildcards are supported:

* `'*'` matches any sequence of characters
* `'?'` matches any single character
* `[SET]` matches any single character in the specified set
* `[!SET]` matches any character, not in the specified set.

##### Example
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

| Use cases                                                                 | Syntax                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|: ------------------------------------------------------------------------- |: ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Get all files for file type xyz                                           | *URL = 's3://bucket/c_type=xyz/'* <br> *OBJECT_PATTERN = '\*'*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|                                                                           | *URL = 's3://bucket/'<br>OBJECT_PATTERN = 'c_type=xyz/\*'*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Get one specific file: `c_type=xyz/year=2018/month=01/part-00001.parquet` | *URL = 's3://bucket/c_type=xyz/year=2018/month=01/' OBJECT_PATTERN = 'c_type=xyz/year=2018/month=01/part-00001.parquet'<br> <br> URL = 's3://bucket/c_type=xyz/year=2018/month=01/' OBJECT_PATTERN = '\*/part-00001.parquet'*<br><br>As can be seen in this example, the ​`URL`​ is used to get only the minimal set of files (c_type files in the bucket from January 2018), and then from within those matching files, the `OBJECT_PATTERN`​​ is matched against the full path of the file (without the bucket name). |
| Get all parquet files for type xyz                                        | *URL = 's3://bucket/c_type=xyz/'<br> OBJECT_PATTERN = '\*.parquet'*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Get all client data (for all types) from 2018 and 2019                    | *URL = 's3://bucket/'<br>OBJECT_PATTERN =<br>'/year=2018/',<br>'/year=2019/'*                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Get all files for type xyz, from the past 3 months                        | *URL = 's3://bucket/c_type=xyz/'<br>OBJECT_PATTERN =<br>'/year=2019/month=12/',<br>'/year=2020/month=01/',<br>'/year=2020/month=02/'*                                                                                                                                                                                                                                                                                                                                                                                                    |
| No files matched, since the URL parameter does not support wildcards.     | *URL = 's3://bucket/'<br>OBJECT_PATTERN =<br>'/year=2019/month=12/',<br>'/year=2020/month=01/',<br>'/year=2020/month=02/'*                                                                                                                                                                                                                                                                                                                                                                                                               |
| Get all files of type xyz from the first six months of 2019               | *URL = 's3://bucket/c_type=xyz/'OBJECT_PATTERN ='/year=2019/month=0[1-6]'*                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

### TYPE
{: .no_toc}

Specifies the type of the files in S3. The following types and type options are supported.

* `TYPE = (CSV [SKIP_HEADER_ROWS = {1|0}])`  
With `TYPE = (CSV SKIP_HEADER_ROWS = 1)`, Firebolt assumes that the first row in each file read from S3 is a header row and skips it when ingesting data. When set to `0`, which is the default if not specified, Firebolt ingests the first row as data.  

* `TYPE = (JSON [PARSE_AS_TEXT = {'TRUE'|'FALSE'}])`  
With `TYPE = (JSON PARSE_AS_TEXT = 'TRUE')`, Firebolt ingests each JSON object literal in its entirety into a single column of type `TEXT`. With `TYPE = (JSON PARSE_AS_TEXT = 'FALSE')`, Firebolt expects each key in a JSON object literal to map to a column in the table definition. During ingestion, Firebolt inserts the key's value into the corresponding column.  

* `TYPE = (ORC)`
* `TYPE = (PARQUET)`
* `TYPE = (TSV)`

##### Example
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
{: .no_toc}

Specifies the compression type of the files in S3.

##### Syntax
{: .no_toc}

```sql
[COMPRESSION = <compression_type>]
```

| Parameters           | Description                                                        |
| :-------------------- |:------------------------------------------------------------------ |
| `<compression_type>` | An identifier specifies the compression type. `GZIP` is supported. |

##### Example
{: .no_toc}

The example below creates an external table to ingest parquet files from S3 that are compressed using gzip. The credentials for an IAM user with access to the bucket are provided.

```sql
CREATE EXTERNAL TABLE my_external_table
(
    c_id INT,
    c_name TEXT
)
CREDENTIALS = (AWS_KEY_ID = 'AKIAIOSFODNN7EXAMPLE' AWS_SECRET_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY')
URL = 's3://mybucket/'
OBJECT_PATTERN= '*.parquet.gz'
TYPE = (PARQUET)
COMPRESSION = GZIP
```

### CREATE EXTERNAL TABLE based on an AWS Glue table
In addition to other CREATE EXTERNAL TABLE clauses, the `META_STORE` clause provides information to connect to a AWS Glue database and table.

##### Syntax
{: .no_toc}

```sql
META_STORE = (TYPE='Glue' DATABASE_NAME=<db_name> TABLE_NAME=<table_name>)
```

| Parameter |Description| Data type |
|:--------- | :-------- | :--------- |
| `<db_name>`| The name of the database in AWS Glue| TEXT      |
| `<table_name>` | The name of the table in AWS Glue | TEXT      |

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

##### Example
{: .no_toc}

An external table based on an AWS Glue table `'glue_table'` in `'glue_db'` database:

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS
  my_external_table
CREDENTIALS = ( AWS_KEY_ID = 'AKIAIOSFODNN7EXAMPLE' AWS_SECRET_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY' )
META_STORE = (TYPE='Glue' DATABASE_NAME='glue_db' TABLE_NAME='glue_table')
```

## CREATE FACT | DIMENSION TABLE

Creates a new FACT/DIMENSION table in the current database.

Firebolt also supports creating a table as select (also referred to as CTAS) - read more [here](ddl-commands#ctas---create-fact--dimension-table-as-select).

##### Syntax&ndash;fact table
{: .no_toc}

```sql
CREATE FACT TABLE [IF NOT EXISTS] <table_name>
(
    <column_name> <column_type> [constraints]
    [, <column_name2> <column_type2> [constraints]
    [, ...n]]
)
PRIMARY INDEX <column_name>[, <column_name>[, ...n]]
[PARTITION BY <column_name>[, <column_name>[, ...n]]]
```

{: .note}
Partitions are only supported on FACT tables.

##### Syntax&ndash;dimension table**
{: .no_toc}

```sql
CREATE DIMENSION TABLE [IF NOT EXISTS] <table_name>
(
    <column_name> <column_type> [constraints]
    [, <column_name2> <column_type2> [constraints]
    [, ...n]]
)
[PRIMARY INDEX <column_name>[, <column_name>[, ...n]]]
```

| Parameter                                       | Description                                                                                            |
| :----------------------------------------------- | :------------------------------------------------------------------------------------------------------ |
| `<table_name>`                                  | An ​identifier​​ that specifies the name of the table. This name should be unique within the database. |
| `​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​<column_name>` | An identifier that specifies the name of the column. This name should be unique within the table.      |
| `<column_type>`                                 | Specifies the data type for the column.                                                                |

All identifiers are case insensitive unless double-quotes are used. For more information, please see our [identifier requirements page](../../general-reference/identifier-requirements.md).

* [Column constraints & default expression](ddl-commands.md#column-constraints--default-expression)
* [PRIMARY INDEX specifier](ddl-commands.md#primary-index)
* [PARTITION BY specifier](ddl-commands.md#partition-by)

### Column constraints & default expression
{: .no_toc}

Firebolt supports the column constraints shown below.

```sql
<column_name> <column_type> [UNIQUE] [NULL | NOT NULL] [DEFAULT <expr>]
```


| Constraint           | Description                                                                                                                                                                                                                | Default value |
| :-------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------- |
| `DEFAULT <expr>`     | Determines the default value that is used instead of NULL value is inserted.                                                                                                                                               |               |
| `NULL` \| `NOT NULL` | Determines if the column may or may not contain NULLs.                                                                                                                                                                     | `NOT NULL`    |
| `UNIQUE`             | This is an optimization hint to tell Firebolt that this column will be queried for unique values, such as through a `COUNT(DISTINCT)` function. This will not raise an error if a non-unique value is added to the column. |               |

{: .note}
Note that nullable columns can not be used in Firebolt indexes (Primary, Aggregating, or Join indexes).

##### Example&ndash;Creating a table with nulls and not nulls
{: .no_toc}

This example illustrates different use cases for column definitions and INSERT statements.

* **Explicit NULL insert**&ndash;a direct insertion of a `NULL` value into a particular column.
* **Implicit NULL insert**&ndash;an `INSERT` statement with missing values for a particular column.

The example uses a fact table in which to insert different values. The example below creates the fact table `t1`.

```sql
CREATE FACT TABLE t1
(
    col1 INT  NULL ,
    col2 INT  NOT NULL UNIQUE,
    col3 INT  NULL DEFAULT 1,
    col4 INT  NOT NULL DEFAULT 1,
    col5 TEXT
)
PRIMARY INDEX col2;
```

Once we've created the table, we can manipulate the values with different INSERT statements. Following are detailed descriptions of different examples of these:

| INSERT statement | Results and explanation  |
| :--------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `INSERT INTO t1 VALUES (1,1,1,1,1)`                                                                                               | 1 is inserted into each column                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `INSERT INTO t1 VALUES (NULL,1,1,1,1)`                                                                                            | col1 is `NULL`, and this is an explicit NULL insert, so NULL is inserted successfully.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `INSERT INTO t1 (col2,col3,col4,col5) VALUES (1,1,1,1)`                                                                           | This is an example of explicit and implicit INSERT statements. col1 is `NULL`, which is an implicit insert, as a default expression was not specified. In this case, col1 is treated as `NULL DEFAULT NULL,`so Firebolt inserts NULL.                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `INSERT INTO t1 VALUES (1,NULL,1,1,1)`<br> <br>`INSERT INTO t1 (col1,col3,col4,col5) VALUES (1,1,1,1)` | The behavior here depends on the column type. For both cases, a “null mismatch” event occurs.<br><br> In the original table creation, col2 receives a `NOT NULL` value. Since a default expression is not specified, both of these INSERT statements try to insert `NOT NULL DEFAULT NULL` into col2. This means that there is an implicit attempt to insert `NULL` in both cases.<br><br> In this particular case, the data type for col4 is `INT`. Because `NOT NULL` is configured on col4 as well, it cannot accept `NULL` values. If the data type for col4 was `TEXT`, for example, the result would have been an insert of `''`. |
| `INSERT INTO t1 VALUES (1,1,NULL,1,1)`                                                                                            | col3 is`NULL DEFAULT 1,`and this is an explicit insert. `NULL` is inserted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `INSERT INTO t1 (col1,col2,col4,col5) VALUES (1,1,1,1)`                                                                           | col3 is `NULL DEFAULT 1`. This is an implicit insert, and a default expression is specified, so 1 is inserted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `INSERT INTO t1 VALUES (1,1,1,NULL,1)`                                                                                            | col4 is `NOT NULL DEFAULT 1`, and this is an explicit insert. Therefore, a “null mismatch” event occurs. In this particular case, since the data type for col4 is INT, the result is an error. If the data type for col4 was TEXT, for example, the result would have been an insert of `''`.                                                                                                                                                                                                                                                                                                                                                                                                    |
| `INSERT INTO t1 (col1,col2,col3,col5) VALUES (1,1,1,1)`                                                                           | col4 is `NOT NULL DEFAULT 1`, and this is an implicit insert. Therefore, the default expression is used, and 1 is inserted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `INSERT INTO t1 VALUES (1,1,1,1,NULL)`<br><br>`INSERT INTO t1 (col1,col2,col3,col4) VALUES (1,1,1,1)` | The nullability and default expression for col5 were not specified. In this case, Firebolt treats col5 as `NOT NULL DEFAULT NULL`.</p><p>For the explicit insert, Firebolt attempts to insert NULL into a NOT NULL int column, and a “null mismatch” event results.<br><br>For the implicit insert, Firebolt resorts to the default, and again, attempts to insert NULL. Similar to the explicit NULL case - an empty value `''` is inserted.                                                                                                                                                                                                                        |

### PRIMARY INDEX
{: .no_toc}

The `PRIMARY INDEX` is a sparse index containing sorted data based on the indexed field. This index clusters and sorts data as it is ingested, without affecting data scan performance. A `PRIMARY INDEX` is required for `FACT` tables and optional for `DIMENSION` tables.

##### Syntax&ndash;primary index
{: .no_toc}

```sql
PRIMARY INDEX <column_name>[, <column_name>[, ...n]]
```

The following table describes the primary index parameters:

| Parameter.      | Description                                                                                                                                  | Mandatory? |
| :--------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- | :---------- |
| `<column_name>` | Specifies the name of the column in the Firebolt table which composes the index. At least one column must be used for configuring the index. | Y          |

### PARTITION BY
{: .no_toc}

The `PARTITION BY` clause specifies a column or columns by which the table will be split into physical parts. Those columns are considered to be the partition key of the table. Columns must be non-nullable.

Only `FACT` tables can be partitioned.

When the partition key is set with multiple columns, all columns are used as the partition boundaries.

```sql
PARTITION BY <column_name>[, <column_name>[, ...n]]
```

For more information, see [Working with partitions](../../working-with-partitions.md).

### CTAS&ndash;CREATE FACT|DIMENSION TABLE AS SELECT

Creates a table and loads data into it based on the [SELECT](query-syntax.md) query. The table column names and types are automatically inferred based on the output columns of the [SELECT](query-syntax.md). When specifying explicit column names those override the column names inferred from the [SELECT](query-syntax.md).

##### Syntax&ndash;CTAS
{: .no_toc}

Fact table:

```sql
CREATE FACT TABLE <table_name>
[(<column_name>[, ...n] )]
PRIMARY INDEX <column_name>[, <column_name>[, ...n]]
[PARTITION BY <column_name>[, <column_name>[, ...n]]]
AS <select_query>
```

Dimension table:

```sql
CREATE DIMENSION TABLE <table_name>
[(<column_name>[, ...n] )]
[PRIMARY INDEX <column_name>[, <column_name>[, ...n]]]
AS <select_query>
```

| Parameter                                       | Description                                                                                                     |
| :----------------------------------------------- | :--------------------------------------------------------------------------------------------------------------- |
| `<table_name>`                                  | An ​identifier​​ that specifies the name of the external table. This name should be unique within the database. |
| `​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​<column_name>` | An identifier that specifies the name of the column. This name should be unique within the table.               |
| `<select_query`>                                | Any valid select query                                                                                          |

## CREATE VIEW

Views allow you to use a query as if it were a table.

Views are useful to filter, focus and simplify a database for users. They provide a level of abstraction that can make subqueries easier to write, especially for commonly referenced subsets of data. A view in Firebolt executes its query each time the view is referenced. In other words, the view results are not stored for future usage, and therefore using views does not provide a performance advantage.

##### Syntax
{: .no_toc}

```sql
CREATE VIEW [IF NOT EXISTS] <name> [(<column_list>)]
AS SELECT <select_statement>
```

| Parameter                                       | Description                                                                                                                     |
| :----------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------- |
| `<name>`                                        | An ​identifier​​ that specifies the name of the view. This name should be unique within the database.                           |
| `​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​<column_list>` | An optional list of column names to be used for columns of the view. If not given, the column names are deduced from the query. |
| `<select_statement>`                            | The select statement for creating the view                                                                                      |

##### Example
{: .no_toc}

```sql
CREATE VIEW fob_shipments
AS SELECT   l_shipmode,
            l_shipdate,
            l_linestatus,
            l_orderkey,
FROM    lineitem
WHERE   l_shipdate > '1990-01-01'
AND     l_shipmode = 'FOB'
```

## CREATE JOIN INDEX

Join indexes can accelerate queries that use `JOIN` operations on dimension tables. Under certain circumstances, a join index can significantly reduce the compute requirements required to perform a join at query runtime.

##### Syntax
{: .no_toc}

```sql
CREATE JOIN INDEX [IF NOT EXISTS] <unique_join_index_name> ON <dimension_table_name>
(
  <unique_join_key_column>,
  <dimension_column>[, ...n]
)
```

| Parameter                  | Description                                                                                                        |
| :-------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| `<unique_join_index_name>` | A unique name for the join index.                                                                                  |
| `<dimension_table_name>`   | The name of the dimension table on which the index is configured.                                                  |
| `<unique_join_key_column>` | The column name that is used in the join’s `ON` clause.                                                            |
| `<dimension_column>`       | The column name which is being loaded into memory from the dimension table. More than one column can be specified. |

{: .note}
For better performance, whenever possible, use the [UNIQUE](ddl-commands.md#column-constraints--default-expression) column attribute in the dimension table definition for the column that is used as the join key in queries.  the join index is loaded into engine RAM, make sure to choose only the subset of dimension table columns that appear in queries that use the join.

##### Example&ndash;create join index with specific columns
{: .no_toc}

In the following example, we create a join index on the dimension table `my_dim`, and store the columns `email` and `country` in the index:

```sql
CREATE DIMENSION TABLE my_dim(
my_dim_id BIGINT UNIQUE,
email TEXT,
country TEXT,
city TEXT,
cellolar TEXT)
PRIMARY INDEX my_dim_id;


CREATE JOIN INDEX my_dim_join_idx ON my_dim
(my_dim_id, email, country);
```

## CREATE AGGREGATING INDEX

Different syntax is used when creating an aggregating index on an empty table or a table populated with data.

##### Syntax&ndash;aggregating index on an empty table
{: .no_toc}

```sql
CREATE AGGREGATING INDEX <agg_index_name> ON <fact_table_name>
(
  <key_column>[, ...n],
  <aggregation>[, ...n]
);
```

Click [here](ddl-commands.md#parameters) to read about the different parameters.

{: .note}
The index is populated automatically as data is loaded into the table.

##### Syntax&ndash;aggregating index on a populated table
{: .no_toc}

```sql
CREATE AND GENERATE AGGREGATING INDEX <agg_index_name> ON <fact_table_name>
(
  <key_column>[, ...n],
  <aggregation>[, ...n]
);
```

{: .caution}
Generating the index after data was loaded to the table is a memory-heavy operation.

| Parameter           | Description                                                                                                             |
| :------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| `<agg_index_name>`  | Specifies a unique name for the index                                                                                   |
| `<fact_table_name>` | Specifies the name of the fact table referenced by this index                                                           |
| `<key_column>`      | Specifies column name from the `<fact_table_name>` used for the index                                                   |
| `<aggregation>`     | Specifies one or more aggregation functions to be applied on a `<key_column>`, such as `SUM`, `COUNT`, `AVG`, and more. |

##### Example&ndash;create an aggregating index**
{: .no_toc}

In the following example, we create an aggregating index on the fact table `my_fact`, to be used in the following query:

```sql
SELECT
	product_name,
	count(DISTINCT source),
	sum(amount)
FROM
	my_fact
GROUP BY
	product_name;
```

The aggregating index is created with the statement below.

```sql
CREATE AGGREGATING INDEX
  my_fact_agg_idx ON my_fact
  (
    product_name,
    count(distinct source),
    sum(amount)
  );
```

{: .note}
To benefit from the performance boost provided by the index, include in the index definition all columns and measurements that the query uses.

## START ENGINE

The `START ENGINE` statement enables you to start a stopped engine.

##### Syntax
{: .no_toc}

```sql
START ENGINE <engine_name>
```

| Parameter       | Description                          | Mandatory? Y/N |
| :--------------- | :------------------------------------ | :-------------- |
| `<engine_name>` | The name of the engine to be started | Y              |

## STOP ENGINE

The `STOP ENGINE` statement enables you to stop a running engine.

##### Syntax
{: .no_toc}

```sql
STOP ENGINE <engine_name>
```

| Parameter       | Description                          | Mandatory? Y/N |
| :--------------- | :------------------------------------ | :-------------- |
| `<engine_name>` | The name of the engine to be stopped | Y              |

## ATTACH ENGINE

The `ATTACH ENGINE` statement enables you to attach an engine to a database.

##### Syntax
{: .no_toc}

```sql
ATTACH ENGINE <engine_name> TO <database_name>
```

| Parameter         | Description                                                   | Mandatory? Y/N |
| :----------------- | :------------------------------------------------------------- | :-------------- |
| `<engine_name>`   | The name of the engine to attach.                             | Y              |
| `<database_name>` | The name of the database to attach engine `<engine_name>` to. | Y              |

## DETACH ENGINE (deprecated)

Deprecated. Avoid using this statement and use `DROP ENGINE` instead. Allows you to detach an engine from a database.

##### Syntax
{: .no_toc}

```sql
DETACH ENGINE <engine_name> FROM <database_name>
```

| Parameter         | Description                                                     | Mandatory? Y/N |
| :----------------- | :--------------------------------------------------------------- | :-------------- |
| `<engine_name>`   | The name of the engine to detach.                               | Y              |
| `<database_name>` | The name of the database to detach engine `<engine_name>` from. | Y              |

## DESCRIBE

Lists all columns and data types for the table. Once the results are displayed, you can also export them to CSV or JSON.

##### Syntax
{: .no_toc}

```sql
DESCRIBE <table_name>
```

**Example**

The following lists all columns and data types for the table named `prices`:

```sql
DESCRIBE prices
```

**Returns:**

```
+------------+-------------+-----------+----------+
| table_name | column_name | data_type | nullable |
+------------+-------------+-----------+----------+
| prices     | item        | text      |        0 |
| prices     | num         | int       |        0 |
+------------+-------------+-----------+----------+
```

## DROP ENGINE
Deletes an engine.

##### Syntax
{: .no_toc}

```sql
DROP ENGINE [IF EXISTS] <engine_name>
```

| Parameter       | Description                           |
| :--------------- | :------------------------------------- |
| `<engine_name>` | The name of the engine to be deleted. |

## DROP INDEX
Deletes an index.

##### Syntax
{: .no_toc}

```sql
DROP [AGGREGATING | JOIN] INDEX [IF EXISTS] <index_name>
```

| Parameter      | Description                          |
| :-------------- | :------------------------------------ |
| `<index_name>` | The name of the index to be deleted. |

## DROP TABLE
Deletes a table.

##### Syntax
{: .no_toc}

```sql
DROP TABLE [IF EXISTS] <table_name>
```

| Parameter      | Description                          |
| :-------------- | :------------------------------------ |
| `<table_name>` | The name of the table to be deleted. For external tables, the definition is removed from Firebolt but not from the source. |

## DROP DATABASE
Deletes a database.

##### Syntax
{: .no_toc}

Deletes the database and all of its tables and attached engines.

```sql
DROP DATABASE [IF EXISTS] <database_name>
```

| Parameter         | Description                            |
| :----------------- | :-------------------------------------- |
| `<database_name>` | The name of the database to be deleted |

## DROP VIEW

Deletes a view.

##### Syntax
{: .no_toc}

```sql
DROP VIEW [IF EXISTS] <view_name>
```

| Parameter     | Description                         |
| :------------- | :----------------------------------- |
| `<view_name>` | The name of the view to be deleted. |

## REFRESH JOIN INDEX

Recreates a join index or all join indices associated with a dimension table on the engine. You can run this statement to rebuild a join index or indices after data has been ingested into an underlying dimension table. For more information about join indexes, see [Using join indexes](../../using-indexes/using-join-indexes.md).

Join indexes are not updated automatically in an engine when new data is ingested into a dimension table or a partition is dropped. You must refresh all indexes on all engines with queries that use them or those queries will return pre-update results.

Refreshing join indexes is a memory-intensive operation because join indexes are stored in node RAM. When refreshing join indexes, use [SHOW INDEXES](ddl-commands.md#show-indexes) to get the `size_compressed` of all indexes to refresh. Ensure that node RAM is greater than the sum of `size_compressed` for all join indexes to be refreshed.

##### Syntax
{: .no_toc}

Two versions of the command are available.

* `REFRESH JOIN INDEX` refreshes a single join index that you specify.
* `REFRESH ALL JOIN INDEXES ON TABLE` refreshes all join indexes associated with a specific dimension table.

```sql
REFRESH JOIN INDEX <index-name>
```

**—OR—**

```sql
REFRESH ALL JOIN INDEXES ON TABLE <dim-table-name>
```

| Parameter          |                                                                                         |
| :------------------ | :--------------------------------------------------------------------------------------- |
| `<index-name>`     | The name of the join index to rebuild.                                                  |
| `<dim-table-name>` | The name of a dimension table. All join indexes associated with that table are rebuilt. |

## SHOW CACHE

Returns the current SSD usage (`ssd_usage`) for the current engine. `SHOW CACHE` returns values at the engine level, not by each node.

##### Syntax
{: .no_toc}

```sql
SHOW CACHE;
```

The results of `SHOW CACHE` are formatted as follows:

`<ssd_used>`/`<ssd`\_`available>` GB (`<percent_utilization>`%)

These components are defined as follows:

| Component               | Description                                                                                                                |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------- |
| `<ssd_used>`            | The amount of storage currently used on your engine. This data includes storage that Firebolt reserves for internal usage. |
| `<ssd_available>`    | The amount of available storage on your engine.                                                                            |
| `<percent_utilization>` | The percent of used storage as compared to available storage.                                                              |

Example returned output is shown below.

```
| ssd_usage             |
+-----------------------+
| 3.82/73.28 GB (5.22%) |
```

## SHOW COLUMNS

Lists columns and their properties for a specified table. Returns `<table_name>`, `<column_name>`, `<data_type>`, and `nullable` for each column.

##### Syntax
{: .no_toc}

```sql
SHOW COLUMNS <table_name>;
```

| Parameter      | Description                           |
| :-------------- | :------------------------------------- |
| `<table_name>` | The name of the table to be analyzed. |

##### Example
{: .no_toc}

```sql
SHOW COLUMNS prices;
```

**Returns**:

```
------------+-------------+-----------+----------+
| table_name | column_name | data_type | nullable |
+------------+-------------+-----------+----------+
| prices     | item        | text      |        0 |
| prices     | num         | int       |        0 |
+------------+-------------+-----------+----------+
```

## SHOW DATABASES

Lists databases in the current Firebolt account. Returns `name`, `region`, `attached_engines`, `created_on`, `created_by`, and `errors` for each database.

##### Syntax
{: .no_toc}

```sql
SHOW DATABASES;
```

##### Example
{: .no_toc}

```sql
SHOW DATABASES;
```

**Returns**:

```
+---------------+-----------+-------------------------------------+-----------------------------+---------------+--------+
| database_name |  region   |          attached_engines           |         created_on          |  created_by   | errors |
+---------------+-----------+-------------------------------------+-----------------------------+---------------+--------+
| Tutorial1     | us-east-1 | Tutorial1_general_purpose (default) | 2021-09-30T21:25:45.401405Z | someone       |      - |
+---------------+-----------+-------------------------------------+-----------------------------+---------------+--------+
```

## SHOW DATABASE

Shows the status for the specified database. These are the same metadata fields as `SHOW DATABASES`.

```sql
SHOW DATABASE <database_name>;
```

| Parameter         | Description                              |
| :----------------- | :---------------------------------------- |
| <`database_name>` | The name of the database to be analyzed. |

## SHOW ENGINES

Lists all engines in the current Firebolt account. Returns `engine_name`, `region`, `spec`, `scale`, `status`, and `attached_to` for each engine.

##### Syntax
{: .no_toc}

```sql
SHOW ENGINES;
```

##### Example
{: .no_toc}

```sql
SHOW ENGINES;
```

**Returns**:

```
+--------------------+-----------+-------------+-------+---------+-------------+
|    engine_name     |  region   |    spec     | scale | status  | attached_to |
+--------------------+-----------+-------------+-------+---------+-------------+
| Tutorial_analytics | us-east-1 | r5d.4xlarge |     2 | Stopped | Tutorial    |
+--------------------+-----------+-------------+-------+---------+-------------+
```

## SHOW INDEXES

Lists all indexes defined in the current database. Returns `index_name`, `table_name`, `type` (primary, aggregating, or join), the index `expression`, and the `size_compressed`.

##### Syntax
{: .no_toc}

```sql
SHOW INDEXES;
```

##### Example
{: .no_toc}

```sql
SHOW INDEXES;
```

**Returns:**

```
+------------------------+----------------+-------------+----------------------------------------------------------------------------------------------------------+-----------------+-------------------+-------------------+--------------------+
|       index_name       |   table_name   |    type     |                                                expression                                                | size_compressed | size_uncompressed | compression_ratio | number_of_segments |
+------------------------+----------------+-------------+----------------------------------------------------------------------------------------------------------+-----------------+-------------------+-------------------+--------------------+
| primary_lineitem       | lineitem       | primary     | ["l_orderkey","l_linenumber"]                                                                            | N/A             | N/A               | N/A               | N/A                |
| primary_partition_test | partition_test | primary     | ["store_id","product_id"]                                                                                | N/A             | N/A               | N/A               | N/A                |
| agg_lineitem           | lineitem       | aggregating | ["\"l_suppkey\"","\"l_partkey\"","SUM(\"l_quantity\")","SUM(\"l_extendedprice\")","AVG(\"l_discount\")"] | N/A             | N/A               | N/A               | 8                  |
+------------------------+----------------+-------------+----------------------------------------------------------------------------------------------------------+-----------------+-------------------+-------------------+--------------------+
```

## SHOW TABLES

Lists all tables defined in the current database. Returns `table_name`, `state`, `table_type`, `column_count`, `primary_index`, and `schema` (the `CREATE [EXTERNAL|FACT|DIMENSION] TABLE` statement for the table).

##### Syntax
{: .no_toc}

```sql
SHOW TABLES;
```

##### Example
{: .no_toc}

```sql
SHOW TABLES;
```

**Returns**:

```
+----------------+-------+------------+--------------+----------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------+------+-------------------+-------------------+--------------------+
|   table_name   | state | table_type | column_count |       primary_index        |                                                                                                                                                                                                                                                                                                                           schema                                                                                                                                                                                                                                                                                                                            | number_of_rows | size | size_uncompressed | compression_ratio | number_of_segments |
+----------------+-------+------------+--------------+----------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------+------+-------------------+-------------------+--------------------+
| ex_lineitem    | Valid | EXTERNAL   |           16 | N/A                        | CREATE EXTERNAL TABLE IF NOT EXISTS "ex_lineitem" ("l_orderkey" long NOT NULL, "l_partkey" long NOT NULL, "l_suppkey" long NOT NULL, "l_linenumber" int NOT NULL, "l_quantity" long NOT NULL, "l_extendedprice" long NOT NULL, "l_discount" long NOT NULL, "l_tax" long NOT NULL, "l_returnflag" text NOT NULL, "l_linestatus" text NOT NULL, "l_shipdate" text NOT NULL, "l_commitdate" text NOT NULL, "l_receiptdate" text NOT NULL, "l_shipinstruct" text NOT NULL, "l_shipmode" text NOT NULL, "l_comment" text NOT NULL) "URL" = 's3://firebolt-publishing-public/samples/tpc-h/parquet/lineitem/' "OBJECT_PATTERN" = '*.parquet' "TYPE" = ("PARQUET") | N/A            | N/A  | N/A               | N/A               | N/A                |
| lineitem       | Valid | FACT       |           16 | [l_orderkey, l_linenumber] | CREATE FACT TABLE IF NOT EXISTS "lineitem" ("l_orderkey" long NOT NULL, "l_partkey" long NOT NULL, "l_suppkey" long NOT NULL, "l_linenumber" int NOT NULL, "l_quantity" long NOT NULL, "l_extendedprice" long NOT NULL, "l_discount" long NOT NULL, "l_tax" long NOT NULL, "l_returnflag" text NOT NULL, "l_linestatus" text NOT NULL, "l_shipdate" text NOT NULL, "l_commitdate" text NOT NULL, "l_receiptdate" text NOT NULL, "l_shipinstruct" text NOT NULL, "l_shipmode" text NOT NULL, "l_comment" text NOT NULL) PRIMARY INDEX "l_orderkey", "l_linenumber"                                                                                           | N/A            | N/A  | N/A               | N/A               | 6                  |
| partition_test | Valid | FACT       |            5 | [store_id, product_id]     | CREATE FACT TABLE IF NOT EXISTS "partition_test" ("transaction_id" long NOT NULL, "transaction_date" timestamp NOT NULL, "store_id" int NOT NULL, "product_id" int NOT NULL, "units_sold" int NOT NULL) PRIMARY INDEX "store_id", "product_id" PARTITION BY EXTRACT(YEAR FROM "transaction_date")                                                                                                                                                                                                                                                                                                                                                           | N/A            | N/A  | N/A               | N/A               | N/A                |
| Insert_test    | Valid | DIMENSION  |            3 | N/A                        | CREATE DIMENSION TABLE IF NOT EXISTS "Insert_test" ("name" long NOT NULL, "number" int NOT NULL, "other_name" long NOT NULL)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | N/A            | N/A  | N/A               | N/A               | 2                  |
+----------------+-------+------------+--------------+----------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------+------+-------------------+-------------------+--------------------+
```
