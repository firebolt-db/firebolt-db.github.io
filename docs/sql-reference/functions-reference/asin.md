---
layout: default
title: ASIN
description: Reference material for ASIN function
parent: SQL functions
---

# ASIN

Calculates the arc sinus. `ASIN` returns `NULL` if `<val>` is higher than 1.

## Syntax
{: .no_toc}

```sql
ASIN(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## Example
{: .no_toc}

```sql
SELECT
    ASIN(1.0);
```

**Returns**: `1.5707963267948966`
