---
layout: default
title: TO_TIMESTAMP
description: Reference material for TO_TIMESTAMP function
parent: SQL functions
---

# TO\_TIMESTAMP

Converts a string to timestamp.

## Syntax
{: .no_toc}

```sql
​​TO_TIMESTAMP(<string>)​​
```

| Parameter  | Description                                        |
| :---------- | :-------------------------------------------------- |
| `<string>` | The string format should be: ‘YYYY-MM-DD HH:mm:ss’ |

## Example
{: .no_toc}

```sql
SELECT
	TO_TIMESTAMP('2020-05-31 10:31:14') AS res;
```

**Returns**: `2020-05-31 10:31:14`
