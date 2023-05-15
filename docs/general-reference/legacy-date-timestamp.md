---
layout: default
title: Legacy date and timestamp types
description: Describes the legacy implementation of `DATE` and `TIMESTAMP` data types
nav_exclude: true
search_exclude: false
---

# Date and timestamp (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp types.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are already using the redesigned date and timestamp types and can find their documentation [here](data-types.md#date-and-timestamp).
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation.

Firebolt supports date- and time-related data types:

| Name                                  | Size    | Minimum                          | Maximum                          | Resolution    |
| :------------------------------------ | :------ | :------------------------------- | :------------------------------- | :------------ |
| `PGDATE` (synonym: `DATE`)            | 4 bytes | `0001-01-01`                     | `9999-12-31`                     | 1 day         |
| `TIMESTAMPNTZ` (synonym: `TIMESTAMP`) | 8 bytes | `0001-01-01 00:00:00.000000`     | `9999-12-31 23:59:59.999999`     | 1 microsecond |
| `TIMESTAMPTZ`                         | 8 bytes | `0001-01-01 00:00:00.000000 UTC` | `9999-12-31 23:59:59.999999 UTC` | 1 microsecond |

After DB version 3.22.0, new customers and those who have reingested data to use these types can use synonyms `DATE` and `TIMESTAMP` for types `PGDATE` and `TIMESTAMPNTZ` to use these supported types, but in the past these types names referred to legacy types: 

| Name                 | Size    | Minimum                          | Maximum                          | Resolution    |
| `DATE` (legacy)      | 2 bytes | `1970-01-01`                     | `2105-12-31`                     | 1 day         |
| `TIMESTAMP` (legacy) | 4 bytes | `1970-01-01 00:00:00`            | `2105-12-31 23:59.59`            | 1 second      |

Dates are counted according to the [proleptic Gregorian calendar](https://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar).
Each year consists of 365 days, with leap days added to February in leap years.

## PGDATE

A year, month, and day calendar date independent of a time zone.
For more information, see [DATE data type](date-data-type.md), but be aware that you need to use the name `PGDATE` every time the [DATE data type](date-data-type.md) document uses the name `DATE`, as that document assumes you have enabled synonyms for these new types. 

### Type conversions

The `PGDATE` data type can be cast to and from types as follows:

| To `PGDATE`          | Example                                                                          | Note                                                                                                                                                                                                |
| :------------------- | :------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PGDATE`             | `SELECT CAST(PGDATE '2023-02-13' as PGDATE); --> 2023-02-13`                     |                                                                                                                                                                                                     |
| `TIMESTAMPNTZ`       | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as PGDATE);  --> 2023-02-13`     | Truncates the timestamp to the date.                                                                                                                                                                |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPTZ '2023-02-13 Europe/Berlin' as PGDATE);  --> 2023-02-13` | Converts from Unix time to local time in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone), and then truncates the timestamp to the date. This example assumes `SET time_zone = 'UTC';`. |
| `NULL`               | `SELECT CAST(null as PGDATE);  --> NULL`                                         |                                                                                                                                                                                                     |
| `DATE` (legacy)      | `SELECT CAST(DATE '2023-02-13' as PGDATE);  --> 2023-02-13`                      | Converts from the legacy `DATE` type.                                                                                                                                                               |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMP '2023-02-13' as PGDATE);  --> 2023-02-13`                 | Converts from the legacy `TIMESTAMP` type.                                                                                                                                                          |

| From `PGDATE`   | Example                                                                      | Note                                                                                                                                               |
| :-------------- | :--------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMPNTZ`  | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPNTZ );  --> 2023-02-1 00:00:00` | Extends the date with `00:00:00`.                                                                                                                  |
| `TIMESTAMPTZ`   | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPTZ );  --> 2023-02-13`          | Interprets the date to be midnight in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone). This example assumes `SET time_zone = 'UTC';`. |
| `DATE` (legacy) | `SELECT CAST(PGDATE '2023-02-13' as DATE);  --> 2023-02-13`                  | Converts to the legacy `DATE` type, and throws an exception if the `PGDATE` value is outside of the supported range of a legacy `DATE` type.       |

## TIMESTAMPNTZ

A year, month, day, hour, minute, second, and microsecond timestamp independent of a time zone.
For more information, see [TIMESTAMP data type](timestampntz-data-type.md), but be aware that you need to use the name `TIMESTAMPNTZ` every time the [TIMESTAMP data type](timestampntz-data-type.md) document uses the name `TIMESTAMP`, as that document assumes you have enabled synonyms for these new types. 

### Type conversions

The `TIMESTAMPNTZ` data type can be cast to and from types as follows: 

| To `TIMESTAMPNTZ`    | Example                                                                                         | Note                                                                                                                                                                                                |
| :------------------- | :---------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMPNTZ`       | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMPNTZ); --> 2023-02-13 11:19:42`      |                                                                                                                                                                                                     |
| `PGDATE`             | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPNTZ);  --> 2023-02-13 00:00:00`                    | Extends the date with `00:00:00`.                                                                                                                                                                   |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPTZ '2023-02-13 Europe/Berlin' as TIMESTAMPNTZ);  --> 2023-02-13 22:00:00` | Converts from Unix time to local time in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone), and then truncates the timestamp to the date. This example assumes `SET time_zone = 'UTC';`. |
| `NULL`               | `SELECT CAST(null as TIMESTAMPNTZ);  --> NULL`                                                  |                                                                                                                                                                                                     |
| `DATE` (legacy)      | `SELECT CAST(DATE '2023-02-13' as TIMESTAMPNTZ);  --> 2023-02-13 00:00:00`                      | Converts from the legacy `DATE` type by extending with `00:00:00`.                                                                                                                                  |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMP '2023-02-13' as TIMESTAMPNTZ);  --> 2023-02-13`                          | Converts from the legacy `TIMESTAMP` type.                                                                                                                                                          |

| From `TIMESTAMPNTZ`  | Example                                                                                        | Note                                                                                                                                                         |
| :------------------- | :--------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PGDATE`             | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as PGDATE );  --> 2023-02-13`                  | Truncates the timestamp to the date.                                                                                                                         |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMPTZ );  --> 2023-02-13 11:19:42+00` | Interprets the timestamp to be local time in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone). This example assumes `SET time_zone = 'UTC';`.    |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMP);  --> 2023-02-13 11:19:42`       | Converts to the legacy `TIMESTAMP` type, and throws an exception if the `TIMESTAMPNTZ` value is outside of the supported range of a legacy `TIMESTAMP` type. |

## TIMESTAMPTZ

A year, month, day, hour, minute, second, and microsecond timestamp associated with a time zone.
For more information, see [TIMESTAMPTZ data type](timestamptz-data-type.md).
`TIMESTAMPTZ` is not a legacy data type, and is only available on DB versions after 3.19.0. 

### Type conversions

The `TIMESTAMPTZ` data type can be cast to and from types as follows (assuming `SET time_zone = 'UTC';`): 

| To `TIMESTAMPTZ`     | Example                                                                                                   | Note                                                                                                                                                      |
| :------------------- | :-------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TIMESTAMPTZ`        | `SELECT CAST(TIMESTAMPTZ '2023-02-13 11:19:42 Europe/Berlin' as TIMESTAMPTZ); --> 2023-02-13 09:19:42+00` |                                                                                                                                                           |
| `PGDATE`             | `SELECT CAST(PGDATE '2023-02-13' as TIMESTAMPTZ);  --> 2023-02-13 00:00:00+00`                            | Interprets the timestamp to be midnight in the time zone specified by the [session's `time_zone` setting](system-settings.md#set-time-zone).                                                  |
| `TIMESTAMPNTZ`       | `SELECT CAST(TIMESTAMPNTZ '2023-02-13 11:19:42' as TIMESTAMPTZ);  --> 2023-02-13 11:19:42+00`             | Interprets the timestamp to be local time in the time zone specified by the session's `time_zone` setting.                                                |
| `NULL`               | `SELECT CAST(null as TIMESTAMPTZ);  --> NULL`                                                             |                                                                                                                                                           |
| `DATE` (legacy)      | `SELECT CAST(DATE '2023-02-13' as TIMESTAMPTZ);  --> 2023-02-13 00:00:00+00`                              | Converts from the legacy `DATE` type by interpreting the timestamp to be midnight in the time zone specified by the session's `time_zone` setting.        |
| `TIMESTAMP` (legacy) | `SELECT CAST(TIMESTAMP '2023-02-13 11:19:42' as TIMESTAMPTZ);  --> 2023-02-13 11:19:42+00`                | Converts from the legacy `TIMESTAMP` type by interpreting the timestamp to be local time in the time zone specified by the session's `time_zone` setting. |

| From `TIMESTAMPTZ` | Example                                                                                                      | Note                                                                                                                                                |
| :----------------- | :----------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PGDATE`           | `SELECT CAST(TIMESTAMPTZ '2023-02-13 11:19:42 Europe/Berlin' as PGDATE);  --> 2023-02-13`                    | Converts from Unix time to local time in the time zone specified by the session's `time_zone` setting and then truncates the timestamp to the date. |
| `TIMESTAMPNTZ`     | `SELECT CAST(TIMESTAMPTZ '2023-02-13 11:19:42 Europe/Berlin' as TIMESTAMPNTZ );  --> 2023-02-13 11:19:42+00` | Convert from Unix time to local time in the time zone specified by the session's `time_zone` setting.                                               |

## DATE (legacy)

A year, month and day in the format *YYYY-MM-DD*. `DATE` is independent of a time zone. 

Arithmetic operations can be executed on `DATE` values. The examples below show the addition and subtraction of integers.

`CAST(‘2019-07-31' AS DATE) + 4`

Returns: `2019-08-04`

`CAST(‘2019-07-31' AS DATE) - 4`

Returns: `2019-07-27`

### Working with dates outside the allowed range
{:.no_toc}
Arithmetic, conditional, and comparative operations are not supported for date values outside the supported range. These operations return inaccurate results because they are based on the minimum and maximum dates in the range rather than the actual dates provided or expected to be returned. `PGDATE` data type has a much wider range, and we recommend using this type instead. 

The arithmetic operations in the examples below return inaccurate results as shown because the dates returned are outside the supported range.  

`CAST ('1970-02-02' AS DATE) - 365`  
Returns `1970-01-31`  

`CAST ('2105-02-012' AS DATE) + 365`  
Returns `2105-12-31`  

If you work with dates outside the supported range, we recommend that you use a string datatype such as `TEXT`. For example, the following query returns all rows with the date `1921-12-31`.

```sql
SELECT
  *
FROM
  tab1text
WHERE
  date_as_text = '1921-12-31';
```

The example below selects all rows where the `date_as_text` column specifies a date after `1921-12-31`.

```sql
SELECT
  *
FROM
  tab1text
WHERE
  date_as_text > '1921-12-31';
```

The example below generates a count of how many rows in `date_as_text` are from each month of the year. It uses `SUBSTR` to extract the month value from the date string, and then it groups the count by month.

```sql
SELECT
  COUNT(), SUBSTR(date_as_text,6,2)
FROM
  tab1text
GROUP BY
  SUBSTR(date_as_text,6,2);
```

## TIMESTAMP (legacy)

A year, month, day, hour, minute and second in the format *YYYY-MM-DD hh:mm:ss*. We recommend using new `TIMESTAMPNTZ` type instead. 

The minimum `TIMESTAMP` value is `1970-01-01 00:00:00`. The maximum `TIMESTAMP` value is `2105-12-31 23:59.59`

Synonyms: `DATETIME`

## Legacy date and timestamp functions

Functions have been redesigned to support new date and timestamp types. Determine how to adjust scripts to use supported functions for new date and timestamp types using the following table. 

| Legacy function   | New function | 
| :----------------- | :----------- |
| [CURRENT\_PGDATE](../sql-reference/functions-reference/current-pgdate.md) | [CURRENT_DATE](../sql-reference/functions-reference/current-date.md) |
| [CURRENT\_TIMESTAMP (legacy)](../sql-reference/functions-reference/current-timestamp.md) | [CURRENT_TIMESTAMP](../sql-reference/functions-reference/current-timestamptz.md) | 
| [DATE\_FORMAT](../sql-reference/functions-reference/date-format.md) | [TO_CHAR](../sql-reference/functions-reference/to-char-new.md) |
| [DATE\_TRUNC (legacy)](../sql-reference/functions-reference/date-trunc.md) | [DATE\_TRUNC](../sql-reference/functions-reference/date-trunc-new.md) | 
| [EXTRACT (legacy)](../sql-reference/functions-reference/extract.md) | [EXTRACT](../sql-reference/functions-reference/extract-new.md)
| [FROM\_UNIXTIME](../sql-reference/functions-reference/from-unixtime.md) | [TO_TIMESTAMPTZ](../sql-reference/functions-reference/to-timestamptz.md) |
| [LOCALTIMESTAMPNTZ](../sql-reference/functions-reference/localtimestampntz.md) | [LOCALTIMESTAMP](../sql-reference/functions-reference/localtimestamp.md) | 
| [NOW](../sql-reference/functions-reference/now.md) | [LOCALTIMESTAMP](../sql-reference/functions-reference/localtimestamp.md) |
| [TIMEZONE](../sql-reference/functions-reference/timezone.md) | Use [`time_zone` setting](../general-reference/system-settings.md#set-time-zone) instead | 
| [TO_CHAR (legacy)](../sql-reference/functions-reference/to-char.md) | [TO_CHAR](../sql-reference/functions-reference/to-char-new.md) |
| [TO\_DATE (legacy)](../sql-reference/functions-reference/to-date.md) | [TO_DATE](../sql-reference/functions-reference/to-date-new.md) |
| [TO\_DAY\_OF\_WEEK](../sql-reference/functions-reference/to-day-of-week.md) | Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_DAY\_OF\_YEAR](../sql-reference/functions-reference/to-day-of-year.md) | Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_HOUR](../sql-reference/functions-reference/to-hour.md)| Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_MINUTE](../sql-reference/functions-reference/to-minute.md)| Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_MONTH](../sql-reference/functions-reference/to-month.md)| Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_QUARTER](../sql-reference/functions-reference/to-quarter.md)| Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_SECOND](../sql-reference/functions-reference/to-second.md)| Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_TEXT](../sql-reference/functions-reference/to-text.md) | Use [CAST](../sql-reference/functions-reference/cast.md) instead |
| [TO\_TIMESTAMP (legacy)](../sql-reference/functions-reference/to-timestamp.md) | [TO_TIMESTAMP](../sql-reference/functions-reference/to-timestamp-new.md) |
| [TO\_UNIX\_TIMESTAMP](../sql-reference/functions-reference/to-unix-timestamp.md) | Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_UNIXTIME](../sql-reference/functions-reference/to-unixtime.md)|  Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_WEEK](../sql-reference/functions-reference/to-week.md) | Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_WEEKISO](../sql-reference/functions-reference/to-weekiso.md) | Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
| [TO\_YEAR](../sql-reference/functions-reference/to-year.md) | Use [EXTRACT](../sql-reference/functions-reference/extract-new.md) instead | 
