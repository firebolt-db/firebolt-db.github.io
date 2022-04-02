---
layout: default
title: ARRAY_JOIN
description: Reference material for ARRAY_JOIN function
parent: SQL functions
---

# ARRAY\_JOIN

Concatenates an array of `TEXT` elements using an optional delimiter. If no delimiter is provided, an empty string is used instead.

## Syntax
{: .no_toc}

```sql
ARRAY_JOIN(<arr>[, <delimiter>])
```

| Parameter     | Description                                                                                                              |
| :------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `<arr>`       | An array of `TEXT` elements.                                                                                             |
| `<delimiter>` | The delimiter used for joining the array elements. If you omit this value, an empty string is being used as a delimiter. |

## Example
{: .no_toc}

In the example below, the three elements are joined with no delimiter.

```sql
SELECT
	ARRAY_JOIN([ '1', '2', '3' ]) AS res;
```

**Returns**: `123`

In this example below, we are providing a comma delimiter.

```
SELECT
	ARRAY_JOIN([ 'a', 'b', 'c' ], ',') AS res;
```

**Returns**: `a,b,c`
