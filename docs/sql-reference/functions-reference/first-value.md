---
layout: default
title: FIRST_VALUE
description: Reference material for FIRST_VALUE function
parent: SQL functions
---

# FIRST_VALUE

Returns the first value evaluated in the specified window frame. If there are no rows in the window frame, `FIRST_VALUE` returns `NULL`.

See also [NTH\_VALUE](../nth-value.md), which returns the value evaluated of the nth row (starting at the first row).

## Syntax
{: .no_toc}

```sql
FIRST_VALUE( <expr> ) OVER ( [ PARTITION BY <expr0> ] ORDER BY <expr1> [ASC|DESC] )
```

| Parameter | Description                                                                                        |
| :--------- | :-------------------------------------------------------------------------------------------------- |
| `<expr>`   | A SQL expression of any type to evaluate.                                                |
| `<expr0>` | An expression used for the PARTITION clause. |
| `<expr1>` | An expression used for the order by clause. |

The return type of the function will be the same type as the expression to evaluate. This function respects `NULL` values, and results will be ordered with default null ordering `NULLS LAST` unless otherwise specified in the `ORDER BY` clause. If applied without an `ORDER BY` clause, the order will be undefined.

## Example
{: .no_toc}

The example below returns the highest test score for each grade level. 

```sql
SELECT
  first_name,
  grade_level,
  test_score,
  FIRST_VALUE(test_score) OVER (PARTITION BY grade_level ORDER BY test_score DESC) highest_score
FROM
    class_test;
```

**Returns**:

```sql
+------------+-------------+------------+---------------+
| first_name | grade_level | test_score | highest_score |
+------------+-------------+------------+---------------+
| Humphrey   |           9 |         90 |            90 |  
| Sammy      |           9 |         85 |            90 | 
| Peter      |           9 |         80 |            90 |
| Iris       |           9 |         79 |            90 |
| Jojo       |           9 |         78 |            90 |
| Frank      |           9 |         76 |            90 |
| Shawn      |          10 |         89 |            89 |
| Mary       |          10 |         85 |            89 |
| Deborah    |          10 |         78 |            89 |
| Albert     |          10 |         59 |            89 |
| Yolinda    |          10 |         30 |            89 |
| Roseanna   |          11 |         94 |            94 |
| Shangxiu   |          11 |         76 |            94 |
| Otis       |          11 |         75 |            94 |
| Wanda      |          11 |         73 |            94 |
| Larry      |          11 |         68 |            94 |
| Carol      |          11 |         52 |            94 |
| Charles    |          12 |        100 |           100 |
| Gary       |          12 |        100 |           100 |
| Franco     |          12 |         94 |           100 |
| Brunhilda  |          12 |         92 |           100 |
| Jesse      |          12 |         89 |           100 |
| Thomas     |          12 |         66 |           100 |
+------------+-------------+------------+---------------+
```

Note that you will get the same results using the [NTH_VALUE](../nth-value.md) function with n=1

```sql
SELECT
    first_name,
    grade_level,
    test_score,
    NTH_VALUE(test_score, 1) OVER (PARTITION BY grade_level ORDER BY test_score DESC) highest_score
FROM
    class_test;
```