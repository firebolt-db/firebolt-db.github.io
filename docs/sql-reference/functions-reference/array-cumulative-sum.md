---
layout: default
title: ARRAY_CUMULATIVE_SUM
description: Reference material for ARRAY_CUMULATIVE_SUM function ( cumulative )
parent: SQL functions
---

# ARRAY\_CUMULATIVE\_SUM

Returns an array of partial sums of elements from the source array (a cumulative sum). If the argument `<func>` is provided, the values of the array elements are converted by this function before summing.

## Syntax
{: .no_toc}

```sql
ARRAY_CUMULATIVE_SUM( [<func>,] arr)
```

| Parameter | Description                                     |
| :--------- | :----------------------------------------------- |
| `<func>`  | The function used to convert the array members. |
| `<arr>`   | The array used for the sum calculations.        |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_CUMULATIVE_SUM(x -> x + 1, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `2,5,9,19`

```sql
SELECT
	ARRAY_CUMULATIVE_SUM([ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1,3,6,15`
