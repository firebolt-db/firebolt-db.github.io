---
layout: default
title: CURRENT_PGDATE
description: Reference material for CURRENT_PGDATE function
parent: SQL functions
---

# CURRENT_PGDATE

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
