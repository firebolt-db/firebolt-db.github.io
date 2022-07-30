---
layout: default
title: TO_DATE
description: Reference material for TO_DATE function
parent: SQL functions
---

# TO\_DATE

Converts a string to `DATE` type using optional formatting.

## Syntax
{: .no_toc}

```sql
TO_DATE(<string> [,format])
```

| Parameter   | Description                                                                 |
| :---------- | :-------------------------------------------------------------------------- |
| `<string>` | The string to convert to a date. |
| `format` | An optional string literal that defines the format of the input string, in terms of its date parts.  |

## Example
{: .no_toc}

```sql
SELECT
	TO_DATE('2020-05-31', 'YYYY-MM-DD') AS res;
```

**Returns**: `2020-05-31`
