---
layout: default
title: MAX (window function)
description: Reference material for MAX function
parent: SQL functions
---

# MAX (window function)

Returns the maximum value within the requested window.

For more information on usage, please refer to [Window Functions](./window-functions.md).

## Syntax
{: .no_toc}

```sql
MAX( <exp> ) OVER ( [ PARTITION BY <exp> ] )
```

| Parameter | Description                                       |
| :--------- | :------------------------------------------------- |
| `<val>`   | An expression used for the `MAX` function.        |
| `<exp>`   | An expression used for the `PARTITION BY` clause. |

## Example
{: .no_toc}

The example below queries test scores for students in various grade levels. Unlike a regular `MAX()` aggregation, the window function allows us to see how each student individually compares to the highest test score for their grade level.

```sql
SELECT
	first_name,
	grade_level,
	test_score,
	MAX(test_score) OVER (PARTITION BY grade_level) AS highest_score
FROM
	class_test;
```

**Returns**:

```
+------------+-------------+------------+---------------+
| first_name | grade_level | test_score | highest_score |
+------------+-------------+------------+---------------+
| Frank      |           9 |         76 |            90 |
| Humphrey   |           9 |         90 |            90 |
| Iris       |           9 |         79 |            90 |
| Sammy      |           9 |         85 |            90 |
| Peter      |           9 |         80 |            90 |
| Jojo       |           9 |         78 |            90 |
| Brunhilda  |          12 |         92 |           100 |
| Franco     |          12 |         94 |           100 |
| Thomas     |          12 |         66 |           100 |
| Gary       |          12 |        100 |           100 |
| Charles    |          12 |         93 |           100 |
| Jesse      |          12 |         89 |           100 |
| Roseanna   |          11 |         94 |            94 |
| Carol      |          11 |         52 |            94 |
| Wanda      |          11 |         73 |            94 |
| Shangxiu   |          11 |         76 |            94 |
| Larry      |          11 |         68 |            94 |
| Otis       |          11 |         75 |            94 |
| Deborah    |          10 |         78 |            89 |
| Yolinda    |          10 |         30 |            89 |
| Albert     |          10 |         59 |            89 |
| Mary       |          10 |         85 |            89 |
| Shawn      |          10 |         89 |            89 |
+------------+-------------+------------+---------------+
```
