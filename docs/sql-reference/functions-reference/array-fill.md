---
layout: default
title: ARRAY_FILL
description: Reference material for ARRAY_FILL function
parent: SQL functions
---

# ARRAY\_FILL

This function scans through the given array `<arr>` from the first to the last element and replaces `arr[i]` with `arr[i - 1]` if the `<func>` returns `0`. The first element of the given array is not replaced.

The Lambda function `<func>` is mandatory.

## Syntax
{: .no_toc}

```sql
ARRAY_FILL(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be evaluated by the function.                                                                                                                                     |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_FILL(x -> x < 0, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1,1,1,1`

```sql
SELECT
	ARRAY_FILL(x -> x > 0, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1,2,3,9`
