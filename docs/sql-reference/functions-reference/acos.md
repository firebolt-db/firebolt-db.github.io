---
layout: default
title: ACOS
description: Reference material for ACOS function
parent: SQL functions
---

# ACOS

Calculates the arc cosine of a value `<val>`. `ACOS` returns `NULL` if `<val>` is higher than 1.

## Syntax
{: .no_toc}

```sql
ACOS(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## Example
{: .no_toc}

```sql
SELECT
    ACOS(0.5);
```

**Returns**: `1.0471975511965979`
