---
layout: default
title: TIMESTAMPNTZ data type
description: Describes the Firebolt implementation of the `TIMESTAMPNTZ` data type
nav_exclude: true
search_exclude: false
---

# TIMESTAMPNTZ data type
{:.no_toc}

This topic describes the Firebolt implementation of the `TIMESTAMPNTZ` data type.

* Topic ToC
{:toc}

## Overview

| Name           | Size    | Minimum                      | Maximum                      | Resolution    |
| :------------- | :------ | :--------------------------- | :--------------------------- | :------------ |
| `TIMESTAMPNTZ` | 8 bytes | `0001-01-01 00:00:00.000000` | `9999-12-31 23:59:59.999999` | 1 microsecond |

The `TIMESTAMPNTZ` data type represents a date and time with microsecond resolution independent of a time zone.
Every day consists of 24 hours.
To represent an absolute point in time, use [TIMESTAMPTZ](timestamptz-data-type.md).

## Literal string interpretation

`TIMESTAMPNTZ` literals follow the ISO 8601 and RFC 3339 format: `YYYY-[M]M-[D]D[( |T)[h]h:[m]m:[s]s[.f]]`.

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
SELECT TIMESTAMPNTZ '1996-09-03 11:19:33.123456';
SELECT '2023-02-13'::TIMESTAMPNTZ;  --> 2023-02-13 00:00:00
SELECT CAST('2019-7-23T16:9:3.1' as TIMESTAMPNTZ);  --> 2019-07-23 16:09:03.1
```

As shown below, string literals are implicitly converted to `TIMESTAMPNTZ` when used where an expression of type `TIMESTAMPNTZ` is expected:

```sql
SELECT DATE_TRUNC('hour', TIMESTAMPNTZ '2023-02-13 17:14:19.123') = '2023-02-13 17:00:00';  --> true
SELECT TIMESTAMPNTZ '1996-09-03' BETWEEN '1991-12-31 18:29:12' AND '2022-12-31 0:1:2.123';  --> true
```

## Functions and operators

### Type conversions

The `TIMESTAMPNTZ` data type can be cast to and from types as follows: 

| To `TIMESTAMPNTZ`    | Example                                                                                         | Note                                                                                                                                                                                                |
| :------------------- | :---------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMPNTZ`       | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMPNTZ); --> 2023-02-13 11:19:42`      |                                                                                                                                                                                                     |
| `PGDATE`             | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPNTZ);  --> 2023-02-13 00:00:00`                    | Extends the date with `00:00:00`.                                                                                                                                                                   |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPTZ '2023-02-13 Europe/Berlin' as TIMESTAMPNTZ);  --> 2023-02-13 22:00:00` | Converts from Unix time to local time in the time zone specified by the session's `time_zone` setting, and then truncates the timestamp to the date. This example assumes `set time_zone = 'UTC';`. |
| `NULL`               | `SELECT CAST(null as TIMESTAMPNTZ);  --> NULL`                                                  |                                                                                                                                                                                                     |
| `DATE` (legacy)      | `SELECT CAST(DATE '2023-02-13' as TIMESTAMPNTZ);  --> 2023-02-13 00:00:00`                      | Converts from the legacy `DATE` type by extending with `00:00:00`.                                                                                                                                  |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMP '2023-02-13' as TIMESTAMPNTZ);  --> 2023-02-13`                          | Converts from the legacy `TIMESTAMP` type.                                                                                                                                                          |

| From `TIMESTAMPNTZ`  | Example                                                                                        | Note                                                                                                                                                         |
| :------------------- | :--------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PGDATE`             | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as PGDATE );  --> 2023-02-13`                  | Truncates the timestamp to the date.                                                                                                                         |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMPTZ );  --> 2023-02-13 11:19:42+00` | Interprets the timestamp to be local time in the time zone specified by the session's `time_zone` setting. This example assumes `set time_zone = 'UTC';`.    |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMP);  --> 2023-02-13 11:19:42`       | Converts to the legacy `TIMESTAMP` type, and throws an exception if the `TIMESTAMPNTZ` value is outside of the supported range of a legacy `TIMESTAMP` type. |


### Comparison operators

The usual comparison operators are supported:

| Operator                       | Description              |
| :----------------------------- | :----------------------- |
| `TIMESTAMPNTZ < TIMESTAMPNTZ`  | Less than                |
| `TIMESTAMPNTZ > TIMESTAMPNTZ`  | Greater than             |
| `TIMESTAMPNTZ <= TIMESTAMPNTZ` | Less than or equal to    |
| `TIMESTAMPNTZ >= TIMESTAMPNTZ` | Greater than or equal to |
| `TIMESTAMPNTZ = TIMESTAMPNTZ`  | Equal to                 |
| `TIMESTAMPNTZ <> TIMESTAMPNTZ` | Not equal to             |

A `TIMESTAMPNTZ` value is also comparable with a `PGDATE` or `TIMESTAMPTZ` value:

* The `PGDATE` value is converted to the `TIMESTAMPNTZ` type for comparison with a `TIMESTAMPNTZ` value.
* The `TIMESTAMPNTZ` value is converted to the `TIMESTAMPTZ` type for comparison with a `TIMESTAMPTZ` value.

For more information, see [type conversions](#type-conversions).

### Arithmetic operators

Arithmetic with intervals can be used to add or subtract a duration to/from a timestamp.
The result is of type `TIMESTAMPNTZ`.

```sql
SELECT TIMESTAMPNTZ '1996-09-03' + INTERVAL '42' YEAR;  --> 2038-09-03 00:00:00
SELECT TIMESTAMPNTZ '2023-03-18' - INTERVAL '26 years 5 months 44 days 12 hours 41 minutes';  --> 1996-09-03 11:19:00
```

For more information, see [Arithmetic with intervals](interval-arithmetic.md).

## Serialization and deserialization

### Text, CSV, JSON
{:.no_toc}

In the text, CSV, and JSON format, a `TIMESTAMPNTZ` value is output as a `YYYY-MM-DD hh:mm:ss[.f]` string.
Firebolt outputs as few digits after the decimal separator as possible (at most six).
Input is accepted in the literal format described above: `YYYY-[M]M-[D]D[( |T)[h]h:[m]m:[s]s[.f]]`.

### Parquet
{:.no_toc}

`TIMESTAMPNTZ` maps to Parquet's 64-bit signed integer `TIMESTAMP` type with the parameter `isAdjustedToUTC` set to `false` and `unit` set to `MICROS`, representing the number of microseconds before or after `1970-01-01 00:00:00.000000`.
It's also possible to import into a `TIMESTAMPNTZ` column from Parquet's 64-bit signed integer `TIMESTAMP` type with the parameter `isAdjustedToUTC` set to `false` and the `unit` set to `MILLIS` or `NANOS`.
In this case, Firebolt implicitly extends or truncates data to resolve in microseconds.

### Avro
{:.no_toc}

The Avro version used by Firebolt supports the logical types `timestamp-millis` and `timestamp-micros`.
Those types represent absolute points in time, similar to Firebolt's `TIMESTAMPTZ` type.
To prevent unintended time zone conversions, directly importing data from Avro into a `TIMESTAMPNTZ` column is not supported. 
Instead, first import using a `TIMESTAMPTZ` data type column and then convert into `TIMESTAMPNTZ` column, for example using the `AT TIME ZONE` expression.

Similarly, it's not possible to export a `TIMESTAMPNTZ` column to the Avro format, as this would require a possibly unintended time zone conversion.
Instead, use the `AT TIME ZONE` expression to convert a `TIMESTAMPNTZ` column to `TIMESTAMPTZ`.

### ORC

`TIMESTAMPNTZ` maps to ORC's logical type `TIMESTAMP` using up to 128 bits and a resolution of nanoseconds.
During imports, Firebolt truncates data to resolve in microseconds.

## Data pruning

Columns of type `TIMESTAMPNTZ` can be used in the `PRIMARY INDEX` and `PARTITION BY` clause of `CREATE TABLE` commands.
