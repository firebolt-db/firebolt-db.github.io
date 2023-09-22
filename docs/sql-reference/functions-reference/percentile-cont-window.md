---
layout: default
title: PERCENTILE_CONT (window function)
description: Reference material for PERCENTILE_CONT window function
parent: SQL functions
---

# PERCENTILE_CONT

Calculates a percentile over a partition, assuming a continuous distribution of values of <expr0> defined. Results are interpolated, rather than matching any of the specific column values. 

PERCENTILE\_CONT is  available as an [aggregation function](./aggregation-functions.md).
See also [PERCENTILE\_DISC](./percentile-disc-window.md), which returns a percentile over a partition equal to a specific column value.

## Syntax
{: .no_toc}

```sql
PERCENTILE_CONT( <val> ) WITHIN GROUP ( ORDER BY <expr0> [ { ASC | DESC } ] ) [ OVER ( PARTITION BY <expr1> ) ]
```

|           |                                                 |
| :--------- | :----------------------------------------------- |
| Parameter | Description                                     |
| `<val>`   | A double/float literal between 0.0 and 1.0.  |
| `<expr0>` | An expression used for the order by clause. |
| `<expr1>` | An expression used for the partition by clause. |

The expression used for the order by clause must be of numeric data type. The return type of the function is DOUBLE.

## Example
{: .no_toc}

The example below calculates the max percentile value based on continuous distribution of students, partitioned by grade level. 

```sql
SELECT
	first_name,
	PERCENTILE_CONT(1.0) WITHIN GROUP (ORDER BY test_score) OVER (PARTITION BY grade_level) AS percentile
FROM
	class_test;
```

**Returns**:

```sql
' +-------------+------------+
' | grade_level | percentile | 
' +-------------+------------+
' |       Frank |         90 |
' |       Peter |         90 |
' |        Iris |         90 |
' |    Humphrey |         90 |
' |        Jojo |         90 |
' |       Sammy |         90 |
' |      Albert |         89 |
' |     Deborah |         89 |
' |     Yolinda |         89 |
' |        Mary |         89 |
' |       Shawn |         89 |
' |        Otis |         94 |
' |       Larry |         94 |
' |       Carol |         94 |
' |       Wanda |         94 |
' |    Roseanna |         94 |
' |    Shangxiu |         94 |
' |      Franco |        100 |
' |     Charles |        100 |
' |   Brunhilda |        100 |
' |        Gary |        100 |
' |      Thomas |        100 |
' |       Jesse |        100 |
' +-------------+------------+
```
