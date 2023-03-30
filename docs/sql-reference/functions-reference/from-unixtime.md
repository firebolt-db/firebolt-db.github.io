---
layout: default
title: FROM_UNIXTIME
description: Reference material for FROM_UNIXTIME function
parent: SQL functions
---

# FROM\_UNIXTIME

Convert Unix time (`BIGINT` in epoch seconds) to `DATETIME` (YYYY-MM-DD HH:mm:ss).

## Syntax
{: .no_toc}

```sql
FROM_UNIXTIME(<unix_time>)
```

| Parameter     | Description                                  |
| :------------- | :-------------------------------------------- |
| `<unix_time>` | The UNIX epoch time that is to be converted. |

## Example
{: .no_toc}

```sql
SELECT
    FROM_UNIXTIME(1493971667);
```

**Returns**: `2017-05-05 08:07:47`
