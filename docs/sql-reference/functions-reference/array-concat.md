---
layout: default
title: ARRAY_CONCAT
description: Reference material for ARRAY_CONCAT function
parent: SQL functions
---

# ARRAY\_CONCAT

Combines one or more arrays that are passed as arguments.

## Syntax
{: .no_toc}

```sql
ARRAY_CONCAT(<arr1> [, ...n])
```

| Parameter        | Description                                                                            |
| :---------------- | :-------------------------------------------------------------------------------------- |
| `<arr> [, ...n]` | The arrays to be combined. If only one array is given, an identical array is returned. |

## Example
{: .no_toc}

```sql
SELECT
    ARRAY_CONCAT([ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ]) AS res;
```

**Returns**: `[1, 2, 3, 4, 5, 6, 7, 8]`
