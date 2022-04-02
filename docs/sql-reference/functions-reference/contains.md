---
layout: default
title: CONTAINS
description: Reference material for CONTAINS function
parent: SQL functions
---

# CONTAINS

Returns `1` if a specified argument is present in the array, or `0` otherwise.

## Syntax
{: .no_toc}

```sql
CONTAINS(<arr>, <arg>)
```

| Parameter | Description                                      |
| :--------- | :------------------------------------------------ |
| `<arr>`   | The array to be checked for the given element.   |
| `<arg>`   | The element to be searched for within the array. |

## Example
{: .no_toc}

```sql
SELECT
	CONTAINS([ 1, 2, 3 ], 3) AS res;
```

**Returns**: `1`

`CONTAINS` returns a `0` result when single character or substring matches only part of a longer string.

```
SELECT
	CONTAINS([ 'a', 'b', 'cookie' ], 'c') AS res;
```

**Returns**: `0`
