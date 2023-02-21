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

Join operations are often the most resource-intensive aspect of queries, slowing down queries and consuming engine resources. Firebolt join indexes can help accelerate queries that include joins. Firebolt can read the join index cached in engine RAM rather than creating the join at query runtime. Join indexes are created & held in RAM automatically for eligible queries. This reduces disk I/O and compute resources at query runtime. Queries run faster and you can use engine resources more efficiently to reduce cost. With this optimization, we have seen real-world, production queries run 200x faster.

## How to use a join index

To see how this works, let us look at an example. Say we have the following query pattern which is run hundreds of times per second with different values for `l.player_id` and `l.date`:

```sql
SELECT r.name, SUM(l.score) 
FROM   game_plays as l
JOIN   player_info as r 
ON     l.player_id = r.player_id
WHERE  l.player_id = XXX AND l.date = YYY
GROUP  BY r.name;
```

On the first run of this query, the relevant data from the right-hand side table `player_info` is read and stored in a specialized data structure, which is cached in RAM. This can take tens of seconds if the `player_info` table is large (e.g., contains millions of rows). 

However, on subsequent runs of the query pattern, the cached data structure can be reused - so all subsequent queries will only take a few milliseconds (if the left-hand side with potential field restrictions is small, as here).

## Requirements on join queries

Not all join queries create (and use) join indexes. Here is a set of requirements that must be met:
* The right side of the join in the query must be directly a table. Subselects or views are not supported.
* Restrictions on fields from the right side of the join need to be applied in an `OUTER SELECT`, wrapping the query.
* Since the join index data structure is cached in RAM, the right side table may not be too large (by default the size of the cache is limited to 20% of the RAM).
* All types of joins (INNER, LEFT, RIGHT, …) are supported.
* The right table in the join can be a FACT or DIMENSION table.  

[//]: # (Comment: perhaps add a reference / remark that a dashboard for observing whether queries profited from the HashJoin Cache / Join Index can be made available?)

## Examples
See *Join indexes* in the [Firebolt indexes in action](https://www.firebolt.io/blog/firebolt-indexes-in-action) blog post.
