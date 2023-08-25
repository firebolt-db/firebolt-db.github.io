---
layout: default
title: ELEMENT_AT
description: Reference material for ELEMENT_AT function
parent: SQL functions
---

# ELEMENT\_AT

Returns the element at a location `<index>` from the given array. `<index>` can be any integer type. Indexes in an array begin at position `1`.

## Syntax
{: .no_toc}

```sql
ELEMENT_AT(<array>, <value>)
```
## Parameters
{: .no_toc}

| Parameter | Description           | Supported input types | 
| :--------- | :------------------------------------- |
| `<array>`   | The array that the function is applied to. | `ARRAY` of any type | 
| `<value>` | The index that is matched by the function. <br>Negative indexes are supported. If used, the function selects the corresponding element numbered from the end. For example, array[-1] is the last item in the array. | `INTEGER` |

## Return Types 
Same as the element data type of the input array

## Example
{: .no_toc}

The following example displays the player's current level by returning the element at the index of `2`: 

```sql
SELECT
	ELEMENT_AT([ 1, 2, 3, 4 ], 2) AS current_level;
```

**Returns**: `2`

<!-- In the example below, `ELEMENT_AT` is paired with `ARRAY_SORT` to reorder the array before grabbing the specified element. `ARRAY_SORT` orders the arrays in ascending order by the elements in the second array `[ 3, 7, 4 ]`. Upon being sorted, that array is reordered to `[ 3, 4, 7 ]` while its associated array `[ 'red', 'green', 'blue' ]` is reordered to `[ 'red', 'blue', 'green' ]`. `ELEMENT_AT` then returns the element at index `-1`, which is now `green`.

```sql
SELECT
	ELEMENT_AT(
		ARRAY_SORT(v, k -> k,
			[ 'red', 'green', 'blue' ],
			[ 3, 7, 4 ] ),
			-1
		)
    AS res;
```
**Returns**: `'green'` -->
