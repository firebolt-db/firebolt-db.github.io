---
layout: default
title: TO_CHAR
description: Reference material for TO_CHAR function
parent: SQL functions
---

# TO_CHAR

Converts a value of type `PGDATE`, `TIMESTAMPNTZ`, or `TIMESTAMPTZ` to a formatted string.

## Syntax

```sql
TO_CHAR(<expression>, '<format>')
```

| Parameter      | Description                                                                  | Supported input types                   |
| :------------- | :--------------------------------------------------------------------------- | :-------------------------------------- |
| `<expression>` | A date or time expression to be converted to text.                           | `PGDATE`, `TIMESTAMPNTZ`, `TIMESTAMPTZ` |
| `<format>`     | A string literal that specifies the format of the `<expression>` to convert. | See below                               |

Accepted `<format>` patterns include:

| Format option     | Description                                                                                       | Example                                                  |
| :---------------- | :------------------------------------------------------------------------------------------------ | :------------------------------------------------------- |
| `HH12` or `HH`    | Hour of day (01–12)                                                                               | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'hh12 HH'); --> '06 06'`   |
| `HH24`            | Hour of day (00–23)                                                                               | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'HH24'); --> '18'`         |
| `MI`              | Minute (00–59)                                                                                    | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'MI'); --> '24'`           |
| `SS`              | Second (00–59)                                                                                    | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'HH24'); --> '58'`         |
| `SSSS` or `SSSSS` | Seconds past midnight (0–86399)                                                                   | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'SSSS'); --> '41098'`      |
| `MS`              | Millisecond (000–999)                                                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'MS'); --> '085'`          |
| `US`              | Microsecond (000000–999999)                                                                       | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'US'); --> '085109'`       |
| `Y,YYY`           | Year (4 or more digits) with comma Y,YYY                                                          | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Y,YYY'); --> '2,023'`     |
| `YYYY`            | Year (4 or more digits)                                                                           | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'YYYY'); --> '2023'`       |
| `YYY`             | Last 3 digits of year                                                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'YYY'); --> '023'`         |
| `YY`              | Last 2 digits of year                                                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'YY'); --> '23'`           |
| `Y`               | Last digit of year                                                                                | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Y'); --> '3'`             |
| `IYYY`            | ISO 8601 week-numbering year (4 or more digits)                                                   | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'IYYY'); --> '2023'`       |
| `IYY`             | Last 3 digits of ISO 8601 week-numbering year                                                     | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'IYY'); --> '023'`         |
| `IY`              | Last 2 digits of ISO 8601                                                                         | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'IY'); --> '23'`           |
| `I`               | Last digit of ISO 8601 week-numbering year                                                        | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'I'); --> '3'`             |
| `MM`              | Month number (01–12)                                                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'MM'); --> '03'`           |
| `DDD`             | Day of year (001–366)                                                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'DDD'); --> '062'`         |
| `DD`              | Day of month (01–31)                                                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'DD'); --> '03'`           |
| `D`               | Day of the week, Sunday (1) to Saturday (7)                                                       | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'D'); --> '6'`             |
| `ID`              | ISO 8601 day of the week, Monday (1) to Sunday (7)                                                | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'ID'); --> '5'`            |
| `W`               | Week of month (1–5) (the first week starts on the first day of the month)                         | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'W'); --> '1'`             |
| `WW`              | Week number of year (1–53) (the first week starts on the first day of the year)                   | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'WW'); --> '09'`           |
| `IW`              | Week number of ISO 8601 week-numbering year (01–53) (the first Thursday of the year is in week 1) | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'IW'); --> '09'`           |
| `CC`              | Century (2 digits) (the twenty-first century starts on 2001-01-01)                                | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'CC'); --> '21'`           |
| `Q`               | Single digit quarter                                                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Q'); --> '1'`             |
| `AM` or `PM`      | Meridiem indicator upper case without periods                                                     | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'hhPM'); --> '5PM'`        |
| `am` or `pm`      | Meridiem indicator lower case without periods                                                     | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'hham'); --> '9am'`        |
| `A.M.` or `P.M.`  | Meridiem indicator upper case with periods                                                        | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'hhP.M.'); --> '9A.M.'`    |
| `a.m.` or `p.m.`  | Meridiem indicator lower case with periods                                                        | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'hha.m.'); --> '5p.m.'`    |
| `MONTH`           | Full upper case month name (blank-padded to 9 chars)                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'MONTH'); --> 'MARCH    '` |
| `Month`           | Full capitalized month name (blank-padded to 9 chars)                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Month'); --> 'August   '` |
| `month`           | Full lower case month name (blank-padded to 9 chars)                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'month'); --> 'September'` |
| `MON`             | Abbreviated upper case month name (3 chars)                                                       | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'MON'); --> 'JUL'`         |
| `Mon`             | Abbreviated capitalized month name (3 chars)                                                      | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Mon'); --> 'Jan'`         |
| `mon`             | Abbreviated lower case month name (3 chars)                                                       | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'mon'); --> 'dec'`         |
| `DAY`             | Full upper case day name (blank-padded to 9 chars)                                                | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'DAY'); --> 'MONDAY   '`   |
| `Day`             | Full capitalized day name (blank-padded to 9 chars)                                               | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Day'); --> 'Tuesday  '`   |
| `day`             | Full lower case day name (blank-padded to 9 chars)                                                | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'day'); --> 'wednesday'`   |
| `DY`              | Abbreviated upper case day name (3 chars in English)                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'DY'); --> 'THU'`          |
| `Dy`              | Abbreviated capitalized day name (3 chars in English)                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'Dy'); --> 'Fri'`          |
| `dy`              | Abbreviated lower case day name (3 chars in English)                                              | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'dy'); --> 'sat'`          |
| `RM`              | Month in upper case Roman numerals (I–XII; I=January)                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'RM'); --> 'III'`          |
| `rm`              | Month in lower case Roman numerals (i–xii; i=January)                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'rm'); --> 'vi'`           |
| `AD` or `BC`      | Upper case era indicator without periods                                                          | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'BC'); --> 'AD'`           |
| `ad` or `bc`      | lower case era indicator without periods                                                          | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'ad'); --> 'ad'`           |
| `A.D.` or `B.C.`  | Upper case era indicator with periods                                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'A.D.'); --> 'A.D.'`       |
| `a.d.` or `b.c.`  | Upper case era indicator with periods                                                             | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'b.c.'); --> 'a.d.'`       |
| `TZ`              | Upper case time-zone abbreviation                                                                 | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'TZ'); --> 'PST'`          |
| `tz`              | Lower case time-zone abbreviation                                                                 | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'tz'); --> 'pst'`          |
| `TZH`             | Time zone hours                                                                                   | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'TZH'); --> '-08'`         |
| `TZM`             | Time zone minutes                                                                                 | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'tzm'); --> '00'`          |
| `OF`              | Time zone offset from UTC                                                                         | `TO_CHAR(CURRENT_TIMESTAMPTZ, 'OF'); --> '-08:00'`       |

Additionally, modifiers can be applied to the format patterns above to alter their behavior.

| Format option | Description                                | Example                                                                                                                      |
| :------------ | :----------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| `FM` prefix   | Surpress leading zeroes and padding blanks | `TO_CHAR(CURRENT_PGDATE, 'Month YYYY')` = `'March     2023'` <br> `TO_CHAR(CURRENT_PGDATE, 'FMMonth YYYY')` = `'March 2023'` |
| `TH` suffix   | Upper case ordinal number suffix           | `'MMTH'` = `'7TH'`                                                                                                           |
| `th` suffix   | Lower case ordinal number suffix           | `'MMth'` = `'7th'`                                                                                                           |

Any character in the format string that is not recognized as a pattern is simply copied over without being replaced. Parts that are quoted `"` will be copied over independent of possibly valid patterns.
Patterns are matched in lower and upper case if there is no other behavior described above.

## Examples

`SELECT TO_CHAR(CURRENT_TIMESTAMPTZ, '"Date": FMMonth ddth, YYYY "Time": HH12am (mi:ss.us) OF (TZ)'); --> `

## Example

The example below outputs the current local time in a formatted string. Note that the `"` around the words `Date` and `Time` are required, otherwise the characters `D` and `I` would be interpreted as valid patterns which would result in the output `6ate` and `T3me`.

```sql
SET time_zone = 'America/Vancouver';
SELECT
    TO_CHAR(
        CURRENT_TIMESTAMPTZ,
        '"Date": FMMonth FMddth, YYYY "Time": FMHH12am (mi:ss.us) OF (TZ)'
    );
```

**Returns**: `'Date: March 3rd, 2023 Time: 6am (33:26.466511) -08:00 (PST)'`

The example below outputs the current date in a formatted string with any time field set to `0` which indicates midnight. Note the quotation marks again that are required to prevent unintended replacements.

```sql
SELECT
    TO_CHAR(
        current_pgdate,
        '"The" fmDDDth "day in" YY "is a" fmDay "at midnight" hh24:mi:ss.us'
    );
```

**Returns**: `'The 62th day in 23 is a Friday at midnight 00:00:00.000000'`
