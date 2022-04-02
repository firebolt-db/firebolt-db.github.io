---
layout: default
title: LEAD
description: Reference material for LEAD function
parent: SQL functions
---

# LEAD

Returns values from the row after the current row within the requested window.

For more information on usage, please refer to [Window Functions](./window-functions.md).

## Syntax
{: .no_toc}

```sql
LEAD ( <val> [, <offset> [, <default> ] )
    OVER ( [ PARTITION BY <exp> ] ORDER BY <exp> [ { ASC | DESC } ] )
```

| Parameter   | Description                                                                                                                                                           |
| :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<val>`     | Any valid expression that will be returned based on the `LEAD` `<offset>.`                                                                                            |
| `<expr>`    | The expression used for the `PARTITION BY` clause.                                                                                                                    |
| `<offset>`  | The number of rows forward from the current row from which to obtain a value.                                                                                         |
| `<default>` | The expression to return when the offset goes out of the bounds of the window. Supports any expression whose type is compatible with expression. The default is `NULL`. |

## Example
{: .no_toc}

In the example below, the `LEAD` function is being used to find the students in each grade level who are sitting next to each other. In some cases, a student does not have an adjacent classmate, so the `LEAD` function returns `NULL`.

```sql
SELECT
	first_name,
	grade_level,
	LEAD(first_name, -1) OVER (PARTITION BY grade_level ORDER BY first_name ) AS to_the_left,
	LEAD(first_name, 1) OVER (PARTITION BY grade_level ORDER BY first_name ) AS to_the_right
FROM
	class_test;
```

**Returns**:

```
+------------+-------------+-------------+--------------+
| first_name | grade_level | to_the_left | to_the_right |
+------------+-------------+-------------+--------------+
| Frank      |           9 | NULL        | Humphrey     |
| Humphrey   |           9 | Frank       | Iris         |
| Iris       |           9 | Humphrey    | Jojo         |
| Sammy      |           9 | Peter       | NULL         |
| Peter      |           9 | Jojo        | Sammy        |
| Jojo       |           9 | Iris        | Peter        |
| Brunhilda  |          12 | NULL        | Charles      |
| Franco     |          12 | Charles     | Gary         |
| Thomas     |          12 | Jesse       | NULL         |
| Gary       |          12 | Franco      | Jesse        |
| Charles    |          12 | Brunhilda   | Franco       |
| Jesse      |          12 | Gary        | Thomas       |
| Roseanna   |          11 | Otis        | Shangxiu     |
| Carol      |          11 | NULL        | Larry        |
| Wanda      |          11 | Shangxiu    | NULL         |
| Shangxiu   |          11 | Roseanna    | Wanda        |
| Larry      |          11 | Carol       | Otis         |
| Otis       |          11 | Larry       | Roseanna     |
| Deborah    |          10 | Albert      | Mary         |
| Yolinda    |          10 | Shawn       | NULL         |
| Albert     |          10 | NULL        | Deborah      |
| Mary       |          10 | Deborah     | Shawn        |
| Shawn      |          10 | Mary        | Yolinda      |
+------------+-------------+-------------+--------------+
```
