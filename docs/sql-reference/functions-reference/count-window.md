---
layout: default
title: COUNT (window function)
description: Reference material for COUNT function
parent: SQL functions
---

# COUNT

Count the number of values within the requested window.

For more information on usage, please refer to [Window Functions](./window-functions.md)  

## Syntax
{: .no_toc}

```sql
COUNT( <val> ) OVER ( [ PARTITION BY <exp> ] )
```

| Parameter | Description                                      |
| :--------- | :------------------------------------------------ |
| `<val>`   | An expression used for the `COUNT()` function.   |
| `<expr>`  | An expression used for the `PARTITION BY` clause |

## Example
{: .no_toc}

This example below generates a count of how many students are in each grade level while leaving each student as an independent row.

```sql
SELECT
	first_name,
	grade_level,
	COUNT(first_name) OVER (PARTITION BY grade_level) AS count_of_students
FROM
	class_test;
```

**Returns**:

```
+------------+-------------+-------------------+
| first_name | grade_level | count_of_students |
+------------+-------------+-------------------+
| Frank      |           9 |                 6 |
| Humphrey   |           9 |                 6 |
| Iris       |           9 |                 6 |
| Sammy      |           9 |                 6 |
| Peter      |           9 |                 6 |
| Jojo       |           9 |                 6 |
| Brunhilda  |          12 |                 6 |
| Franco     |          12 |                 6 |
| Thomas     |          12 |                 6 |
| Gary       |          12 |                 6 |
| Charles    |          12 |                 6 |
| Jesse      |          12 |                 6 |
| Roseanna   |          11 |                 6 |
| Carol      |          11 |                 6 |
| Wanda      |          11 |                 6 |
| Shangxiu   |          11 |                 6 |
| Larry      |          11 |                 6 |
| Otis       |          11 |                 6 |
| Deborah    |          10 |                 5 |
| Yolinda    |          10 |                 5 |
| Albert     |          10 |                 5 |
| Mary       |          10 |                 5 |
| Shawn      |          10 |                 5 |
+------------+-------------+-------------------+
```
