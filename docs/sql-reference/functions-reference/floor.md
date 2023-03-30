---
layout: default
title: FLOOR
description: Reference material for FLOOR function
parent: SQL functions
---

# FLOOR

Returns the largest round number that is less than or equal to `<value>`. The value is rounded to a decimal range defined by `<decimal>`.

## Syntax
{: .no_toc}

```sql
FLOOR(<value>[, <decimal>])
```

| Parameter | Description                                                                                                                   |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------- |
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.           |
| `<decimal>`   | Optional. An `INTEGER` constant that defines the decimal range of the returned value. By default, `FLOOR` returns whole numbers.  |

## Example
{: .no_toc}

```sql
SELECT
    FLOOR(2.19, 1);
```

**Returns**: `2.1`
