---
layout: default
title: SUM (aggregation function)
description: Reference material for SUM
parent: SQL functions
---

# SUM

Calculates the sum of an expression.

## Syntax
{: .no_toc}

```sql
SUM ([DISTINCT] <expr>)
```

| Parameter | Description                                                                                                                              |
| :--------- | :---------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`   | The expression used to calculate the sum. Valid values for `<expr>` include column names or expressions that evaluate to numeric values. |
| `DISTINCT` | When specified, removes duplicate values from `<expr>` before calculating the sum. |

## Example

Consider a table `test_scores` with the following columns.

+-----------+-------+
| firstname | score |
+-----------+-------+
| Deborah   |    90 |
| Albert    |    50 |
| Carol     |    11 |
| Frank     |    87 |
| Thomas    |    85 |
| Peter     |    50 |
| Sammy     |    90 |
| Humphrey  |    56 |
+-----------+-------+


```
SELECT
	SUM(score)
FROM
	test_scores
```

**Returns**: `519`

```
SELECT
	SUM (DISTINCT score)
FROM
	test_scores
```

One each of the duplicated `90` and `50` scores are removed from the calculation.

**Returns**: `379`
