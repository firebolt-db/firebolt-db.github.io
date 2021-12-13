---
layout: default
title: Window functions
nav_order: 7

parent: SQL functions reference
---

# Window Functions

A window function performs a calculation across a set of table rows. Unlike regular aggregate functions, the use of a window function does not cause rows to become grouped into a single output row but allows the rows to retain their separate identities.

Window functions are identified by the `OVER()` syntax.

To narrow down the window dataset into individual groups, use the `PARTITION BY` clause. In case this clause is not used, a single window is being created.

This page describes the window functions supported in Firebolt.

## AVG

Returns the average value within the requested window.

**Syntax**

```sql
AVG( <val> ) OVER ( [ PARTITION BY <exp> ] )
```

|           |                                                 |
| :--------- | :----------------------------------------------- |
| Parameter | Description                                     |
| `<val>`   | An expression used for the `AVG()` function.    |
| `<expr>`  | An expression used for the partition by clause. |

**Example**

The example below is querying test scores for students in various grade levels. Unlike a regular `AVG()` aggregation, the window function allows us to see how each student individually compares to the average test score for their grade level.

```sql
SELECT
	First_name,
	Grade_level,
	Test_score,
	AVG(Test_score) OVER (PARTITION BY Grade_level) AS average_for_grade
FROM
	class_test
```

**Returns**

```
' +------------+-------------+------------+-------------------------+
' | First_name | Grade_level | Test_score |    average_for_grade    |
' +------------+-------------+------------+-------------------------+
' | Frank      |           9 |         76 | 81.33333333333333       |
' | Humphrey   |           9 |         90 | 81.33333333333333       |
' | Iris       |           9 |         79 | 81.33333333333333       |
' | Sammy      |           9 |         85 | 81.33333333333333       |
' | Peter      |           9 |         80 | 81.33333333333333       |
' | Jojo       |           9 |         78 | 81.33333333333333       |
' | Brunhilda  |          12 |         92 | 89                      |
' | Franco     |          12 |         94 | 89                      |
' | Thomas     |          12 |         66 | 89                      |
' | Gary       |          12 |        100 | 89                      |
' | Charles    |          12 |         93 | 89                      |
' | Jesse      |          12 |         89 | 89                      |
' | Roseanna   |          11 |         94 | 73                      |
' | Carol      |          11 |         52 | 73                      |
' | Wanda      |          11 |         73 | 73                      |
' | Shangxiu   |          11 |         76 | 73                      |
' | Larry      |          11 |         68 | 73                      |
' | Otis       |          11 |         75 | 73                      |
' | Deborah    |          10 |         78 | 68.2                    |
' | Yolinda    |          10 |         30 | 68.2                    |
' | Albert     |          10 |         59 | 68.2                    |
' | Mary       |          10 |         85 | 68.2                    |
' | Shawn      |          10 |         89 | 68.2                    |
' +------------+-------------+------------+-------------------------+
```

## COUNT

Count the number of values within the requested window.

**Syntax**

```sql
COUNT( <val> ) OVER ( [ PARTITION BY <exp> ] )
```
| Parameter | Description                                      |
| :--------- | :------------------------------------------------ |
| `<val>`   | An expression used for the `COUNT()` function.   |
| `<expr>`  | An expression used for the `PARTITION BY` clause |

**Example**

This example below generates a count of how many students are in each grade level while leaving each student as an independent row.

```sql
SELECT
	First_name,
	Grade_level,
	COUNT(First_name) OVER (PARTITION BY Grade_level) AS count_of_students
FROM
	class_test
```

**Returns**

```
+------------+-------------+-------------------+
| First_name | Grade_level | count_of_students |
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

## DENSE\_RANK

Rank the current row within the requested window.

**Syntax**

```sql
DENSE_RANK() OVER ([PARTITION BY <val>] ORDER BY <exp> [ASC|DESC] )
```

| Parameter | Description                                                                                       |
| :--------- | :------------------------------------------------------------------------------------------------- |
| `<val>`   | The expression used for the `PARTITION BY` clause.                                                |
| `<exp>`    | The expression used in the `ORDER BY` clause. This parameter determines what value will be ranked.  |

**Example**

In this example below, students are ranked based on their test scores for their grade level.

```
SELECT
	First_name,
	Grade_level,
	Test_score,
	DENSE_RANK() OVER (PARTITION BY Grade_level ORDER BY Test_score DESC ) AS Rank_in_class
FROM
	class_test
```

**Returns:**

```
+------------+-------------+------------+---------------+
| First_name | Grade_level | Test_score | Rank_in_class |
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

## LAG

Returns the value of the input expression at the given offset before the current row within the requested window.

**Syntax**

```sql
LAG ( <exp> [, <offset> [, <default> ]] )
    OVER ( [ PARTITION BY <exp> ] ORDER BY <exp> [ { ASC | DESC } ] )
```

| Parameter   | Description                                                                                                                  |
| :----------- | :---------------------------------------------------------------------------------------------------------------------------- |
| `<val>`     | Any valid expression that will be returned based on the `LAG` `<offset>.`                                                    |
| `<expr>`    | The expression used for the `PARTITION BY` clause.                                                                           |
| `<offset>`  | The number of rows backward from the current row from which to obtain a value. A negative number will act as `LEAD()`        |
| `<default>` | The expression to return when the offset goes out of the bounds of the window. Must be a literal `INT`. The default is `NULL`. |

**Example**

In the example below, the `LAG `function is being used to find the students in each grade level who are sitting next to each other. In some cases, a student does not have an adjacent classmate, so the `LAG `function returns `NULL`.

```sql
SELECT
	First_name,
	Grade_level,
	LAG(First_name, 1) OVER (PARTITION BY Grade_level ORDER BY First_name ) AS To_the_left,
	LAG(First_name, -1) OVER (PARTITION BY Grade_level ORDER BY First_name ) AS To_the_right
FROM
	class_test
```

**Returns:**

```
+------------+-------------+-------------+--------------+
| First_name | Grade_level | To_the_left | To_the_right |
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

## LEAD

Returns values from the row after the current row within the requested window.

**Syntax**

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

**Example**

In the example below, the `LEAD `function is being used to find the students in each grade level who are sitting next to each other. In some cases, a student does not have an adjacent classmate, so the `LEAD `function returns `NULL`.

```sql
SELECT
	First_name,
	Grade_level,
	LEAD(First_name, -1) OVER (PARTITION BY Grade_level ORDER BY First_name ) AS To_the_left,
	LEAD(First_name, 1) OVER (PARTITION BY Grade_level ORDER BY First_name ) AS To_the_right
FROM
	class_test;
```

**Returns:**

```
+------------+-------------+-------------+--------------+
| First_name | Grade_level | To_the_left | To_the_right |
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

## MIN

Returns the minimum value within the requested window.

**Syntax**

```sql
MIN( <exp> ) OVER ( [ PARTITION BY <exp> ] )
```

| Parameter | Description                                                      |
| :--------- | :---------------------------------------------------------------- |
| `<val>`   | <p>An expression used for the <code>MIN </code>function.<br></p> |
| `<exp>`   | An expression used for the `PARTITION BY` clause.                |

**Example**

The example below queries test scores for students in various grade levels. Unlike a regular `MIN()` aggregation, the window function allows us to see how each student individually compares to the lowest test score for their grade level.&#x20;

```sql
SELECT
	First_name,
	Grade_level,
	Test_score,
	MIN(Test_score) OVER (PARTITION BY Grade_level) AS Lowest_score
FROM
	class_test
```

**Returns:**

```
+------------+-------------+------------+--------------+
| First_name | Grade_level | Test_score | Lowest_score |
+------------+-------------+------------+--------------+
| Frank      |           9 |         76 |           76 |
| Humphrey   |           9 |         90 |           76 |
| Iris       |           9 |         79 |           76 |
| Sammy      |           9 |         85 |           76 |
| Peter      |           9 |         80 |           76 |
| Jojo       |           9 |         78 |           76 |
| Brunhilda  |          12 |         92 |           66 |
| Franco     |          12 |         94 |           66 |
| Thomas     |          12 |         66 |           66 |
| Gary       |          12 |        100 |           66 |
| Charles    |          12 |         93 |           66 |
| Jesse      |          12 |         89 |           66 |
| Roseanna   |          11 |         94 |           52 |
| Carol      |          11 |         52 |           52 |
| Wanda      |          11 |         73 |           52 |
| Shangxiu   |          11 |         76 |           52 |
| Larry      |          11 |         68 |           52 |
| Otis       |          11 |         75 |           52 |
| Deborah    |          10 |         78 |           30 |
| Yolinda    |          10 |         30 |           30 |
| Albert     |          10 |         59 |           30 |
| Mary       |          10 |         85 |           30 |
| Shawn      |          10 |         89 |           30 |
+------------+-------------+------------+--------------+
```

## MAX

Returns the maximum value within the requested window.

**Syntax**

```sql
MAX( <exp> ) OVER ( [ PARTITION BY <exp> ] )
```

| Parameter | Description                                       |
| :--------- | :------------------------------------------------- |
| `<val>`   | An expression used for the `MAX `function.        |
| `<exp>`   | An expression used for the `PARTITION BY` clause. |

**Example**

The example below queries test scores for students in various grade levels. Unlike a regular `MAX()` aggregation, the window function allows us to see how each student individually compares to the highest test score for their grade level.&#x20;

```sql
SELECT
	First_name,
	Grade_level,
	Test_score,
	MAX(Test_score) OVER (PARTITION BY Grade_level) AS Highest_score
FROM
	class_test
```

**Returns:**

```
+------------+-------------+------------+---------------+
| First_name | Grade_level | Test_score | Highest_score |
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

## RANK

Rank the current row within the requested window with gaps.

**Syntax**

```sql
RANK() OVER ([PARTITION BY <exp>] ORDER BY <exp> [ASC|DESC] )
```

| Parameter | Description                                                                                        |
| :--------- | :-------------------------------------------------------------------------------------------------- |
| `<val>`   | The expression used for the `PARTITION BY` clause.                                                 |
| `<exp>`   | The expression used in the `ORDER BY` clause. This parameter determines what value will be ranked. |

**Example**

In this example below, students are ranked based on their test scores for their grade level.

```sql
SELECT
	First_name,
	Grade_level,
	Test_score,
	RANK() OVER (PARTITION BY Grade_level ORDER BY Test_score DESC ) AS Rank_in_class
FROM
	class_test
```

**Returns:**

```sql
+------------+-------------+------------+---------------+
| First_name | Grade_level | Test_score | Rank_in_class |
+------------+-------------+------------+---------------+
| Frank      |           9 |         76 |             6 |
| Humphrey   |           9 |         90 |             1 |
| Iris       |           9 |         79 |             4 |
| Sammy      |           9 |         85 |             2 |
| Peter      |           9 |         80 |             3 |
| Jojo       |           9 |         78 |             5 |
| Brunhilda  |          12 |         92 |             4 |
| Franco     |          12 |         94 |             2 |
| Thomas     |          12 |         66 |             6 |
| Gary       |          12 |        100 |             1 |
| Charles    |          12 |         93 |             3 |
| Jesse      |          12 |         89 |             5 |
| Roseanna   |          11 |         94 |             1 |
| Carol      |          11 |         52 |             6 |
| Wanda      |          11 |         73 |             4 |
| Shangxiu   |          11 |         76 |             2 |
| Larry      |          11 |         68 |             5 |
| Otis       |          11 |         75 |             3 |
| Deborah    |          10 |         78 |             3 |
| Yolinda    |          10 |         30 |             5 |
| Albert     |          10 |         59 |             4 |
| Mary       |          10 |         85 |             2 |
| Shawn      |          10 |         89 |             1 |
+------------+-------------+------------+---------------+
```

## ROW\_NUMBER

Returns a unique row number for each row within the requested window.

**Syntax**

```sql
ROW_NUMBER() OVER ([PARTITION BY <exp>] ORDER BY <exp> [ASC|DESC] )
```

| Parameter | Desccription                                                                                                      |
| :--------- | :----------------------------------------------------------------------------------------------------------------- |
| `<val>`   | The expression used for the `PARTITION BY` clause.                                                                |
| `<exp>`   | The expression used in the `ORDER BY` clause. This parameter determines what value will be used for `ROW_NUMBER`. |

**Example**

In this example below, students in each grade level are** **assigned a unique number.

```sql
SELECT
	First_name,
	Grade_level,
	ROW_NUMBER() OVER (PARTITION BY Grade_level ORDER BY Grade_level ASC ) AS Student_No
FROM
	class_test
```

**Returns:**

```
+------------+-------------+------------+
| First_name | Grade_level | Student_No |
+------------+-------------+------------+
| Frank      |           9 |          1 |
| Humphrey   |           9 |          2 |
| Iris       |           9 |          3 |
| Sammy      |           9 |          4 |
| Peter      |           9 |          5 |
| Jojo       |           9 |          6 |
| Brunhilda  |          12 |          1 |
| Franco     |          12 |          2 |
| Thomas     |          12 |          3 |
| Gary       |          12 |          4 |
| Charles    |          12 |          5 |
| Jesse      |          12 |          6 |
| Roseanna   |          11 |          1 |
| Carol      |          11 |          2 |
| Wanda      |          11 |          3 |
| Shangxiu   |          11 |          4 |
| Larry      |          11 |          5 |
| Otis       |          11 |          6 |
| Deborah    |          10 |          1 |
| Yolinda    |          10 |          2 |
| Albert     |          10 |          3 |
| Mary       |          10 |          4 |
| Shawn      |          10 |          5 |
+------------+-------------+------------+
```

## SUM

Calculate the sum of the values within the requested window.

The SUM function works with numeric values and ignores `NULL `values.

**Syntax**

```sql
SUM( <val> ) OVER ( [ PARTITION BY <expr> ] )
```

| Parameter | Description                                      |
| :--------- | :------------------------------------------------ |
| `<val>`   | The expression used for the `SUM `function       |
| `<expr>`  | An expression used for the `PARTITION BY` clause |

**Example**

The example below shows how many vaccinated students are in the same grade level for each student.&#x20;

```sql
SELECT
	First_name,
	SUM(Vaccinated) OVER (PARTITION BY Grade_level ) AS Vaccinated_Students
FROM
	class_test
```

**Returns:**

```
+------------+---------------------+
| First_name | Vaccinated_Students |
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
