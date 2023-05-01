---
layout: default
title: Using indexes
description: Understand the types of indexes in Firebolt and their role in accelerating query performance and efficiency.
nav_order: 7
has_children: true
has_toc: false
---

# Using Firebolt indexes

Firebolt offers unique technologies that accelerate query performance. Indexes are among the most important. Although indexes are a familiar concept in databases and SQL engines, Firebolt indexes are different because they work together with the Firebolt File Format (F3). Firebolt indexes allow your queries to scan very small ranges of cached data rather than scanning much larger ranges as other systems do.

Efficient indexes not only accelerate query performance, they allow you to use compute engines more efficiently and reduce cost.

Firebolt offers three types of indexes:

* [Primary indexes](index-quick-reference.md#primary-indexes)
* [Aggregating indexes](index-quick-reference.md#aggregating-indexes)
* [Join indexes](index-quick-reference.md#join-indexes)

## You can combine indexes

Each table has only one primary index, which is optional. You can have as many aggregating indexes and join indexes as your workloads demand. Indexes are highly compressed. The cost of storing them is small when compared to the potential savings in engine runtime, number of nodes, and the engine spec.

## Firebolt maintains indexes automatically

After you define an index for a table, Firebolt updates the index on the general purpose engine that you use to ingest data (the engine that runs the `INSERT INTO` statement). You don’t need to manually maintain or recreate indexes as you incrementally ingest data.

## Test and validate indexes before deploying to production

We recommend that you experiment with index configurations before you go to production. Create indexes on tables, create analytics queries that are comparable to your production queries, run the queries, and then compare performance results using query statistics, query history, and explain plans.

## Additional resources

* For in-depth information about index internals, see the *Firebolt Cloud Data Warehouse Whitepaper* sections on [Indexes](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper#Indexes) and [Query Optimization](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper#Query-optimization).
* To see examples of the application of indexes, see the Firebolt blog post, [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action).
