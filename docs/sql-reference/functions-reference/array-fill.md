---
layout: default
title: ARRAY_FILL
description: Reference material for ARRAY_FILL function
parent: SQL functions
---

# ARRAY\_FILL

This function scans through the given array from the first to the last element and replaces `array[i]` with `array[i - 1]` if the `<function>` returns `0`. The first element of the given array is not replaced.

The Lambda function `<function>` is mandatory.

## Syntax
{: .no_toc}

```sql
ARRAY_FILL(<function>, <array>)
```

## Parameters 
{: .no_toc}

| Parameter | Description       | Supported input types | 
| :--------- | :------------------------ | :---------| 
| `<function>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. | Any Lambda function | 
| `<array>`   | The array to be evaluated by the function.     | Any array | 

## Return Type
`ARRAY` of the same type as the input array 

## Example
{: .no_toc}

The following example returns an array where all values are greater than `1`:
```sql
SELECT
	ARRAY_FILL(x -> x > 0, [ 1, 2, 3, 9 ]) AS levels;
```

**Returns**: `1,2,3,9`
