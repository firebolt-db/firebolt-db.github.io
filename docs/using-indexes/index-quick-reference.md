---
layout: default
title: Quick reference
nav_order: 2
parent: Using indexes
---

# Index quick reference
{: .no_toc}

* Topic ToC
{:toc}

## Primary indexes

* Accelerate queries at runtime—efficiently prunes ranges of data for reads from Firebolt File Format (F3)
* Defined by you in `CREATE TABLE` clause, only one per table because of physical sort in F3, updated automatically with incremental ingestion
* Best built with columns frequently used in `WHERE` predicates that drastically filter, in order of filtering effect (highest cardinality first), also add join key columns
* Sparse indexes behind the scenes&mdash;one entry per data block vs. mapping every search key value like dense index, less I/O and maintenance
* Work with partitions, pruning data after partitioning

## Aggregating indexes

* Accelerate queries with aggregate functions&mdash;used by query analyzer instead of scanning table to calculate results, like a materialized view
* Defined by you on fact tables with `CREATE AGGREGATING INDEX`, as many as you want. Built with columns first, like a primary index for pruning, followed by aggregations exactly as they are used in analytics queries
* Best with empty fact table, but you can use `CREATE AND GENERATE` on populated fact table (memory-intensive)
* Only used by optimizer if all columns, measures (and aggregations), and join key columns in the aggregations are in your index definition

## Join indexes

* Accelerate joins&mdash;stored in RAM and used by query optimizer instead of performing the actual join at runtime
* Defined by you on dimension tables with `CREATE JOIN INDEX`, as many as you want. Built with join key column first, and then other dimension columns used in analytics queries
* Most effective in schema with many-fact-to-one-dimension relationship, with large dimension tables, and with small subset of available dimension columns
* Must have dimension join key column defined with `UNIQUE` attribute for best performance
