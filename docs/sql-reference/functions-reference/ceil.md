---
layout: default
title: CEIL, CEILING
description: Reference material for CEIL, CEILING functions
parent: SQL functions
---

# CEIL, CEILING

Returns the smallest number that is greater than or equal to a specified value `<val>`. The value is rounded to a decimal range defined by `<dec>`.

## Syntax
{: .no_toc}

```sql
CEIL(<val>[, <dec>]);
CEILING(<val>[, <dec>]);
```

| Parameter | Description                                                                                                                               |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.                       |
| `<dec>`   | Optional. An `INT` constant that defines the decimal range of the returned value. By default, `CEIL `and `CEILING` return whole numbers.  |

## Example
{: .no_toc}

```sql
SELECT
    CEIL(2.5549900, 3);
```

**Returns**: `2.555`
