---
layout: default
title: ALL_MATCH
description: Reference material for ALL_MATCH function
parent: SQL functions
---

# ALL\_MATCH

Returns `1` if all elements of an array match the results of the function provided in the `<func>` parameter, otherwise returns `0`.

## Syntax
{: .no_toc}

```sql
ALL_MATCH(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be matched with the function. The array cannot be empty.                                                                                                          |

## Example
{: .no_toc}

```sql
SELECT
	ALL_MATCH(x -> x > 0, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1`

```sql
SELECT
	ALL_MATCH(x -> x > 10, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `0`
