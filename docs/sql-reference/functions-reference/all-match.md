---
layout: default
title: ALL_MATCH
description: Reference material for ALL_MATCH function
parent: SQL functions
---

# ALL_MATCH

Returns `1` (true) when the Boolean expression `<Boolean_expr>` performed on all elements of an array evaluate to true. Returns `0` (false) when any one comparison evaluates to false.

## Syntax
{: .no_toc}

```sql
ALL_MATCH(<array_var> -> <Boolean_expr>, <array_expr>)
```

| Parameter      | Description                                   |
| :------------- |:--------------------------------------------- |
| `<array_var>`  | A Lambda array variable that contains elements of the array specified using `<array_expr>`. For more information, see [Manipulating arrays with Lambda functions](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions). |
| `<Boolean_expr>` | A Boolean expression that evaluates each array value using a comparison operator. For available operators, see [Comparison operators](../../general-reference/operators.md#comparison). |
| `<array_expr>` | An expression that evaluates to an `ARRAY` data type. |

## Examples
{: .no_toc}

Return `1` (true) if all elements in the array are greater than 0.

```sql
SELECT
	ALL_MATCH(x -> x > 0, [ 1, 2, 3, 9 ]) AS comparisons_result;
```

**Returns**: 

```
+--------------------+
| comparisons_result |
+--------------------+
| 1                  |
+--------------------+
```

Return `1` (true) if `gadgets` does not appear in the array.

```sql
SELECT
	ALL_MATCH(x -> x <> 'gadgets', [ 'audio', summer-sale', 'gadgets']) AS comparisons_result;
```

**Returns**: 

```
+--------------------+
| comparisons_result |
+--------------------+
| 0                  |
+--------------------+
```