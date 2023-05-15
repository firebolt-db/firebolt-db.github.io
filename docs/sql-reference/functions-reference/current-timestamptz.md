---
layout: default
title: CURRENT_TIMESTAMP
description: Reference material for CURRENT_TIMESTAMP function
parent: SQL functions
---

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](../../general-reference/legacy-date-timestamp.md#legacy-date-and-timestamp-functions), or instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).

# CURRENT_TIMESTAMP

Returns the current timestamp as a `TIMESTAMPTZ` value.

## Syntax
{: .no_toc}

The function can be called with or without parentheses:

```sql
CURRENT_TIMESTAMP
CURRENT_TIMESTAMP()
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
SELECT CURRENT_TIMESTAMP;  --> 2023-03-03 15:42:31.123456+01

SET time_zone = 'America/New_York';
SELECT CURRENT_TIMESTAMP;  --> 2023-03-03 09:42:31.123456-05
```
