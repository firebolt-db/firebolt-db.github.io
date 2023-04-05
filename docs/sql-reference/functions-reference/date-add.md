---
layout: default
title: DATE_ADD
description: Reference material for DATE_ADD function
parent: SQL functions
---

# DATE\_ADD

Calculates a new `DATE `or `TIMESTAMP` by adding or subtracting a specified number of time units from an indicated expression.

## Syntax
{: .no_toc}

```sql
DATE_ADD('<unit>', <interval>, <date_expr>)
```

| Parameter     | Description                                                                                                                 |
| :------------- | :--------------------------------------------------------------------------------------------------------------------------- |
| `<unit>`      | A unit of time. This can be any of the following: `SECOND`, `MINUTE`, `HOUR`, `DAY`, `WEEK`, `MONTH`, `QUARTER`, `YEAR`.                                                                  |
| `<interval>`  | The number of times to increase the `<date_expr>` by the time unit specified by `<unit>`. This can be a negative number. |
| `<date_expr>` | An expression that evaluates to a `DATE` or `TIMESTAMP`. value.                                                              |

## Example
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
	category,
	DATE_ADD('WEEK', 15, sale_date)
FROM
	date_test;
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
