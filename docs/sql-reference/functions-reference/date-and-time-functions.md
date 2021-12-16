---
layout: default
title: Date and time functions
nav_order: 3
parent: SQL functions reference
---

# Date and time functions
{: .no_toc}

This page describes the date and time functions and [format expressions](date-and-time-functions.md#date-format-expressions) supported in Firebolt.

* Topic ToC
{:toc}

## CURRENT\_DATE

Returns the current year, month and day as a `DATE` value, formatted as YYYY-MM-DD.

### Syntax
{: .no_toc}

```sql
​​CURRENT_DATE()​​
```

### Example
{: .no_toc}

```
SELECT
    CURRENT_DATE();
```

**Returns:** `2021-11-04`

## DATE\_ADD

Calculates a new `DATE `or `TIMESTAMP` by adding or subtracting a specified number of time units from an indicated expression.

### Syntax
{: .no_toc}

```sql
​​DATE_ADD('<unit>', <interval>, <date_expr>)​​
```

| Parameter     | Description                                                                                                                 |
| :------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| `<unit>`      | A unit of time. This can be any of the following: `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `YEAR`, `EPOCH`                                                                  |
| `<interval>`  | The number of times to increase the ​`<date_expr>​​` by the time unit specified by `<unit>`. This can be a negative number. |
| `<date_expr>` | An expression that evaluates to a `DATE` or `TIMESTAMP` value.                                                              |

### Example
{: .no_toc}

The example below uses a table `date_test` with the columns and values below.

| Category | sale\_date |
| :-------- | :---------- |
| a        | 2012-05-01 |
| b        | 2021-08-30 |
| c        | 1999-12-31 |

This example below adds 15 weeks to the `sale_date` column.

```sql
SELECT
	Category,
	DATE_ADD('WEEK', 15, sale_date)
FROM
	date_test
```

**Returns**:

```
+---+------------+
| a | 2012-08-14 |
| b | 2021-12-13 |
| c | 2000-04-14 |
+---+------------+
```

This example below subtracts 6 months from a given start date string. This string representation of a date first needs to be transformed to `DATE `type using the `CAST `function.

```
SELECT
    DATE_ADD('MONTH', -6, CAST ('2021-11-04' AS DATE));
```

**Returns**: `2021-05-04`

## DATE\_DIFF

Calculates the difference between ​​`start_date`​​ and ​`end_date`​​ by the indicated ​unit​​.

### Syntax
{: .no_toc}

```sql
​​DATE_DIFF('<unit>', <start_date>, <end_date>)​​
```

| Parameter      | Description                                                    |
| :-------------- | :-------------------------------------------------------------- |
| `<unit>`       | A unit of time. This can be any of the following: `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `YEAR`, `EPOCH`     |
| `<start_date>` | An expression that evaluates to a `DATE` or `TIMESTAMP` value. |
| `<end_date>`   | An expression that evaluates to a `DATE` or `TIMESTAMP` value. |

### Example
{: .no_toc}

The example below uses a table `date_test` with the columns and values below.

| Category | sale\_date | sale\_datetime      |
| :-------- | :---------- | :------------------- |
| a        | 2012-05-01 | 2017-06-15 09:34:21 |
| b        | 2021-08-30 | 2014-01-15 12:14:46 |
| c        | 1999-12-31 | 1999-09-15 11:33:21 |

```sql
SELECT
	Category,
	DATE_DIFF('YEAR', sale_date, sale_datetime) AS year_difference
FROM
	date_test
```

**Returns**:

```
+----------+-----------------+
| Category | year_difference |
| a        | 5               |
| b        | -7              |
| c        | 0               |
+----------+-----------------+
```

This example below finds the number of days difference between two date strings. The strings first need to be transformed to `TIMESTAMP` type using the `CAST `function.

```sql
SELECT
	DATE_DIFF(
		'day',
		CAST('2020/08/31 10:00:00' AS TIMESTAMP),
		CAST('2020/08/31 11:00:00' AS TIMESTAMP)
	);
```

**Returns**: `0`

## DATE\_FORMAT

Formats a ​`DATE` ​​or ​`DATETIME` ​​according to the given format expression.

### Syntax
{: .no_toc}

```sql
​​DATE_FORMAT(<date>, '<format>')​​
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

### Example
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
	Category,
	DATE_FORMAT(sale_datetime, '%C') AS C,
	DATE_FORMAT(sale_datetime, '%d') AS d,
	DATE_FORMAT(sale_datetime, '%D') AS D,
	DATE_FORMAT(sale_datetime, '%e') AS e,
	DATE_FORMAT(sale_datetime, '%F') AS F,
	DATE_FORMAT(sale_datetime, '%H') AS H,
	DATE_FORMAT(sale_datetime, '%I') AS I
FROM
	date_test
ORDER BY Category
```

**Returns:**

```
+----------+---------------------+----+----+----------+----+------------+----+----+
| Category | sale_datetime       | C  | d  | D        | e  | F          | H  | I  |
| a        | 2017-06-15 09:34:21 | 20 | 15 | 06/15/17 | 15 | 2017-06-15 | 09 | 09 |
| b        | 2014-01-15 12:14:46 | 20 | 15 | 01/15/14 | 15 | 2014-01-15 | 12 | 12 |
| c        | 1999-09-15 11:33:21 | 19 | 15 | 09/15/99 | 15 | 1999-09-15 | 11 | 11 |
+----------+---------------------+----+----+----------+----+------------+----+----+
```

The example below shows output for `<format>` expressions %j, %m, %M, %p, %R, %S

```sql
SELECT
	Category,
	sale_datetime,
	DATE_FORMAT(sale_datetime, '%j') AS j,
	DATE_FORMAT(sale_datetime, '%m') AS m,
	DATE_FORMAT(sale_datetime, '%M') AS M,
	DATE_FORMAT(sale_datetime, '%p') AS p,
	DATE_FORMAT(sale_datetime, '%R') AS R,
	DATE_FORMAT(sale_datetime, '%S') AS S
FROM
	date_test
ORDER BY Category
```

**Returns:**

```
+----------+---------------------+-----+----+----+----+-------+----+
| Category | sale_datetime       | j   | m  | M  | p  | R     | S  |
| a        | 2017-06-15 09:34:21 | 166 | 06 | 34 | AM | 09:34 | 21 |
| b        | 2014-01-15 12:14:46 | 015 | 01 | 14 | PM | 12:14 | 46 |
| c        | 1999-09-15 11:33:21 | 258 | 09 | 33 | AM | 11:33 | 21 |
+----------+---------------------+-----+----+----+----+-------+----+
```

The example below shows output for `<format>` expressions %T, %u, %V, %w, %y, %Y, %%

```sql
SELECT
	Category,
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
ORDER BY Category
```

**Returns:**

```
+----------+---------------------+----------+---+----+---+----+------+---------+
| Category | sale_datetime       | T        | u | V  | w | y  | Y    | percent |
| a        | 2017-06-15 09:34:21 | 09:34:21 | 4 | 24 | 4 | 17 | 2017 | %       |
| b        | 2014-01-15 12:14:46 | 12:14:46 | 3 | 03 | 3 | 14 | 2014 | %       |
| c        | 1999-09-15 11:33:21 | 11:33:21 | 3 | 37 | 3 | 99 | 1999 | %       |
+----------+---------------------+----------+---+----+---+----+------+---------+
```

## DATE\_TRUNC

Truncate a given date to a specified position.

### Syntax
{: .no_toc}

```sql
​​DATE_TRUNC('<precision>', <date>)​​
```

| Parameter     | Description                                                                                           |
| :------------- | :----------------------------------------------------------------------------------------------------- |
| `<precision>` | The time unit for the returned value to be expressed. ​ This can be any of the following: `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `YEAR`, `EPOCH`    |
| `<date>`      | The date to be truncated. This can be any expression that evaluates to a `DATE` or `TIMESTAMP` value. |

### Example
{: .no_toc}

The example below uses a table `date_test` with the columns and values below.

| Category | sale\_datetime      |
| :-------- | :------------------- |
| a        | 2017-06-15 09:34:21 |
| b        | 2014-01-15 12:14:46 |
| c        | 1999-09-15 11:33:21 |

```sql
SELECT
    Category,
    sale_datetime,
    DATE_TRUNC('MINUTE', sale_datetime) AS MINUTE,
    DATE_TRUNC('HOUR', sale_datetime) AS HOUR,
    DATE_TRUNC('DAY', sale_datetime) AS DAY
FROM
	date_test
ORDER BY Category
```

**Returns**:

```
+----------+---------------------+---------------------+---------------------+---------------------+
| Category | sale_datetime       | MINUTE              | HOUR                | DAY                 |
| a        | 2017-06-15 09:34:21 | 2017-06-15 09:34:00 | 2017-06-15 09:00:00 | 2017-06-15 00:00:00 |
| b        | 2014-01-15 12:14:46 | 2014-01-15 12:14:00 | 2014-01-15 12:00:00 | 2014-01-15 00:00:00 |
| c        | 1999-09-15 11:33:21 | 1999-09-15 11:33:00 | 1999-09-15 11:00:00 | 1999-09-15 00:00:00 |
+----------+---------------------+---------------------+---------------------+---------------------+
```

## EXTRACT

Retrieves subfields such as year or hour from date/time values.

### Syntax
{: .no_toc}

```sql
​​EXTRACT(<field> FROM <source>)​​
```

| Parameter  | Description                                                                                                      |
| :---------- | :---------------------------------------------------------------------------------------------------------------- |
| `<field>`  | Supported fields: `DAY`, `DOW, MONTH`, `WEEK`, `WEEKISO`, `QUARTER`, `YEAR`, `HOUR`, `MINUTE`, `SECOND`, `EPOCH` |
| `<source>` | A value expression of type timestamp.                                                                            |

### Example
{: .no_toc}

This example below extracts the year from the timestamp. The string date first need to be transformed to `TIMESTAMP` type using the `CAST `function.

```sql
SELECT
	EXTRACT(
		YEAR
		FROM
			CAST('2020-01-01 10:00:00' AS TIMESTAMP)
	)
```

**Returns**: `2020`

## FROM\_UNIXTIME

Convert Unix time (`LONG` in epoch seconds) to `DATETIME` (YYYY-MM-DD HH:mm:ss).

### Syntax
{: .no_toc}

```sql
​​FROM_UNIXTIME(<unix_time>)​​
```

| Parameter     | Description                                  |
| :------------- | :-------------------------------------------- |
| `<unix_time>` | The UNIX epoch time that is to be converted. |

### Example
{: .no_toc}

```sql
SELECT
    FROM_UNIXTIME(1493971667);
```

**Returns**: `2017-05-05 08:07:47`

## NOW

Returns the current date and time.

### Syntax
{: .no_toc}

```sql
​​NOW()​​
```

### Example
{: .no_toc}

```sql
SELECT
    NOW()
```

**Returns**: `2021-11-04 20:42:54`

## TIMEZONE

Returns the current timezone of the request execution

### Syntax
{: .no_toc}

```sql
​​TIMEZONE()​​
```

### Example
{: .no_toc}


```sql
SELECT
    TIMEZONE()
```

**Returns**: `Etc/UTC`

## TO\_DAY\_OF\_WEEK

Converts a date or timestamp to a number representing the day of the week (Monday is 1, and Sunday is 7).

### Syntax
{: .no_toc}

```sql
​​TO_DAY_OF_WEEK(<date>)​​
```

| Parameter | Description                                             |
| :--------- | :------------------------------------------------------- |
| `<date>`  | An expression that evaluates to a `DATE `or `TIMESTAMP` |

### Example
{: .no_toc}

This example below finds the day of week number for April 22, 1975. The string first needs to be transformed to `DATE `type using the `CAST `function.

```sql
SELECT
    TO_DAY_OF_WEEK(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `2`

## TO\_DAY\_OF\_YEAR

Converts a date or timestamp to a number containing the number for the day of the year.

### Syntax
{: .no_toc}

```sql
​​TO_DAY_OF_YEAR(<date>)​​
```

| Parameter | Description                                             |
| :--------- | :------------------------------------------------------- |
| `<date>`  | An expression that evaluates to a `DATE `or `TIMESTAMP` |

### Example
{: .no_toc}

This example below finds the day of the year number for April 22, 1975. The string first needs to be transformed to `DATE `type using the `CAST `function.

```sql
SELECT
    TO_DAY_OF_YEAR(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `112`

## TO\_HOUR

Converts a date or timestamp to a number containing the hour.

### Syntax
{: .no_toc}

```sql
​​TO_HOUR(<timestamp>)​​
```

| Parameter     | Description                                                |
| :------------- | :---------------------------------------------------------- |
| `<timestamp>` | The timestamp to be converted into the number of the hour. |

### Example
{: .no_toc}

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT TO_HOUR(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

Returns: `12`

## TO\_MINUTE

Converts a timestamp (any date format we support) to a number containing the minute.

### Syntax
{: .no_toc}

```sql
​​TO_MINUTE(<timestamp>)​​
```

| Parameter     | Description                                                  |
| :------------- | :------------------------------------------------------------ |
| `<timestamp>` | The timestamp to be converted into the number of the minute. |

### Example
{: .no_toc}

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT TO_MINUTE(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

**Returns:** `20`

## TO\_MONTH

Converts a date or timestamp (any date format we support) to a number containing the month.

### Syntax
{: .no_toc}

```sql
​​TO_MONTH(<date>)​​
```

| Parameter | Description                                                         |
| :--------- | :------------------------------------------------------------------- |
| `<date>`  | The date or timestamp to be converted into the number of the month. |

**Example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_MONTH(CAST('1975/04/22' AS DATE)) as res;
```

**Returns:** 4

## TO\_QUARTER

Converts a date or timestamp (any date format we support) to a number containing the quarter.

### Syntax
{: .no_toc}

```sql
​​TO_QUARTER(<date>)​​
```

| Parameter | Description                                                           |
| :--------- | :--------------------------------------------------------------------- |
| `<date>`  | The date or timestamp to be converted into the number of the quarter. |

### Example
{: .no_toc}

For Tuesday, April 22, 1975:

```sql
SELECT TO_QUARTER(CAST('1975/04/22' AS DATE)) as res;
```

**Returns:**` 2`

## TO\_SECOND

Converts a timestamp (any date format we support) to a number containing the second.

### Syntax
{: .no_toc}

```sql
​​TO_SECOND(<timestamp>)​​
```

| Parameter     | Description                                                  |
| :------------- | :------------------------------------------------------------ |
| `<timestamp>` | The timestamp to be converted into the number of the second. |

### Example
{: .no_toc}

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT TO_SECOND(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

**Returns**: `5`

## TO\_STRING

Converts a date into a STRING. The date is any [date data type​​](../../general-reference/data-types.md).

### Syntax
{: .no_toc}

```sql
TO_STRING(<date>)
```

| Parameter | Description                           |
| :--------- | :------------------------------------- |
| `<date>`  | The date to be converted to a string. |

### Example
{: .no_toc}


This que**r**y returns today's date and the current time.

```sql
SELECT TO_STRING(NOW());
```

**Returns**: ​ `2022-10-10 22:22:33`

## TO\_WEEK

Converts a date or timestamp to a number representing the week. This function defines week 1 of a calendar year as the first full week of a calendar year starting on a Sunday.

### Syntax
{: .no_toc}

```sql
​​TO_WEEK(<date>)​​
```

| Parameter | Description                                                        |
| :--------- | :------------------------------------------------------------------ |
| `<date>`  | The date or timestamp to be converted into the number of the week. |

### Example
{: .no_toc}

For Sunday, Jan. 1,  2017:&#x20;

```sql
SELECT
    TO_WEEK(CAST('2017/01/01' AS DATE))
```

**Returns**: `1`

For Monday, Jan. 1, 2018:&#x20;

```
SELECT
    TO_WEEK(CAST('2018/01/01' AS DATE))
```

**Returns**: `0`

## TO\_WEEKISO

Converts any supported date or timestamp data type to a number representing the week of the year. This function adheres to the [ISO 8601](https://en.wikipedia.org/wiki/ISO\_week\_date) standards for numbering weeks, meaning week 1 of a calendar year is the first week with 4 or more days in that year.

### Syntax
{: .no_toc}

```sql
TO_WEEKISO(<date>)
```

| Parameter | Description                                                     |
| :--------- | :--------------------------------------------------------------- |
| `<date>`  | The date or timestamp to be converted into the ISO week number. |

### Example
{: .no_toc}

Where `ship_date` is a column of type `DATE `in the table `fct_orders`.

```sql
SELECT
    TO_WEEKISO (ship_date)
FROM
    fct_orders;
```

**Returns:**

```
+-----------+
| ship_date |
+-----------+
|        33 |
|        12 |
|        18 |
|         2 |
|         1 |
|       ... |
+-----------+
```

Where `ship_date` is a column of type `TEXT` with values in the format _YYYY/MM/DD** **_**.**

```sql
SELECT
    TO_WEEKISO(CAST(ship_date AS DATE))
FROM
    fct_orders;
```

**Returns:**

```
+-----------+
| ship_date |
+-----------+
|        33 |
|        12 |
|        18 |
|         2 |
|         1 |
|       ... |
+-----------+
```

## TO\_YEAR

Converts a date or timestamp (any date format we support) to a number containing the year.

### Syntax
{: .no_toc}

```sql
​​TO_YEAR(<date>)​​
```

| Parameter | Description                                                        |
| :--------- | :------------------------------------------------------------------ |
| `<date>`  | The date or timestamp to be converted into the number of the year. |

### Example
{: .no_toc}

For Tuesday, April 22, 1975:

```sql
SELECT TO_YEAR(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `1975`
