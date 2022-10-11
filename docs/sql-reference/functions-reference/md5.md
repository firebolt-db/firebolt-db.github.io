---
layout: default
title: MD5
description: Reference material for MD5 function
parent: SQL functions
---

# MD5

Calculates the MD5 hash of string, returning the result as a string in hexadecimal.

## Syntax
{: .no_toc}

```sql
MD5(<string>)
```

| Parameter  | Description                                               |
| :---------- | :--------------------------------------------------------- |
| `<string>` | The string to hash. For `NULL`, the function returns `NULL`. |

## Example
{: .no_toc}

```sql
SELECT
	MD5('text') AS res;
```

**Returns**: `1cb251ec0d568de6a929b520c4aed8d1`
