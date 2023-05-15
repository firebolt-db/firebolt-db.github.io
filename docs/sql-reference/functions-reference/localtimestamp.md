---
layout: default
title: LOCALTIMESTAMP
description: Reference material for LOCALTIMESTAMP function
parent: SQL functions
---

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19.0 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.0.
  >
  >If you worked with Firebolt before DB version 3.22.0, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](../../general-reference/legacy-date-timestamp.md#legacy-date-and-timestamp-functions), or instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).

# LOCALTIMESTAMP

Returns the current local timestamp in the time zone specified in the session's [`time_zone` setting](../../general-reference/system-settings.md#set-time-zone).

## Syntax
{: .no_toc}

The function can be called with or without parentheses:

```sql
LOCALTIMESTAMP
LOCALTIMESTAMP()
```

## Return Type

`TIMESTAMP`

## Remarks
{: .no_toc}

The function takes the current Unix timestamp (in the UTC time zone), converts it to the time zone specified in the `time_zone` setting, and returns it as a `TIMESTAMP` value.
Two simultaneous calls of the function can return different timestamps, due to time zone conversion.

## Example
{: .no_toc}

The following example assumes that the current timestamp is `2023-03-03 14:42:31.123456 UTC`.
Observe how we return different `TIMESTAMP` values with different time zone settings:

```sql
SET time_zone = 'Europe/Berlin';
SELECT LOCALTIMESTAMP;  --> 2023-03-03 15:42:31.123456

SET time_zone = 'America/New_York';
SELECT LOCALTIMESTAMP;  --> 2023-03-03 09:42:31.123456
```
