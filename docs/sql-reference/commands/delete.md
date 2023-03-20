---
layout: default
title: DELETE (Beta)
description: Reference and syntax for the DELETE command.
parent: SQL commands
---

# DELETE (Beta)
{: .no_toc}

Deletes rows from the specified table.

* Topic ToC
{:toc}

## Syntax

```sql
DELETE FROM <table_name> WHERE <condition>
```

| Parameter | Description|
| :---------| :----------|
| `<table_name>`| The table to delete rows from. |
| `<condition>` | A Boolean expression. Only rows for which this expression returns `true` will be deleted. Condition can have subqueries doing semijoin with other table(s). |

{: .note}
The `DELETE FROM <table_name>` without `<condition>` will delete *all* rows from the table. It is equivalent to a [TRUNCATE TABLE](../commands/truncate-table.md) statement.

### Example with simple WHERE clause

`DELETE FROM product WHERE price = 0`

Table before:

```
product
+------------+--------+
| name       | price  |
+---------------------+
| wand       |    125 |
| broomstick |    270 |
| bludger    |      0 |
| robe       |     80 |
| cauldron   |     25 |
| quaffle    |      0 |
+------------+--------+
```

Table after:

```
product
+------------+--------+
| name       | price  |
+---------------------+
| wand       |    125 |
| broomstick |    270 |
| robe       |     80 |
| cauldron   |     25 |
+------------+--------+
```

### Example with subqueries

```sql
DELETE FROM product WHERE 
  name IN (SELECT name FROM inventory WHERE amount = 0) OR
  name NOT IN (SELECT name FROM inventory)
```

Tables before:

```
product
+------------+--------+
| name       | price  |
+---------------------+
| wand       |    125 |
| broomstick |    270 |
| robe       |     80 |
| cauldron   |     25 |
+------------+--------+

inventory
+------------+--------+
| name       | amount |
+---------------------+
| wand       |      3 |
| cauldron   |     18 |
| robe       |      0 |
| bludger    |      5 |
+------------+--------+
```

Table after:
```
product
+------------+--------+
| name       | price  |
+---------------------+
| wand       |    125 |
| cauldron   |     25 |
+------------+--------+
```


### Known limitations

Below are some known limitations of the `DELETE` command in the beta release. 

* `DELETE` cannot be used on tables that have certain aggregating indexes, or join indexes. It can be used on tables that have aggregating indexes containing the following aggregating functions, starting in **DB version 3.15.0:**
  * [COUNT and COUNT(DISTINCT)](../functions-reference/count.md)
  * [SUM](../functions-reference/sum.md)
  * [AVG](../functions-reference/avg.md)
  * [PERCENTILE_CONT](../functions-reference/percentile-cont.md)
  * [PERCENTILE_DISC](../functions-reference/percentile-disc.md)
  * [ARRAY_AGG/NEST](../functions-reference/array-agg.md)

* `DELETE` cannot be used on tables that have aggregating indexes containing other aggregating functions than the ones listed above. An attempt to issue a `DELETE` statement on a table with a join index or aggregating index outside of the above defined fails. In order for `DELETE` to succeed, table level aggregating or join indexes need to be dropped.

* `DISTINCT` works with `COUNT` – i.e. `COUNT(DISTINCT)`, but not `SUM(DISTINCT)` currently.

* Rows marked for deletion are not able to be cleaned up.
    * `DELETE` command marks rows for deletion for performance and cost reasons.
    * Query performance is not materially impacted by delete marks.
    * You can monitor fragmentation in `information_schema.tables` to understand how many rows are marked for deletion out of total rows - Fragmentation = (rows marked for deletion / total rows)
    * Total row count in `information_schema.tables` includes the number of rows marked for deletion.
    * To mitigate fragmentation, use the [`VACUUM`](vacuum.md) command to manually clean up deleted rows.

* Only one `DELETE` will be executed against a table at once.

* Queries against tables with deleted rows are supported and can be run. However, expect slower performance during beta phase.

* `DELETE` marks are always loaded during engine warm-up, regardless of engine policy. This can increase engine start time if there are significant number of deletions.
