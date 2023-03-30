---
layout: default
title: SHOW COLUMNS
description: Reference and syntax for the SHOW COLUMNS command.
parent: SQL commands
---

# SHOW COLUMNS

Lists columns and their properties for a specified table. Returns `<table_name>`, `<column_name>`, `<data_type>`, and `nullable` (`1` if nullable, `0` if not) for each column.

## Syntax

```sql
SHOW COLUMNS <table_name>;
```

| Parameter      | Description                           |
| :-------------- | :------------------------------------- |
| `<table_name>` | The name of the table to be analyzed. |

## Example

```sql
SHOW COLUMNS prices;
```

## Returns

```
------------+-------------+-----------+----------+
| table_name | column_name | data_type | nullable |
+------------+-------------+-----------+----------+
| prices     | item        | TEXT      |        0 |
| prices     | num         | INTEGER   |        0 |
+------------+-------------+-----------+----------+
```
