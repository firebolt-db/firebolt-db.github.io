---
layout: default
title: TO_TIMESTAMP
description: Reference material for TO_TIMESTAMP function
parent: SQL functions
---

# TO_TIMESTAMP

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](../../general-reference/egacy-date-timestamp.md#legacy-date-and-timestamp-functions), or instructions to use the new types [here](../../release-notes/release-notes-archive.html#db-version-322).

Converts a string to `TIMESTAMPTZ` type (i.e., timestamp with time zone) using format.

{: .note}
The functions returns the new date data type `TIMESTAMPTZ`. If you seek for the old type, see [TO_TIMESTAMP (legacy)](../functions-reference/to-timestamp.md).

## Syntax

```sql
TO_TIMESTAMP(<expression> [,'<format>'])
```

| Parameter      | Description                                                                                                                                                                                                                                                                                                                                | Supported input types |
| :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------- |
| `<expression>` | The text to convert to a timestamp with time zone. If no optional `<format>` argument is given that can be use to parse the `<expression>`, the following format is required: any supported date format directly followed by `( \|T)[H]H:[m]m:[S]S[.F]`. (For supported date formats see [TO_DATE](../functions-reference/to-date-new.md)) | `TEXT`                |
| `<format>`     | Optional. A string literal that specifies the format of the `<expression>` to convert.                                                                                                                                                                                                                                                     | `TEXT` (see below)    |

Accepted `<format>` patterns include the following specifications:

| Format option    | Description                                        | Example                                                              |
| :--------------- | :------------------------------------------------- | :------------------------------------------------------------------- |
| `YYYY`           | Year (4 or more digits)                            | `TO_TIMESTAMP('2023', 'YYYY'); --> '2023-01-01 00:00:00+00'`         |
| `YYY`            | Last 3 digits of year                              | `TO_TIMESTAMP('2023', 'YYY'); --> '2023-01-01 00:00:00+00'`          |
| `YY`             | Last 2 digits of year                              | `TO_TIMESTAMP('2023', 'YY'); --> '2023-01-01 00:00:00+00'`           |
| `Y`              | Last digit of year                                 | `TO_TIMESTAMP('2023', 'Y'); --> '2023-01-01 00:00:00+00'`            |
| `MONTH`          | Full month name (case insensitive)                 | `TO_TIMESTAMP('august', 'MONTH'); --> '0001-08-01 00:00:00+00'`      |
| `MON`            | abbreviated month name (3 chars, case insensitive) | `TO_TIMESTAMP('dec', 'MON'); --> '0001-12-01 00:00:00+00'`           |
| `MM`             | Month number (01–12)                               | `TO_TIMESTAMP('7', 'MM'); --> '0001-07-01 00:00:00+00'`              |
| `DD`             | Day of month (01–31)                               | `TO_TIMESTAMP('15', 'DD'); --> '0001-01-15 00:00:00+00'`             |
| `HH` or `HH12`   | Hour of day (01–12)                                | `TO_TIMESTAMP('8', 'hh'); --> '0001-01-01 08:00:00+00'`              |
| `HH24`           | Hour of day (00–23)                                | `TO_TIMESTAMP('18', 'hh24'); --> '0001-01-01 18:00:00+00'`           |
| `MI`             | Minute (00–59)                                     | `TO_TIMESTAMP('35', 'hh'); --> '0001-01-01 00:35:00+00'`             |
| `SS`             | Second (00–59)                                     | `TO_TIMESTAMP('52', 'hh'); --> '0001-01-01 00:00:52+00'`             |
| `MS`             | Millisecond (000–999)                              | `TO_TIMESTAMP('89', 'ms'); --> '0001-01-01 08:00:00.89+00'`          |
| `US`             | Microsecond (000000–999999)                        | `TO_TIMESTAMP('04852', 'hh'); --> '0001-01-01 08:00:00.04852+00'`    |
| `AM` or `PM `    | meridiem indicator (without periods)               | `TO_TIMESTAMP('5 am', 'hh PM'); --> '0001-01-01 05:00:00+00+00'`     |
| `A.M.` or `P.M.` | meridiem indicator (with periods)                  | `TO_TIMESTAMP('5 p.m.', 'hh A.M.'); --> '0001-01-01 17:00:00+00'`    |
| `TZH`            | Time zone hours                                    | `TO_TIMESTAMP('12 -2', 'hh24 TZH'); --> '0001-01-01 14:00:00+00+00'` |
| `TZM`            | Time zone minutes                                  | `TO_TIMESTAMP('12 45', 'hh24 TZM'); --> '0001-01-01 11:15:00+00`     |

**Usage notes for formatting**

- Case letters in the input `<expression>` are ignored
- A separator (non-digit and non-letter) in the `<format>` string will match exactly one separator or is skipped
- Any non-separator in the `<format>` that is not part of a format option will match exactly one other character.
- Any character in quotes `"` will match exactly one other character.
- If the year format specification is `'YYY'`, `'YY'`, or `'Y'` and the supplied year is less than four digits, the year will be adjusted to be nearest to the year 2020, (e.g., `80` becomes `1980`).
- Milliseconds and microseconds are interpreted as subseconds in the form `ss.xxx[xxx]`. This means that `TO_TIMESTAMP('30.7', 'SS.MS')` is not 7 milliseconds, but 700, because it will be treated as 30 + 0.7 seconds. To achieve 7 milliseconds, one ust write `30.007` instead.
- Modifiers (e.g., `'FM'`) are not supported.

## Examples

The example below shows our separators and non-separators can cause skips. The separator `' '` (space) in the `<format>` matches the other separator `'/'` in the `<expression>`. The non-separator `'x'` will match any other character, in this case the `'a'`. Lastly, the two separators `'++'` will match up to two other separators, here the first `'x'` matches `'.'` while the second `'x'` will simply be ignored as no other separators follow.

```sql
SELECT
    TO_TIMESTAMP(
        '2023/aJUN.23',
        'YYYY xMON++DD'
    );
```

**Returns**: `'2023-06-23 00:00:00+00'`

The example below shows how the year is adjusted to be nearest to 2020 because `YYY` was used to match a less than four digit number. To receive the exact year `'180'` use `YYYY` instead.
Furthermore, as the three separators are quotes `"..."` they will match any character (separator or non-separator) which in this case is `'ar '`.

```sql
SELECT
    TO_TIMESTAMP(
        'Year 180: August 4th',
        'xx"..."yyy: month DDxx'
    );
```

**Returns**: `'2180-08-04 00:00:00+00'`

```sql
SELECT
    TO_TIMESTAMP(
        'Date: August 2nd, 2023 at 3pm +2',
        'Date: month DDxx, YYYY at HH12am TZH'
    );
```

**Returns**: `'2023-08-02 13:00:00+00'`

```sql
SELECT
    TO_TIMESTAMP(
        'h:19 m:34 s:29 ms:035 us:000123',
        'X:hh24 X:mi X:ss XX:ms XX:us'
    );
```

**Returns**: `'0001-01-01 19:34:29.035123+00'`
