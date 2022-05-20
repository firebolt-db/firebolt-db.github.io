---
layout: default
title: TO_MINUTE
description: Reference material for TO_MINUTE function
parent: SQL functions
---

# TO\_MINUTE

Converts a timestamp (any date format we support) to a number containing the minute.

## Syntax
{: .no_toc}

```sql
TO_MINUTE(<timestamp>)
```

| Parameter     | Description                                                  |
| :------------- | :------------------------------------------------------------ |
| `<timestamp>` | The timestamp to be converted into the number of the minute. |

## Example
{: .no_toc}

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT
	TO_MINUTE(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) AS res;
```

**Returns**: `20`
