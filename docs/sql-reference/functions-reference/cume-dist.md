---
layout: default
title: CUME_DIST
description: Reference material for CUME_DIST window function
parent: SQL functions
---

# CUME_DIST

Calculates the relative rank (cumulative distribution) of the current row in relation to other rows in the same partition within an ordered data set, as 
`( rank + number_of_peers - 1 ) / ( total_rows )`
where rank is the current row's rank within the partition, number_of_peers is the number of row values equal to the current row value (including the current row), and total_rows is the total number of rows in the partition.
The return value ranges from 1/(total_rows) to 1.

See also [PERCENT_RANK](./percent-rank.md), which returns the relative rank of the current row within an ordered data set.

## Syntax
{: .no_toc}

```sql
CUME_DIST() OVER ( [ PARTITION BY <val> ] ORDER BY <expr> [ASC|DESC] )
```

| Parameter | Description                                                                                       |
| :--------- | :------------------------------------------------------------------------------------------------- |
| `<val>`    | The expression used for the `PARTITION BY` clause.                                                |
| `<exp>`    | The expression used in the `ORDER BY` clause. This parameter determines what value will be ranked.  |

The return type of the function is DOUBLE.
This function respects `NULL` values, and results will be ordered with default null ordering `NULLS LAST` unless otherwise specified in the `ORDER BY` clause.

## Example
{: .no_toc}

The example below returns the cumulative distribution of test scores for students in grade nine.

```sql
SELECT
	first_name, test_score,
	CUME_DIST() OVER (PARTITION BY grade_level ORDER BY test_score DESC) as cume_dist
FROM
	class_test
WHERE grade_level=9;
```

**Returns**:

```sql
' +------------+------------+---------------------+
' | first_name | test_score |      cume_dist      |
' +------------+------------+---------------------+
' | Humphrey   |         90 | 0.16666666666666666 |
' | Sammy      |         85 |  0.3333333333333333 |
' | Peter      |         80 |                 0.5 |
' | Iris       |         79 |  0.6666666666666666 |
' | Jojo       |         78 |                   1 |
' | Frank      |         76 |  0.6666666666666666 |
' +------------+------------+---------------------+
```