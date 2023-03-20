---
layout: default
title: PERCENTILE_CONT (aggregation function)
description: Reference material for PERCENTILE_CONT aggregate function
parent: SQL functions
---

# PERCENTILE_CONT

Calculates a percentile, assuming a continuous distribution of values of <expr> defined. Results are interpolated, rather than matching any of the specific column values. 

PERCENTILE\_CONT is available as a [window function](./window-functions.md). 
See also [PERCENTILE\_DISC](../percentile-disc.md), which returns a percentile equal to a specific column value.


## Syntax
{: .no_toc}

```sql
PERCENTILE_CONT( <val> ) WITHIN GROUP ( ORDER BY <expr> [ { ASC | DESC } ] )
```

|            |                                                 |
| :--------- | :----------------------------------------------- |
| Parameter | Description                                     |
| `<val>`   | A `DOUBLE PRECISION`/`REAL` literal between 0.0 and 1.0.  |
| `<expr>`  | A numeric expression used for the order by clause. |

The expression used for the order by clause must be of numeric or time data types. The return type of the function will be the same as the expression type.
This function ignores `NULL` values.

## Example
{: .no_toc}

The example below calculates the median percentile value based on continuous distribution of student grade levels. 

```sql
SELECT
	grade_level,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY test_score) AS percentile
FROM
	class_test
GROUP BY grade_level;
```

**Returns**:

```sql
' +-------------+------------+
' | grade_level | percentile | 
' +------------+-------------+
' | 9           |        79.5 |
' | 10          |          78 |
' | 11          |          74 |
' | 12          |          93 |
' +-------------+------------+
```
