---
layout: default
title: Using indexes
nav_order: 2
parent: Concepts
---
# Using indexes for faster queries

Firebolt incorporates several building blocks that enable accelerate query response times.

Those building blocks are called indexes. Using them wisely not only guarantees fast query response times but will also reduce down your cloud bill.

**In this topic:**

1. [Primary indexes as the first line of performance accelerator](get-instant-query-response-time.md#primary-indexes)
2. [Get sub-second query response time using aggregating indexes](get-instant-query-response-time.md#get-sub-second-query-response-time-using-aggregating-indexes)
3. [Accelerate queries using join indexes](get-instant-query-response-time.md#accelerate-joins-using-join-indexes)

## Primary indexes

The primary indexes are the main sort key of the table. They will be built with the table using the [CREATE FACT/DIMENSION TABLE syntax](../sql-reference/commands/ddl-commands.md#create-fact--dimension-table) and will be used as the main tool for data pruning and data distribution.
 
By using the primary index, Firebolt will read ranges of data from each F3 file. This will reduce the I/O needed to be read, and increase performance dramatically.

### How to choose your Primary index

The columns we set in the primary index and their order is a key factor for the index success. Make sure to put the main queries filter columns, in the order that filter the most.

* In partitioned tables, the partition key column will be the first line of data distribution. The primary index will be used in each partition as the second level of sort/distribution.
* If you have a use case of a star schema, and you use [join indexes](../sql-reference/commands/ddl-commands.md#create-join-index) on your dimension tables, we recommend adding the dimension join key as the first column in the primary index.

## Get sub-second query response time using aggregating indexes

Firebolt incorporates many building blocks to guarantee fast query response times. One of these building blocks is a type of index called an [aggregating index](../sql-reference/commands/ddl-commands.md#create-aggregating-index).

The aggregating index enables you to take a subset of a table's columns and configure aggregations on top of those columns. Many aggregations are supported from the simple `sum`, `max`, `min` to more complex ones such as `count` and `count (distinct)`. The index is automatically updated and aggregating as new data streams into the table without having to scan the entire table every time since the index is stateful and consistent.

The index is configured per table so when the table is queried, Firebolt's query optimizer searches the table's indexes for the index (or indexes) which has the potential for providing the most optimized query response time. When using the index - Instead of calculating the aggregation on the entire table and scanning all the rows, the aggregation is already pre-calculated in the aggregating index. No need to scan the entire table to perform the calculation.

### When to use aggregating indexes

You should consider using aggregating indexes as a best practice in Firebolt to speed up dashboards, reports, or any type of workload that is highly repetitive in your queries and contains aggregations. Not only does it speed up queries dramatically, but it also helps reduce compute costs because the CPU doesn’t need to work as hard to scan as much data. This means that once indexes are set up, you can often reduce your cluster size (and thus pay less on compute), while still enjoying fast query performance.

### How many aggregating indexes can I create?

You can create as many aggregating indexes as you like. Since the indexes are compressed and relatively small compared to the table they are configured on - you have nothing to worry about increasing your cloud bill. In fact, when using aggregating indexes your cloud bill will drop significantly since you will probably be able to reduce your cluster size and maybe also use an engine with a cheaper spec.

### Prerequisites

To configure an aggregating index, first, you need to [create a Fact table](../sql-reference/commands/ddl-commands.md#create-fact--dimension-table).

### Create and generate an aggregating index

Use the [CREATE & GENERATE AGGERGATING INDEX syntax](../sql-reference/commands/ddl-commands.md#create-aggregating-index) to create and generate an aggregating index that includes the keys and the functions per parameter that you usually query.

**Example: Implementing an aggregating index for common queries**

To create an index, we need to first create a fact table. We'll call ours _fact\_orders_.

```sql
CREATE FACT TABLE fact_orders
(
    order_id LONG,
    product_id LONG,
    store_id LONG,
    client_id LONG,
    order_date DATE,
    order_total DOUBLE,
    order_item_count INT
)
PRIMARY INDEX store_id, product_id, order_id;
```

From this table, let's assume we typically run queries that calculate the `SUM(order_total), SUM(order_item_count)`,`AVG(order_item_count)`, and `COUNT(DISTINCT client_id),` grouped by different combinations of the `store_id` and `product_id` columns.

To help us accelerate our queries, we'll create an aggregating index and populate it as follows:

```sql
CREATE AND GENERATE AGGREGATING INDEX agg_fact_orders ON fact_orders
(
  store_id,
  product_id,
  SUM(order_total),
  SUM(order_item_count),
  AVG(order_item_count),
  COUNT(DISTINCT client_id)
);
```

From now on, every query for data from the _fact\_orders_ table that combines any of these fields and aggregations will now benefit from the aggregating index. Instead of performing a full query scan and every aggregation, the engine uses the aggregating index - which already has the required aggregations pre-calculated - providing a sub-second query response time.


The order of the fields is important. Firebolt will create the primary index on the aggregating index as an optimization to filter it best. The primary index will be built based on the index fields, in the order as they were written. In our example, the primary index will be in the following order: `store_id`, `product_id`. Make sure to write first those you mostly filter by in your query [WHERE clause](../sql-reference/commands/query-syntax.md#where).


## Accelerate joins using join indexes

Firebolt supports accelerating your joins by creating join indexes. Queries with joins might be resource-consuming and - if not done efficiently - can take a significant amount of time to complete which makes them unusable to the user. Using Firebolt’s join indexing saves time searching data in the disk and loading it into memory. It’s already there, indexed by the required join key, and waits to be queried.

**Warning!**
Join indexes are not updated automatically in an engine when new data is ingested into a dimension table or a partition is dropped. You must refresh all indexes on all engines with queries that use them or those queries will return pre-update results. For more information, see [REFRESH JOIN INDEX](../sql-reference/commands/ddl-commands.md#refresh-join-index "mention").

### When to use join index

You should consider implementing join indexes as best practice in Firebolt to speed up any query which performs a join with a dimension table. This reduces the additional overhead of performing the join to the minimum with the benefit of fast query response times. It also keeps your cloud bill low.

### Create join index

Configuring the join index is being done using the [CREATE JOIN INDEX syntax](../sql-reference/commands/ddl-commands.md#create-join-index).

**Example:**

Assuming we have the following tables:

1. A fact table `my_fact` with a column named `id` and some additional columns.
2. A dimension table `my_dimension` with a column named `id` and some additional columns.

We want to run the following query:

```sql
select * from my_fact left join my_dimension_table on (my_fact.id = my_dimension_table.id)
```

Let's create the following join index:

```sql
CREATE JOIN INDEX IF NOT EXISTS my_join_index ON my_dimension_table
(
  id
)
```

The query optimizer uses `my_join_index` instead of performing the join in runtime. This instantly reduces both CPU and memory overhead while achieving super-fast query response time.
