---
layout: default
title: STRPOS
description: Reference material for STRPOSR function
parent: SQL functions
---

# STRPOS

Returns the position (in bytes) of the substring found in the string, starting from 1. The returned value is for the first matching value, and not for any subsequent valid matches.

## Syntax
{: .no_toc}

```sql
STRPOS(<string>, <substring>)
```

| Parameter     | Description                         |
| :------------- | :----------------------------------- |
| `<string>`    | The string that will be searched. |
| `<substring>` | The substring to search for.        |

## Example
{: .no_toc}

```sql
SELECT
	STRPOS('hello world','hello') AS res;
```

**Returns**: `1`

```sql
SELECT
	STRPOS('hello world','world') AS res;
```

**Returns**: `7`
