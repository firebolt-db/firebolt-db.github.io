---
layout: default
title: SPLIT
description: Reference material for SPLIT function
parent: SQL functions
---

# SPLIT

This function splits a given string by a given separator and returns the result in an array of strings.

## Syntax
{: .no_toc}

```sql
SPLIT( <delimiter>, <string> )
```

| Parameter     | Description                           |
| :------------- | :------------------------------------- |
| `<delimiter>` | The separator to split the string by. |
| `<string>`    | The string to split.                  |

## Example
{: .no_toc}

```sql
SELECT
	SPLIT('|','this|is|my|test') AS res;
```

**Returns**: `["this","is","my","test"]`
