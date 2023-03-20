---
layout: default
title: TRUNC
description: Reference material for TRUNC function
parent: SQL functions
---

# TRUNC

Returns the rounded absolute value of a numeric value. The returned value will always be rounded to less than the original value.

## Syntax
{: .no_toc}

```sql
TRUNC(<value>[, <decimal>])
```

| Parameter | Description                                                                                                                  |
| :--------- | :---------------------------------------------------------------------------------------------------------------------------- |
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.          |
| `<decimal>`   | Optional. An `INTEGER` constant that defines the decimal range of the returned value. By default, `TRUNC` returns whole numbers. |

## Example
{: .no_toc}

```sql
SELECT
    TRUNC(-20.5);
```

**Returns**: `-20`

```sql
SELECT
    TRUNC(-99.999999, 3);
```

**Returns**: `-99.999`
