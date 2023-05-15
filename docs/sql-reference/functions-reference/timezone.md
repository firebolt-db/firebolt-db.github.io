---
layout: default
title: TIMEZONE (legacy)
description: Reference material for TIMEZONE (legacy) function
nav_exclude: true
parent: SQL functions
---

# TIMEZONE (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation.
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [`time_zone` setting](../../general-reference/available-engine-specs.mdsystem-settings.md#set-time-zone) instead.

Returns the current timezone of the request execution.

## Syntax
{: .no_toc}

```sql
TIMEZONE()
```

## Example
{: .no_toc}


```sql
SELECT
    TIMEZONE()
```

**Returns**: `Etc/UTC`
