---
layout: default
title: EXTRACT
description: Reference material for the EXTRACT function
parent: SQL functions
---

# EXTRACT

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](../../general-reference/legacy-date-timestamp.md#legacy-date-and-timestamp-functions), or instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).

Retrieves the time unit, such as `year` or `hour`, from a `PGDATE`, `TIMESTAMPNTZ`, or `TIMESTAMPTZ` value.

{: .note}
The functions works with new `PGDATE`, `TIMESTAMPTZ`, and `TIMESTAMPNTZ` data types. If you are using legacy `DATE` and `TIMESTAMP` data types, see [EXTRACT (legacy)](../functions-reference/extract.md).

## Syntax
{: .no_toc}

```sql
EXTRACT(<time_unit> FROM <expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                                  |Supported input types |
| :-------- | :------------------------------------------- | :---------------------------------------------------------------- |
| `<time_unit>`   | The time unit to extract from the expression.       | `microseconds`, `milliseconds`, `second`, `minute`, `hour`, `day`, `week`, `month`, `quarter`, `year`, `decade`, `century`, `millennium` (unquoted)             |
| `<expression>`  | The expression from which the time unit is extracted. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` |

`TIMESTAMPTZ` values are converted from Unix time to local time according to the session's `time_zone` setting before extracting the `time_unit`.
The set of allowed `time_unit` values depends on the data type of `<expression>`.
Furthermore, the return type depends on the `time_unit`.

### Time Units

| Unit      | Description                            | Supported input types  | Return type  | Example |
| -------- | --------------------------------------- | ---------------------- | ------------ | ------- |
| `century` | Extract the century. The first century starts on `0001-01-01` and ends on `0100-12-31` (inclusive). | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(century FROM TIMESTAMPNTZ '0100-12-31');  --> 1` |
| `day` | Extract the day (of the month) field. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(day FROM PGDATE '2001-02-16');  --> 16` |
|`decade` | Extract the year field divided by 10. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(decade FROM PGDATE '0009-12-31');  --> 0` |
| `dow` | Extract the day of the week as Sunday (0) to Saturday (6). | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(dow FROM PGDATE '2022-10-13');  --> 4` |
| `doy` | Extract the day of the year (1–365/366). | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(doy FROM PGDATE '1972-02-29');  --> 60` |
| `epoch` | For `TIMESTAMPTZ`, extract the number of seconds since `1970-01-01 00:00:00 UTC`. For `TIMESTAMPNTZ`, extract the number of seconds since `1970-01-01 00:00:00` independent of a time zone. `PGDATE` expressions are implicitly converted to `TIMESTAMPNTZ`. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `NUMERIC(38, 6)` | `SELECT EXTRACT(epoch FROM TIMESTAMPNTZ '2001-02-16 20:38:40.12');  --> 982355920.120000` |
| `hour` | Extract the hour field (0–23). | `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(hour FROM TIMESTAMPNTZ '2001-02-16 20:38:40.12');  --> 20` |
| `isodow` | Extract the day of the week as Monday (1) to Sunday (7). | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(isodow FROM PGDATE '2022-10-13');  --> 4` |
| `isoyear` | Extract the ISO 8601 week-numbering year that the date falls in. Each ISO 8601 week-numbering year begins with the Monday of the week containing the 4th of January; so in early January or late December the ISO year may be different from the Gregorian year. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(isoyear FROM PGDATE '2006-01-01');  --> 2005` |
| `microseconds` | Extract the seconds field, including fractional parts, multiplied by 1,000,000. | `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(microseconds FROM TIMESTAMPNTZ '2001-02-16 20:38:40.12');  --> 40120000` |
| `millennium` | Extract the millennium. The third millennium started on 2001-01-01. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(millennium FROM TIMESTAMPNTZ '1000-12-31 23:59:59.999999');  --> 1` |
| `milliseconds` | Extract the seconds field, including fractional parts, multiplied by 1,000. | `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `NUMERIC(8, 3)` | `SELECT EXTRACT(milliseconds FROM TIMESTAMPNTZ '2001-02-16 20:38:40.12');  --> 40120.000` |
| `minute` | Extract the minutes field (0–59). | `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(minute FROM TIMESTAMPNTZ '1000-12-31 23:42:59');  --> 42` |
| `month` | Extract the number of the month within the year (1–12). | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(month FROM PGDATE '1000-12-31');  --> 12` |
| `quarter` | Extract the quarter of the year (1–4) that the date is in:<br>`[01, 03] -> 1`<br>`[04, 06] -> 2`<br>`[07, 09] -> 3`<br>`[10, 12] -> 4` | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(quarter FROM PGDATE '1000-10-31');  --> 4` |
| `second` | Extract the second's field, including fractional parts. | `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `NUMERIC(8, 6)` | `SELECT EXTRACT(second FROM TIMESTAMPNTZ '2001-02-16 20:38:40.12');  --> 40.120000` |
| `timezone` | Extract the time zone offset from UTC, measured in seconds, with a positive sign for zones east of Greenwich. | `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(timezone FROM TIMESTAMPTZ '2022-11-29 13:58:23 Europe/Berlin');  --> -28800` (assumes set time zone is 'US/Pacific') |
| `timezone_hour` | Extract the hour component of the time zone offset. | `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(timezone_hour FROM TIMESTAMPTZ '2022-11-29 13:58:23 Europe/Berlin');  --> -8` (assumes set time zone is 'US/Pacific') |
| `timezone_minute` | Extract the minute component of the time zone offset. | `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(timezone_minute FROM TIMESTAMPTZ '2022-11-29 13:58:23 Europe/Berlin');  --> 0` (assumes set time zone is 'US/Pacific') |
| `week` | Extract the number of the ISO 8601 week-numbering week of the year. By definition, ISO weeks start on Mondays and the first week of a year contains January 4 of that year. It is possible for early-January dates to be part of the 52nd or 53rd week of the previous year, and for late-December dates to be part of the first week of the next year. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ`. | `INTEGER` | `SELECT EXTRACT(week FROM PGDATE '2005-01-01');  --> 53`<br>`SELECT EXTRACT(week from PGDATE '2006-01-01');  --> 52` |
| `year` | Extract the year field. | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` | `INTEGER` | `SELECT EXTRACT(year FROM TIMESTAMP '2001-02-16');  --> 2001`

## Remarks
{: .no_toc}

The `EXTRACT` function can be used in the `PARTITION BY` clause of `CREATE TABLE` commands.

```sql
CREATE DIMENSION TABLE test (
  d PGDATE,
  t TIMESTAMPNTZ
)
PARTITION BY EXTRACT(month FROM d), EXTRACT(hour FROM t);
```
