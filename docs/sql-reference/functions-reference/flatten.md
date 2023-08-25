---
layout: default
title: FLATTEN
description: Reference material for FLATTEN function
parent: SQL functions
---

# FLATTEN

Converts an array of arrays into a flat array. This means for every element that is an array, this function extracts its elements into the new array. The resulting flattened array contains all the elements from all source arrays.

The function:

* Applies to any depth of nested arrays.
* Does not change arrays that are already flat.

## Syntax
{: .no_toc}

```sql
FLATTEN(<array>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<array>` | The array of arrays to be flattened | Any `ARRAY` of `ARRAY` types | 

## Return Type
`ARRAY` of the same type as the input array

## Example
{: .no_toc}

The following example flattens multiple arrays of level IDs: 

```sql
SELECT
	FLATTEN([ [ [ 1, 2 ] ], [ [ 2, 3 ], [ 3, 4 ] ] ])
```

**Returns**: `[1, 2, 2, 3, 3, 4]`
