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

* Accelerat queries at runtime by efficiently pruning ranges of data when reading from Firebolt tables.
* Are defined by the user in `CREATE TABLE` clause. Only one primary index supported per table due to physical sort in F3. Updated automatically with incremental ingestion.
* Should include columns frequently used in `WHERE` predicates. If more than one column are frequently used, they should be listed in order of increasing cardinality (i.e. number of distinct values) for faster filtering and higher compression. Also include columns used as join keys.
* Sparse indexes maintain one entry per data block (as compared to traditional "dense" indexes that map every search key value). This design takes up much less disk space, decreases I/O and simplifies maintenance.
* Sparse indexes work with partitions, pruning data after any partition filters are evaluated.

For more information and examples, see [Using primary indexes](using-primary-indexes.md).

## Aggregating indexes

* Accelerate queries with aggregation functions by federating query execution to pre-aggregated index, much like a materialized view but integrated within F3 format.
* Can be created with multiple, different definitions against the same fact table to support diverse query patterns.
* Are defined by users on fact tables with `CREATE AGGREGATING INDEX` statement. GROUP BY columns are included first, and included with the same approach as with primary indexes (i.e. in order of increasing cardinality) following by aggregated metrics. 
* Are best created on an empty fact table before data is ingested. However, users can also run `CREATE AND GENERATE` statements if the index is created after the fact table has been populated. This approach can be memory-intensive.
* To be used at query runtime, all columns, measures (and aggregations), and join key columns in the query aggregations must be included in the index definition.

For more information and examples, see [Using aggregating indexes](using-aggregating-indexes.md).

## Join indexes

* Accelerate joins via optimized in-memory data structures used by the query optimizer in place of actual joins.
* Defined by users on dimension tables with `CREATE JOIN INDEX`. Specify join key column first, and then other dimension columns used in analytics queries.
* More than one JOIN INDEX can be created and maintained.
* Most effective in schema with many-fact-to-one-dimension table relationship, large dimension tables, and when a relatively small subset of available dimension columns are used in the join.
* Must have dimension join key column defined with `UNIQUE` attribute for best performance.

For more information, see [Using join indexes](using-join-indexes.md). For examples, see *Join indexes* in the [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action) blog post.
