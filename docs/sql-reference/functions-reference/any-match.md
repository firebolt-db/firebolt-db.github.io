---
layout: default
title: ANY_MATCH
description: Reference material for ANY_MATCH function
parent: SQL functions
---


# ANY\_MATCH

Returns `1` if at least one of the elements of an array matches the results of the function provided in the `<func>` parameter. Otherwise returns `0`.

## Syntax
{: .no_toc}

```sql
ANY_MATCH(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be matched with the function. The array cannot be empty                                                                                                           |

## Example
{: .no_toc}

```sql
SELECT
	ANY_MATCH(x -> x > 3, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1`

```
SELECT
	ANY_MATCH(x -> x = 10, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `0`
