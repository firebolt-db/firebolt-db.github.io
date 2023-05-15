---
layout: default
title: TIMESTAMP data type
description: Describes the Firebolt implementation of the `TIMESTAMP` data type
nav_exclude: true
search_exclude: false
---

# TIMESTAMP data type
{:.no_toc}

This topic describes the Firebolt implementation of the `TIMESTAMP` data type.

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](legacy-date-timestamp.md), or instructions to reingest your data to use the new types [here](../release-notes/release-notes-archive.md#db-version-3190).

* Topic ToC
{:toc}

## Overview

| Name        | Size    | Minimum                      | Maximum                      | Resolution    |
| :---------- | :------ | :--------------------------- | :--------------------------- | :------------ |
| `TIMESTAMP` | 8 bytes | `0001-01-01 00:00:00.000000` | `9999-12-31 23:59:59.999999` | 1 microsecond |

The `TIMESTAMP` data type represents a date and time with microsecond resolution independent of a time zone.
Every day consists of 24 hours.
To represent an absolute point in time, use [TIMESTAMPTZ](timestamptz-data-type.md).

## Literal string interpretation

`TIMESTAMP` literals follow the ISO 8601 and RFC 3339 format: `YYYY-[M]M-[D]D[( |T)[h]h:[m]m:[s]s[.f]]`.

* `YYYY`: Four-digit year (`0001` - `9999`)
* `[M]M`: One or two digit month (`01` - `12`)
* `[D]D`: One or two digit day (`01` - `31`)
* `( |T)`: A space or `T` separator
* `[h]h`: One or two digit hour (`00` - `23`)
* `[m]m`: One or two digit minute (`00` - `59`)
* `[s]s`: One or two digit second (`00` - `59`)
* `[.f]`: Up to six digits after the decimal separator (`000000` - `999999`)

If only the date is specified, the time is assumed to be `00:00:00.000000`.

**Examples**

```sql
SELECT TIMESTAMP '1996-09-03 11:19:33.123456';
SELECT '2023-02-13'::TIMESTAMP;  --> 2023-02-13 00:00:00
SELECT CAST('2019-7-23T16:9:3.1' as TIMESTAMP);  --> 2019-07-23 16:09:03.1
```

As shown below, string literals are implicitly converted to `TIMESTAMP` when used where an expression of type `TIMESTAMP` is expected:

```sql
SELECT DATE_TRUNC('hour', TIMESTAMP '2023-02-13 17:14:19.123') = '2023-02-13 17:00:00';  --> true
SELECT TIMESTAMP '1996-09-03' BETWEEN '1991-12-31 18:29:12' AND '2022-12-31 0:1:2.123';  --> true
```

## Functions and operators

### Type conversions

The `TIMESTAMP` data type can be cast to and from types as follows: 

| To `TIMESTAMP` | Example                                                                                      | Note                                                                                                                                                                                                |
| :------------- | :------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMP`    | `SELECT CAST(TIMESTAMP '2023-02-13 11:19:42' as TIMESTAMP); --> 2023-02-13 11:19:42`         |                                                                                                                                                                                                     |
| `DATE`         | `SELECT CAST(DATE '2023-02-13' as TIMESTAMP);  --> 2023-02-13 00:00:00`                      | Extends the date with `00:00:00`.                                                                                                                                                                   |
| `TIMESTAMPTZ`  | `SELECT CAST(TIMESTAMPTZ '2023-02-13 Europe/Berlin' as TIMESTAMP);  --> 2023-02-13 22:00:00` | Converts from Unix time to local time in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone), then truncates the timestamp to the date. This example assumes `SET time_zone = 'UTC';`. |
| `NULL`         | `SELECT CAST(NULL as TIMESTAMP);  --> NULL`                                                  |                                                                                                                                                                                                     |

| From `TIMESTAMP` | Example                                                                                    | Note                                                                                                                                                      |
| :--------------- | :----------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DATE`           | `SELECT CAST(TIMESTAMP '2023-02-13 11:19:42' as DATE);  --> 2023-02-13`                    | Truncates the timestamp to the date.                                                                                                                      |
| `TIMESTAMPTZ`    | `SELECT CAST(TIMESTAMP '2023-02-13 11:19:42' as TIMESTAMPTZ);  --> 2023-02-13 11:19:42+00` | Interprets the timestamp to be local time in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone). This example assumes `SET time_zone = 'UTC';`. |

### Comparison operators

The usual comparison operators are supported:

| Operator                 | Description              |
| :----------------------- | :----------------------- |
| `TIMESTAMP < TIMESTAMP`  | Less than                |
| `TIMESTAMP > TIMESTAMP`  | Greater than             |
| `TIMESTAMP <= TIMESTAMP` | Less than or equal to    |
| `TIMESTAMP >= TIMESTAMP` | Greater than or equal to |
| `TIMESTAMP = TIMESTAMP`  | Equal to                 |
| `TIMESTAMP <> TIMESTAMP` | Not equal to             |

A `TIMESTAMP` value is also comparable with a `DATE` or `TIMESTAMPTZ` value:

* The `DATE` value is converted to the `TIMESTAMP` type for comparison with a `TIMESTAMP` value.
* The `TIMESTAMP` value is converted to the `TIMESTAMPTZ` type for comparison with a `TIMESTAMPTZ` value.

For more information, see [type conversions](#type-conversions).

### Arithmetic operators

Arithmetic with intervals can be used to add or subtract a duration to/from a timestamp.
The result is of type `TIMESTAMP`.

```sql
SELECT TIMESTAMP '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00
SELECT TIMESTAMP '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00
```

For more information, see [Arithmetic with intervals](interval-arithmetic.md).

## Serialization and deserialization

### Text, CSV, JSON
{:.no_toc}

In the text, CSV, and JSON format, a `TIMESTAMP` value is output as a `YYYY-MM-DD hh:mm:ss[.f]` string.
Firebolt outputs as few digits after the decimal separator as possible (at most six).
Input is accepted in the literal format described above: `YYYY-[M]M-[D]D[( |T)[h]h:[m]m:[s]s[.f]]`.

### Parquet
{:.no_toc}

`TIMESTAMP` maps to Parquet's 64-bit signed integer `TIMESTAMP` type with the parameter `isAdjustedToUTC` set to `false` and `unit` set to `MICROS`, also representing the number of microseconds before or after `1970-01-01 00:00:00.000000`.

### Avro
{:.no_toc}

`TIMESTAMP` maps to Avro's 64-bit signed integer `local-timestamp-micros` type, also representing the number of microseconds before or after `1970-01-01 00:00:00.000000`.

## Data pruning

Columns of type `TIMESTAMP` can be used in the `PRIMARY INDEX` and `PARTITION BY` clause of `CREATE TABLE` commands.
