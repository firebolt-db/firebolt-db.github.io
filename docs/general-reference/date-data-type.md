---
layout: default
title: DATE data type
description: Describes the Firebolt implementation of the `DATE` data type
nav_exclude: true
search_exclude: false
---

# DATE data type
{:.no_toc}

This topic describes the Firebolt implementation of the `DATE` data type.

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

| Name   | Size    | Minimum      | Maximum      | Resolution |
| :----- | :------ | :----------- | :----------- | :--------- |
| `DATE` | 4 bytes | `0001-01-01` | `9999-12-31` | 1 day      |

The `DATE` type represents a calendar date, independent of time zone. 
The `DATE` value can be interpreted differently within different time zones; it usually corresponds to some 24 hour time period, but it may also correspond to longer or shorter time period, depending on time zone daylight saving time rules. 
To represent an absolute point in time, use [TIMESTAMPTZ](timestamptz-data-type.md).

## Literal string interpretation

`DATE` literals follow the ISO 8601 format: `YYYY-[M]M-[D]D`.

* `YYYY`: Four-digit year (`0001` - `9999`)
* `[M]M`: One or two digit month (`01` - `12`)
* `[D]D`: One or two digit day (`01` - `31`)

**Examples**

```sql
SELECT DATE '2023-02-13';
SELECT '2023-02-13'::DATE;
SELECT CAST('2023-6-03' AS DATE);
```

As shown below, string literals are implicitly converted to `DATE` when used where an expression of type `DATE` is expected:

```sql
SELECT DATE_TRUNC('year', DATE '2023-02-13') = '2023-01-01';  --> true
SELECT DATE '1996-09-03' BETWEEN '1991-12-31' AND '2022-12-31';  --> true
```

## Functions and operators

### Type conversions

The `DATE` data type can be cast to and from types as follows: 

| To `DATE`     | Example                                                                        | Note                                                                                                                                                                                                |
| :------------ | :----------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DATE`        | `SELECT CAST(DATE '2023-02-13' as DATE); --> 2023-02-13`                       |                                                                                                                                                                                                     |
| `TIMESTAMP`   | `SELECT CAST(TIMESTAMP '2023-02-13 11:19:42' as DATE);  --> 2023-02-13`        | Truncates the timestamp to the date.                                                                                                                                                                |
| `TIMESTAMPTZ` | `SELECT CAST(TIMESTAMPTZ '2023-02-13 Europe/Berlin' as DATE);  --> 2023-02-13` | Converts from Unix time to local time in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone), then truncates the timestamp to the date. This example assumes `SET time_zone = 'UTC';`. |
| `NULL`        | `SELECT CAST(null as DATE);  --> NULL`                                         |                                                                                                                                                                                                     |

| From `DATE`   | Example                                                                | Note                                                                                                                                               |
| :------------ | :--------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMP`   | `SELECT CAST(DATE '2023-02-13' as TIMESTAMP);  --> 2023-02-1 00:00:00` | Extends the date with `00:00:00`.                                                                                                                  |
| `TIMESTAMPTZ` | `SELECT CAST(DATE '2023-02-13' as TIMESTAMPTZ);  --> 2023-02-13`       | Interprets the date to be midnight in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone). This example assumes `SET time_zone = 'UTC';`. |

### Comparison operators

The usual comparison operators are supported:

| Operator       | Description              |
| :------------- | :----------------------- |
| `DATE < DATE`  | Less than                |
| `DATE > DATE`  | Greater than             |
| `DATE <= DATE` | Less than or equal to    |
| `DATE >= DATE` | Greater than or equal to |
| `DATE = DATE`  | Equal to                 |
| `DATE <> DATE` | Not equal to             |

A `DATE` value is also comparable with a `TIMESTAMP` or `TIMESTAMPTZ` value:

* The `DATE` value is converted to the `TIMESTAMP` or `TIMESTAMPTZ` type for comparison with a `TIMESTAMP` or `TIMESTAMPTZ` value.

For more information, see [type conversions](#type-conversions).

### Date-specific arithmetic operators

The `+` operators described below come in commutative pairs (for example both `DATE + INTEGER` and `INTEGER + DATE`).
Although the arithmetic operators check that the resulting `DATE` value is in the supported range, they don't check for integer overflow.

| Operator                       | Description                                          | Example                                                                                                         |
| :----------------------------- | :--------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------- |
| `DATE + INTEGER -> DATE`       | Add a number of days to a date                       | `SELECT DATE '2023-03-03' + 42;  --> 2023-04-14`                                                                |
| `DATE - INTEGER -> DATE`       | Subtract a number of days from a date                | `SELECT DATE '2023-03-03' - 42;  --> 2023-01-20`                                                                |
| `DATE - DATE -> INTEGER`       | Subtract dates, producing the number of elapsed days | `SELECT DATE '2023-03-03' - DATE '1996-09-03';  --> 9677`                                                       |
| `DATE + INTERVAL -> TIMESTAMP` | Add an interval to a date                            | `SELECT DATE '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00`                                       |
| `DATE - INTERVAL -> TIMESTAMP` | Subtract an interval from a date                     | `SELECT DATE '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00` |

#### Interval arithmetic

Arithmetic with intervals can be used to add or subtract a duration to or from a date.
The result is of type `TIMESTAMP`.

**Example**

```sql
SELECT DATE '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00
SELECT DATE '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00
```

For more information, see [Arithmetic with intervals](interval-arithmetic.md).

## Serialization and deserialization

### Text, CSV, JSON
{:.no_toc}

In the text, CSV, and JSON format, a `DATE` value is output as a `YYYY-MM-DD` string. Input is accepted in the literal format described above: `YYYY-[M]M-[D]D`.

### Parquet
{:.no_toc}

`DATE` maps to Parquet's 32-bit signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

### Avro
{:.no_toc}

`DATE` maps to Avro's 32-bit signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

### ORC
{:.no_toc}

`DATE` maps to ORC's signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

### ORC
{:.no_toc}

`PGDATE` maps to ORC's signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

## Data pruning

Columns of type `DATE` can be used in the `PRIMARY INDEX` and `PARTITION BY` clause of `CREATE TABLE` commands.
