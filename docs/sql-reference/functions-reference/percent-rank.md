---
layout: default
title: PERCENT_RANK
description: Reference material for PERCENT_RANK window function
parent: SQL functions
---

# PERCENT_RANK

Calculates the relative rank of the current row within an ordered data set, as
`( rank - 1 ) / ( rows - 1 )`
where rank is the current row's rank within the partition, and rows is the number of rows in the partition. PERCENT_RANK always returns values from 0 to 1 inclusive. The first row in any set has a `PERCENT_RANK` of 0. 

See also [CUME_DIST](../cume-dist.md), which returns the cumulative distribution of the current row in relation to other rows in the same partition within an ordered data set.

## Syntax
{: .no_toc}

```sql
PERCENT_RANK() OVER ( [ PARTITION BY <val> ] ORDER BY <expr> [ASC|DESC] )
```

| Parameter | Description                                                                                       |
| :--------- | :------------------------------------------------------------------------------------------------- |
| `<val>`    | The expression used for the `PARTITION BY` clause.                                                |
| `<exp>`    | The expression used in the `ORDER BY` clause. This parameter determines what value will be ranked.  |

The return type of the function is DOUBLE.
This function respects `NULL` values, and results will be ordered with default null ordering `NULLS LAST` unless otherwise specified in the `ORDER BY` clause.

## Example
{: .no_toc}

The example below calculates, for each student in grade nine, the percent rank of the student's test score by their grade level.

```sql
SELECT
	first_name, test_score,
	PERCENT_RANK() OVER (PARTITION BY grade_level ORDER BY test_score DESC) as percent_rank
FROM
	class_test
WHERE grade_level=9;
```

**Returns**:

```sql
' +------------+------------+---------------------+
' | first_name | test_score |    percent_rank     |
' +------------+------------+---------------------+
' | Humphrey   |         90 |                   0 |
' | Sammy      |         85 |                 0.2 |
' | Peter      |         80 |                 0.4 |
' | Iris       |         79 |                 0.6 |
' | Jojo       |         78 |                 0.8 |
' | Frank      |         76 |                   1 |
' +------------+------------+---------------------+
```