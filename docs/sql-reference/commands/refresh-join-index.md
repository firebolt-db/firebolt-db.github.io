---
layout: default
title: REFRESH JOIN INDEX
description: Reference and syntax for the REFRESH JOIN INDEX command.
parent: SQL commands
---

# REFRESH JOIN INDEX

Recreates a join index or all join indices associated with a dimension table on the engine. You can run this statement to rebuild a join index or indices after data has been ingested into an underlying dimension table or after a partition has been dropped to delete records. For more information about join indexes, see [Using join indexes](../../using-indexes/using-join-indexes.md).

Join indexes are not updated automatically in an engine when a partition is dropped. You must refresh all indexes on all engines with queries that use the indexes, otherwise the queries return results from before the partition drop.

Refreshing join indexes is a memory-intensive operation because join indexes are stored in node RAM. When refreshing join indexes, use [SHOW INDEXES](show-indexes.md) to get the `size_compressed` of all indexes to refresh. Ensure that node RAM is greater than the sum of `size_compressed` for all join indexes to be refreshed.

## Syntax
{: .no_toc}

Two versions of the command are available.

* `REFRESH JOIN INDEX` refreshes a single join index that you specify.
* `REFRESH ALL JOIN INDEXES ON TABLE` refreshes all join indexes associated with a specific dimension table.

```sql
REFRESH JOIN INDEX <index-name>
```

**—OR—**

```sql
REFRESH ALL JOIN INDEXES ON TABLE <dim-table-name>
```

| Parameter          |                                                                                         |
| :------------------ | :--------------------------------------------------------------------------------------- |
| `<index-name>`     | The name of the join index to rebuild.                                                  |
| `<dim-table-name>` | The name of a dimension table. All join indexes associated with that table are rebuilt. |
