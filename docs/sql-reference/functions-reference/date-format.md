---
layout: default
title: DATE_FORMAT
description: Reference material for DATE_FORMAT function
parent: SQL functions
---

# DATE\_FORMAT

Formats a `DATE` or `DATETIME` according to the given format expression.

## Syntax
{: .no_toc}

```sql
DATE_FORMAT(<date>, '<format>')
```

| Parameter  | Description                                                                                                                                                                                |
| :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<date>`   | The date to be formatted.                                                                                                                                                                  |
| `<format>` | The format to be used for the output using the syntax shown. The reference table below lists allowed expressions and provides example output of each expression for a given date and time. |

| Expression for \<format> | Description                                                                 | Expression output for Tuesday the 2nd of April, 1975 at 12:24:48:13 past midnight          |
| ------------------------ | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `%C`                     | The year divided by 100 and truncated to integer (00-99)                    | `19`                                                                                       |
| `%d`                     | Day of the month, zero-padded (01-31)                                       | `02`                                                                                       |
| `%D`                     | Short MM/DD/YY date, equivalent to `%m/%d/%y`                                 | `04/02/75`                                                                                 |
| `%e`                     | Day of the month, space-padded ( 1-31)                                      | `2`                                                                                        |
| `%F`                     | Short YYYY-MM-DD date, equivalent to %Y-%m-%d                               | `1975-04-02`                                                                               |
| `%H`                     | The hour in 24h format (00-23)                                              | `00`                                                                                       |
| `%I`                     | The hour in 12h format (01-12)                                              | `12`                                                                                       |
| `%j`                     | Day of the year (001-366)                                                   | `112`                                                                                      |
| `%m`                     | Month as a decimal number (01-12)                                           | `04`                                                                                       |
| `%M`                     | Minute (00-59)                                                              | `24`                                                                                       |
| `%n`                     | New-line character (‘’) in order to add a new line in the converted format. | For example, `%Y%n%m` returns: <br>`1975`<br>`04` |
| `%p`                     | AM or PM designation                                                        | `PM`                                                                                       |
| `%R`                     | 24-hour HH:MM time, equivalent to `%H:%M`                                     | `00:24`                                                                                    |
| `%S`                     | The second (00-59)                                                          | `48`                                                                                       |
| `%T`                     | ISO 8601 time format (HH:MM:SS), equivalent to `%H:%M:%S`                     | `00:24:48`                                                                                 |
| `%u`                     | ISO 8601 weekday as number with Monday as 1 (1-7)                           | `2`                                                                                        |
| `%V`                     | ISO 8601 week number (01-53)                                                | `17`                                                                                       |
| `%w`                     | weekday as a decimal number with Sunday as 0 (0-6)                          | `2`                                                                                        |
| `%y`                     | Year, last two digits (00-99)                                               | `75`                                                                                       |
| `%Y`                     | Year                                                                        | `1975`                                                                                     |
| `%%`                     | Escape character to use a `%` sign                                          | `%`                                                                                        |

## Example
{: .no_toc}

The examples below use a table `date_test` with the columns and values below. The following examples use these `TIMESTAMP` values to demonstrate the various `DATE_FORMAT` expressions.

| Category | sale\_datetime      |
| :-------- | :------------------- |
| a        | 2017-06-15 09:34:21 |
| b        | 2014-01-15 12:14:46 |
| c        | 1999-09-15 11:33:21 |

The example below shows output for `<format>` expressions %C, %d, %D, %e, %F, %H, %I

```sql
SELECT
	category,
	DATE_FORMAT(sale_datetime, '%C') AS C,
	DATE_FORMAT(sale_datetime, '%d') AS d,
	DATE_FORMAT(sale_datetime, '%D') AS D,
	DATE_FORMAT(sale_datetime, '%e') AS e,
	DATE_FORMAT(sale_datetime, '%F') AS F,
	DATE_FORMAT(sale_datetime, '%H') AS H,
	DATE_FORMAT(sale_datetime, '%I') AS I
FROM
	date_test
ORDER BY
	category;
```

**Returns**:

```
+----------+---------------------+----+----+----------+----+------------+----+----+
| category | sale_datetime       | C  | d  | D        | e  | F          | H  | I  |
| a        | 2017-06-15 09:34:21 | 20 | 15 | 06/15/17 | 15 | 2017-06-15 | 09 | 09 |
| b        | 2014-01-15 12:14:46 | 20 | 15 | 01/15/14 | 15 | 2014-01-15 | 12 | 12 |
| c        | 1999-09-15 11:33:21 | 19 | 15 | 09/15/99 | 15 | 1999-09-15 | 11 | 11 |
+----------+---------------------+----+----+----------+----+------------+----+----+
```

The example below shows output for `<format>` expressions %j, %m, %M, %p, %R, %S

```sql
SELECT
	category,
	sale_datetime,
	DATE_FORMAT(sale_datetime, '%j') AS j,
	DATE_FORMAT(sale_datetime, '%m') AS m,
	DATE_FORMAT(sale_datetime, '%M') AS M,
	DATE_FORMAT(sale_datetime, '%p') AS p,
	DATE_FORMAT(sale_datetime, '%R') AS R,
	DATE_FORMAT(sale_datetime, '%S') AS S
FROM
	date_test
ORDER BY
	category;
```

**Returns**:

```
+----------+---------------------+-----+----+----+----+-------+----+
| category | sale_datetime       | j   | m  | M  | p  | R     | S  |
| a        | 2017-06-15 09:34:21 | 166 | 06 | 34 | AM | 09:34 | 21 |
| b        | 2014-01-15 12:14:46 | 015 | 01 | 14 | PM | 12:14 | 46 |
| c        | 1999-09-15 11:33:21 | 258 | 09 | 33 | AM | 11:33 | 21 |
+----------+---------------------+-----+----+----+----+-------+----+
```

The example below shows output for `<format>` expressions %T, %u, %V, %w, %y, %Y, %%

```sql
SELECT
	category,
	sale_datetime,
	DATE_FORMAT(sale_datetime, '%T') AS T,
	DATE_FORMAT(sale_datetime, '%u') AS u,
	DATE_FORMAT(sale_datetime, '%V') AS V,
	DATE_FORMAT(sale_datetime, '%w') AS w,
	DATE_FORMAT(sale_datetime, '%y') AS y,
	DATE_FORMAT(sale_datetime, '%Y') AS Y,
	DATE_FORMAT(sale_datetime, '%%') AS percent
FROM
	date_test
ORDER BY
	category;
```

**Returns**:

```
+----------+---------------------+----------+---+----+---+----+------+---------+
| category | sale_datetime       | T        | u | V  | w | y  | Y    | percent |
| a        | 2017-06-15 09:34:21 | 09:34:21 | 4 | 24 | 4 | 17 | 2017 | %       |
| b        | 2014-01-15 12:14:46 | 12:14:46 | 3 | 03 | 3 | 14 | 2014 | %       |
| c        | 1999-09-15 11:33:21 | 11:33:21 | 3 | 37 | 3 | 99 | 1999 | %       |
+----------+---------------------+----------+---+----+---+----+------+---------+
```
