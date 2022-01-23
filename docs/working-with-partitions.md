---
layout: default
title: Working with partitions
nav_order: 9
---
# Working with partitions

Partitions are multiple smaller physical parts of large tables created for data maintenance and performance. They are defined as part of the table's DDL and maintained as part of the table's internal structure. You can partition your data by any column in your table.

## When to use partitions

Partitions should be used on large fact tables in one of the following scenarios:

### Delete or update data in bulk
Partitions are useful if you need to perform update or delete operations on large portions of your data. You can use [ALTER TABLE ... DROP PARTITION](sql-reference/commands/ddl-commands.md#alter-table-drop-partition). After deleting data from a partition, it can be updated with new data by using an [INSERT](sql-reference/commands/dml-commands.md#insert-into) command.

### Improve performance
If your fact table is large enough (greater than 100 million rows), consider using partitions to better prune data at query runtime. When the partition key appears in the `WHERE` clause of your queries, it extends the functionality of your primary index and reduces the required disk I/O even further.

{: .note}
It's not a requirement that the partition key column appear in a query's [WHERE](sql-reference/commands/query-syntax.md#where) predicate. If it doesn't, Firebolt uses the primary index and reads from all partitions.

## Defining partition keys

You define partitions using the [PARTITION BY](sql-reference/commands/ddl-commands.md#partition-by) clause in a [CREATE FACT TABLE](sql-reference/commands/ddl-commands.md#create-fact--dimension-table) statement.

The partition key can be either a column name or a result of a function applied on a column:

```sql
PARTITION BY date_column;
PARTITION BY product_type;
PARTITION BY EXTRACT(MONTH FROM date_column);
PARTITION BY EXTRACT(MONTH FROM date_column), product_type;
```

The following functions are supported for defining the partition key:

* [DATE_FORMAT](sql-reference/functions-reference/date-and-time-functions.md#date_format)
* [EXTRACT](sql-reference/functions-reference/date-and-time-functions.md#extract)

When using multiple columns for the partition key, Firebolt creates each partition with all the column boundaries.

## Choosing paritition keys
Check the queries you plan to run on your data&mdash;in particular, the [WHERE](sql-reference/commands/query-syntax.md#where) clauses in them. Make sure that either the table primary index or the table partition key covers those to enjoy maximum data pruning. The partition key cannot contain nullable columns. Avoid using long text columns as your partition key.

If you use partitions to delete or update data, your partition key should be the column by which you intend to update and delete. For example, if you need to store one month of data, set your partition key based on your `date` column so that you can drop partitions that are older than one month.

If you choose to use partitions to improve performance, base your partition key on the main predicate in your [WHERE](../sql-reference/commands/query-syntax.md#where) clause, so that it prunes as much data as possible for each query. For example, if your main query's predicate is the `product_type` column, use that column in the partition key.

## Working with partitions

After the table is created with the required partition key, Firebolt arranges the table's data in the specified partitions. New partitions will be created automatically during ingest, based on the partition key. New rows are stored in the relevant partition, and queries prune and read from the relevant partition. A database administrator should drop partitions manually.  

## Dropping partitions

Use the [ALTER TABLE...DROP PARTITION](sql-reference/commands/ddl-commands.md#alter-table-drop-partition) command to delete a partition. When working with multiple-column partition keys, you must specify the full partition key. Using a partial partition key value is not supported.

For example, the partition key defined as `extract(month from date_column), product_type` creates partitions based on an extraction of the month value from the `date_column`, and the `product_type`, which is a numeric product identifier. The statement below drops the partition consisting of the month December (`12`) and product type `34`.

```sql
ALTER TABLE <table_name> DROP PARTITION 12,34;
```

## Example&ndash;partition and drop using a column

The example below creats a fact table that is partitioned by year. All records with the same year value extracted from the `transaction_date` column are saved in the same partition.

```sql
CREATE FACT TABLE transactions
(
    transaction_id    BIGINT,
    transaction_date  DATETIME,
    store_id          INT,
    product_id        INT,
    units_sold        INT
)
PRIMARY INDEX store_id, product_id
PARTITION BY EXTRACT(YEAR from transaction_date);
```

The example below deletes all the rows that have the year `2020` in the `transaction_date` column from the table.

```sql
ALTER TABLE transactions DROP PARTITION 2020;
```

## Example&ndash;partition and drop using multiple columns

The example below creates a table that is partitioned by year and `store_id`. Records with the same year *and* the same `store_id` values are saved in the same partition.

```sql
CREATE FACT TABLE transactions
(
    transaction_id    BIGINT,
    transaction_date  DATETIME,
    store_id          INT,
    product_id        INT,
    units_sold        INT
)
PRIMARY INDEX store_id, product_id
PARTITION BY store_id,EXTRACT(YEAR FROM transaction_date);
```

The example below deletes all the rows that have both the year `2020` in the `transaction_date` column and the value `982` un the `store_id` column.

```sql
ALTER TABLE transactions DROP PARTITION 982,2020;
```
