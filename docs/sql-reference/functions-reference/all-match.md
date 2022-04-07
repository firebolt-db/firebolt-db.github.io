---
layout: default
title: ALL_MATCH
description: Reference material for ALL_MATCH function
parent: SQL functions
---

# ALL_MATCH

Returns `1` if all elements `<array_var>` of the specified `<array>` when compared to `<comparator>` evaluate to `1` (true). match the results of the function provided in the `<func>` parameter, otherwise returns `0`.

## Syntax
{: .no_toc}

```sql
ALL_MATCH(<array_var> -> <array_var>[<comparison>]<expr>, <array_expr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<array_var>`  | A Lambda expression array variable that you define to contain elements of arrays found in `<array_expr>`. For more information, see [Manipulating arrays with Lambda functions](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<comparison>` | A comparison operator. For more information, see [Comparison operators](../../general-reference/operators.md#comparison)
| `<expr>`   | An expression that evaluates to the same element type represented by `<array_var>`. |
| `<array_expr>`  | An expression that evaluates to an `ARRAY` data type. |                                                                                                          |

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
