---
layout: default
title: ARRAY_REVERSE
description: Reference material for ARRAY_REVERSE function
parent: SQL functions
---

# ARRAY\_REVERSE

Returns an array of the same size as the original array, with the elements in reverse order.

## Syntax
{: .no_toc}

```sql
ARRAY_REVERSE(<arr>)
```

| Parameter | Description               |
| :--------- | :------------------------- |
| `<arr>`   | The array to be reversed. |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_REVERSE([ 1, 2, 3, 6 ]) AS res;
```

**Returns**: `[6,3,2,1]`
