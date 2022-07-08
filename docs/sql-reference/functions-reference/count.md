---
layout: default
title: COUNT (aggregation function)
description: Reference material for COUNT
parent: SQL functions
---


# COUNT

Counts the number of rows or not NULL values.

## Syntax
{: .no_toc}

```sql
COUNT([ DISTINCT ] <expr>)
```

| Parameter | Description                                                                                                                                                                                                           |
| :--------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Valid values for the expression include column names or functions that return a column name. When `DISTINCT` is being used, counts only the unique number of rows with no `NULL` values. |

{: .note}
> `COUNT(*)` returns a total count of all rows in the table, while `COUNT(<column_name>)` returns a count of non-NULL rows in the specified `<column_name>`.
>
> By default, `COUNT(DISTINCT)` returns approximate results. To get a precise result, with a performance penalty, use `SET firebolt_optimization_enable_exact_count_distinct=1;`

## Example
{: .no_toc}

For this example, we'll create a new table `number_test` as shown below.&#x20;

```sql
CREATE DIMENSION TABLE IF NOT EXISTS number_test
	(
		num TEXT
	);

INSERT INTO
	number_test
VALUES
	(1),
	(1),
	(2),
	(3),
	(3),
	(3),
	(4),
	(5);
```

Doing a regular `COUNT` returns the total number of rows in the column. We inserted 8 rows earlier, so it should return the same number.

```sql
SELECT
	COUNT(num)
FROM
	number_test;
```

**Returns**: `8`

A `COUNT(DISTINCT)` function on the same column returns the number of unique rows. There are five unique numbers that we inserted earlier.&#x20;

```sql
SELECT
	COUNT(DISTINCT num)
FROM
	number_test;
```

**Returns**: `5`
