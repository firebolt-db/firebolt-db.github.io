---
layout: default
title: NTH_VALUE
description: Reference material for NTH_VALUE function
parent: SQL functions
---

# NTH_VALUE

Returns the value evaluated of the nth row of the specified window frame (starting at the first row). If the specified row does not exist, NTH_VALUE returns NULL.

See also [FIRST\_VALUE](../first-value.md), which returns the first value evaluated in the specified window frame.

## Syntax
{: .no_toc}

```sql
NTH_VALUE( <expr>, <n> ) OVER ( [ PARTITION BY <expr0> ] ORDER BY <expr1> [ASC|DESC] )
```

| Parameter | Description                                                                                        |
| :--------- | :-------------------------------------------------------------------------------------------------- |
| `<expr>`   | A SQL expression of any type to evaluate.                                                |
| `<n>`     | A constant integer in range [1, max of datatype long] to indicate the row number to evaluate. |
| `<expr0>` | An expression used for the PARTITION clause. |
| `<expr1>` | An expression used for the order by clause. |

The return type of the function will be the same type as the expression to evaluate. This function respects `NULL` values, and results will be ordered with default null ordering `NULLS LAST` unless otherwise specified in the `ORDER BY` clause. If applied without an `ORDER BY` clause, the order will be undefined.

## Example
{: .no_toc}

The example below returns the student with the second highest test score for each grade level. Notice that the function returns `NULL` for the first row in each partition, unless the value of the expression for first and second rows of the partition are equal. 

```sql
SELECT
    first_name,
    grade_level,
    test_score,
    NTH_VALUE(first_name, 2) OVER (PARTITION BY grade_level ORDER BY test_score DESC) second_highest_score
FROM
    class_test;
```

**Returns**:

```sql
+------------+-------------+------------+----------------------+
| first_name | grade_level | test_score | second_highest_score |
+------------+-------------+------------+----------------------+
| Humphrey   |           9 |         90 |                null  |  
| Sammy      |           9 |         85 |                Sammy |
| Peter      |           9 |         80 |                Sammy |
| Iris       |           9 |         79 |                Sammy |
| Jojo       |           9 |         78 |                Sammy |
| Frank      |           9 |         76 |                Sammy |
| Shawn      |          10 |         89 |                 null |
| Mary       |          10 |         85 |                 Mary |
| Deborah    |          10 |         78 |                 Mary |
| Albert     |          10 |         59 |                 Mary |
| Yolinda    |          10 |         30 |                 Mary |
| Roseanna   |          11 |         94 |                 null |
| Shangxiu   |          11 |         76 |             Shangxiu |
| Otis       |          11 |         75 |             Shangxiu |
| Wanda      |          11 |         73 |             Shangxiu |
| Larry      |          11 |         68 |             Shangxiu |
| Carol      |          11 |         52 |             Shangxiu |
| Charles    |          12 |        100 |              Charles |
| Gary       |          12 |        100 |              Charles |
| Franco     |          12 |         94 |              Charles |
| Brunhilda  |          12 |         92 |              Charles |
| Jesse      |          12 |         89 |              Charles |
| Thomas     |          12 |         66 |              Charles |
+------------+-------------+------------+----------------------+
```