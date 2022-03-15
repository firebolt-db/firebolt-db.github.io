---
layout: default
title: ILIKE
description: Reference material for ILIKE function
parent: SQL functions
---

## ILIKE

Allows matching of strings based on comparison to a pattern. `ILIKE` is normally used as part of a `WHERE` clause.

##### Syntax
{: .no_toc}

```sql
<expr> ILIKE '<pattern>'
```

| Parameter   | Description                                                                                                                                                                                                                                                                              |
| :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`    | Any expression that evaluates to a `TEXT`, `STRING`, or `VARCHAR` data type.                                                                                                                                                                                                             |
| `<pattern>` | Specifies the pattern to match and is case-insensitive. SQL wildcards are supported: <br> <br>* Use an underscore (`_`) to match any single character<br>* Use a percent sign (`%`) to match any number of any characters, including no characters. |

**Example**

For this example, we will create and load data into a demonstration table `match_test`:

```sql
CREATE DIMENSION TABLE match_test (first_name TEXT, last_name TEXT);

INSERT INTO
	match_test
VALUES
	('Sammy', 'Sardine'),
	('Franco', 'Fishmonger'),
	('Carol', 'Catnip'),
	('Thomas', 'Tinderbox'),
	('Deborah', 'Donut'),
	('Humphrey', 'Hoagie'),
	('Frank', 'Falafel');
```

We can match first names that partially match the string "Fran" and any following characters as follows:

```sql
SELECT
	*
FROM
	match_test
WHERE
	first_name ILIKE 'Fran%';
```

**Returns**:

```
+------------+------------+
| first_name | last_name  |
+------------+------------+
| Frank      | Falafel    |
| Franco     | Fishmonger |
+------------+------------+
```
