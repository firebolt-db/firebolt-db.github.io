---
layout: default
title: LOCALTIMESTAMPNTZ (legacy)
description: Reference material for LOCALTIMESTAMPNTZ (legacy) function
nav_exclude: true
parent: SQL functions
---

# LOCALTIMESTAMPNTZ (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19.0 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.0.
  >
  >If you worked with Firebolt before DB version 3.22.0, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation.
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [LOCALTIMESTAMP](./localtimestamp.md) function instead.

Returns the current local timestamp in the time zone specified in the session's [`time_zone` setting](../../general-reference/system-settings.md#set-time-zone).

## Syntax
{: .no_toc}


The function can be called with or without parentheses:

```sql
LOCALTIMESTAMPNTZ
LOCALTIMESTAMPNTZ()
```

## Return Type

`TIMESTAMPNTZ`

## Remarks
{: .no_toc}

The function takes the current Unix timestamp (in the UTC time zone), converts it to the time zone specified in the `time_zone` setting, and returns it as a `TIMESTAMPNTZ` value.
Two simultaneous calls of the function can return different timestamps, due to time zone conversion.


## Example
{: .no_toc}

The following example assumes that the current timestamp is `2023-03-03 14:42:31.123456 UTC`.

Observe how we return different `TIMESTAMPNTZ` values with different time zone settings:

```sql
SET time_zone = 'Europe/Berlin';
SELECT LOCALTIMESTAMPNTZ;  --> 2023-03-03 15:42:31.123456

SET time_zone = 'America/New_York';
SELECT LOCALTIMESTAMPNTZ;  --> 2023-03-03 09:42:31.123456
```
