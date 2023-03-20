---
layout: default
title: DESCRIBE
description: Reference and syntax for the DESCRIBE table command.
parent: SQL commands
---

# DESCRIBE

Lists all columns and data types for the table. Once the results are displayed, you can also export them to CSV or JSON.

## Syntax
{: .no_toc}

```sql
DESCRIBE <table_name>
```

**Example**

The following lists all columns and data types for the table named `prices`:

```sql
DESCRIBE prices
```

**Returns:**

```
+------------+-------------+-----------+----------+
| table_name | column_name | data_type | nullable |
+------------+-------------+-----------+----------+
| prices     | item        | TEXT      |        0 |
| prices     | num         | INTEGER   |        0 |
+------------+-------------+-----------+----------+
```
