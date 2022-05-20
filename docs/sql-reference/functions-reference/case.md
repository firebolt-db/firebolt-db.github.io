---
layout: default
title: CASE
description: Reference material for CASE function
parent: SQL functions
---
# CASE

The CASE expression is a conditional expression similar to if-then-else statements.\
If the result of the condition is true then the value of the CASE expression is the result that follows the condition.  If the result is false any subsequent WHEN clauses (conditions) are searched in the same manner.  If no WHEN condition is true then the value of the case expression is the result specified in the ELSE clause.  If the ELSE clause is omitted and no condition matches, the result is null.

## Syntax
{: .no_toc}

```sql
CASE
    WHEN <condition> THEN <result>
    [WHEN ...n]
    [ELSE <result>]
END;
```

| Parameter     | Description                                                                                                                                             |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<condition>` | An expression that returns a boolean result.  A condition can be defined for each `WHEN`, and `ELSE` clause.                                               |
| `<result>`    | The result of any condition. Every `THEN` clause receives a single result. All results in a single `CASE` function must share the same data type. |

## Example
{: .no_toc}

This example references a table `Movie_test` with the following columns and values:&#x20;

| Movie                | Length |
| :-------------------- | :------ |
| Citizen Kane         | 114    |
| Happy Gilmore        | 82     |
| Silence of the Lambs | 110    |
| The Godfather        | 150    |
| The Jazz Singer      | 40     |
| Tropic Thunder       | 90     |

The following example categorizes each entry by length. If the movie is longer than zero minutes and less than 50 minutes it is categorized as SHORT. When the length is 50-120 minutes, it's categorized as Medium, and when even longer, it's categorized as Long.

```sql
SELECT
	movie,
	length,
	CASE
		WHEN length > 0
		AND length <= 50 THEN 'Short'
		WHEN length > 50
		AND length <= 120 THEN 'Medium'
		WHEN length > 120 THEN 'Long'
	END duration
FROM
	movie_test
ORDER BY
	movie;
```

**Returns**:

```
+----------------------+--------+----------+
|        Title         | Length | duration |
+----------------------+--------+----------+
| Citizen Kane         |    114 | Medium   |
| Happy Gilmore        |     82 | Medium   |
| Silence of the Lambs |    110 | Medium   |
| The Godfather        |    150 | Long     |
| The Jazz Singer      |     40 | Short    |
| Tropic Thunder       |     90 | Medium   |
+----------------------+--------+----------+
```
