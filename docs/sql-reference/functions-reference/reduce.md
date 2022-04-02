---
layout: default
title: REDUCE
description: Reference material for REDUCE function
parent: SQL functions
---

# REDUCE

Applies an aggregate function on the elements of the array and returns its result. The name of the aggregation function is passed as a string in single quotes - for example: `'max'`, `'sum'`.

## Syntax
{: .no_toc}

```sql
REDUCE(<agg_function>, <arr>)
```

| Parameter        | Description                                                                     |
| :---------------- | :------------------------------------------------------------------------------- |
| `<agg_function>` | The name of an aggregate function which should be a constant string             |
| `<arr>`          | Any number of array type columns as the parameters of the aggregation function. |

## Examples
{: .no_toc}

```sql
SELECT
	REDUCE('max', [ 1, 2, 3, 6 ]) AS res;
```

**Returns**: `6`

When using aggregation functions that take a constant as a parameter, the parameter should be specified after the function name in parentheses. This example below uses `REDUCE` with the `APPROX_PERCENTILE` function, which requires a percentile as a parameter.

```sql
SELECT
	REDUCE('approx_percentile(0.3)', [ 1, 2, 3, 4, 5, 6 ]) AS res;
```
**Returns**: `2.5`
