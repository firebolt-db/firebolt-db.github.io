---
layout: default
title: ARRAY_DISTINCT
description: Reference material for ARRAY_DISTINCT function
parent: SQL functions
---

# ARRAY\_DISTINCT

Returns an array containing only the _unique_ elements of the given array. If the given array contains multiple identical members, the returned array will include only a single member of that value.

## Syntax
{: .no_toc}

```sql
ARRAY_DISTINCT(<array>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                                  | Supported input types 
| :--------- | :-------------------------------------------- | :----------|
| `<array>`   | The array to be analyzed for unique members | `ARRAY` |

## Return Type
`ARRAY` of the same type as the input array 

## Example
{: .no_toc}
In the following example, the unique levels of the game are returned in an array called `levels`: 

```sql
SELECT
	ARRAY_DISTINCT([ 1, 1, 2, 2, 3, 4 ]) AS levels;
```

**Returns**: `[1,2,3,4]`
