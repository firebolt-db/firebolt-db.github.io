---
layout: default
title: Exporting query results
nav_order: 11.1
---

# Exporting query results

Firebolt has two ways to save query data to use and analyze outside of Firebolt.

* You can use the SQL workspace to export query results to your local hard drive as a `JSON` or `CSV` file. For more information, see [Exporting query results to a local hard drive](/using-the-sql-workspace/using-the-sql-workspace.md#exporting-results-to-a-local-hard-drive). This method is limited to 10,000 rows.
* Use the `COPY TO (Beta)` statement to write the output of a `SELECT` query to an Amazon S3 location. This gives you more options than exporting from the SQL workspace offers. For more information, see [COPY TO (Beta)](/sql-reference/commands/copy-to.md).
