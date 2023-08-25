---
layout: default
title: ARRAY_SUM
description: Reference material for ARRAY_SUM function
parent: SQL functions
---

# ARRAY\_SUM

Returns the sum of elements of `<array>`. If the argument `<function>` is provided, the values of the array elements are converted by this function before summing.

## Syntax
{: .no_toc}

```sql
ARRAY_SUM([<function>,] <array>)
```
## Parameters
{: .no_toc} 

| Parameter | Description | Supported input types | 
| :--------- | :-------------------------------- |
| `<function>`  | A Lambda function with an [arithmetic function](../../general-reference/operators.md#arithmetic) used to modify the array elements. | Any function | 
| `<array>`   | The array to be used to calculate the function.     | Any array of numeric types | 

## Return Type 
`DOUBLE PRECISION`

## Example
{: .no_toc}

This example below uses a function to first add 1 to all elements before calculating the sum:

```sql
SELECT
	ARRAY_SUM(x -> x + 1, [ 4, 1, 3, 2 ]) AS levels;
```

**Returns**: `14`

In this example below, no function to change the array elements is given.

```sql
SELECT
	ARRAY_SUM([ 4, 1, 3, 2 ]) AS levels;
```

**Returns**: `10`