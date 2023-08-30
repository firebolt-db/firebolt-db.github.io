---
layout: default
title: ARRAY_COUNT
description: Reference material for ARRAY_COUNT function
parent: SQL functions
---

# ARRAY\_COUNT
Let arr[0], ..., arr[n-1] be the elements of <array>.
If <function> is not provided, count how many elements are evaluated to true.
if <function> is provided, count the number of elements for which ```function(array[i])``` evaluates to true.
If you want only a count of the elements in an array without any conditions, we recommend using the [LENGTH](./length.md) function instead.

## Syntax
{: .no_toc}

```sql
ARRAY_COUNT(<function>, <array>)
```
## Parameters
{: .no_toc} 

| Parameter | Description         | Supported input types | 
| :--------- | :-------------------------------------------- | :--------| 
| `<function>`  | Optional. A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. If `<function>` is not included, `ARRAY_COUNT` will return a count of all non-false elements in the array. | Any Lambda function | 
| `<array>`   | An array of elements | An array of booleans | 

## Return Type
* Integer

## Examples
{: .no_toc}

The example below searches through the array for any elements that are greater than 3. Only one number that matches this criteria is found, so the function returns `1`

```sql
SELECT
	ARRAY_COUNT(x -> x > 3, [ 1, 2, 3, 9 ]) AS levels;
```

**Returns**: `1`

In this example below, there is no `<function>` criteria provided in the `ARRAY_COUNT` function. This means the function will count all of the non-false elements in the array. `0` is not counted because it evaluates to `FALSE`

```sql
SELECT
	ARRAY_COUNT([true, false, 2::bool, 3 is not null, null is null]) as levels;;
```

**Returns**: `4`
