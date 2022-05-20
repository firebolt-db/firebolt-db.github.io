---
layout: default
title: TO_UNIX_TIMESTAMP
description: Reference material for TO_UNIX_TIMESTAMP function
parent: SQL functions
---

# TO\_UNIX\_TIMESTAMP

Converts a string to a UNIX timestamp.

## Syntax
{: .no_toc}

```sql
TO_UNIX_TIMESTAMP(<string>)
```

| Parameter  | Description                                        |
| :---------- | :-------------------------------------------------- |
| `<string>` | The string format should be: ‘YYYY-MM-DD HH:mm:ss’ |

## Example
{: .no_toc}

```sql
SELECT
	TO_UNIX_TIMESTAMP('2017-11-05 08:07:47');
```

**Returns**: `1509869267`
