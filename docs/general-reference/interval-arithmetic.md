---
layout: default
title: Arithmetic with intervals
description: Describes the Firebolt implementation of arithmetic with intervals
nav_exclude: true
search_exclude: false
---

# Arithmetic with intervals
{:.no_toc}

This topic describes the Firebolt implementation of arithmetic with intervals.

* Topic ToC
{:toc}

## Overview

An `interval` represents a duration. In Firebolt, values of type `interval` can be used to add or subtract a duration to/from a date or timestamp.
`Interval` cannot be used as the data type of a column.

The `+` operators shown below come in commutative pairs (e.g., both `PGDATE + interval` and `interval + PGDATE` are accepted). Although the arithmetic operators check that the resulting timestamp is in the supported range, they don't check for integer overflow.

| Operator                                  | Description                                  |
| :---------------------------------------- | :------------------------------------------- |
| `PGDATE + interval -> TIMESTAMPNTZ`       | Add an `interval` to a `PGDATE`              |
| `PGDATE - interval -> TIMESTAMPNTZ`       | Subtract an `interval` from a `PGDATE`       |
| `TIMESTAMPNTZ + interval -> TIMESTAMPNTZ` | Add an `interval` to a `TIMESTAMPNTZ`        |
| `TIMESTAMPNTZ - interval -> TIMESTAMPNTZ` | Subtract an `interval` from a `TIMESTAMPNTZ` |
| `TIMESTAMPTZ + interval -> TIMESTAMPTZ`   | Add an `interval` to a `TIMESTAMPTZ`         |
| `TIMESTAMPTZ - interval -> TIMESTAMPTZ`   | Subtract an `interval` from a `TIMESTAMPTZ`  |

## Literal string interpretation

`Interval` literals can be specified in two formats. 

### First format

```sql
interval 'quantity unit [quantity unit...] [direction]'
```

where `direction` can be `ago` or empty (`ago` negates all the quantities), `quantity` is a possibly signed integer, and `unit` is one of the following, matched case-insensitively:

| Unit                 |      Minimum |     Maximum | 
| :------------------- | -----------: | ----------: | 
| microsecond[s] / us    | `-999999999` | `999999999` |
| millisecond[s] / ms    | `-999999999` | `999999999` |
| second[s] / s          | `-999999999` | `999999999` |
| minute[s] / m          | `-999999999` | `999999999` |
| hour[s] / h            | `-999999999` | `999999999` |
| day[s] / d             | `-999999999` | `999999999` |
| week[s] / w            | `-999999999` | `999999999` |
| month[s] / mon[s]      | `-999999999` | `999999999` |
| year[s] / y            |  `-99999999` |  `99999999` |
| decade[s] / dec[s]     |   `-9999999` |   `9999999` |
| century / centuries / c |   `-999999` |    `999999` |
| millennium[s] / mil[s] |     `-99999` |     `99999` |

Each `unit` can appear only once in an interval literal. 
Not all months have the same number of days.
Additionally, not all days consist of 24 hours because of daylight savings time transitions for `TIMESTAMPTZ`.
For instance, `SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '1 day'` returns `2022-10-31 00:00:00+01` but `SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '24 hours'` returns `2022-10-30 23:00:00+01` (assuming the value of the session's `time_zone` setting is `'Europe/Berlin'`).

The value of the interval is determined by adding the quantities of the specified units with the appropriate signs, and an interval literal is valid if:

1. The quantities used for `millennium`, `century`, `decade`, `year`, and `month` can be represented as a number of months in the range `[-pow(2, 31), pow(2, 31) - 1]`,
2. The quantities used for `week` and `day` can be represented as a number of days in the range `[-pow(2, 31), pow(2, 31) - 1]`,
3. The quantities used for `hour`, `minute`, `second`, `millisecond`, and `microsecond` can be represented as a number of microseconds in the range `[-pow(2, 63), pow(2, 63) - 1]`.

### Second format

```sql
interval 'N' unit
```

where `N` is a possibly signed integer, and `unit` is one of the following, matched case-insensitively:

| Unit   |  Minimum `N` |  Maximum `N`|
| :----- | -----------: | ----------: |
| second | `-999999999` | `999999999` |
| minute | `-999999999` | `999999999` |
| hour   | `-999999999` | `999999999` |
| day    | `-999999999` | `999999999` |
| week   | `-999999999` | `999999999` |
| month  | `-999999999` | `999999999` |
| year   |  `-99999999` |  `99999999` |

## Arithmetic between interval and TIMESTAMPTZ

Interval arithmetic with `TIMESTAMPTZ` values works as follows:

1. Convert the `TIMESTAMPTZ` value from Unix time to local time according to the rules of the time zone specified by the session's `time_zone` setting.
2. Add the months and days components of the interval to the local time.
3. Convert the local time back to Unix time according to the rules of the time zone specified by the session's `time_zone` setting.
4. Add the microseconds component of the interval to the Unix time.

The back and forth between Unix time and local time is necessary to handle the fact that not all days consist of 24 hours due to daylight savings time transitions.
Still, the dependence on the session's `time_zone` setting should be kept in mind when doing arithmetic between interval and `TIMESTAMPTZ`.

## Examples

```sql
SELECT PGDATE '1996-09-03' - interval '1 millennium 5 years 42 day 42 ms';  --> 0991-07-22 23:59:59.958
SELECT TIMESTAMPNTZ '1996-09-03 11:19:42' + interval '10 years 5 months 42 days 7 seconds';  --> 2007-03-17 11:19:49

-- The following example shows a daylight savings time change in the time zone 'Europe/Berlin'
SET time_zone = 'Europe/Berlin';
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '1 day';  --> 2022-10-31 00:00:00+01
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '24' hour;  --> 2022-10-30 23:00:00+01

SET time_zone = 'US/Pacific';
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '1 day';  --> 2022-10-30 15:00:00-07
SELECT TIMESTAMPTZ '2022-10-30 Europe/Berlin' + interval '24' hour;  --> 2022-10-30 15:00:00-07
```
