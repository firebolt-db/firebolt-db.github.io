---
layout: default
title: CURRENT_TIMESTAMPTZ
description: Reference material for CURRENT_TIMESTAMPTZ function
parent: SQL functions
---

# CURRENT_TIMESTAMPTZ

Returns the current timestamp as a `TIMESTAMPTZ` value.

## Syntax
{: .no_toc}

The function can be called with or without parentheses:

```sql
CURRENT_TIMESTAMPTZ
CURRENT_TIMESTAMPTZ()
```

## Return Type

`TIMESTAMPTZ`

## Remarks
{: .no_toc}

The function takes the current Unix timestamp (in the UTC time zone), and returns it as a `TIMESTAMPTZ` value.

## Example
{: .no_toc}

The following example assumes that the current Unix timestamp is `2023-03-03 14:42:31.123456 UTC`.

```sql
SET time_zone = 'Europe/Berlin';
SELECT CURRENT_TIMESTAMPTZ;  --> 2023-03-03 15:42:31.123456+01

SET time_zone = 'America/New_York';
SELECT CURRENT_TIMESTAMPTZ;  --> 2023-03-03 09:42:31.123456-05
```
