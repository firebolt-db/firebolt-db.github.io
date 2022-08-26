---
layout: default
title: FILTER
description: Reference material for FILTER function
parent: SQL functions
---

# FILTER

Returns an array containing the elements from `<arr>` for which the given Lambda function `<func>` returns something other than `0`.

The function can receive one or more arrays as its arguments. If more than one array is provided the following conditions should be met:

* The number of arguments of the Lambda function must be equal to the number of arrays provided. If the condition isn't met - the query will not run and an error will be returned.

* All the provided arrays should be of the same length. If the condition isn't met a runtime error will occur.

When multiple arrays are provided to the function, the function will evaluate the current elements from each array as its parameter. All of the elements at that index position must evaluate to true (or `1`) for this index to be included in the results. The elements that are returned are taken only from the first array provided.

## Syntax
{: .no_toc}

```sql
FILTER(<func>, <arr> [, ...] )
```

| Parameter        | Description                                                                                                                                                                    |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`         | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr> [, ...]`  | One or more arrays that will be evaluated by the Lambda function. Only the first array that is included will be filtered in the results. All the arrays must have exactly same number of elements.                                             |

## Examples
{: .no_toc}

In the example below, there is only one array.

```
SELECT
	FILTER(x -> x = 'a', [ 'a', 'b', 'c', 'd' ]);
```

**Returns**: `['a']`

In this example below, there are two arrays and two separate arguments for evaluation. The Lambda function searches the second array for all elements that are greater than 2. The elements in these positions are returned from the first array.

```sql
SELECT
	FILTER(x, y -> y > 2, [ 'a', 'b', 'c', 'd' ], [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `['c', 'd']`

In this example below, there are three arrays, and Lambda function which have condition on two of them.

```sql
SELECT
	FILTER(x, y, z -> (y > 2 AND z = 'red'),
		[ 'a', 'b', 'c', 'd' ],
		[ 1, 2, 3, 9 ],
		[ 'red', 'green', 'red', 'green' ] )
	AS res;
```

**Returns**: `['c']`
