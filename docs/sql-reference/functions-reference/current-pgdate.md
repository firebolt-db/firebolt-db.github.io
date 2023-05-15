---
layout: default
title: CURRENT_PGDATE (legacy)
description: Reference material for CURRENT_PGDATE (legacy) function
nav_exclude: true
parent: SQL functions
---

# CURRENT_PGDATE (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use this function under the name [CURRENT_DATE()](./current-date.md).
  

Returns the current (local) date in the time zone specified in the session's [`time_zone` setting](../../general-reference/system-settings.md#set-time-zone).

## Syntax
{: .no_toc}

The function can be called with or without parentheses:

```sql
CURRENT_PGDATE
CURRENT_PGDATE()
```

## Return Type

`PGDATE`

## Remarks
{: .no_toc}

The function takes the current Unix timestamp (in the UTC time zone), converts it to the time zone specified in the `time_zone` setting, extracts the date part, and returns it as a `PGDATE` value.
Two simultaneous calls of the function can return different dates, due to time zone conversion.

## Example
{: .no_toc}

The following example assumes that the current Unix timestamp is `2023-03-03 23:59:00 UTC`.
Observe how we return different dates with different time zone settings:

```sql
SET time_zone = 'Europe/Berlin';
SELECT CURRENT_PGDATE;  --> 2023-03-04

SET time_zone = 'America/New_York';
SELECT CURRENT_PGDATE;  --> 2023-03-03
```
