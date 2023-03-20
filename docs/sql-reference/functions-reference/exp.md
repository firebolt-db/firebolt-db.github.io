---
layout: default
title: EXP
description: Reference material for EXP function
parent: SQL functions
---

# EXP

Returns the `REAL` value of the constant _e_ raised to the power of a specified number.

## Syntax
{: .no_toc}

```sql
EXP(<value>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## Example
{: .no_toc}

```sql
SELECT
    EXP(2);
```

**Returns**: `7.389056098924109`
