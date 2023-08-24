---
layout: default
title: PERCENTILE_DISC (window function)
description: Reference material for PERCENTILE_DISC window function
parent: SQL functions
---

# PERCENTILE\_DISC

Returns a percentile over a partition for an ordered data set. The result is equal to a specific column value, the smallest distributed value that is greater than or equal to the percentile <val>. 

PERCENTILE\_DISC is available as a [aggregation function](./aggregation-functions.md).
See also [PERCENTILE\_CONT](./percentile-cont-window.md), which calculates an interpolated result over a partition, rather than matching any of the specific column values.

## Syntax
{: .no_toc}

```sql
PERCENTILE_DISC( <val> ) WITHIN GROUP ( ORDER BY <expr0> [ { ASC | DESC } ] ) [ OVER ( PARTITION BY <expr1> ) ]
```

|           |                                                 |
| :--------- | :----------------------------------------------- |
| Parameter | Description                                     |
| `<val>`   | A double/float literal between 0.0 and 1.0.  |
| `<expr0>` | An expression used for the order by clause. |
| `<expr1>` | An expression used for the partition by clause. |

The return type of the function will be the same as the order by expression type.
This function ignores `NULL` values.


## Example
{: .no_toc}

The example below returns the 70th percentile value per student, partitioned by grade_level. The percentile value returned is a value from the data set. 

```sql
SELECT
	first_name,
	PERCENTILE_DISC(0.7) WITHIN GROUP (ORDER BY test_score) OVER (PARTITION BY grade_level) AS percentile
FROM
	class_test;
```

**Returns**:

```sql
' +-------------+------------+
' | grade_level | percentile | 
' +-------------+------------+
' |       Frank |         85 |
' |       Peter |         85|
' |        Iris |         85 |
' |    Humphrey |         85 |
' |        Jojo |         85 |
' |       Sammy |         85 |
' |     Deborah |         85 |
' |     Yolinda |         85 |
' |      Albert |         85 |
' |       Shawn |         85 |
' |        Mary |         85 |
' |       Larry |         76 |
' |        Otis |         76 |
' |       Wanda |         76 |
' |       Carol |         76 |
' |    Roseanna |         76 |
' |    Shangxiu |         76 |
' |      Thomas |        100 |
' |     Charles |        100 |
' |      Franco |        100 |
' |   Brunhilda |        100 |
' |       Jesse |        100 |
' |        Gary |        100 |
' +-------------+------------+
```
