# Semi-structured data functions

This page describes the semi-structured data functions supported in ​Firebolt​.

## NEST

Takes a column as an argument, and returns an array of the values. In case the type of the column is nullable, the NULL values will be ignored.

**Syntax**

```sql
​​NEST(col)​​
```

| Parameter | Description |
| :--- | :--- |
| `col` | The name of the column to be referenced. |

**Usage example**

Assume we have the following `prices` table:

| item | price |
| :--- | :--- |
| apple | 4 |
| banana | NULL |
| orange | 11 |
| kiwi | 20 |

Running the following query:

```sql
SELECT NEST(price) as arr from prices;
```

Returns: \[4,11,20\]

## ALL\_MATCH

The `ALL_MATCH` function results indicate whether all elements of an array match the results of the function indicated in the parameters.

Following are the possible values that can be returned:

* 1 if a function is not specified or if all the elements match the function
* 0 if one or more elements don’t match
* `NULL` if the predicate function returns NULL for one or more elements
* `true` for all other elements

**Syntax**

```sql
ALL_MATCH([func,] arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function against which to check the array. |
| `arr` | The array of possible results for the function. The array cannot be empty. |

**Usage example**

```sql
SELECT ALL_MATCH(x -> x > 0, [1,2,3,9]) AS res;
```

Returns: 1

## ANY\_MATCH

The results of the `ANY_MATCH` function indicate whether at least one of the elements of an array matches the results of the function indicated in the parameters.

Following are the possible values that can be returned:

* `true` if one or more elements match the function;
* `false` if none of the elements matches;
* `NULL` if the predicate function returns NULL for one or more elements and false for all other elements.
* 1 if a function is not specified.

**Syntax**

```sql
​​ANY_MATCH([func,] arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function against which to check the array. |
| `arr` | The array of possible results for the function. The array cannot be empty |

**Usage example**

```sql
SELECT ANY_MATCH(x -> x > 3, [1,2,3,9]) AS res;
```

Returns: 1

## ARRAY\_COUNT

This function returns the number of elements in the`arr`array for which the function that is indicated in the parameters returns something other than 0. If no function is specified, it returns the number of non-zero elements in the array.

**Syntax**

```sql
ARRAY_COUNT([function] arr)
```

| Parameter | Description |
| :--- | :--- |
| `function` | The function to be tested. |
| `arr` | The array to be used to check the function. |

**Usage examples**

```sql
SELECT ARRAY_COUNT(x -> x > 3, [1,2,3,9]) AS res;
```

Returns: 1

```sql
SELECT ARRAY_COUNT([1,2,3,9]) AS res;
```

Returns: 4

## ARRAY\_COUNT\_GLOBAL

This function returns the number of elements in the array typed column accumulated over all rows. As such it is an _aggregation_ function.

**Syntax**

```sql
ARRAY_COUNT_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked or an array typed column |

Assuming that `arr` is an array typed column, the following is equivalent

```sql
SUM(ARRAY_COUNT(arr))
```

## ARRAY\_CUMULATIVE\_SUM

This function returns an array of partial sums of elements from the source array \(a running sum\). If the function is specified, then the values of the array elements are converted by this function before summing.

**Syntax**

```sql
ARRAY_CUMULATIVE_SUM([func,] arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function used to convert the array members. |
| `arr` | The array to be used for the sum calculations. |

**Usage examples**

```sql
SELECT ARRAY_CUMULATIVE_SUM(x -> x + 1, [1,2,3,9]) AS res;
```

Returns: 2,5,9,19

```sql
SELECT ARRAY_CUMULATIVE_SUM([1,2,3,9]) AS res
```

Returns: 1,3,6,15

## ARRAY\_FILL

This function scans through the given array from the first element to the last element and replaces arr\[i\] by arr\[i - 1\] if the function that is indicated returns 0. The first element of the given array is not replaced.

The first argument \(lambda function\) is mandatory.

**Syntax**

```sql
ARRAY_FILL(func, arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage examples**

```sql
SELECT ARRAY_FILL(x -> x < 0,[1,2,3,9]) AS res;
```

Returns: 1,1,1,1

```sql
SELECT ARRAY_FILL(x -> x > 0,[1,2,3,9]) AS res;
```

Returns: 1,2,3,9

## FILTER

The `FILTER` function returns an array that only contains the elements in the given array for which the given `func` function returns something other than 0.

The function can receive one or more arrays as its arguments. If more than one array is provided the following conditions should be met:

1. The number of arguments of the lambda function should be equal to the number of arrays provided. If the condition isn't met - the query will not run and an error will be returned.
2. All the provided array should be of the same length. If the condition isn't met a runtime error will occur.

When multiple arrays are provided to the function, the function will receive the current element from each array as its actual parameter, and can use any or all of them to produce the result which will detemine if the element at this index will be included in the result of the function, however, the elements of the result are _always taken from the first array provided._

**Syntax**

```sql
FILTER(func, arr[, arr1, arr2...] )
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage example**

```sql
SELECT FILTER(x, y -> y > 2,['a','b','c','d'],[1,2,3,9]) AS res;
```

Returns: \['c', 'd'\]

## ARRAY\_FIRST

Returns the first element in the given array for which the given `func` function returns something other than 0. The first argument \(lambda function\) can’t be omitted.

**Syntax**

```sql
ARRAY_FIRST(func, arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage example**

```sql
SELECT ARRAY_FIRST(x -> x > 2,[1,2,3,9]) AS res;
```

Returns: 3

## ARRAY\_FIRST\_INDEX

Returns the index of the first element in the indicated array for which the given `func` function returns something other than 0.

The first argument \(lambda function\) is mandatory.

**Syntax**

```sql
ARRAY_FIRST_INDEX(func, arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage example**

```sql
SELECT ARRAY_FIRST_INDEX(x -> x > 2,[1,2,3,9]) AS res;
```

Returns: 3

## ARRAY\_UNNEST

This function "unfolds" the given array by creating individual members from the array's values.

**Syntax**

```sql
ARRAY_UNNEST(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be unfolded. |

**Usage example**

```sql
SELECT ARRAY_UNNEST([1,2,3,4]) AS res;
```

Returns:

| res |
| :--- |
| 1 |
| 2 |
| 3 |
| 4 |

## ARRAY\_REPLACE\_BACKWARDS

This function scans the indicated array from the last element to the first element and replaces each of the elements in that array with arr\[i + 1\].

If the given function returns 0, the last element of the given array is not replaced.

The first argument \(lambda function\) is mandatory.

**Syntax**

```sql
ARRAY_REPLACE_BACKWARDS(func, arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage example**

```sql
SELECT ARRAY_REPLACE_BACKWARDS(x -> x > 2,[1,2,3,9]) AS res;
```

Returns: 3,3,3,9

## TRANSFORM

This function returns a resulting array based on the calculation of the given array members using the given `func` function.

The first argument \(lambda function\) is mandatory.

**Syntax**

```sql
TRANSFORM(func, arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage example**

```sql
SELECT TRANSFORM(x -> x * 2,[1,2,3,9]) AS res;
```

Returns: 2,4,6,18

## ARRAY\_SORT

This function sorts the members of the given array in ascending order.

If a function is specified, the sorting order is determined by the result of the function.

**Syntax**

```sql
ARRAY_SORT([func,] arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | An optional function to be used to determine the sort order. |
| `arr` | The array to be sorted. |

**Usage examples**

```sql
SELECT ARRAY_SORT([4,1,3,2]) AS res;
```

Returns: 1,2,3,4

```sql
SELECT ARRAY_SORT(x -> x * 2,[4,1,3,2]) AS res;
```

Returns: 1,2,3,4

## ARRAY\_SUM

This function calculates given `func` function using the members of the given array. When the function results in 0 or 1, the number of values in the array that the function returned 1 for is returned. If the function is omitted, only the sum of the array elements is returned.

**Syntax**

```sql
ARRAY_SUM([func,] arr)
```

| Parameter | Description |
| :--- | :--- |
| `func` | The function to be used to calculate the array members. |
| `arr` | The array to be used to calculate the function. |

**Usage examples**

A regular transformation function:

```sql
SELECT ARRAY_SUM(x -> x + 1,[4,1,3,2]) AS res;
```

Returns: 14

A function that returns 0/1:

```sql
SELECT ARRAY_SUM(x -> x > 1,[4,1,3,2]) AS res;
```

Returns: 3

No function:

```sql
SELECT ARRAY_SUM([4,1,3,2]) AS res;
```

Returns: 10

```sql
SUM(ARRAY_COUNT(arr))
```

Assuming that `arr` is an array typed column, the following is equivalent

| Parameter | Description |
| :--- | :--- |
| `arr` | The array column over which the function will count the elements |

```sql
ARRAY_COUNT_GLOBAL(arr)
```

**Syntax**

This function returns the number of elements in the array typed column accumulated over all rows. As such it is an _aggregation function._

## ARRAY\_SUM\_GLOBAL

This function returns the sum of elements in the array typed column accumulated over all rows. As such it is an _aggregation function._

**Syntax**

```sql
ARRAY_SUM_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array column over which the function will count the elements |

Assuming that `arr` is an array typed column, the following is equivalent

```sql
SUM(ARRAY_COUNT(arr))
```

## ARRAY\_CONCAT

This function combines arrays that are passed as arguments.

**Syntax**

```sql
ARRAY_CONCAT(arr1 [,arr…])
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The arrays to be combined. If only one array is given, the identical array is returned. |

**Usage Example**

```sql
SELECT ARRAY_CONCAT([1,2,3,4],[5,6,7,8]) AS res;
```

Returns:1,2,3,4,5,6,7,8

## ARRAY\_DISTINCT

This function returns an array containing only the _unique_ elements of the given array. In other words, if the given array contains multiple identical members, the returned array will include only a single member of that value.

**Syntax**

```sql
ARRAY_DISTINCT(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be analyzed for unique members. |

**Usage Example**

```sql
SELECT ARRAY_DISTINCT([1,1,2,2,3,4]) AS res;
```

Returns: 1,2,3,4

## ELEMENT\_AT

This function retrieves the element with the index `n` from the given array. `n` must be any integer type. Indexes in an array begin from one \(1\).

**Syntax**

```sql
ELEMENT_AT(arr, n)
```

<table>
  <thead>
    <tr>
      <th style="text-align:left">Parameter</th>
      <th style="text-align:left">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>arr</code>
      </td>
      <td style="text-align:left">The array containing the index.</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>n</code>
      </td>
      <td style="text-align:left">
        <p>The index that is matched by the function.</p>
        <p>Negative indexes are supported. If used, the function selects the corresponding
          element numbered from the end. For example, arr[-1] is the last item in
          the array.</p>
      </td>
    </tr>
  </tbody>
</table>

**Usage Example**

```sql
SELECT ELEMENT_AT([1,2,3,4],2) AS res;
```

Returns: 2

## FLATTEN

This function converts an array of arrays into a flat array. That is, for every element that is an array, this function extracts its elements into the new array. The resulting flattened array contains all the elements from all source arrays.

The function:

* Applies to any depth of nested arrays.
* Does not change arrays that are already flat.

**Syntax**

```sql
FLATTEN(arr_of_arrs)
```

| Parameter | Description |
| :--- | :--- |
| `arr_of_arrs` | The array of arrays to be flattened. |

**Usage Example**

```sql
SELECT flatten([[[1,2]], [[2,3], [3,4]]])
```

Returns: \(1, 2, 2, 3, 3, 4\)

## ARRAY\_INTERSECT

This function takes multiple arrays and returns an array containing the elements that are present in all source arrays. The order of the resulting array is the same as in the first array.

**Syntax**

```sql
ARRAY_INTERSECT(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | Each of the arrays analyzed for mutual elements. |

**Usage Example**

```sql
SELECT ARRAY_INTERSECT([1, 2, 3], [1, 3], [2, 3])
```

Returns: 3

## ARRAY\_JOIN

This function concatenates the elements of the given array of TEXT using the delimiter \(optional\). In case the delimiter is not provided, an empty string is being used.

**Syntax**

```sql
ARRAY_INTERSECT(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | An array of TEXT elements. |
| `delimiter` | The delimiter used for joining the array elements. If you omit this value, an empty string is being used as a delimiter. |

**Usage Example**

```sql
SELECT ARRAY_JOIN(['1', '2', '3']) AS res;
```

Returns: 123

## REDUCE

This function applies an aggregate function to array elements and returns its result. The name of the aggregation function is passed as a string in single quotes - for example: 'max', 'sum'. When using parametric aggregate functions, the parameter is indicated after the function name in parentheses 'func\_name\(param\)'.

**Syntax**

```sql
REDUCE(agg_function, arr)
```

| Parameter | Description |
| :--- | :--- |
| `agg_function` | The name of an aggregate function which should be a constant string |
| `arr` | Any number of array type columns as the parameters of the aggregation function. |

**Usage Example**

```sql
SELECT REDUCE('max', [1, 2, 3, 6]) AS res;
```

Returns: 6

## **ARRAY\_REVERSE**

This function returns an array of the same size as the original array, with the elements in reverse order.

**Syntax**

```sql
ARRAY_REVERSE(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be reversed. |

**Usage Example**

```sql
SELECT ARRAY_REVERSE([1, 2, 3, 6]) AS res
```

Returns: 6,3,2,1

## **SLICE**

This function returns a "slice" of the array based on the indicated offset and length.

**Syntax**

```sql
SLICE(arr, offset[, length])
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array of data to be sliced. Array elements set to NULL are handled as normal values. The numbering of the array items begins with 1. |
| `offset` | Indicates the indent from the edge of the array. A positive value indicates an offset on the left, and a negative value is an indent on the right. |
| `length` | The length of the required slice. If you specify a negative value, the function returns an open slice \[offset, array\_length - length\). If you omit this value, the function returns the slice \[offset, the\_end\_of\_array\]. |

**Usage Example**

```sql
SELECT SLICE([1, 2, NULL, 4, 5], 2, 3) AS res
```

Returns: 2,,4

## **ARRAY\_UNIQ**

If one argument is passed, this function counts the number of different elements in the array. If multiple arguments are passed, it counts the number of different tuples of elements at corresponding positions in multiple arrays.

**Syntax**

```sql
ARRAY_UNIQ(arr, ...)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be analyzed. |

**Usage Example**

```sql
SELECT ARRAY_UNIQ([1, 2, 4, 5]) AS res;
```

Returns: 4

## **INDEX\_OF**

This function returns the position of the first occurrence of the element in the array \(or 0 if not found\).

**Syntax**

```sql
INDEX_OF(arr, x)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be analyzed. |
| `x` | The element from the array that is to be matched. |

**Usage Example**

```sql
SELECT INDEX_OF([1, 3, 5, 7], 5) AS res;
```

Returns: 3

## **LENGTH**

This function returns the length of the given array.

**Syntax**

```sql
LENGTH(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked for length. |

**Usage Example**

```sql
SELECT LENGTH([1, 2, 3, 4]) AS res;
```

Returns: 4

## **CONTAINS**

The function checks whether the given array has the given element.

Returns 0 if the element is not in the array, or 1 if it is.

`NULL` is processed as a value.

**Syntax**

```sql
CONTAINS(arr, x)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked for the given element. |
| `x` | The element to be searched for within the array. |

**Usage Example**

```sql
SELECT CONTAINS([1, 2, 3], 3) AS res;
```

Returns: 1

## ARRAY\_MAX

This function returns the maximum element per each array in the array typed column. In-case an array is provided as literal - the function returns the maximum element in it.

**Syntax**

```sql
ARRAY_MAX(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked or an array typed column |

**Usage Example**

```sql
SELECT ARRAY_MAX([1,2,3,4]) AS res;
```

Returns: 4

## ARRAY\_MIN

This function returns the minimum element per each array in the array typed column. In-case an array is provided as literal - the function returns the minimum element in it.

**Syntax**

```sql
ARRAY_MIN(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked or an array typed column |

**Usage Example**

```sql
SELECT ARRAY_MIN([1,2,3,4]) AS res;
```

Returns: 1

## ARRAY\_MAX\_GLOBAL

This function returns the maximum element across all arrays in the array typed column. As such it is an _aggregation_ function. In-case an array is provided as literal \(see the below example\) - the function returns the maximum element in it.

**Syntax**

```sql
ARRAY_MAX_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked or an array typed column |

Assuming that `arr` is an array typed column, the following is equivalent:

```sql
SELECT MAX(ARRAY_MAX(arr)) AS res;
```

**Usage Example**

```sql
SELECT ARRAY_MAX_GLOBAL([1,2,3,4]) AS res;
```

Returns: 4

## ARRAY\_MIN\_GLOBAL

This function returns the minimum element across all arrays in the array typed column. As such it is an _aggregation_ function. In-case an array is provided as literal \(see the below example\) - the function returns the minimum element in it.

**Syntax**

```sql
ARRAY_MIN_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array to be checked or an array typed column |

Assuming that `arr` is an array typed column, the following is equivalent:

```sql
SELECT MIN(ARRAY_MIN(arr)) AS res;
```

**Usage Example**

```sql
SELECT ARRAY_MIN_GLOBAL([1,2,3,4]) AS res;
```

Returns: 1

