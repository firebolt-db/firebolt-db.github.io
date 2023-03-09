---
layout: default
title: DATE_TRUNC (legacy)
description: Reference material for DATE_TRUNC function
parent: SQL functions
---

# DATE\_TRUNC (legacy)

Truncate a given date to a specified position.

{: .note}
The functions works with legacy `DATE` and `TIMESTAMP` data types. If you are using new `PGDATE`, `TIMESTAMPTZ`, and `TIMESTAMPNTZ` data types, see [DATE_TRUNC (new)](../functions-reference/date-trunc-new.md).

## Syntax
{: .no_toc}

```sql
DATE_TRUNC('<precision>', <date>)
```

| Parameter     | Description                                                                                           |
| :------------- | :----------------------------------------------------------------------------------------------------- |
| `<precision>` | The time unit for the returned value to be expressed.  This can be any of the following: `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `MONTH`, `QUARTER`, `YEAR`, `EPOCH`    |
| `<date>`      | The date to be truncated. This can be any expression that evaluates to a `DATE` or `TIMESTAMP` value. |

## Example
{: .no_toc}

The example below uses a table `date_test` with the columns and values below.

| Cat | sale\_datetime      |
| :-- | :------------------- |
| a   | 2017-06-15 09:34:21 |
| b   | 2014-01-15 12:14:46 |
| c   | 1999-09-15 11:33:21 |

```sql
SELECT
	cat,
	sale_datetime,
	DATE_TRUNC('MINUTE', sale_datetime) AS MINUTE,
	DATE_TRUNC('HOUR', sale_datetime) AS HOUR,
	DATE_TRUNC('DAY', sale_datetime) AS DAY
FROM
	date_test
ORDER BY
	cat;
```

**Returns**:

```
+-----+---------------------+---------------------+---------------------+---------------------+
| cat | sale_datetime       | MINUTE              | HOUR                | DAY                 |
| a   | 2017-06-15 09:34:21 | 2017-06-15 09:34:00 | 2017-06-15 09:00:00 | 2017-06-15 00:00:00 |
| b   | 2014-01-15 12:14:46 | 2014-01-15 12:14:00 | 2014-01-15 12:00:00 | 2014-01-15 00:00:00 |
| c   | 1999-09-15 11:33:21 | 1999-09-15 11:33:00 | 1999-09-15 11:00:00 | 1999-09-15 00:00:00 |
+-----+---------------------+---------------------+---------------------+---------------------+
```