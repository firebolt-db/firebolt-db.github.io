---
layout: default
title: INDEX_OF
description: Reference material for INDEX_OF function
parent: SQL functions
---

# INDEX\_OF

Returns the index position of the first occurrence of the element in the array (or `0` if not found).

## Syntax
{: .no_toc}

```sql
INDEX_OF(<arr>, <x>)
```

| Parameter | Description                                       |
| :--------- | :------------------------------------------------- |
| `<arr>`   | The array to be analyzed.                         |
| `<x>`     | The element from the array that is to be matched. |

## Example
{: .no_toc}

```sql
SELECT
	INDEX_OF([ 1, 3, 5, 7 ], 5) AS res;
```

**Returns**: `3`
