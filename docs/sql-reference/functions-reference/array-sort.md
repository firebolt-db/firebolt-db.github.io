---
layout: default
title: ARRAY_SORT
description: Reference material for ARRAY_SORT function
parent: SQL functions
---

# ARRAY\_SORT

Returns the elements of the input array in ascending order.

If the argument `<function>` is provided, the sorting order is determined by the result of applying `<function>` on each element of the array.

## Syntax
{: .no_toc}

```sql
ARRAY_SORT([<function>,] <array>)
```
## Parameters
{: .no_toc} 

| Parameter | Description                                                  | Supported input type | 
| :--------- | :------------------------------------------------------------ |:------|
| `<function>`  | An optional function to be used to determine the sort order. | Any Lambda function | 
| `<array>`   | The array to be sorted.                                      | Any array of integers | 

## Return Type 
`ARRAY` of the same type as the input array


## Example
{: .no_toc}

The following examples orders the array `levels` in ascending order:  

```sql
SELECT
	ARRAY_SORT([ 4, 1, 3, 2 ]) AS levels;
```

**Returns**: `1,2,3,4`

In this example below, the modulus operator is used to calculate the remainder on any odd numbers. Therefore `ARRAY_ SORT` puts the higher (odd) numbers last in the results.

```sql
SELECT
	ARRAY_SORT(x -> x % 2, [ 4, 1, 3, 2 ]) AS levels;
```

**Returns**: `4,2,1,3`