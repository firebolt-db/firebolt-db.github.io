---
layout: default
title: RADIANS
description: Reference material for RADIANS function
parent: SQL functions
---

# RADIANS

Converts degrees to radians as a `REAL` value.

## Syntax
{: .no_toc}

```sql
RADIANS(<value>) 
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## Example
{: .no_toc}

```sql
SELECT
    RADIANS(180);
```

**Returns**: `3.141592653589793`
