---
layout: default
title: CURRENT_PGDATE
description: Reference material for CURRENT_PGDATE function
parent: SQL functions
---

# FUNCTION

The `CURRENT_PGDATE` function returns the current (local) date in the time zone specified in the session's `time_zone` setting.

## Syntax
{: .no_toc}

The function can be called with and without parentheses:

```sql
CURRENT_PGDATE
CURRENT_PGDATE()
```

## Return Type

`PGDATE`

## Remarks
{: .no_toc}

The function takes the current Unix timestamp (in the UTC time zone), converts it to the time zone specified in the `time_zone` setting, extracts the date part, and returns it as a `PGDate` value.
Therefore, two simultaneous calls of the function can return a different date because of the time zone conversion.

## Example
{: .no_toc}

The following example assumes that the current timestamp is `2023-03-03 23:59:00 UTC`.
Observe how we get different dates for different time zones:

```sql
SET time_zone = 'Europe/Berlin';
SELECT CURRENT_PGDATE;  --> 2023-03-04

SET time_zone = 'America/New_York';
SELECT CURRENT_PGDATE;  --> 2023-03-03
```
