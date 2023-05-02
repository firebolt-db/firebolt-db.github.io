---
layout: default
title: TIMESTAMPTZ data type
description: Describes the Firebolt implementation of the `TIMESTAMPTZ` data type
nav_exclude: true
search_exclude: false
---

# TIMESTAMPTZ data type
{:.no_toc}

This topic describes the Firebolt implementation of the `TIMESTAMPTZ` data type.

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

| Name          | Size    | Minimum                          | Maximum                          | Resolution    |
| :------------ | :------ | :------------------------------- | :------------------------------- | :------------ |
| `TIMESTAMPTZ` | 8 bytes | `0001-01-01 00:00:00.000000 UTC` | `9999-12-31 23:59:59.999999 UTC` | 1 microsecond |

The `TIMESTAMPTZ` data type represents an absolute point in time as a date and time with microsecond resolution.

With `TIMESTAMP`, the time zone is deliberately unspecified.
For example, the start of the third millennium was celebrated on New Year's Day at `TIMESTAMP '2001-01-01 00:00:00'`, independent of a geographical location.
However, that doesn't mean that everybody in the world celebrated at the same absolute point in time.
In Munich, Germany, the new year was celebrated at `TIMESTAMPTZ '2001-01-01 00:00:00 Europe/Berlin'`, which was `TIMESTAMPTZ '2000-12-31 23:00:00 UTC'`.
Seattle in the United States celebrated nine hours later at `TIMESTAMPTZ '2001-01-01 00:00:00 US/Pacific'`, which was `TIMESTAMPTZ '2001-01-01 08:00:00 UTC'`.

Firebolt stores `TIMESTAMPTZ` values as [Unix time](https://en.wikipedia.org/wiki/Unix_time), which is UTC without leap seconds.

## Literal string interpretation

`TIMESTAMPTZ` literals can be specified in one of three formats:

1. `local_timestamp [time_zone]`
2. `local_timestamp[time_zone_offset]`
3. `local_timestamp[utc_time_zone]`

* `local_timestamp` follows the ISO 8601 and RFC 3339 format: `YYYY-[M]M-[D]D[( |T)[h]h:[m]m:[s]s[.f]]`.
  * `YYYY`: Four-digit year (`0001` - `9999`)
  * `[M]M`: One or two digit month (`01` - `12`)
  * `[D]D`: One or two digit day (`01` - `31`)
  * `( |T)`: A space or `T` separator
  * `[h]h`: One or two digit hour (`00` - `23`)
  * `[m]m`: One or two digit minutes (`00` - `59`)
  * `[s]s`: One or two digit seconds (`00` - `59`)
  * `[.f]`: Up to six digits after the decimal separator (`000000` - `999999`)
* `time_zone` is a string containing the name of the time zone.
* `time_zone_offset` is a string representing the offset from the UTC time zone.
  * Format: `(+|-)H[H][:m[m]]`.
* `utc_time_zone`: The letter `Z` representing the UTC time zone.

Time zone names are from the [tz database](http://www.iana.org/time-zones) (see the [list of tz database time zones](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)). For times in the future, the latest known rule for the given time zone is applied. Firebolt does not support time zone abbreviations, as they cannot account for daylight savings time transitions, and some time zone abbreviations implied different UTC offsets at different times.

If a `TIMESTAMPTZ` literal has an explicit time zone specified, it is converted to Unix time using the appropriate offset.
If not, Firebolt uses the session's `time_zone` setting and assumes the `TIMESTAMPTZ` literal is in that time zone.
The default value of the `time_zone` setting is UTC.
To check what time zone is set, use [`SELECT TIMEZONE()`](../sql-reference/functions-reference/timezone.md).
To set it to, e.g., `Europe/Berlin`, you can issue: `SET time_zone = 'Europe/Berlin';`. For more information, see [system settings](../general-reference/system-settings.md#set-time-zone).

If only the date is specified, the time is assumed to be `00:00:00.000000`.

**Example**

```sql
SET time_zone = 'UTC';
SELECT TIMESTAMPTZ '1996-09-03 11:19:33.123456 Europe/Berlin';  --> 1996-09-03 09:19:33.123456+00
SELECT TIMESTAMPTZ '2023-1-29 6:3:42.7-3:30';  --> 2023-01-29 09:33:42.7+00
```

As shown below, string literals are implicitly converted to `TIMESTAMPTZ` when used where an expression of type `TIMESTAMPTZ` is expected:

```sql
SELECT DATE_TRUNC('hour', TIMESTAMPTZ '2023-02-13 17:14:19.123 Europe/Berlin', 'Israel') = '2023-02-13 17:00:00+01';  --> true
```

## Daylight savings

During a daylight savings time transition, a seemingly valid timestamp can represent a nonexistent or ambiguous timestamp.
Firebolt resolves the problem by returning the later time point.

### "Spring forward" transitions

```sql
SET time_zone = 'UTC';
SELECT TIMESTAMPTZ '2022-03-27 01:59:59 Europe/Berlin';  --> 2022-03-27 00:59:59+00
SELECT TIMESTAMPTZ '2022-03-27 02:00:00 Europe/Berlin';  --> 2022-03-27 01:00:00+00
SELECT TIMESTAMPTZ '2022-03-27 03:00:00 Europe/Berlin';  --> 2022-03-27 01:00:00+00
```

### "Fall back" transitions

```sql
SET time_zone = 'UTC';
SELECT TIMESTAMPTZ '2022-10-30 01:59:59 Europe/Berlin';  --> 2022-10-29 23:59:59+00
SELECT TIMESTAMPTZ '2022-10-30 02:00:00 Europe/Berlin';  --> 2022-10-30 01:00:00+00
SELECT TIMESTAMPTZ '2022-10-30 03:00:00 Europe/Berlin';  --> 2022-10-30 02:00:00+00
```

## Functions and operators

### Type conversions

The `TIMESTAMPTZ` data type can be cast to and from types as follows (assuming `SET time_zone = 'UTC';`): 

| To `TIMESTAMPTZ` | Example                                                                                                   | Note                                                                                                       |
| :--------------- | :-------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| `TIMESTAMPTZ`    | `SELECT CAST(TIMESTAMPTZ '2023-02-13 11:19:42 Europe/Berlin' as TIMESTAMPTZ); --> 2023-02-13 09:19:42+00` |                                                                                                            |
| `DATE`           | `SELECT CAST(DATE '2023-02-13' as TIMESTAMPTZ);  --> 2023-02-13 00:00:00+00`                              | Interprets the timestamp to be midnight in the time zone specified by the session's `time_zone` setting.   |
| `TIMESTAMP`      | `SELECT CAST(TIMESTAMP '2023-02-13 11:19:42' as TIMESTAMPTZ);  --> 2023-02-13 11:19:42+00`                | Interprets the timestamp to be local time in the time zone specified by the session's `time_zone` setting. |
| `NULL`           | `SELECT CAST(null as TIMESTAMPTZ);  --> NULL`                                                             |                                                                                                            |

| From `TIMESTAMPTZ` | Example                                                                                                   | Note                                                                                                                                                |
| :----------------- | :-------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DATE`             | `SELECT CAST(TIMESTAMPTZ '2023-02-13 11:19:42 Europe/Berlin' as DATE);  --> 2023-02-13`                   | Converts from Unix time to local time in the time zone specified by the session's `time_zone` setting and then truncates the timestamp to the date. |
| `TIMESTAMP`        | `SELECT CAST(TIMESTAMPTZ '2023-02-13 11:19:42 Europe/Berlin' as TIMESTAMP );  --> 2023-02-13 11:19:42+00` | Convert from Unix time to local time in the time zone specified by the session's `time_zone` setting.                                               |

Use the function [TO_TIMESTAMPTZ](../sql-reference/functions-reference/to_timestamptz.md) to convert the number of seconds since the Unix epoch to a `TIMESTAMPTZ` value.

#### AT TIME ZONE

The dependence on the session's `time_zone` setting for type conversions is especially problematic for automatic conversions, which, for example, might be required when reading from an external table.
Therefore, we recommend using the `AT TIME ZONE` construct to avoid the implicit dependence on the `time_zone` setting, to be explicit about which time zone to use.

* `TIMESTAMP AT TIME ZONE time_zone_str -> TIMESTAMPTZ` <br>
 Converts the given `TIMESTAMP` to `TIMESTAMPTZ` by interpreting it as local time in the time zone `time_zone_str`.

**Example:**
`SELECT TIMESTAMP '1996-09-03' at time zone 'Europe/Berlin' = TIMESTAMPTZ '1996-09-03 Europe/Berlin';  --> 1`

* `TIMESTAMPTZ AT TIME ZONE time_zone_str -> TIMESTAMP`:<br>
 Converts the given `TIMESTAMPTZ` to `TIMESTAMP` by transforming it from Unix time to local time in the time zone `time_zone_str`.
 
**Example:**
`SELECT TIMESTAMPTZ '1996-09-03 Europe/Berlin' AT TIME ZONE 'US/Pacific';  --> 1996-09-02 15:00:00`

The `AT TIME ZONE` construct cannot be used with values of type `DATE`.
However, you can explicitly cast a `DATE` value to `TIMESTAMP` and use the converted value instead.

### Comparison operators

The usual comparison operators are supported:

| Operator                     | Description              |
| :--------------------------- | :----------------------- |
| `TIMESTAMPTZ < TIMESTAMPTZ`  | Less than                |
| `TIMESTAMPTZ > TIMESTAMPTZ ` | Greater than             |
| `TIMESTAMPTZ <= TIMESTAMPTZ` | Less than or equal to    |
| `TIMESTAMPTZ >= TIMESTAMPTZ` | Greater than or equal to |
| `TIMESTAMPTZ = TIMESTAMPTZ`  | Equal to                 |
| `TIMESTAMPTZ <> TIMESTAMPTZ` | Not equal to             |

A `TIMESTAMPTZ` value is also comparable with a `DATE` or `TIMESTAMP` value:

* The `DATE` value is converted to the `TIMESTAMPTZ` type for comparison with a `TIMESTAMPTZ` value.
* The `TIMESTAMP` value is converted to the `TIMESTAMPTZ` type for comparison with a `TIMESTAMPTZ` value.

For more information, see [type conversions](#type-conversions).

### Arithmetic operators

`TIMESTAMPTZ` values can be used for arithmetic with intervals:

```sql
SET time_zone = 'Europe/Berlin';
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '1 day';  --> 2022-10-31 00:00:00+01
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '24' hour;  --> 2022-10-30 23:00:00+01

SET time_zone = 'US/Pacific';
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '1 day';  --> 2022-10-30 15:00:00-07
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '24' hour;  --> 2022-10-30 15:00:00-07
```

For more information, see [Arithmetic with intervals](interval-arithmetic.md).

## Serialization and deserialization

### Text, CSV, JSON
{:.no_toc}

In the text, CSV, and JSON format, a `TIMESTAMPTZ` value is shown as local time after conversion from Unix time using the time zone specified in the session's `time_zone` setting.
Time zone information using the session's `time_zone` setting is shown as a signed numeric offset from UTC (`hh` if it is an integral number of hours, `hh:mm` if it is an integral number of minutes, else `hh:mm:ss`), with a positive sign for zones east of Greenwich.
The date and time components are output as a `YYYY-MM-DD hh:mm:ss[.f]` string.
Firebolt outputs as few digits after the decimal separator as possible (at most six).
Input is accepted in one of the literal formats described above.

### Parquet
{:.no_toc}

`TIMESTAMPTZ` maps to Parquet's 64-bit signed integer `TIMESTAMP` type with the parameter `isAdjustedToUTC` set to `true` and `unit` set to `MICROS`, representing the number of microseconds before or after `1970-01-01 00:00:00.000000 UTC`.
It's also possible to import into a `TIMESTAMPTZ` column from Parquet's 64-bit signed integer `TIMESTAMP` type with the parameter `isAdjustedToUTC` set to `true` and the `unit` set to `MILLIS` or `NANOS`.
In this case, Firebolt implicitly extends or truncates to resolve in microseconds.

### Avro
{:.no_toc}

`TIMESTAMPTZ` maps to Avro's 64-bit signed integer `timestamp-micros` type, representing the number of microseconds before or after `1970-01-01 00:00:00.000000 UTC`.
It's also possible to import into a `TIMESTAMPTZ` column from Avro's `timestamp-millis` type.

### ORC

It's not possible to import directly from ORC into a `TIMESTAMPTZ` column; ORC's logical `TIMESTAMP` type is independent of a time zone and this would require a possibly unintended time zone conversion on import.
Instead, first import using a `TIMESTAMPNTZ` column and then use the `AT TIME ZONE` expression to convert to `TIMESTAMPTZ`.

## Data pruning

Columns of type `TIMESTAMPTZ` can be used in the `PRIMARY INDEX` and `PARTITION BY` clause of `CREATE TABLE` commands.
