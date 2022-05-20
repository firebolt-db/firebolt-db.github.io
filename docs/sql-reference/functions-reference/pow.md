---
layout: default
title: POW, POWER
description: Reference material for POW, POWER functions
parent: SQL functions
---

# POW, POWER

Returns a number `<val>` raised to the specified power `<exp>`.

## Syntax
{: .no_toc}

```sql
POW(<val>, <exp>);
POWER(<val>, <exp>);
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `<exp>`   | The exponent value used to raise `<val>`                                                                            |

## Example
{: .no_toc}

```sql
SELECT
    POW(2, 5);
```

**Returns**: `32`
