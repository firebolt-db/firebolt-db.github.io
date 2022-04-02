---
layout: default
title: DENSE_RANK
description: Reference material for DENSE_RANK function
parent: Window functions
parent: SQL functions
---

# DENSE\_RANK

Rank the current row within the requested window.

For more information on usage, please refer to [Window Functions](./window-functions.md).

## Syntax
{: .no_toc}

```sql
DENSE_RANK() OVER ([PARTITION BY <val>] ORDER BY <exp> [ASC|DESC] )
```

| Parameter | Description                                                                                       |
| :--------- | :------------------------------------------------------------------------------------------------- |
| `<val>`   | The expression used for the `PARTITION BY` clause.                                                |
| `<exp>`    | The expression used in the `ORDER BY` clause. This parameter determines what value will be ranked.  |

## Example
{: .no_toc}

In this example below, students are ranked based on their test scores for their grade level.

```
SELECT
	first_name,
	grade_level,
	test_score,
	DENSE_RANK() OVER (PARTITION BY grade_level ORDER BY test_score DESC ) AS rank_in_class
FROM
	class_test;
```

**Returns**:

```
+------------+-------------+------------+---------------+
| first_name | grade_level | test_score | rank_in_class |
+------------+-------------+------------+---------------+
| Frank      |           9 |         76 |             6 |
| Humphrey   |           9 |         90 |             1 |
| Iris       |           9 |         79 |             4 |
| Sammy      |           9 |         85 |             2 |
| Peter      |           9 |         80 |             3 |
| Jojo       |           9 |         78 |             5 |
| Deborah    |          10 |         78 |             3 |
| Yolinda    |          10 |         30 |             5 |
| Albert     |          10 |         59 |             4 |
| Mary       |          10 |         85 |             2 |
| Shawn      |          10 |         89 |             1 |
| Roseanna   |          11 |         94 |             1 |
| Carol      |          11 |         52 |             6 |
| Wanda      |          11 |         73 |             4 |
| Shangxiu   |          11 |         76 |             2 |
| Larry      |          11 |         68 |             5 |
| Otis       |          11 |         75 |             3 |
| Brunhilda  |          12 |         92 |             4 |
| Franco     |          12 |         94 |             2 |
| Thomas     |          12 |         66 |             6 |
| Gary       |          12 |        100 |             1 |
| Charles    |          12 |         93 |             3 |
| Jesse      |          12 |         89 |             5 |
+------------+-------------+------------+---------------+
```
