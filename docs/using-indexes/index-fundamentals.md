---
layout: default
title: Index fundamentals
nav_order: 1
parent: Using indexes
---

## Index fundamentals

There are three types of indexes that you can create in Firebolt.

* [Primary indexes](using-primary-indexes.md)
* [Aggregating indexes](using-aggregating-indexes.md)
* [Join indexes](using-join-indexes.md)

### You can combine indexes

Each table has only one primary index, which is mandatory for fact tables and optional for dimension tables. You can have as many aggregating indexes and join indexes as your workloads demand. Indexes are highly compressed. The cost of storing them is small when compared to the potential savings in engine runtime, number of nodes, and instance type.

### Firebolt maintains indexes automatically

After you define an index for a table, Firebolt updates the index on the general purpose engine that you use to ingest data (the engine that runs the `INSERT INTO` statement). You don’t need to manually maintain or recreate indexes as you incrementally ingest data.

### Test and validate indexes before deploying to production

We recommend that you experiment with index configurations before you go to production. Create indexes on tables, create analytics queries that are comparable to your production queries, run the queries, and then compare performance results using query statistics, query history, and explain plans. For more information, see (*need xref*)Analyzing index performance.
