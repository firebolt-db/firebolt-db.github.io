---
layout: default
title: Quick reference
description: Use this quick reference and cheat sheet for Firebolt indexes to remember index roles and configuration keys.
nav_order: 1
parent: Using indexes
---

# Index quick reference
{: .no_toc}

* Topic ToC
{:toc}

## Primary indexes

* Accelerate queries at runtime&mdash;efficiently prunes ranges of data for reads from Firebolt File Format (F3).
* Defined by you in `CREATE TABLE` clause. Only one per table because of physical sort in F3. Updated automatically with incremental ingestion.
* Specify columns frequently used in `WHERE` predicates that drastically filter, in order of filtering effect (highest degree of filtering first). Also specify columns used as join keys.
* Sparse indexes behind the scenes&mdash;one entry per data block vs. mapping every search key value like dense index, less I/O and maintenance.
* Work with partitions, pruning data after partitioning.

For more information and examples, see [Using primary indexes](using-primary-indexes.md).

## Aggregating indexes

* Accelerate queries with aggregate functions&mdash;used by query analyzer instead of scanning table to calculate results, like a materialized view but integrated with F3 format.
* Defined by you on fact tables with `CREATE AGGREGATING INDEX`, as many as you want. Built with columns first, like a primary index for pruning, followed by aggregations exactly as they are used in analytics queries.
* Best created on an empty fact table, before first `INSERT`. But you can use `CREATE AND GENERATE` on populated fact table (memory-intensive).
* To be used at query runtime, all columns, measures (and aggregations), and join key columns in the query aggregations must in your index definition.

For more information and examples, see [Using aggregating indexes](using-aggregating-indexes.md).

## Join indexes

* Accelerate joins&mdash;stored in RAM and used by query optimizer instead of performing the actual join at runtime.
* Defined by you on dimension tables with `CREATE JOIN INDEX`, as many as you want. Specify join key column first, and then other dimension columns used in analytics queries.
* Most effective in schema with many-fact-to-one-dimension table relationship, large dimension tables, and small subset of available dimension columns used in join.
* Must have dimension join key column defined with `UNIQUE` attribute.  Join key column must have unique values for accurate results.

For more information, see [Using join indexes](using-join-indexes.md). For examples, see *Join indexes* in the [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action) blog post.
