---
layout: default
title: PGDATE data type
description: Describes the Firebolt implementation of the `PGDATE` data type
nav_exclude: true
search_exclude: false
---

# PGDATE data type
{:.no_toc}

This topic describes the Firebolt implementation of the `PGDATE` data type.

* Topic ToC
{:toc}

## Overview

| Name     | Size    | Minimum      | Maximum      | Resolution |
| :------- | :------ | :----------- | :----------- | :--------- |
| `PGDATE` | 4 bytes | `0001-01-01` | `9999-12-31` | 1 day      |

The `PGDATE` type represents a calendar date, independent of time zone. 
The `PGDATE` value can be interpreted differently within different time zones; it usually corresponds to some 24 hour time period, but it may also correspond to a longer or shorter time period, depending on time zone daylight saving time rules. 
To represent an absolute point in time, use [TIMESTAMPTZ](timestamptz-data-type.md).

## Literal string interpretation

`PGDATE` literals follow the ISO 8601 format: `YYYY-[M]M-[D]D`.

* `YYYY`: Four-digit year (`0001` - `9999`)
* `[M]M`: One or two digit month (`01` - `12`)
* `[D]D`: One or two digit day (`01` - `31`)

**Examples**

```sql
SELECT PGDATE '2023-02-13';
SELECT '2023-02-13'::PGDATE;
SELECT CAST('2023-6-03' AS PGDATE);
```

As shown below, string literals are implicitly converted to `PGDATE` when used where an expression of type `PGDATE` is expected:

```sql
SELECT DATE_TRUNC('year', PGDATE '2023-02-13') = '2023-01-01';  --> true
SELECT PGDATE '1996-09-03' BETWEEN '1991-12-31' AND '2022-12-31';  --> true
```

## Functions and operators

### Type conversions

The `PGDATE` data type can be cast to and from types as follows: 

| To `PGDATE`          | Example                                                                          | Note                                                                                                                                                                                                |
| :------------------- | :------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PGDATE`             | `SELECT CAST(PGDATE '2023-02-13' as PGDATE); --> 2023-02-13`                     |                                                                                                                                                                                                     |
| `TIMESTAMPNTZ`       | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as PGDATE);  --> 2023-02-13`     | Truncates the timestamp to the date.                                                                                                                                                                |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPTZ '2023-02-13 Europe/Berlin' as PGDATE);  --> 2023-02-13` | Converts from Unix time to local time in the time zone specified by the session's `time_zone` setting, and then truncates the timestamp to the date. This example assumes `set time_zone = 'UTC';`. |
| `NULL`               | `SELECT CAST(null as PGDATE);  --> NULL`                                         |                                                                                                                                                                                                     |
| `DATE` (legacy)      | `SELECT CAST(DATE '2023-02-13' as PGDATE);  --> 2023-02-13`                      | Converts from the legacy `DATE` type.                                                                                                                                                               |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMP '2023-02-13' as PGDATE);  --> 2023-02-13`                 | Converts from the legacy `TIMESTAMP` type.                                                                                                                                                          |

| From `PGDATE`   | Example                                                                      | Note                                                                                                                                               |
| :-------------- | :--------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMPNTZ`  | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPNTZ );  --> 2023-02-1 00:00:00` | Extends the date with `00:00:00`.                                                                                                                  |
| `TIMESTAMPTZ`   | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPTZ );  --> 2023-02-13`          | Interprets the date to be midnight in the time zone specified by the session's `time_zone` setting. This example assumes `set time_zone = 'UTC';`. |
| `DATE` (legacy) | `SELECT CAST(PGDATE '2023-02-13' as DATE);  --> 2023-02-13`                  | Converts to the legacy `DATE` type, and throws an exception if the `PGDATE` value is outside of the supported range of a legacy `DATE` type.       |

### Comparison operators

The usual comparison operators are supported:

| Operator           | Description              |
| :----------------- | :----------------------- |
| `PGDATE < PGDATE`  | Less than                |
| `PGDATE > PGDATE`  | Greater than             |
| `PGDATE <= PGDATE` | Less than or equal to    |
| `PGDATE >= PGDATE` | Greater than or equal to |
| `PGDATE = PGDATE`  | Equal to                 |
| `PGDATE <> PGDATE` | Not equal to             |

A `PGDATE` value is also comparable with a `TIMESTAMPNTZ` or `TIMESTAMPTZ` value:

* The `PGDATE` value is converted to the `TIMESTAMPNTZ` type for comparison with a `TIMESTAMPNTZ` value.
* The `PGDATE` value is converted to the `TIMESTAMPTZ` type for comparison with a `TIMESTAMPTZ` value.

For more information, see [type conversions](#type-conversions).

### Date-specific arithmetic operators

The `+` operators described below come in commutative pairs (for example both `PGDATE + INTEGER` and `INTEGER + PGDATE`).
Although the arithmetic operators check that the resulting `PGDATE` value is in the supported range, they don't check for integer overflow.

| Operator                            | Description                                          | Example                                                                                                           |
| :---------------------------------- | :--------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| `PGDATE + INTEGER -> PGDATE`        | Add a number of days to a date                       | `SELECT PGDATE '2023-03-03' + 42;  --> 2023-04-14`                                                                |
| `PGDATE - INTEGER -> PGDATE`        | Subtract a number of days from a date                | `SELECT PGDATE '2023-03-03' - 42;  --> 2023-01-20`                                                                |
| `PGDATE - PGDATE -> INTEGER`        | Subtract dates, producing the number of elapsed days | `SELECT PGDATE '2023-03-03' - PGDATE '1996-09-03';  --> 9677`                                                     |
| `PGDATE + INTERVAL -> TIMESTAMPNTZ` | Add an interval to a date                            | `SELECT PGDATE '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00`                                       |
| `PGDATE - INTERVAL -> TIMESTAMPNTZ` | Subtract an interval from a date                     | `SELECT PGDATE '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00` |

#### Interval arithmetic

The `+` operators described below come in commutative pairs (for example both `PGDATE + INTEGER` and `INTEGER + PGDATE`).
Although the arithmetic operators check that the resulting `PGDATE` value is in the supported range, they don't check for integer overflow.

| Operator                            | Description                                          | Example                                                                                                           |
| :---------------------------------- | :--------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| `PGDATE + INTEGER -> PGDATE`        | Add a number of days to a date                       | `SELECT PGDATE '2023-03-03' + 42;  --> 2023-04-14`                                                                |
| `PGDATE - INTEGER -> PGDATE`        | Subtract a number of days from a date                | `SELECT PGDATE '2023-03-03' - 42;  --> 2023-01-20`                                                                |
| `PGDATE - PGDATE -> INTEGER`        | Subtract dates, producing the number of elapsed days | `SELECT PGDATE '2023-03-03' - PGDATE '1996-09-03';  --> 9677`                                                     |
| `PGDATE + INTERVAL -> TIMESTAMPNTZ` | Add an interval to a date                            | `SELECT PGDATE '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00`                                       |
| `PGDATE - INTERVAL -> TIMESTAMPNTZ` | Subtract an interval from a date                     | `SELECT PGDATE '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00` |

#### Interval arithmetic

Arithmetic with intervals can be used to add or subtract a duration to or from a date.
The result is of type `TIMESTAMPNTZ`.

**Example**

```sql
SELECT PGDATE '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00
SELECT PGDATE '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00
```

For more information, see [Arithmetic with intervals](interval-arithmetic.md).

## Serialization and deserialization

### Text, CSV, JSON
{:.no_toc}

In the text, CSV, and JSON format, a `PGDATE` value is output as a `YYYY-MM-DD` string. Input is accepted in the literal format described above: `YYYY-[M]M-[D]D`.

### Parquet
{:.no_toc}

`PGDATE` maps to Parquet's 32-bit signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

### Avro
{:.no_toc}

`PGDATE` maps to Avro's 32-bit signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

### ORC
{:.no_toc}

`PGDATE` maps to ORC's signed integer `DATE` type, also representing the number of days before or after `1970-01-01`.

## Data pruning

Columns of type `PGDATE` can be used in the `PRIMARY INDEX` and `PARTITION BY` clause of `CREATE TABLE` commands.
