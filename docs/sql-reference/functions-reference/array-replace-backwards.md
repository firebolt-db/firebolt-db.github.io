---
layout: default
title: ARRAY_REPLACE_BACKWARDS
description: Reference material for ARRAY_REPLACE_BACKWARDS function
parent: SQL functions
---

# ARRAY\_REPLACE\_BACKWARDS

Scans an array `<arr>` from the last to the first element and replaces each of the elements in that array with `arr[i + 1]` if the `<func>` returns `0`. The last element of `<arr>` is not replaced.

The `<func>` argument must be included.

## Syntax
{: .no_toc}

```sql
ARRAY_REPLACE_BACKWARDS(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be evaluated by the function.                                                                                                                                     |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_REPLACE_BACKWARDS(x -> x > 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `3,3,3,9`
