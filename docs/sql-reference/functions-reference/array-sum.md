---
layout: default
title: ARRAY_SUM
description: Reference material for ARRAY_SUM function
parent: SQL functions
---

# ARRAY\_SUM

Returns the sum of elements of `<arr>`. If the argument `<func>` is provided, the values of the array elements are converted by this function before summing.

## Syntax
{: .no_toc}

```sql
ARRAY_SUM([<func>,] <arr>)
```

| Parameter | Description                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------- |
| `<func>`  | A Lambda function with an [arithmetic function](../../general-reference/operators.md#arithmetic) used to modify the array elements. |
| `<arr>`   | The array to be used to calculate the function.                                                                            |

## Example
{: .no_toc}

This example below uses a function to first add 1 to all elements before calculating the sum:

```sql
SELECT
	ARRAY_SUM(x -> x + 1, [ 4, 1, 3, 2 ]) AS res;
```

**Returns**: `14`

In this example below, no function to change the array elements is given.

```sql
SELECT
	ARRAY_SUM([ 4, 1, 3, 2 ]) AS res;
```

**Returns**: `10`
