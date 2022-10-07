---
layout: default
title: Aggregating indexes
description: Learn about aggregating indexes in Firebolt and how to configure and use them.
nav_order: 3
parent: Using indexes
---

# Using aggregating indexes
{: .no_toc}

* Topic ToC
{:toc}

Aggregating indexes accelerate queries that include aggregate functions that you perform repeatedly on large fact tables with millions or billions of rows. Aggregating indexes greatly reduce the compute resources required at query runtime to process functions. This can improve performance and save cost by allowing you to use less costly engines. Dashboards and repetitive reports are common use cases for aggregating indexes. It’s less common to create aggregating indexes for ad hoc queries.

## How aggregating indexes work

Firebolt uses an aggregating index to pre-calculate and store the results of aggregate functions that you define. An aggregating index is like a materialized view in many ways, with technology proprietary to Firebolt that works together with the F3 storage format to make them more efficient.

At query runtime, Firebolt scans the aggregating indexes associated with a fact table to determine those that provide the best fit to accelerate query performance. To return query results, Firebolt uses the indexes rather than scanning the table.

Firebolt automatically updates aggregating indexes as you ingest new data. The precalculated results of aggregate functions are stateful and consistent with the underlying fact table data on the engine.

Firebolt shards aggregating indexes across engine nodes in multi-node engines as it does with underlying fact tables.

The video below is a technical discussion of some issues with traditional materialized views and how Firebolt addresses the problem with unique technology. Eldad Farkash is the CEO of Firebolt.
<iframe width="560" height="315" src="https://www.youtube.com/embed/Hniv9u4w7lI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Aggregating index tradeoffs

Effective aggregating indexes are relatively small compared to the underlying fact table. We recommend that you confirm that an aggregating index is significantly smaller than the underlying fact table. For more information, see [Validating aggregating index size](#validating-aggregating-index-size) below.

For very large fact tables, an aggregating index may still be quite large. If the index is effective, the savings at query runtime will outweigh the cost of storage. Aggregating indexes also increase compute requirements during data ingestion because Firebolt performs pre-calculations at that time. As with storage, savings at query runtime usually outweigh the ingestion cost.

If your application favors speed of ingestion over speed of analytics queries, be sure to test ingestion with aggregating indexes before production. You can also change the impact of aggregating indexes on ingestion and first-query speed by configuring the engine warmup method. For more information, see [Warmup method](../working-with-engines/understanding-engine-fundamentals.md#warmup-method).

## How to define an aggregating index

To create an aggregating index, use the [`CREATE AGGREGATING INDEX`](../sql-reference/commands/create-aggregating-index.md) statement. This statement specifies a fact table, a subset of columns from the table, and a list of the aggregate functions that commonly run over that table. You can create as many aggregating indexes per table as you need. Each aggregating index is associated with a single fact table.

The syntax for the `CREATE AGGREGATING INDEX` is shown below.

```sql
CREATE AGGREGATING INDEX <agg_index_name> ON <fact_table_name>
  (
    <fact_table_column_1> [,<fact_table_column_2>][,...]
    <aggregate_expression> [,...]
  );
```

### Creating the index on empty tables is preferred

Whenever possible, we strongly recommend that you create aggregating indexes for a fact table when the table is empty, before you run the first `INSERT INTO` command to ingest data.

### Aggregating indexes can’t be modified

You can’t modify aggregating indexes after you create them. To modify an aggregating index, use the `DROP AGGREGATING INDEX` command, and then use `CREATE AGGREGATING INDEX` to specify a new index for the same table.

### How to choose aggregating index columns

Firebolt uses the columns that you specify for an aggregating index in much the same way as the columns for a primary index.

Follow the same guidelines as those outlined for primary index columns. For more information, see [Using primary indexes](using-primary-indexes.md). Most importantly, specify columns in descending order of cardinality, highest cardinality first.

All columns that are used in aggregations at query runtime must appear in the index definition, either in the primary index or the function definitions, for the optimizer to use the index at query runtime. This includes columns that are part of the aggregate functions, any columns used in `GROUP BY` and `WHERE` clauses, and any columns in the fact table that are used as join keys. If a column is missing, Firebolt must scan the fact table, and the aggregating index doesn’t improve performance.

### How to choose aggregate expressions

You can specify as many aggregate expressions as required in an aggregating index definition. At query runtime, the number of aggregate expressions does not affect query performance. However, because Firebolt pre-processes each aggregate expression during ingestion, each additional aggregate expression increases compute requirements during ingestion.

Aggregate expressions that you specify must correspond precisely to the aggregate expressions used at query runtime, including specified columns. You also can specify complex functions in the index definition, but make sure to specify them precisely as you use them in queries.

## Aggregating indexes and partitions

Aggregating indexes inherit the partitions from the underlying fact table. When you drop a partition from the underlying fact table, the partition is dropped from the aggregating index.

## Aggregating indexes and engine warmup method

The columns that you specify for an aggregating index are essentially a primary index for the aggregating index. With the warmup method set to **Preload indexes**, an engine preloads these columns on warmup but doesn’t perform the pre-calculations until Firebolt uses the index. This accelerates ingestion but causes first queries to be slower than subsequent queries. With the warmup method set to **Preload all data**, an engine loads the calculations in addition to the columns. This slows engine start time, but accelerates the first analytics query. For more information, see [Engine warmup method](../working-with-engines/understanding-engine-fundamentals.md#warmup-method).

## Validating aggregating index size

You should aim for aggregating index results to be a ratio of approximately 20-50% size of the whole table or smaller. The smaller the ratio, the more effective the aggregating index is.

For example, with the aggregating index below on the table store_sales with 200,000,000 rows.

```sql
CREATE AGGREGATING INDEX idx_agg_store_sales ON store_sales (
	ss_sold_date_sk,
	ss_item_sk,
	sum(ss_ext_discount_amt)
);
```

You can run the following query to validate that the size of the aggregating index is effective:

```sql
SELECT count(*)
FROM (
  SELECT
    ss_sold_date_sk,
    ss_item_sk
  FROM
    store_sales
  GROUP BY
    1,2);
```

If the `SELECT` query returns 100,000,000 or fewer, the aggregating index may be beneficial. If it returns 40,000,000 or fewer it will almost certainly be beneficial.

## Aggregating index examples

The example in this section are based on a fact table, `fact_orders`, created with the DDL shown below. For a more in-depth example, see *Aggregating indexes* in the [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action) blog post.

```sql
CREATE FACT TABLE fact_orders (
  order_id LONG,
  product_id LONG,
  store_id LONG,
  client_id LONG,
  order_date DATE,
  order_total DOUBLE,
  order_item_count INT
)
PRIMARY INDEX
  store_id,
  product_id,
  order_id;
```

From this table, let's assume we typically run queries that use these aggregations:

```sql
SUM(order_total)
SUM(order_item_count)
AVG(order_item_count)
COUNT(DISTINCT client_id)
```

And they are grouped by different combinations of the `store_id` and `product_id` columns.

‌The DDL below creates an aggregating index to accelerate these aggregations.

```sql
CREATE AGGREGATING INDEX agg_fact_orders ON fact_orders (
  store_id,
  product_id,
  SUM(order_total),
  SUM(order_item_count),
  AVG(order_item_count),
  COUNT(DISTINCT client_id)
);
```

As with a primary index, the order of the columns specified is important. Firebolt creates a primary index for the aggregating index. In our example, the primary index is in the order of `store_id`, `product_id`.
