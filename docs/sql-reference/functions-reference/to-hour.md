---
layout: default
title: TO_HOUR
parent: SQL functions
---

# TO\_HOUR

Converts a date or timestamp to a number containing the hour.

## Syntax
{: .no_toc}

```sql
TO_HOUR(<timestamp>)
```

| Parameter     | Description                                                |
| :------------- | :---------------------------------------------------------- |
| `<timestamp>` | The timestamp to be converted into the number of the hour. |

## Example
{: .no_toc}

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT
	TO_HOUR(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) AS res;
```

Returns: `12`
