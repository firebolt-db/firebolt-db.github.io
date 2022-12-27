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


`COUNT(*)` returns a total count of all rows in the table, while `COUNT(<column_name>)` returns a count of non-NULL rows in the specified `<column_name>`.

{: .note}
> By default, `COUNT(DISTINCT)` returns approximate results. If you require a precise result (with a performance penalty), please contact Firebolt Support through the Help menu support form. 

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

To understand the difference between `COUNT(DISTINCT pk)` with exact precision enabled and using default approximation, consider a table, `count_test` with 8,388,608 unique `pk` values. The `APPROX_COUNT_DISTINCT` function returns the same approximate results as the `COUNT(DISTINCT)` function with exact precision disabled, so we can see the difference between these methods with the following example. 

```sql
SELECT
	COUNT(DISTINCT pk) as count_distinct,
	APPROX_COUNT_DISTINCT(pk) as approx_count
FROM
	count_test;
```

**Returns**: 

Assuming 8,388,608 unique pk values, we will see results like: 


```sql
' +----------------+--------------+
' | count_distinct | approx_count |
' +----------------+--------------+
' |      8,388,608 |    8,427,387 |
' +----------------+--------------+
```
