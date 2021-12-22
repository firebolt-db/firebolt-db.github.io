---
layout: default
title: Array functions
nav_order: 1
parent: Semi-structured data functions
grand_parent: SQL functions reference
---

# Array Functions
{: .no_toc}

* Topic ToC
{:toc}

This page describes the functions for working with arrays.

## ALL\_MATCH

Returns `1` if all elements of an array match the results of the function provided in the `<func>` parameter, otherwise returns `0`.

### Syntax
{: .no_toc}

```sql
ALL_MATCH(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be matched with the function. The array cannot be empty.                                                                                                          |

### Example
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

## ANY\_MATCH

Returns `1` if at least one of the elements of an array matches the results of the function provided in the `<func>` parameter. Otherwise returns `0`.

### Syntax
{: .no_toc}

```sql
​​ANY_MATCH(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be matched with the function. The array cannot be empty                                                                                                           |

### Example
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

## ARRAY\_CONCAT

Combines one or more arrays that are passed as arguments.

### Syntax
{: .no_toc}

```sql
ARRAY_CONCAT(<arr1> [, ...n])
```

| Parameter        | Description                                                                            |
| :---------------- | :-------------------------------------------------------------------------------------- |
| `<arr> [, ...n]` | The arrays to be combined. If only one array is given, an identical array is returned. |

### Example
{: .no_toc}

```sql
SELECT
    ARRAY_CONCAT([ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ]) AS res;
```

## ARRAY\_COUNT

Returns the number of elements in the `<arr>` array that match a specified function `<func>`.

### Syntax
{: .no_toc}

```sql
ARRAY_COUNT(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                                                                                                                           |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<func>`  | Optional. A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. If `<func>` is not included, `ARRAY_COUNT` will return a count of all elements in the array. |
| `<arr>`   | An array of elements                                                                                                                                                                                                                                                                  |

### Example
{: .no_toc}

The example below searches through the array for any elements that are greater than 3. Only one number that matches this criteria is found, so the function returns `1`

```sql
SELECT
	ARRAY_COUNT(x -> x > 3, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1`

In this example below, there is no `<func>` criteria provided in the `ARRAY_COUNT` function. This means the function will count all of the elements in the given array.

```
SELECT
	ARRAY_COUNT([ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `4`

## ARRAY\_COUNT\_GLOBAL

Returns the number of elements in the array typed column accumulated over all rows. As such it is an _aggregation function._

### Syntax
{: .no_toc}

```sql
ARRAY_COUNT_GLOBAL(<arr_col>)
```

| Parameter   | Description                                                      |
| :----------- | :---------------------------------------------------------------- |
| `<arr_col>` | The array column over which the function will count the elements |

### Example
{: .no_toc}

For this example, we will create a table `array_test` as shown below.

```sql
CREATE DIMENSION TABLE array_test(array_1 ARRAY(INT));

INSERT INTO
	array_test
VALUES
	([ 1, 2, 3, 4 ]),
	([ 5, 0, 20 ]),
	([ 6, 2, 6 ]),
	([ 9, 10, 13 ]),
	([ 20, 13, 40 ]),
	([ 1 ]);
```

We can use `ARRAY_COUNT_GLOBAL` to learn how many total array elements are in all rows.

```sql
SELECT
	ARRAY_COUNT_GLOBAL(array_1)
FROM
	array_test;
```

**Returns**: `17`

If you want to count elements based on specific criteria, you can use the [`ARRAY_COUNT`](array-functions.md#array_count) function with a `SUM` aggregation as demonstrated below.

```sql
SELECT
	SUM(ARRAY_COUNT(x -> x > 3, array_1))
FROM
	array_test;
```

**Returns**: `11`

## ARRAY\_CUMULATIVE\_SUM

Returns an array of partial sums of elements from the source array (a running sum). If the argument `<func>` is provided, the values of the array elements are converted by this function before summing.

### Syntax
{: .no_toc}

```sql
ARRAY_CUMULATIVE_SUM( [<func>,] arr)
```

| Parameter | Description                                     |
| :--------- | :----------------------------------------------- |
| `<func>`  | The function used to convert the array members. |
| `<arr>`   | The array used for the sum calculations.        |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_CUMULATIVE_SUM(x -> x + 1, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `2,5,9,19`

```sql
SELECT
	ARRAY_CUMULATIVE_SUM([ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `1,3,6,15`

## ARRAY\_DISTINCT

Returns an array containing only the _unique_ elements of the given array. In other words, if the given array contains multiple identical members, the returned array will include only a single member of that value.

### Syntax
{: .no_toc}

```sql
ARRAY_DISTINCT(<arr>)
```

| Parameter | Description                                  |
| :--------- | :-------------------------------------------- |
| `<arr>`   | The array to be analyzed for unique members. |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_DISTINCT([ 1, 1, 2, 2, 3, 4 ]) AS res;
```

**Returns**: `1,2,3,4`

## ARRAY\_FILL

This function scans through the given array `<arr>` from the first to the last element and replaces `arr[i]` with `arr[i - 1]` if the `<func>` returns `0`. The first element of the given array is not replaced.

The lambda function `<func>` is mandatory.

### Syntax
{: .no_toc}

```sql
ARRAY_FILL(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be evaluated by the function.                                                                                                                                     |

### Example
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

## ARRAY\_FIRST

Returns the first element in the given array for which the given `<func>` function returns something other than `0`. The `<func>` argument must be included.

### Syntax
{: .no_toc}

```sql
ARRAY_FIRST(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array evaluated by the function.                                                                                                                                           |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_FIRST(x -> x > 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `3`

## ARRAY\_FIRST\_INDEX

Returns the index of the first element in the indicated array for which the given `<func>` function returns something other than `0`. Index counting starts at 1.

The `<func>` argument must be included.

### Syntax
{: .no_toc}

```sql
ARRAY_FIRST_INDEX(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array evaluated by the function.                                                                                                                                           |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_FIRST_INDEX(x -> x > 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `3`

## ARRAY\_INTERSECT

Evaluates all arrays that are provided as arguments and returns an array of any elements that are present in all the arrays. The order of the resulting array may be different than the original arrays. Use [`ARRAY_SORT`](./array-functions.html#array_sort) to stipulate a specific order on the results.

### Syntax
{: .no_toc}

```sql
ARRAY_INTERSECT(<arr>)
```

| Parameter | Description                                            |
| :--------- | :------------------------------------------------------ |
| `<arr>`   | A series of arrays to be analyzed for mutual elements. |

### Examples
{: .no_toc}

In the example below, the only element that is shared between all three arrays is `3.`

```sql
SELECT
	ARRAY_INTERSECT([ 1, 2, 3 ], [ 1, 3 ], [ 2, 3 ])
```

**Returns**: `3`

In this second example below, we are using `ARRAY_SORT` to ensure the results are in ascending order.

```sql
SELECT
	ARRAY_SORT(
	    ARRAY_INTERSECT([ 5, 4, 3, 2, 1 ],[ 5, 3, 1 ])
	    )
```

**Returns**: `[1,3,5]`

## ARRAY\_JOIN

Concatenates an array of `TEXT` elements using an optional delimiter. If no delimiter is provided, an empty string is used instead.

### Syntax
{: .no_toc}

```sql
ARRAY_JOIN(<arr>[, <delimiter>])
```

| Parameter     | Description                                                                                                              |
| :------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `<arr>`       | An array of `TEXT` elements.                                                                                             |
| `<delimiter>` | The delimiter used for joining the array elements. If you omit this value, an empty string is being used as a delimiter. |

### Example
{: .no_toc}

In the example below, the three elements are joined with no delimiter.

```sql
SELECT
	ARRAY_JOIN([ '1', '2', '3' ]) AS res;
```

**Returns**: `123`

In this example below, we are providing a comma delimiter.

```
SELECT
	ARRAY_JOIN([ 'a', 'b', 'c' ], ',') AS res;
```

**Returns**: `a,b,c`

## ARRAY\_MAX

Returns the maximum element in an array `<arr>`.

### Syntax
{: .no_toc}

```sql
ARRAY_MAX(<arr>)
```

| Parameter | Description                                  |
| :--------- | :-------------------------------------------- |
| `<arr>`   | The array or array-type column to be checked |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_MAX([ 1, 2, 3, 4 ]) AS res;
```

**Returns**: `4`

## ARRAY\_MIN

Returns the minimum element in `<arr>`.

### Syntax
{: .no_toc}

```sql
ARRAY_MIN(<arr>)
```

| Parameter | Description                                  |
| :--------- | :-------------------------------------------- |
| `<arr>`   | The array or array-type column to be checked |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_MIN([ 1, 2, 3, 4 ]) AS res;
```

**Returns**: `1`

## ARRAY\_REPLACE\_BACKWARDS

Scans an array `<arr>` from the last to the first element and replaces each of the elements in that array with `arr[i + 1]` if the `<func>` returns `0`. The last element of `<arr>` is not replaced.

The `<func>` argument must be included.

### Syntax
{: .no_toc}

```sql
ARRAY_REPLACE_BACKWARDS(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be evaluated by the function.                                                                                                                                     |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_REPLACE_BACKWARDS(x -> x > 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `3,3,3,9`

## ARRAY\_REVERSE

Returns an array of the same size as the original array, with the elements in reverse order.

### Syntax
{: .no_toc}

```sql
ARRAY_REVERSE(<arr>)
```

| Parameter | Description               |
| :--------- | :------------------------- |
| `<arr>`   | The array to be reversed. |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_REVERSE([ 1, 2, 3, 6 ]) AS res;
```

**Returns**: `6,3,2,1`

## ARRAY\_SORT

Returns the elements of `<arr>` in ascending order.

If the argument `<func>` is provided, the sorting order is determined by the result of applying `<func>` on each element of `<arr>`.

### Syntax
{: .no_toc}

```sql
ARRAY_SORT([<func>,] <arr>)
```

| Parameter | Description                                                  |
| :--------- | :------------------------------------------------------------ |
| `<func>`  | An optional function to be used to determine the sort order. |
| `<arr>`   | The array to be sorted.                                      |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_SORT([ 4, 1, 3, 2 ]) AS res;
```

**Returns**: `1,2,3,4`

In this example below, the modulus operator is used to calculate the remainder on any odd numbers. Therefore `ARRAY_ SORT` puts the higher (odd) numbers last in the results.

```sql
SELECT
	ARRAY_SORT(x -> x % 2, [ 4, 1, 3, 2 ]) AS res;
```

**Returns**: `4,2,1,3`

## ARRAY\_SUM

Returns the sum of elements of `<arr>`. If the argument `<func>` is provided, the values of the array elements are converted by this function before summing.

### Syntax
{: .no_toc}

```sql
ARRAY_SUM([<func>,] <arr>)
```

| Parameter | Description                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------- |
| `<func>`  | A Lambda function with an [arithmetic function](../../commands/operators.md#arithmetic) used to modify the array elements. |
| `<arr>`   | The array to be used to calculate the function.                                                                            |

### Example
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

## ARRAY\_UNIQ

If one argument is passed, returns the number of different elements in the array. If multiple arguments are passed, returns the number of different tuples of elements at corresponding positions in multiple arrays.

### Syntax
{: .no_toc}

```sql
ARRAY_UNIQ(<arr> [, ...n])
```

| Parameter        | Description                         |
| :---------------- | :----------------------------------- |
| `<arr> [, ...n]` | The array or arrays to be analyzed. |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_UNIQ([ 1, 2, 4, 5 ]) AS res;
```

**Returns**: `4`

#### Example&ndash;using multiple arrays
{: .no_toc}

When using multiple arrays, `ARRAY_UNIQ` evaluates all the elements at a specific index as tuples for counting the unique values.&#x20;

For example, two arrays \[1,1,1,1] and \[1,1,1,2] would be evaluated as individual tuples (1,1), (1,1), (1,1), and (1,2). There are 2 unique tuples, so `ARRAY_UNIQ` would return a value of 2.

```
SELECT
	ARRAY_UNIQ ([ 1, 1, 1, 1 ], [ 1, 1, 1, 2 ]) AS res;
```

**Returns**: `2`

In the example below, there are three different strings across all of the elements of the given arrays. However, there are only two unique tuples, ('apple', 'pie') and ('apple', 'jack').

```
SELECT
	ARRAY_UNIQ (
		[ 'apple',
		'apple',
		'apple',
		'apple' ],
		[ 'pie',
		'pie',
		'jack',
		'jack' ]
	) AS res;
```

**Returns**: `2`

## ARRAY\_UNNEST

This function "unfolds" a given array by creating a column result containing the individual members from the array's values.

### Syntax
{: .no_toc}

```sql
ARRAY_UNNEST(<arr>)
```

| Parameter | Description               |
| :--------- | :------------------------- |
| `<arr>`   | The array to be unfolded. |

### Example
{: .no_toc}

```sql
SELECT
	ARRAY_UNNEST([ 1, 2, 3, 4 ]) AS res;
```

**Returns**:

| res |
| :--- |
| 1   |
| 2   |
| 3   |
| 4   |

## CONTAINS

Returns `1` if a specified argument is present in the array, or `0` otherwise.

### Syntax
{: .no_toc}

```sql
CONTAINS(<arr>, <arg>)
```

| Parameter | Description                                      |
| :--------- | :------------------------------------------------ |
| `<arr>`   | The array to be checked for the given element.   |
| `<arg>`   | The element to be searched for within the array. |

### Example
{: .no_toc}

```sql
SELECT
	CONTAINS([ 1, 2, 3 ], 3) AS res;
```

**Returns**: `1`

`CONTAINS` returns a `0` result when single character or substring matches only part of a longer string.

```
SELECT
	CONTAINS([ 'a', 'b', 'cookie' ], 'c') AS res;
```

**Returns**: `0`

## ELEMENT\_AT

Returns the element at a location `<index>` from the given array. `<index>` must be any integer type. Indexes in an array begin at position `1`.

### Syntax
{: .no_toc}

```sql
ELEMENT_AT(<arr>, <index>)
```

| Parameter | Description                                                                                                                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<arr>`   | The array containing the index.                                                                                                                                                                                            |
| `<index>` | The index that is matched by the function. <br>Negative indexes are supported. If used, the function selects the corresponding element numbered from the end. For example, arr[-1] is the last item in the array. |

### Example
{: .no_toc}

```sql
SELECT
	ELEMENT_AT([ 1, 2, 3, 4 ], 2) AS res;
```

**Returns**: `2`

## FILTER

Returns an array containing the elements from `<arr>` for which the given Lambda function `<func>` returns something other than `0`.

The function can receive one or more arrays as its arguments. If more than one array is provided the following conditions should be met:

* The number of arguments of the Lambda function must be equal to the number of arrays provided. If the condition isn't met - the query will not run and an error will be returned.

* All the provided arrays should be of the same length. If the condition isn't met a runtime error will occur.

When multiple arrays are provided to the function, the function will evaluate the current elements from each array as its parameter. All of the elements at that index position must evaluate to true (or `1`) for this index to be included in the results. The elements that are returned are taken only from the first array provided.

### Syntax
{: .no_toc}

```sql
FILTER(<func>, <arr> [, ...n] )
```

| Parameter        | Description                                                                                                                                                                    |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`         | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr> [, ...n]` | One or more arrays that will be evaluated by the function. Only the first array that is included will be filtered in the results.                                              |

### Example
{: .no_toc}

In the example below, there is only one array and function. Only one element matches the function criteria, and it is returned.

```
SELECT
	FILTER(x -> x = 'a', [ 'a', 'b', 'c', 'd' ]);
```

**Returns**: `'a'`

In this example below, there are two arrays and two separate functions for evaluation. The `y` function searches the second array for all elements that are greater than 2. The elements in these positions are returned from the first array.

```sql
SELECT
	FILTER(x, y -> y > 2, [ 'a', 'b', 'c', 'd' ], [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `['c', 'd']`

## FLATTEN

Converts an array of arrays into a flat array. That is, for every element that is an array, this function extracts its elements into the new array. The resulting flattened array contains all the elements from all source arrays.

The function:

* Applies to any depth of nested arrays.
* Does not change arrays that are already flat.

### Syntax
{: .no_toc}

```sql
FLATTEN(<arr_of_arrs>)
```

| Parameter       | Description                          |
| :--------------- | :------------------------------------ |
| `<arr_of_arrs>` | The array of arrays to be flattened. |

### Example
{: .no_toc}

```sql
SELECT
	flatten([ [ [ 1, 2 ] ], [ [ 2, 3 ], [ 3, 4 ] ] ])
```

**Returns**: `(1, 2, 2, 3, 3, 4)`

## INDEX\_OF

Returns the index position of the first occurrence of the element in the array (or `0` if not found).

### Syntax
{: .no_toc}

```sql
INDEX_OF(<arr>, <x>)
```

| Parameter | Description                                       |
| :--------- | :------------------------------------------------- |
| `<arr>`   | The array to be analyzed.                         |
| `<x>`     | The element from the array that is to be matched. |

### Example
{: .no_toc}

```sql
SELECT
	INDEX_OF([ 1, 3, 5, 7 ], 5) AS res;
```

**Returns**: `3`

## LENGTH

Returns the length (number of elements) of the given array.

### Syntax
{: .no_toc}

```sql
LENGTH(<arr>)
```

| Parameter | Description                         |
| :--------- | :----------------------------------- |
| `<arr>`   | The array to be checked for length. |

### Example
{: .no_toc}

```sql
SELECT
	LENGTH([ 1, 2, 3, 4 ]) AS res;
```

**Returns**: `4`

## NEST

Takes a column as an argument, and returns an array of the values. In case the type of the column is nullable, the `NULL` values will be ignored.

### Syntax
{: .no_toc}

```sql
​​NEST(<col>)​​
```

| Parameter | Description                                         |
| :--------- | :--------------------------------------------------- |
| `<col>`   | The name of the column to be converted to an array. |

### Example
{: .no_toc}

Assume we have the following `prices` table:

| item   | price |
| :------ | :----- |
| apple  | 4     |
| banana | NULL  |
| orange | 11    |
| kiwi   | 20    |

Running the following query:

```sql
SELECT
	NEST(price) AS arr
FROM
	prices;
```

**Returns**: `[4,11,20]`

## REDUCE

Applies an aggregate function on the elements of the array and returns its result. The name of the aggregation function is passed as a string in single quotes - for example: `'max'`, `'sum'`. When using parametric aggregate functions, the parameter is indicated after the function name in parentheses `'<func_name>(<parameter>)'`.

### Syntax
{: .no_toc}

```sql
REDUCE(<agg_function>, <arr>)
```

| Parameter        | Description                                                                     |
| :---------------- | :------------------------------------------------------------------------------- |
| `<agg_function>` | The name of an aggregate function which should be a constant string             |
| `<arr>`          | Any number of array type columns as the parameters of the aggregation function. |

### Example
{: .no_toc}

```sql
SELECT
	REDUCE('max', [ 1, 2, 3, 6 ]) AS res;
```

**Returns**: `6`

## SLICE

Returns a slice of the array based on the indicated offset and length.

### Syntax
{: .no_toc}

```sql
SLICE(<arr>, <offset>[, <length>])
```

| Parameter  | Description                                                                                                                                                        |
| :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<arr>`    | The array of data to be sliced. Array elements set to `NULL` are handled as normal values. The numbering of the array items begins with `1`.                       |
| `<offset>` | Indicates starting point of the array slice. A positive value indicates an offset on the left, and a negative value is an indent on the right.                     |
| `<length>` | The length of the required slice.<br>If you omit this value, the function returns the slice from the `<offset>` to the end of the array. |

### Example
{: .no_toc}

```sql
SELECT
	SLICE([ 1, 2, NULL, 4, 5 ], 2, 3) AS res;
```

**Returns**: `2, null, 4`

## TRANSFORM

Returns an array by applying `<func>` on each element of `<arr>`.

The Lambda function `<func>` is mandatory.

### Syntax
{: .no_toc}

```sql
TRANSFORM(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../../concepts/working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be transformed by the function.                                                                                                                                   |

### Example
{: .no_toc}

```sql
SELECT
	TRANSFORM(x -> x * 2, [ 1, 2, 3, 9 ]) AS res;
```

**Returns**: `2,4,6,18`
