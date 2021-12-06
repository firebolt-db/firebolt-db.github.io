---
layout: default
title: Working with partitions
nav_order: 4
parent: Concepts
---
# Working with partitions

Partitions are multiple smaller physical parts of large tables created for data maintenance and performance. They are defined as part of the table's DDL and maintained as part of the table's internal structure. You can partition your data by any column in your table.

## When to use partitions

Partitions should be used on large fact tables in one of the following scenarios:

1. **Delete or update data:** Partitions are useful if you need to perform update or delete operations on large portions of your data. Data can be deleted from a specified partition by using the [ALTER TABLE ... DROP PARTITION](../sql-reference/commands/ddl-commands.md#alter-table-drop-partition) command. After deleting data from a partition, it can be updated with new data by using an [INSERT](../sql-reference/commands/dml-commands.md#insert-into) command.
2. **Boost performance:** If your fact table is large enough \(contains more than 100 million rows\), consider using partitions to better prune data at query time. When the partition key appears in the WHERE clause of your queries, it will extend the Primary Index's functionality and reduce the required I/O so that you can benefit from even faster query response times.


Note that the partition key column doesn't have to be part of a query's [WHERE](../sql-reference/commands/query-syntax.md#where) predicate. In such cases, Firebolt utilizes the Primary Index per partition and reads them all.


## Considerations and limitations

When using partitions, pay attention to the following:

1. Plan carefully - partitions definition takes place during table creation. Check the queries you plan to run on your data - in particular - the [WHERE](../sql-reference/commands/query-syntax.md#where) clauses in them. Make sure that either the table primary index or the table partition key covers those to enjoy maximum data pruning. Read more here on how to configure the partition key [here](working-with-partitions.md#configuring-the-partition-key).
2. The partition key cannot be composed of nullable columns.

## Choosing the partition key

If you choose to use partitions in order to delete or update data by key, then your partition key should be the column by which you intend to update/delete. For example, if you need to store 1 month of data, set your partition key based on your `date` column, so you can drop partitions that are older than 1 month.

If you choose to use partitions for boosting performance, set your partition key as the main predicate in your [WHERE](../sql-reference/commands/query-syntax.md#where) clause, so that it will prune as much data as possible for each query. For example, if your main query's predicate is the `product_type` column, set the partition key by this column.

In both cases, the recommendation is not to use long text columns as your partition key.

Partitioning your table is done as part of the [CREATE FACT TABLE DDL](../sql-reference/commands/ddl-commands.md#create-fact-dimension-table) using the [PARTITION BY](../sql-reference/commands/ddl-commands.md#partition-by) specifier.

## Working with partitions

* Once the table is created with the required partition key, Firebolt arranges the table's data in the relevant partitions. New rows will be stored, each on the relevant partition and queries will prune and read from the relevant partition.
* New partitions will be created automatically during ingest, based on the partition key.
* Drop partitions, if requested, should be done manually by the DB admin.  

### **Configuring the partition key**

The partition key can be either a column name or a result of a function applied on a column:

```sql
PARTITION BY date_column;
PARTITION BY product_type;
PARTITION BY EXTRACT(MONTH FROM date_column);
PARTITION BY EXTRACT(MONTH FROM date_column), product_type;
```

The following functions are supported for defining the partition key:

* [DATE\_FORMAT](../sql-reference/functions-reference/date-and-time-functions.md#date_format)
* [EXTRACT](../sql-reference/functions-reference/date-and-time-functions.md#extract)

### **Drop partition**

In order to delete data from your table, use the [ALTER TABLE...DROP PARTITION](../sql-reference/commands/ddl-commands.md#alter-table-drop-partition) command.

For example: With the above `extract(month from date_column),product_type`partition key, we have a partition key composed of multiple columns to represent the month of the date\_column and the product type. In order to drop the partition of `December (12)` and product type `34`, use the following command:

```sql
ALTER TABLE <table_name> DROP PARTITION 12,34;
```


When using multiple columns for the partition key, Firebolt creates each partition with all the column boundaries, and when using the [ALTER TABLE ... DROP PARTITION](../sql-reference/commands/ddl-commands.md#alter-table-drop-partition) command - the full partition key should be specified. Providing a partial partition key value is not supported.


## Examples

### Example 1: Partition by a single column

Create a fact table and partition it by year \(assume data was loaded to that table\):

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

Drop all the transactions which took place in the year of `2020`:

```sql
ALTER TABLE transactions DROP PARTITION 2020;
```

### Example 2: Partition by multiple columns

Create a table with a partition key composed of multiple columns:

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

Drop the transactions that have the store\_id `982` and took place in `2020`:

```sql
ALTER TABLE transactions DROP PARTITION 982,2020;
```
