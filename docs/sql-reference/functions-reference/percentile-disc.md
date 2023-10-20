---
layout: default
title: PERCENTILE_DISC (aggregation function)
description: Reference material for PERCENTILE_DISC aggregate function
parent:  SQL functions
---

# PERCENTILE\_DISC

Returns a percentile for an ordered data set. The result is equal to a specific column value, the smallest distributed value that is greater than or equal to the percentile <value>. 

PERCENTILE\_DISC is available as a [window function](./index.md#window-functions).
See also [PERCENTILE\_CONT](./percentile-cont.md), which calculates an interpolated result, rather than matching any of the specific column values.

## Syntax
{: .no_toc}

```sql
PERCENTILE_DISC( <value> ) WITHIN GROUP ( ORDER BY <expression> [ { ASC | DESC } ] )
```

## Parameters 
{: .no_toc}

| Parameter | Description                                     | Supported input types |
| :--------- | :----------------------------------------------- | :---------|
| `<value>`   | Percentile value for the function | `DOUBLE PRECISION`/`REAL` literal between 0.0 and 1.0 |
| `<expression>`  | Expression used for the `ORDER BY` clause | `NUMERIC` or `TIMESTAMP`| 

## Return Types 
The return type of the function will be the same as the order by expression type.
This function ignores `NULL` values.


## Example
{: .no_toc}

The example below returns the median percentile value based on student grade levels. The percentile value returned is a value from the data set. 

```sql
SELECT
	grade_level,
	PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY test_score) AS percentile
FROM
	class_test
GROUP BY grade_level;
```

**Returns**:

```sql
' +-------------+------------+
' | grade_level | percentile | 
' +------------+-------------+
' | 9           |         80 |
' | 10          |         78 |
' | 11          |         75 |
' | 12          |         94 |
' +-------------+------------+
```
