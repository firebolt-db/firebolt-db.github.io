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
REDUCE(<function>, <array>)
```

## Parameters
{: .no_toc}

| Parameter | Description                                       | Supported input types | 
| :--------- | :------------------------------------------------- | :----------|
| `<function>` | The name of an aggregation function in the form of a quoted string. | Any [aggregation function](../functions-reference/aggregation-functions.md) |
| `<array>`          | The array to aggregate. | `ARRAY` |

## Return Types
Same as the element data type of the input array

## Examples
{: .no_toc}

```sql
SELECT
	REDUCE('max', [ 1, 2, 3, 6 ]) AS levels;
```

**Returns**: `6`

When using aggregation functions that take a constant as a parameter, the parameter should be specified after the function name in parentheses. This example below uses `REDUCE` with the `APPROX_PERCENTILE` function, which requires a percentile as a parameter.

```sql
SELECT
	REDUCE('approx_percentile(0.3)', [ 1, 2, 3, 4, 5, 6 ]) AS levels;
```
**Returns**: `2.5`
