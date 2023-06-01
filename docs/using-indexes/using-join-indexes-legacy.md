---
layout: default
title: Join indexes (legacy)
description: Learn about join indexes (legacy) in Firebolt and how to configure and use them.
nav_exclude: true
parent: Using indexes
---

# Legacy index commands 

Prior to release of DB version 3.19, join indexes needed to be created and manually refreshed. Below are legacy instructions. 

## When to use a join index (legacy)

Join indexes are most effective when you define them for a single, large dimension table that you join with many fact tables. A join index is also most effective when the query with a `JOIN` returns only a small subset of many available columns in the dimension table. You can create as many join indexes per dimension table as you want.

## How join indexes work (legacy)

When you create a join index, you specify a dimension table, the unique join key column in the dimension table, and columns in the dimension table that are used in the `SELECT` query with the `JOIN`. When you run the query, the Firebolt optimizer looks for a join index to use. If the query uses the join key column and dimension columns that you defined in the join index, Firebolt reads the join index from engine RAM.

## How to define a join index (legacy)

To create a join index, use the [`CREATE JOIN INDEX`](../sql-reference/commands/create-join-index.md) statement. You can create as many join indexes for a dimension table as you need.

The join index definition establishes the name of the join index and specifies the dimension table it applies to. The definition then specifies the join key column. The join key column must appear in the first position. This column must have been created using the `UNIQUE` attribute and have no duplicate values. For more information, see [`CREATE FACT|DIMENSION TABLE`](../sql-reference/commands/create-fact-dimension-table.md).

```sql
CREATE JOIN INDEX [IF NOT EXISTS] <unique_join_index_name> ON <dim_table_name>
  (
    <dim_join_key_col>,
    <dim_col1>[,...<dim_colN>]  
  );
```