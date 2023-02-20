---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
nav_order: 2
has_toc: false
has_children: true
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the past month are below. See the [Release notes archive](../release-notes/release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## DB version 3.19.0 
**February 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### New features

* #### <!--- FIR-16297 —-->New date and time data types

  Added support for new date and timestamp data types:

  * [PGDATE](../general-reference/date-data-type.md)
  * [TIMESTAMPNTZ](../general-reference/timestampntz-data-type.md)
  * [TIMESTAMPTZ](../general-reference/timestamptz-data-type.md)

  The new data types use an improved memory layout providing a much higher supported range, now extending from `0001-01-01[ 00:00:00.000000]` to `9999-12-31[ 23:59:59.999999]`. This change also extends the syntax for specifying intervals used for arithmetic with dates and timestamps. In addition to the previously supported interval syntax, you can now also write `interval 'N' unit`, where `N` is a possibly signed integer, and `unit` is one of `year`, `month`, `day`, `hour`, `minute`, or `second`, matched case-insensitively.

  The previously supported `DATE` and `TIMESTAMP` data types are planned for deprecation in the future. New features and functionality will be built to support the new date and timestamp data types, rather than these legacy types. 
  
  **To use the new data types:**
  * To ingest from an existing table into a new table using the new types, simply cast a column of type `DATE` to `PGDATE` and a column of type `TIMESTAMP` to `TIMESTAMPNTZ`. 
  * To ingest into a new table using the new types from external data, create an external table with the new types.

  {: .warning}
  The new syntax can break the semantics of existing SQL queries. Previously, the `unit` part of the expression was treated as a column alias, and now it's treated as part of the interval literal. For example, if you wrote `SELECT DATE '2023-01-10' + interval '42' day;`, you would get back a table with one column called `day` and the value `2023-01-10 00:00:42`. Now, you will get a back a table with one column (unspecified name) and the value `2023-02-21 00:00:00`.<br>If you want to retain the old behavior, use `AS`, for example: `SELECT DATE '2023-01-10' + interval '42' AS day;`.

* #### <!--- --->New setting for time zone

  [New setting](../general-reference/system-settings.md#set-time-zone) `time_zone` controls the session time zone. The default value of the `time_zone` setting is UTC.

* #### <!--- FIR-13488, FIR-20666 --->New keyboard shortcuts (UI release)

  Use new [keyboard shortcuts](../using-the-sql-workspace/keyboard-shortcuts-for-sql-workspace.md) in the SQL workspace to cancel a query, or go to a specific line in your script.  

    * Cancel a running script with **Ctrl + Alt + k** for Windows & Linux, or **⌘ + Option + k** for Mac
    * Go to a desired line with **Ctrl + l** for Windows & Linux, or **⌘ + l** for Mac
  
### Enhancements, changes, and new integrations

* #### <!--- FIR-16389 —-->Improved join index performance

  [Join indexes](../using-indexes/using-join-indexes.md) just got better: profit from their extreme performance benefits without any configuration. Moreover, there is no more need to manually create or refresh – the results are always up to date even if the underlying data changed.  With this optimization, we've seen real-world, production queries run 200x faster.

  To see how this works, let’s look at an example. Say we have the following query pattern which is run hundreds of times per second with different values for `l.player_id` and `l.date`:

  ```sql
  SELECT r.name, SUM(l.score) 
  FROM   game_plays as l
  JOIN   player_info as r 
  ON     l.player_id = r.player_id
  WHERE  l.player_id = XXX AND l.date = YYY
  GROUP  BY r.name;
  ```

  On the first run of this query, the relevant data from the right-hand side table `player_info` is read and stored in a specialized data structure, which is cached in RAM. This can take tens of seconds if the `player_info` table is large (e.g., contains millions of rows). However, on subsequent runs of the query pattern, the cached data structure can be reused - so all subsequent queries will only take a few milliseconds (if the left-hand side with potential field restrictions is small, as here).

  **Requirements for query optimization**
    * The right side of the join in the query must be directly a table. Subselects are not supported.
    * Restrictions on fields from the right side of the join need to be applied in an `OUTER SELECT`, wrapping the query.
    * Since the join index data structure is cached in RAM, the right side table may not be too large (by default the size of the cache is limited to 20% of the RAM).
    * All types of joins (INNER, LEFT, RIGHT, …) are supported.
    * The right table in the join can be a FACT or DIMENSION table.  


* #### <!--- FIR-11922 —-->Improved cache eviction

  Cache eviction process and stability has been improved. Tablet eviction is now managed by a Least Recently Used (LRU) algorithm, which provides smarter eviction and keeps the data that is most likely to be accessed in the engine cache.

* #### <!--- FIR-17198 —-->Added syntax option for setting TYPE options in CREATE EXTERNAL TABLE
  
  Added the option to set type options for S3 source files at the same level as `TYPE` is set. [Type option](../sql-reference/commands/create-external-table.md#type) can now be defined as in the example below:

  ```sql
  CREATE EXTERNAL TABLE ex_table( ... )
  TYPE=(CSV)
  ALLOW_COLUMN_MISMATCH=true
  ...
  ```

  as well as with the original syntax: 

  ```sql
  CREATE EXTERNAL TABLE ex_table(...)
  TYPE=(CSV ALLOW_COLUMN_MISMATCH=true)
  ...
  ```

* #### <!--- FIR-20566 —-->Default DECIMAL scale changed

  The default scale for the `DECIMAL` [data type](../general-reference/decimal-data-type.md) has been updated from 0 to 9. 






