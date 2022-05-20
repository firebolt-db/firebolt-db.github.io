---
layout: default
title: TO_UNIXTIME
description: Reference material for TO_UNIXTIME function
parent: SQL functions
---

# TO\_UNIXTIME

For `DATETIME` arguments: this function converts the value to its internal numeric representation (Unix Timestamp).  For `TEXT` arguments: this function parses `DATETIME` from a string and returns the corresponding Unix timestamp.

## Syntax
{: .no_toc}

```sql
TO_UNIXTIME(<string>)
```

| Parameter  | Description                 |
| :---------- | :--------------------------- |
| `<string>` | The string to be converted. |

## Example
{: .no_toc}

```sql
SELECT
	TO_UNIXTIME('2017-11-05 08:07:47') AS TO_UNIXTIME;
```

**Returns**: `1509869267`
