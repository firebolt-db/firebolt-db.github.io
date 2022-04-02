---
layout: default
title: ARRAY_FIRST_INDEX
description: Reference material for ARRAY_FIRST_INDEX function
parent: SQL functions
---

# ARRAY\_FIRST\_INDEX

Returns the index of the first element in the indicated array for which the given `<func>` function returns something other than `0`. Index counting starts at 1.

The `<func>` argument must be included.

## Syntax
{: .no_toc}

```sql
ARRAY_FIRST_INDEX(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array evaluated by the function.                                                                                                                                           |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_FIRST_INDEX(x -> x > 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `3`
