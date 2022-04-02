---
layout: default
title: ABS
description: Reference material for ABS function
parent: SQL functions
---

# ABS

Calculates the absolute value of a number `<val>`.

## Syntax
{: .no_toc}

```sql
ABS(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## Example
{: .no_toc}

```sql
SELECT
    ABS(-200.50);
```

**Returns**: `200.5`
