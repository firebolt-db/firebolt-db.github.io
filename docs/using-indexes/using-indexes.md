---
layout: default
title: Using indexes
description: Understand the types of indexes in Firebolt and their role in accelerating query performance and efficiency.
nav_order: 7
has_children: true
has_toc: false
---

# Using Firebolt indexes

Firebolt indexes are designed to improve query performance and increase compute efficiency when executing various query patterns. Unlike other systems, Firebolt uses indexes to minimize the amount of data scanned by fetching only small data ranges needed to satisfy the query being executed. Firebolt indexes work together with the Firebolt File Format (F3) and are being automatically maintained - as data are ingested, Firebolt automatically sorts and compresses, and incrementally updates each index. Data and indexes are committed as tablets, which are automatically merged and optimized as data evolves. 

Firebolt offers built-in join accelerators, as well as two types of user-managed indexes:

* [Primary indexes](#primary-indexes)
* [Aggregating indexes](#aggregating-indexes)

## Primary indexes

Firebolt uses primary indexes to physically sort data into the Firebolt File Format (F3) and colocates similar values, which allows data to be pruned at query runtime. When you query a table, rather than scanning the whole data set, Firebolt uses the table’s index to prune the data, reading only the relevant ranges of data to produce query results. Unnecessary ranges of data are never loaded from disk. 

Primary indexes in Firebolt are a type of *sparse index*. Unlike a dense index that maps every search key value in a file, a sparse index is a smaller construct that holds only one entry per data block (a compressed range of rows). By using the primary index to read a much smaller and highly compressed range of data from F3 into the engine cache at query runtime, Firebolt produces query results much faster with less disk I/O.

The video below explains sparse indexing. Eldad Farkash is the CEO of Firebolt.
<iframe width="560" height="315" src="https://www.youtube.com/embed/7XDTVB9gsFw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

For more information and examples, see [Primary indexes](using-primary-indexes.md).

## Aggregating indexes

Aggregating indexes greatly reduce the compute resources required at query runtime in scenarios where there is a need to repeatedly execute aggregated functions on large tables with millions or billions of rows. Dashboards and repetitive reports are common use cases for aggregating indexes; it’s less common to create aggregating indexes for ad hoc queries. 

An aggregating index is like a materialized view in many ways, with technology proprietary to Firebolt that works together with the F3 storage format to make them more efficient. Firebolt uses an aggregating index to pre-calculate and store the results of aggregate functions that you define. At query runtime, Firebolt scans the aggregating indexes associated with a fact table to determine those that provide the best fit to accelerate query performance. To return query results, Firebolt uses the indexes rather than scanning the table.

Aggregating indexes are automatically updated as you ingest new data. The precalculated results of aggregate functions are stateful and consistent with the underlying fact table data on the engine. Firebolt automatically shards aggregating indexes to parallelize query execution across engine nodes.

The video below is a technical discussion of some issues with traditional materialized views and how Firebolt addresses the problem with unique technology. Eldad Farkash is the CEO of Firebolt.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Hniv9u4w7lI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

For more information and examples, see [Aggregating indexes](using-aggregating-indexes.md).

## Join accelerators

In addition to user-managed primary and aggregated indexes, Firebolt provides built-in functionality to automatically accelerate joins between different tables. Join operations are often the most resource-intensive aspect of queries, slowing down queries and consuming engine resources. Firebolt reads the join cached in engine RAM rather than creating the join at query runtime. Join accelerators are created & held in RAM automatically for eligible queries, reducing disk I/O and compute resources at query runtime. Queries run faster and you can use engine resources more efficiently to reduce cost. 

To see how this works, let us look at an example. Say we have the following query pattern which is run hundreds of times per second with different values for l.player_id and l.date:

```sql
SELECT r.name, SUM(l.score) 
FROM   game_plays as l
JOIN   player_info as r 
ON     l.player_id = r.player_id
WHERE  l.player_id = XXX AND l.date = YYY
GROUP  BY r.name;
```

On the first run of this query, the relevant data from the right-hand side table player_info is read and stored in a specialized data structure, which is cached in RAM. This can take tens of seconds if the player_info table is large (e.g., contains millions of rows).

However, on subsequent runs of the query pattern, the cached data structure can be reused - so all subsequent queries will only take a few milliseconds (if the left-hand side with potential field restrictions is small, as here).

Not all join queries create (and use) join accelerators. Here is a set of requirements that must be met:
* The right side of the join in the query must be directly a table. Subselects or views are not supported.
* Restrictions on fields from the right side of the join need to be applied in an `OUTER SELECT`, wrapping the query.
* Since the join accelerator data structure is cached in RAM, the right side table may not be too large (by default the size of the cache is limited to 20% of the RAM).

## You can combine indexes

Each table has only one primary index, which is optional. You can have as many aggregating indexes as your workloads demand. Indexes are highly compressed. The cost of storing them is small when compared to the potential savings in engine runtime, number of nodes, and the engine spec.

## Firebolt maintains indexes automatically

After you define an index for a table, Firebolt updates the index on the general purpose engine that you use to ingest data (the engine that runs the `INSERT` statement). You don’t need to manually maintain or recreate indexes as you incrementally ingest data.


## Additional resources

* For in-depth information about index internals, see the *Firebolt Cloud Data Warehouse Whitepaper* sections on [Indexes](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper#Indexes) and [Query Optimization](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper#Query-optimization).
* To see examples of the application of indexes, see the Firebolt blog post, [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action).

