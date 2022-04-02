---
layout: default
title: LENGTH (array function)
description: Reference material for LENGTH function
parent: SQL functions
---

# LENGTH

Returns the length (number of elements) of the given array.

## Syntax
{: .no_toc}

```sql
LENGTH(<arr>)
```

| Parameter | Description                         |
| :--------- | :----------------------------------- |
| `<arr>`   | The array to be checked for length. |

## Example
{: .no_toc}

```sql
SELECT
	LENGTH([ 1, 2, 3, 4 ]) AS res;
```

**Returns**: `4`
