---
layout: default
title: ROUND
description: Reference material for ROUND function
parent: SQL functions
---

# ROUND

Rounds a value to a specified number of decimal places.

## Syntax
{: .no_toc}

```sql
ROUND(<value> [, <decimal>])
```

| Parameter | Description                                                                                                                   |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------- |
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.           |
| `<decimal>`   | Optional. An `INTEGER` constant that defines the decimal range of the returned value. By default, `ROUND` returns whole numbers.  |

## Example
{: .no_toc}

```sql
SELECT
    ROUND(5.4);
```

**Returns**: `5`

```
SELECT
    ROUND(5.6930, 1);
```

**Returns**: `5.7`
