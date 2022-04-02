---
layout: default
title: ARRAY_MAX
description: Reference material for ARRAY_MAX function
parent: SQL functions
---

# ARRAY\_MAX

Returns the maximum element in an array `<arr>`.

## Syntax
{: .no_toc}

```sql
ARRAY_MAX(<arr>)
```

| Parameter | Description                                  |
| :--------- | :-------------------------------------------- |
| `<arr>`   | The array or array-type column to be checked |

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_MAX([ 1, 2, 3, 4 ]) AS res;
```

**Returns**: `4`
