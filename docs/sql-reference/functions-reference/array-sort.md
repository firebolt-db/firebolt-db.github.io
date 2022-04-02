---
layout: default
title: ARRAY_SORT
description: Reference material for ARRAY_SORT function
parent: SQL functions
---

# ARRAY\_SORT

Returns the elements of `<arr>` in ascending order.

If the argument `<func>` is provided, the sorting order is determined by the result of applying `<func>` on each element of `<arr>`.

## Syntax
{: .no_toc}

```sql
ARRAY_SORT([<func>,] <arr>)
```

| Parameter | Description                                                  |
| :--------- | :------------------------------------------------------------ |
| `<func>`  | An optional function to be used to determine the sort order. |
| `<arr>`   | The array to be sorted.                                      |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_SORT([ 4, 1, 3, 2 ]) AS res;
```

**Returns**: `1,2,3,4`

In this example below, the modulus operator is used to calculate the remainder on any odd numbers. Therefore `ARRAY_ SORT` puts the higher (odd) numbers last in the results.

```sql
SELECT
	ARRAY_SORT(x -> x % 2, [ 4, 1, 3, 2 ]) AS res;
```

**Returns**: `4,2,1,3`
