---
layout: default
title: TO_TIMESTAMPTZ
description: Reference material for TO_TIMESTAMPTZ function
parent: SQL functions
---

# TO_TIMESTAMPTZ

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](../../general-reference/legacy-date-timestamp.md#legacy-date-and-timestamp-functions), or instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).

Converts the number of seconds since the Unix epoch to a `TIMESTAMPTZ` value.

## Syntax
{: .no_toc}

`TO_TIMESTAMPTZ(<value>)`

## Parameters
{: .no_toc}

| Parameter | Description                                                                                                                                                                                                                                | Supported input types                |
| :-------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------- |
| `<value>` | A numeric expression to convert. The number left of the decimal separator is interpreted as the number of seconds before or after the Unix epoch `1970-01-01 00:00:00 UTC`. The fractional part (if present) is interpreted as subseconds. | `INTEGER`, `BIGINT`, `NUMERIC`, `DOUBLE PRECISION` |

## Return Types

`TIMESTAMPTZ`

## Remarks
{: .no_toc}

`TO_TIMESTAMPTZ` is the inverse function of `EXTRACT(EPOCH FROM TIMESTAMPTZ)`.

## Example
{: .no_toc}

The following example assumes that the current Unix timestamp is `2023-03-03 14:42:31.123456 UTC`.

```sql
SELECT TO_TIMESTAMPTZ(EXTRACT(EPOCH FROM CURRENT_TIMESTAMPTZ)) = CURRENT_TIMESTAMPTZ;  --> true

SET time_zone = 'Europe/Berlin';

SELECT TO_TIMESTAMPTZ(42::INTEGER);  --> 1970-01-01 01:00:42+01
SELECT TO_TIMESTAMPTZ(-9876543210::BIGINT);  --> 1657-01-09 04:39:58+00:53:28
SELECT TO_TIMESTAMPTZ(42.123456::DOUBLE PRECISION);  --> 1970-01-01 01:00:42.123456+01
SELECT TO_TIMESTAMPTZ(42.123456::NUMERIC(38, 9));  --> 1970-01-01 01:00:42.123456+01
```
