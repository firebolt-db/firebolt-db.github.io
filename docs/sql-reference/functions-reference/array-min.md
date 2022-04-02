---
layout: default
title: ARRAY_MIN
description: Reference material for ARRAY_MIN function
parent: SQL functions
---

# ARRAY\_MIN

Returns the minimum element in `<arr>`.

## Syntax
{: .no_toc}

```sql
ARRAY_MIN(<arr>)
```

| Parameter | Description                                  |
| :--------- | :-------------------------------------------- |
| `<arr>`   | The array or array-type column to be checked |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_MIN([ 1, 2, 3, 4 ]) AS res;
```

**Returns**: `1`
