---
layout: default
title: COALESCE
description: Reference material for COALESCE function
parent: SQL functions
---

# COALESCE

Checks from left to right for the first non-NULL argument found for each entry parameter pair. For example, for an Employee table (where each employee can have more than one location), check multiple location parameters, find the first non-null pair per employee (the first location with data per employee).

## Syntax
{: .no_toc}

```sql
COALESCE(<value> [,...])
```

| Parameter | Description                                                                                                                                       |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<value>` | The value(s) to coalesce. Can be either: column name,  a function applied on a column (or on another function), and a literal (constant value). |

## Example
{: .no_toc}

```sql
SELECT COALESCE(null, 'London','New York') AS res;
```

**Returns:** `London`
