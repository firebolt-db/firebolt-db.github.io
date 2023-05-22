---
layout: default
title: Working with Parquet arrays and maps
description: Learn how to ingest (load) Parquet data into Firebolt and work with Parquet maps, structs, and arrays of structs.
nav_order: 4
parent: Working with semi-structured data
---
# Working with Parquet arrays and maps
{: .no_toc}

Apache Parquet is a binary file format that can store complex nested file structures in a compressed, columnar format. This topic provides guidance for ingesting and querying Parquet data that is stored as structs in arrays or as maps of key-value pairs.

* Topic ToC
{:toc}

## Defining external table columns for Parquet arrays and maps

When you set up an external table to ingest Parquet data files, you use a hierarchical dotted notation syntax to define table columns. Firebolt uses this notation to identify the field to ingest.

## Prerequisite

To run queries and DML commands on external tables that use this notation, you must run the `SET` command shown in the example below. You cannot run the `SET` clause within another statement. In other words, it must be on its own and terminated by a semi-colon. This also applies to external tables connected to AWS Glue.

```sql
SET use_short_column_path_parquet = 1;
```

## Syntax for defining a Parquet nested structure

You specify the top grouping element of a nested structure in Parquet followed by the field in that structure that contains the data to ingest. You then declare the column type using the `ARRAY(<data_type>)` notation, where `<data type>` is the [Firebolt data type](../general-reference/data-types.md) corresponding to the data type of the field in Parquet.

```sql
"<grouping1>.<datafield>" ARRAY(<data_type>)
```

Examples of this syntax in `CREATE EXTERNAL TABLE` queries are demonstrated below.

## Example&ndash;ingest and work with structs inside Parquet arrays

Consider the Parquet schema example below. The following elements define an array of structs:

* A single, optional group field, `hashtags`, contains any number of another group, `bag`. This is the top grouping element.
* The `bag` groups each contain a single, optional group, `array_element`.
* The`array_element` group contains a single, optional field, `s`.
* The field `some_value` contains a value that is a `TEXT` type \(in binary primitive format\).

```
optional group hashtags (LIST) {
  repeated group bag {
    optional group array_element {
      optional binary some_value (TEXT);
    }
```

The steps below demonstrate the process to ingest the array values into Firebolt. You create an external table, create a fact table, and insert data into the fact table from the external table, which is connected to the Parquet data store.

### Step 1&ndash;create an external table

The `CREATE EXTERNAL TABLE` example below creates a column in an external table from the Parquet schema shown in the example above. The column definition uses the top level grouping `hashtags` followed by the field `some_value`. Intermediate nesting levels are omitted.

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS my_parquet_array_ext_tbl
(
  [...,] --additional columns possible, not shown
  "hashtags.some_value" ARRAY(TEXT)
  [,...]
)
CREDENTIALS = (AWS_KEY_ID = '****' AWS_SECRET_KEY = '*****')
URL = 's3://my_bucket_of_parquet_goodies/'
OBJECT_PATTERN = '*.parquet'
TYPE = (PARQUET);
```


When connecting your external table to AWS Glue, we create the columns automatically using the same logic as described above.


### Step 2&ndash;create a fact or dimension table

Create a fact or dimension table that defines a column of the same `ARRAY(TEXT)` type that you defined in the external table in step 1. The example below demonstrates this for a fact table.

```sql
CREATE FACT TABLE IF NOT EXISTS my_parquet_array_fact_tbl
(
  [...,] --additional columns possible, not shown
  some_value ARRAY(TEXT)
  [,...]
)
[...]
--required primary index for fact table not shown
--optional partitions not shown
;
```

### Step 3&ndash;insert into the fact table from the external table

The example below demonstrates an `INSERT INTO` statement that selects the array values from Parquet data files using the external table column definition in step 1, and then inserts them into the specified fact table column, `some_value`.

```sql
SET use_short_column_path_parquet = 1;

INSERT INTO my_parquet_array_fact_tbl
  SELECT "hashtags.some_value" AS some_value
  FROM my_parquet_array_ext_tbl;
```

### Step 4&ndash;query array values

After you ingest array values into the fact table, you can query and manipulate the array using array functions and Lambda functions. For more information, see [Working with arrays](working-with-arrays.md).

## Example&ndash;ingest and work with maps

External tables connected to AWS Glue currently do not support reading maps from Parquet files.

Map keys and values in Parquet appear within a group similar to arrays. Consider the Parquet schema example below. The following define the key-value elements of the map:

* A single, optional group, `context`, is a group of mappings that contains any number of the group `key_value`.
* The `key_value` groups each contain a required field, `key`, which contains the key name as a `TEXT`. Each group also contains an optional field `value`, which contains the value as a `TEXT` corresponding to the key name in the same `key_value` group.

```
optional group context (MAP) {
    repeated group key_value {
      required binary key (TEXT);
      optional binary value (TEXT);
    }
  }
```

The steps below demonstrate the process of creating an external table, creating a fact table, and inserting data into the fact table from the Parquet file using the external table.

### Step 1&ndash;create an external table

When you create an external table for a Parquet map, you use the same syntax that you use in the example for arrays above. You create one column for keys and another column for values. The `CREATE EXTERNAL TABLE` example below demonstrates this.

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS my_parquet_map_ext_tbl
(
  "context.keys" ARRAY(TEXT),
  "context.values" ARRAY(TEXT)
)
CREDENTIALS = (AWS_KEY_ID = '****' AWS_SECRET_KEY = '*****')
URL = 's3://my_bucket_of_parquet/'
OBJECT_PATTERN = '*.parquet'
TYPE = (PARQUET);
```

### Step 2&ndash;create a fact or dimension table

Create a Firebolt fact or dimension table that defines columns of the same `ARRAY(TEXT)` types that you defined in the external table in step 1. The example below demonstrates this for a fact table.

```sql
CREATE FACT TABLE IF NOT EXISTS my_parquet_map_fact_tbl
(
  [...,] --additional columns possible, not shown
  my_parquet_array_keys ARRAY(TEXT)
  my_parquet_array_values ARRAY(TEXT)
  [,...]
)
[...] --required primary index for fact table not shown
      --optional partitions not shown
```

### Step 3&ndash;insert into the fact table from the external table

The example below demonstrates an `INSERT INTO` statement that selects the array values from Parquet data files using the external table column definition in step 1, and inserts them into the specified fact table columns, `my_parquet_array_keys` and `my_parquet_array_values`.

```sql
SET use_short_column_path_parquet = 1;

INSERT INTO my_parquet_map_fact_tbl
  SELECT "context.keys" AS my_parquet_array_keys,
         "context.values" AS my_parquet_array_values
  FROM my_parquet_map_ext_tbl
```

### Step 4&ndash;query map values

After you ingest array values into the fact table, you can query and manipulate the array using array functions and Lambda functions. For more information, see [Working with arrays](working-with-arrays.md).

A query that uses a Lambda function to return a specific value by specifying the corresponding key value is shown below. For more information, see [Manipulating arrays using Lambda functions](working-with-arrays.md#manipulating-arrays-with-lambda-functions).

```sql
SET use_short_column_path_parquet = 1;

SELECT
  ARRAY_FIRST(v, k -> k = 'key_name_of_interest', my_parquet_array_keys, my_parquet_array_values) AS returned_corresponding_key_value
FROM
  my_parquet_map_ext_tbl;
```
