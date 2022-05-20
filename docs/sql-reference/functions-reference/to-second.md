---
layout: default
title: TO_SECOND
description: Reference material for TO_SECOND function
parent: SQL functions
---

# TO\_SECOND

Converts a timestamp (any date format we support) to a number containing the second.

## Syntax
{: .no_toc}

```sql
TO_SECOND(<timestamp>)
```

| Parameter     | Description                                                  |
| :------------- | :------------------------------------------------------------ |
| `<timestamp>` | The timestamp to be converted into the number of the second. |

## Example
{: .no_toc}

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT
	TO_SECOND(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

**Returns**: `5`
