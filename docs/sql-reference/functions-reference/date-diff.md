---
layout: default
title: DATE_DIFF
nav_exclude: true
description: Reference material for DATE_DIFF function
parent: SQL functions
---

# DATE\_DIFF

Calculates the difference between `start_date` and `end_date` by the indicated unit.

## Syntax
{: .no_toc}

```sql
DATE_DIFF('<unit>', <start_date>, <end_date>)
```

| Parameter      | Description                                                    |
| :-------------- | :-------------------------------------------------------------- |
| `<unit>`       | A unit of time. This can be any of the following: `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `MONTH`, `QUARTER`, `YEAR`, `EPOCH`     |
| `<start_date>` | An expression that evaluates to a `DATE` or `TIMESTAMP` value. |
| `<end_date>`   | An expression that evaluates to a `DATE` or `TIMESTAMP` value. |

## Example
{: .no_toc}

The example below uses a table `date_test` with the columns and values below.

| Category | sale\_date | sale\_datetime      |
| :-------- | :---------- | :------------------- |
| a        | 2012-05-01 | 2017-06-15 09:34:21 |
| b        | 2021-08-30 | 2014-01-15 12:14:46 |
| c        | 1999-12-31 | 1999-09-15 11:33:21 |

```sql
SELECT
	category,
	DATE_DIFF('YEAR', sale_date, sale_datetime) AS year_difference
FROM
	date_test;
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
