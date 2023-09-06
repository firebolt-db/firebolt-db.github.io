---
layout: default
title: ARRAY_COUNT
description: Reference material for ARRAY_COUNT function
parent: SQL functions
---

# ARRAY\_COUNT
Counts the number of elements in the specified array for which `function(array[i])` evaluates to TRUE, if a function is provided. 
If `<function>` is not provided, counts the number of elements in the array that evaluate to TRUE.
To count the elements in an array without any conditions, use the [LENGTH](./length.md) function instead.

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
| `<array>`   | An array of elements | `ARRAY BOOLEAN` | 

## Return Type
`INTEGER`

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
	ARRAY_COUNT([TRUE, '0', 1::BOOLEAN, 3 is not null, null is null]) AS levels;
```

**Returns**: `4`
