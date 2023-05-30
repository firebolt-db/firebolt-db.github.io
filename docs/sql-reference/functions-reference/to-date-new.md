---
layout: default
title: TO_DATE
description: Reference material for TO_DATE function
parent: SQL functions
---

# TO_DATE

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](../../general-reference/legacy-date-timestamp.md#legacy-date-and-timestamp-functions), or instructions to use the new types [here](../../release-notes/release-notes-archive.html#db-version-322).

Converts a string to `DATE` type using format.

## Syntax

```sql
TO_DATE(<expression> [,'<format>'])
```

| Parameter      | Description                                                                                                                                                                                                                                                                                                                                                                         | Supported input types |
| :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------- |
| `<expression>` | The text to convert to a date. If no optional `<format>` argument is given that can be use to parse the `<expression>`, the following formats are supported: `'YYYY-M[M]-D[D]'` (e.g., `2023-3-28`), `'YYYY-month-D[D]'` (e.g., `2023-FEB-12`), `'month-D[D]-YYYY'` (e.g., `Dec-01-2023`), `'D[D]-month-YYYY'` (e.g., `3-jun-2023`), and `'month D[D], YYYY'` (e.g., `august 12, 2023`) | `TEXT`                |
| `<format>`     | Optional. A string literal that specifies the format of the `<expression>` to convert.                                                                                                                                                                                                                                                                                              | `TEXT` (see below)    |

Accepted `<format>` patterns include the following specifications:

| Format option | Description                                        | Example                                        |
| :------------ | :------------------------------------------------- | :--------------------------------------------- |
| `YYYY`        | Year (4 or more digits)                            | `TO_DATE('2023', 'YYYY'); --> '2023-01-01'`    |
| `YYY`         | Last 3 digits of year                              | `TO_DATE('2023', 'YYY'); --> '2023-01-01'`     |
| `YY`          | Last 2 digits of year                              | `TO_DATE('2023', 'YY'); --> '2023-01-01'`      |
| `Y`           | Last digit of year                                 | `TO_DATE('2023', 'Y'); --> '2023-01-01'`       |
| `MONTH`       | Full month name (case insensitive)                 | `TO_DATE('august', 'MONTH'); --> '0001-08-01'` |
| `MON`         | abbreviated month name (3 chars, case insensitive) | `TO_DATE('dec', 'MON'); --> '0001-12-01'`      |
| `MM`          | Month number (01–12)                               | `TO_DATE('7', 'MM'); --> '0001-07-01'`         |
| `DD`          | Day of month (01–31)                               | `TO_DATE('15', 'DD'); --> '0001-01-15'`        |

**Usage notes for formatting**

- Case letters in the input `<expression>` are ignored
- A separator (non-digit and non-letter) in the `<format>` string will match exactly one separator or is skipped
- Any non-separator in the `<format>` that is not part of a format option will match exactly one other character.
- Any character in quotes `"` will match exactly one other character.
- If the year format specification is `'YYY'`, `'YY'`, or `'Y'` and the supplied year is less than four digits, the year will be adjusted to be nearest to the year 2020, (e.g., `80` becomes `1980`).
- More specification, such as `'HH'`, `'MI'`, or, `'TZH'`, are accepted but ignored for purposes of computing the `DATE` result.
- Modifiers (e.g., `'FM'`) are not supported.

## Examples

The example below shows our separators and non-separators can cause skips. The separator `' '` (space) in the `<format>` matches the other separator `'/'` in the `<expression>`. The non-separator `'x'` will match any other character, in this case the `'a'`. Lastly, the two separators `'++'` will match up to two other separators, here the first `'x'` matches `'.'` while the second `'x'` will simply be ignored as no other separators follow.

```sql
SELECT
    TO_DATE(
        '2023/aJUN.23',
        'YYYY xMON++DD'
    );
```

**Returns**: `'2023-06-23'`

The example below shows how the year is adjusted to be nearest to 2020 because `YYY` was used to match a less than four digit number. To receive the exact year `'180'` use `YYYY` instead.
Furthermore, as the three separators are quotes `"..."` they will match any character (separator or non-separator) which in this case is `'ar '`.

```sql
SELECT
    TO_DATE(
        'Year 180: August 4th',
        'xx"..."yyy: month DDxx'
    );
```

**Returns**: `'2180-08-04'`
