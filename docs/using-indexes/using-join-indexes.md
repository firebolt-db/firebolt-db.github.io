---
layout: default
title: Join indexes
description: Learn about join indexes in Firebolt and how to configure and use them.
nav_order: 4
parent: Using indexes
---

# Using join indexes
{: .no_toc}

* Topic ToC
{:toc}

Join operations are often the most resource-intensive aspect of queries, slowing down queries and consuming engine resources. Firebolt join indexes can help accelerate queries that include joins. Firebolt can read the join index cached in engine RAM rather than creating the join at query runtime. This reduces disk I/O and compute resources at query runtime. Queries run faster and you can use engine resources more efficiently to reduce cost.

## When to use a join index

Join indexes are most effective when you define them for a single, large dimension table that you join with many fact tables. A join index is also most effective when the query with a `JOIN` returns only a small subset of many available columns in the dimension table. You can create as many join indexes per dimension table as you want.

## How join indexes work

When you create a join index, you specify a dimension table, the unique join key column in the dimension table, and columns in the dimension table that are used in the `SELECT` query with the `JOIN`. When you run the query, the Firebolt optimizer looks for a join index to use. If the query uses the join key column and dimension columns that you defined in the join index, Firebolt reads the join index from engine RAM.

## How to define a join index

To create a join index, use the [`CREATE JOIN INDEX`](../sql-reference/commands/create-join-index.md) statement. You can create as many join indexes for a dimension table as you need.

The join index definition establishes the name of the join index and specifies the dimension table it applies to. The definition then specifies the join key column. The join key column must appear in the first position. This column must have been created using the `UNIQUE` attribute and have no duplicate values. For more information, see [`CREATE FACT|DIMENSION TABLE`](../sql-reference/commands/create-fact-dimension-table.md).

```sql
CREATE JOIN INDEX [IF NOT EXISTS] <unique_join_index_name> ON <dim_table_name>
  (
    <dim_join_key_col>,
    <dim_col1>[,...<dim_colN>]  
  );
```

## Examples
See *Join indexes* in the [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action) blog post.
