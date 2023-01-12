---
layout: default
title: ARRAY_DISTINCT
description: Reference material for ARRAY_DISTINCT function
parent: SQL functions
---

# ARRAY\_DISTINCT

Returns an array containing only the _unique_ elements of the given array. In other words, if the given array contains multiple identical members, the returned array will include only a single member of that value.

## Syntax
{: .no_toc}

```sql
ARRAY_DISTINCT(<arr>)
```

| Parameter | Description                                  |
| :--------- | :-------------------------------------------- |
| `<arr>`   | The array to be analyzed for unique members. |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_DISTINCT([ 1, 1, 2, 2, 3, 4 ]) AS res;
```

**Returns**: `[1,2,3,4]`
