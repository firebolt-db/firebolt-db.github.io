---
layout: default
title: FROM_UNIXTIME (legacy)
description: Reference material for FROM_UNIXTIME (legacy) function
nav_exclude: true
parent: SQL functions
---

# FROM\_UNIXTIME (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19.0 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.0.
  >
  >If you worked with Firebolt before DB version 3.22.0, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation.
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [TO_TIMESTAMPTZ](./to-timestamptz.md) function instead.

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
