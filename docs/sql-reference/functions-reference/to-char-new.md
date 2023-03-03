---
layout: default
title: TO_CHAR
description: Reference material for TO_CHAR function
parent: SQL functions
---

# TO_CHAR

Converts a `PGDATE`, `TIMESTAMPNTZ`, or a `TIMESTAMPTZ` data type to a formatted string.

## Syntax

```sql
TO_CHAR(<expression>, '<format>')
```

| Parameter      | Description                                                                                                                          |
| :------------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| `<expression>` | An expression that resolves to a value with a `PGDATE`, `TIMESTAMPNTZ`, or `TIMESTAMPTZ` data type, which will be converted to text. |
| `<format>`     | Output template string containing certain patterns that are recognized and replaced with appropriately-formatted data.               |

For descriptions of the accepted `<format>` patterns, see below.

| Format option     | Description                                                                                       | Example                                                  |
| :---------------- | :------------------------------------------------------------------------------------------------ | :------------------------------------------------------- |
| `HH12` or `HH`    | Hour of day (01–12)                                                                               | `to_char(current_timestamptz, 'hh12 HH'); --> '06 06'`   |
| `HH24`            | Hour of day (00–23)                                                                               | `to_char(current_timestamptz, 'HH24'); --> '18'`         |
| `MI`              | Minute (00–59)                                                                                    | `to_char(current_timestamptz, 'MI'); --> '24'`           |
| `SS`              | Second (00–59)                                                                                    | `to_char(current_timestamptz, 'HH24'); --> '58'`         |
| `SSSS` or `SSSSS` | Seconds past midnight (0–86399)                                                                   | `to_char(current_timestamptz, 'SSSS'); --> '41098'`      |
| `MS`              | Millisecond (000–999)                                                                             | `to_char(current_timestamptz, 'MS'); --> '085'`          |
| `US`              | Microsecond (000000–999999)                                                                       | `to_char(current_timestamptz, 'US'); --> '085109'`       |
| `Y,YYY`           | Year (4 or more digits) with comma Y,YYY                                                          | `to_char(current_timestamptz, 'Y,YYY'); --> '2,023'`     |
| `YYYY`            | Year (4 or more digits)                                                                           | `to_char(current_timestamptz, 'YYYY'); --> '2023'`       |
| `YYY`             | Last 3 digits of year                                                                             | `to_char(current_timestamptz, 'YYY'); --> '023'`         |
| `YY`              | Last 2 digits of year                                                                             | `to_char(current_timestamptz, 'YY'); --> '23'`           |
| `Y`               | Last digit of year                                                                                | `to_char(current_timestamptz, 'Y'); --> '3'`             |
| `IYYY`            | ISO 8601 week-numbering year (4 or more digits)                                                   | `to_char(current_timestamptz, 'IYYY'); --> '2023'`       |
| `IYY`             | Last 3 digits of ISO 8601 week-numbering year                                                     | `to_char(current_timestamptz, 'IYY'); --> '023'`         |
| `IY`              | Last 2 digits of ISO 8601                                                                         | `to_char(current_timestamptz, 'IY'); --> '23'`           |
| `I`               | Last digit of ISO 8601 week-numbering year                                                        | `to_char(current_timestamptz, 'I'); --> '3'`             |
| `MM`              | Month number (01–12)                                                                              | `to_char(current_timestamptz, 'MM'); --> '03'`           |
| `DDD`             | Day of year (001–366)                                                                             | `to_char(current_timestamptz, 'DDD'); --> '062'`         |
| `DD`              | Day of month (01–31)                                                                              | `to_char(current_timestamptz, 'DD'); --> '03'`           |
| `D`               | Day of the week, Sunday (1) to Saturday (7)                                                       | `to_char(current_timestamptz, 'D'); --> '6'`             |
| `ID`              | ISO 8601 day of the week, Monday (1) to Sunday (7)                                                | `to_char(current_timestamptz, 'ID'); --> '5'`            |
| `W`               | Week of month (1–5) (the first week starts on the first day of the month)                         | `to_char(current_timestamptz, 'W'); --> '1'`             |
| `WW`              | Week number of year (1–53) (the first week starts on the first day of the year)                   | `to_char(current_timestamptz, 'WW'); --> '09'`           |
| `IW`              | Week number of ISO 8601 week-numbering year (01–53) (the first Thursday of the year is in week 1) | `to_char(current_timestamptz, 'IW'); --> '09'`           |
| `CC`              | Century (2 digits) (the twenty-first century starts on 2001-01-01)                                | `to_char(current_timestamptz, 'CC'); --> '21'`           |
| `Q`               | Single digit quarter                                                                              | `to_char(current_timestamptz, 'Q'); --> '1'`             |
| `AM` or `PM`      | Meridiem indicator upper case without periods                                                     | `to_char(current_timestamptz, 'hhPM'); --> '5PM'`        |
| `am` or `pm`      | Meridiem indicator lower case without periods                                                     | `to_char(current_timestamptz, 'hham'); --> '9am'`        |
| `A.M.` or `P.M.`  | Meridiem indicator upper case with periods                                                        | `to_char(current_timestamptz, 'hhP.M.'); --> '9A.M.'`    |
| `a.m.` or `p.m.`  | Meridiem indicator lower case with periods                                                        | `to_char(current_timestamptz, 'hha.m.'); --> '5p.m.'`    |
| `MONTH`           | Full upper case month name (blank-padded to 9 chars)                                              | `to_char(current_timestamptz, 'MONTH'); --> 'MARCH    '` |
| `Month`           | Full capitalized month name (blank-padded to 9 chars)                                             | `to_char(current_timestamptz, 'Month'); --> 'August   '` |
| `month`           | Full lower case month name (blank-padded to 9 chars)                                              | `to_char(current_timestamptz, 'month'); --> 'September'` |
| `MON`             | Abbreviated upper case month name (3 chars)                                                       | `to_char(current_timestamptz, 'MON'); --> 'JUL'`         |
| `Mon`             | Abbreviated capitalized month name (3 chars)                                                      | `to_char(current_timestamptz, 'Mon'); --> 'Jan'`         |
| `mon`             | Abbreviated lower case month name (3 chars)                                                       | `to_char(current_timestamptz, 'mon'); --> 'dec'`         |
| `DAY`             | Full upper case day name (blank-padded to 9 chars)                                                | `to_char(current_timestamptz, 'DAY'); --> 'MONDAY   '`   |
| `Day`             | Full capitalized day name (blank-padded to 9 chars)                                               | `to_char(current_timestamptz, 'Day'); --> 'Tuesday  '`   |
| `day`             | Full lower case day name (blank-padded to 9 chars)                                                | `to_char(current_timestamptz, 'day'); --> 'wednesday'`   |
| `DY`              | Abbreviated upper case day name (3 chars in English)                                              | `to_char(current_timestamptz, 'DY'); --> 'THU'`          |
| `Dy`              | Abbreviated capitalized day name (3 chars in English)                                             | `to_char(current_timestamptz, 'Dy'); --> 'Fri'`          |
| `dy`              | Abbreviated lower case day name (3 chars in English)                                              | `to_char(current_timestamptz, 'dy'); --> 'sat'`          |
| `RM`              | Month in upper case Roman numerals (I–XII; I=January)                                             | `to_char(current_timestamptz, 'RM'); --> 'III'`          |
| `rm`              | Month in lower case Roman numerals (i–xii; i=January)                                             | `to_char(current_timestamptz, 'rm'); --> 'vi'`           |
| `AD` or `BC`      | Upper case era indicator without periods                                                          | `to_char(current_timestamptz, 'BC'); --> 'AD'`           |
| `ad` or `bc`      | lower case era indicator without periods                                                          | `to_char(current_timestamptz, 'ad'); --> 'ad'`           |
| `A.D.` or `B.C.`  | Upper case era indicator with periods                                                             | `to_char(current_timestamptz, 'A.D.'); --> 'A.D.'`       |
| `a.d.` or `b.c.`  | Upper case era indicator with periods                                                             | `to_char(current_timestamptz, 'b.c.'); --> 'a.d.'`       |
| `TZ`              | Upper case time-zone abbreviation                                                                 | `to_char(current_timestamptz, 'TZ'); --> 'PST'`          |
| `tz`              | Lower case time-zone abbreviation                                                                 | `to_char(current_timestamptz, 'tz'); --> 'pst'`          |
| `TZH`             | Time zone hours                                                                                   | `to_char(current_timestamptz, 'TZH'); --> '-08'`         |
| `TZM`             | Time zone minutes                                                                                 | `to_char(current_timestamptz, 'tzm'); --> '00'`          |
| `OF`              | Time zone offset from UTC                                                                         | `to_char(current_timestamptz, 'OF'); --> '-08:00'`       |

Additionally, modifiers can be applied to the template patterns above to alter their behavior.

| Format option | Description                                | Example                                                                                                                      |
| :------------ | :----------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| `FM` prefix   | Surpress leading zeroes and padding blanks | `to_char(current_pgdate, 'Month YYYY')` = `'March     2023'` <br> `to_char(current_pgdate, 'FMMonth YYYY')` = `'March 2023'` |
| `TH` suffix   | Upper case ordinal number suffix           | `'MMTH'` = `'7TH'`                                                                                                           |
| `th` suffix   | Lower case ordinal number suffix           | `'MMth'` = `'7th'`                                                                                                           |

Any character in the template string that is not recognized as a pattern is simply copied over without being replaced. Parts that are quoted `"` will be copied over independent of possibly valid patterns.
Templates are matched in lower and upper case if there is no other behavior described above.

## Examples

`select to_char(current_timestamptz, '"Date": FMMonth ddth, YYYY "Time": HH12am (mi:ss.us) OF (TZ)'); --> `

## Example

This example below extracts outputs the current local time in a formatted string. Note that the `"` around the words `Date` and `Time` are required as otherwise the characters `D` and `I` would be interpreted as valid templates which would result in the output `6ate` and `T3me`.

```sql
SELECT
    TO_CHAR(
        CURRENT_TIMESTAMPTZ,
        '"Date": FMMonth FMddth, YYYY "Time": FMHH12am (mi:ss.us) OF (TZ)'
    );
```

**Returns**: `'Date: March 3rd, 2023 Time: 6am (33:26.466511) -08:00 (PST)`
