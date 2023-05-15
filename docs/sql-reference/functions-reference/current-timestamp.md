---
layout: default
title: CURRENT_TIMESTAMP (legacy)
description: Reference material for CURRENT_TIMESTAMP (legacy) function
nav_exclude: true
parent: SQL functions
---

# CURRENT\_TIMESTAMP (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation.
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use this function under the name [CURRENT_TIMESTAMPTZ()](./current-timestamptz.md), or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).

Returns the current year, month, day and time as a `TIMESTAMP` value, formatted as YYYY-MM-DD hh:mm:ss.

## Syntax
{: .no_toc}

```sql
CURRENT_TIMESTAMP()
```

## Example
{: .no_toc}

```
SELECT
    CURRENT_TIMESTAMP();
```

**Returns**: `2022-10-12 19:39:22`

