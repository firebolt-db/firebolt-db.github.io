---
layout: default
title: ARRAY_FIRST
description: Reference material for ARRAY_FIRST function
parent: SQL functions
---

# ARRAY\_FIRST

Returns the first element in the given array for which the given function returns something other than `0`. The `<function>` parameter must be included.

## Syntax
{: .no_toc}

```sql
ARRAY_FIRST(<function>, <array>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                  | Supported input types | 
| :--------- | :--------------------------- | :-------- | 
| `<function>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array | Any Lambda function |
| `<array>`   | The array evaluated by the function  | Any array | 

## Return Type
`ARRAY` of the same type as the input array 

## Examples
{: .no_toc}

The following example returns the first value in the `levels` array greater than 2: 

```sql
SELECT
	ARRAY_FIRST(x -> x > 2, [ 1, 2, 3, 9 ]) AS levels;
```

**Returns**: `3`

In the example below, the third index is returned because it is the first that evaluates to `esimpson`.

```sql
SELECT
    ARRAY_FIRST(x, y -> y = 'esimpson', [ 1, 2, 3, 9 ], [ 'steven70', 'sabrina21', 'esimpson', 'kennethpark' ]) AS usernames;
```

**Returns**: `3`
