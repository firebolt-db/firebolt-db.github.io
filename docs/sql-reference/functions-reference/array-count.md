---
layout: default
title: ARRAY_COUNT
description: Reference material for ARRAY_COUNT function
parent: SQL functions
---

# ARRAY\_COUNT

Returns the number of elements in the given array that match a specified function. If you want only a count of the elements in an array without any conditions, we recommend using the [LENGTH](./length.md) function instead.

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
| `<array>`   | An array of elements | Any array | 

## Return Types
* Returns `1` if the conditions are met
* Returns `0` if the conditions are not met

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
	ARRAY_COUNT([ 0, 1, 2, 3 ]) AS levels;
```

**Returns**: `3`
