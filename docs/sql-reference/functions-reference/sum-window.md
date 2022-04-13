---
layout: default
title: SUM (window function)
description: Reference material for SUM function
parent: SQL functions
---

# SUM (window function)

Calculate the sum of the values within the requested window.

The SUM function works with numeric values and ignores `NULL` values.

For more information on usage, please refer to [Window Functions](./window-functions.md).

## Syntax
{: .no_toc}

```sql
SUM([DISTINCT] <val> ) OVER ( [ PARTITION BY <expr> ] )
```

| Parameter | Description                                      |
| :--------- | :------------------------------------------------ |
| `<val>`   | The expression used for the `SUM` function       |
| `<expr>`  | An expression used for the `PARTITION BY` clause |
| `DISTINCT` | When specified, removes duplicate values from `<expr>` before calculating the sum. |

## Example
{: .no_toc}

The example below shows how many vaccinated students are in the same grade level for each student.

```sql
SELECT
	first_name,
	SUM(vaccinated) OVER (PARTITION BY grade_level ) AS vaccinated_students
FROM
	class_test;
```

**Returns**:

```
+------------+---------------------+
| first_name | vaccinated_students |
+------------+---------------------+
| Frank      |                   5 |
| Humphrey   |                   5 |
| Iris       |                   5 |
| Sammy      |                   5 |
| Peter      |                   5 |
| Jojo       |                   5 |
| Brunhilda  |                   5 |
| Franco     |                   5 |
| Thomas     |                   5 |
| Gary       |                   5 |
| Charles    |                   5 |
| Jesse      |                   5 |
| Roseanna   |                   4 |
| Carol      |                   4 |
| Wanda      |                   4 |
| Shangxiu   |                   4 |
| Larry      |                   4 |
| Otis       |                   4 |
| Deborah    |                   4 |
| Yolinda    |                   4 |
| Albert     |                   4 |
| Mary       |                   4 |
| Shawn      |                   4 |
+------------+---------------------+
```
