---
layout: default
title: ARRAY_FIRST
description: Reference material for ARRAY_FIRST function
parent: SQL functions
---

# ARRAY\_FIRST

Returns the first element in the given array for which the given `<func>` function returns something other than `0`. The `<func>` argument must be included.

## Syntax
{: .no_toc}

```sql
ARRAY_FIRST(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array evaluated by the function.                                                                                                                                           |

## Examples
{: .no_toc}

```sql
SELECT
	ARRAY_FIRST(x -> x > 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `3`

In the example below, the third index is returned because it is the first that evaluates to `blue`.

```sql
SELECT
    ARRAY_FIRST(x, y -> y = 'blue',
        [ 1, 2, 3, 4 ],
        [ 'red', 'green', 'blue' ,'blue' ]
        )
    AS res;
```

**Returns**: `3`
