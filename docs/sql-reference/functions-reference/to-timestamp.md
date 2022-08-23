---
layout: default
title: TO_TIMESTAMP
description: Reference material for TO_TIMESTAMP function
parent: SQL functions
---

# TO\_TIMESTAMP

Converts a string to timestamp with optional formatting.

## Syntax
{: .no_toc}

```sql
TO_TIMESTAMP(<string> [,format])
```

| Parameter  | Description                                        |
| :---------- | :-------------------------------------------------- |
| `<string>` | The string value to convert. |
| `<format>` | An optional string literal that specifies the format of the `<string>` to convert. See [DATE_FORMAT](../functions-reference/date-format.md) for a table of available string literals.  |

## Example
{: .no_toc}

```sql
SELECT
	TO_TIMESTAMP('2020-05-31 10:31:14', 'YYYY-MM-DD HH:MM:SS') AS res;
```

**Returns**: `2020-05-31 10:31:14`
