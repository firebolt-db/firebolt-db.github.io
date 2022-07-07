---
layout: default
title: SELECT
description: Reference and syntax for SELECT queries.
parent: SQL commands
---

# SELECT query syntax
{: .no_toc}

Firebolt supports running `SELECT` statements with the syntax described in this topic. You can run multiple queries in a single script. Separating them with a semicolon (`;`) is required. Firebolt also supports `CREATE TABLE...AS SELECT` (CTAS). For more information, see [CREATE TABLE...AS SELECT](create-fact-dimension-table-as-select.md).

* Topic ToC
{:toc}

## Syntax

```sql
[ WITH <with_query> [, ...n] ]
SELECT [ DISTINCT ] {<select_expr> [, ...]}
    [ FROM <from_item> [, ...] ]
    [ WHERE <condition> ]
    [ GROUP BY <grouping_element> [, ...] ]
    [ HAVING <condition> [, ...] ]
    [ UNION <select_expr> [ ...n]
    [ ORDER BY <expression> [ ASC | DESC ] [ NULLS FIRST | NULLS LAST] [, ...] ]
    [ LIMIT <count> ]
    [ OFFSET <start> ]
```



## WITH

The `WITH` clause is used for subquery refactoring so that you can specify subqueries and then reference them as part of the main query. This simplifies the hierarchy of the main query, enabling you to avoid using multiple nested sub-queries.

In order to reference the data from the `WITH` clause, a name must be specified for it. This name is then treated as a temporary relation table during query execution.

Each subquery can comprise a `SELECT`, `TABLE`, `VALUES`, `INSERT`, `UPDATE`, or `DELETE `statement. The `WITH `clause is the only clause that precedes the main query.

The primary query and the queries included in the `WITH` clause are all executed at the same time; `WITH` queries are evaluated only once every time the main query is executed, even if the clause is referred to by the main query more than once.

When using the `WITH `clause as part of a DML command, it must include a `RETURNING` clause as well, without which the main query cannot reference the WITH clause.

### Materialized common table expressions (Beta)
{: .no_toc}

The query hint `MATERIALIZED` or `NOT MATERIALIZED` controls whether common table expressions (CTEs) produce an internal results table that is cached in engine RAM (`MATERIALIZED`) or calculated each time the sub-query runs. `NOT MATERIALIZED` is the default. `MATERIALIZED` must be specified explicitly.

Materialized results can be accessed more quickly in some circumstances. By using the proper materialization hint, you can control when a CTE gets materialized and improve query performance. We recommend the `MATERIALIZED` hint to improve query performance in the following circumstances:

* The CTE is reused at the main query level more than once.

* The CTE is computationally expensive, producing a relatively small number of rows.

* The CTE calculation is independent of the main query, and no external optimizations from the main table are needed for it to be fast.

* The materialized CTE fits into the nodes’ ram.

### Syntax
{: .no_toc}

```sql
WITH <subquery_table_name> [ <column_name> [, ...n] ] AS [MATERIALIZED|NOT MATERIALIZED] <subquery>
```

| Component               | Description                                                                          |
| :----------------------- | :------------------------------------------------------------------------------------ |
| `<subquery_table_name>` | A unique name for a temporary table.                                                       |
| `<column_name>`         | An optional list of one or more column names. Columns should be separated by commas. |
| `<subquery>`            | Any query statement.                                                                  |

### Example
{: .no_toc}

The following example retrieves all customers from the "EMEA" region, having the results of the `WITH` query in the temporary table `emea_customrs`.

The results of the main query then list the `customer_name` and `contact_details `for those customers, sorted by name.

```sql
WITH emea_customrs AS (
	SELECT
		*
	FROM
		customers
	WHERE
		region = 'EMEA'
)
SELECT
	customer_name,
	contact_details
FROM
	emea_customrs
ORDER BY
	customer_name
```

## FROM

Use the `FROM` clause to list the tables and any relevant join information and functions necessary for running the query.

### Syntax
{: .no_toc}

```sql
FROM <from_item> [, ...n]
```

| Component     | Description                                                           |
| :------------- | :--------------------------------------------------------------------- |
| `<from_item>` | Indicates the table or tables from which the data is to be retrieved. |

### Example
{: .no_toc}

In the following example, the query retrieves all entries from the `customers` table for which the `region` value is "EMEA".

```sql
SELECT
	*
FROM
	customers
WHERE
	region = 'EMEA'
```

## JOIN

A `JOIN` operation combines rows from two data sources, such as tables or views, and creates a new table of combined rows that can be used in a query.  

`JOIN` operations can be used with an `ON` clause for conditional logic or a `USING` clause to specify columns to match.

### JOIN with ON clause syntax
{: .no_toc}

```sql
FROM <join_table1> [ INNER | LEFT | RIGHT | FULL ] JOIN <join_table2> ON <join_condition>
```

|     Parameters      |                                                                          Description                                                                          |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `<join_table1>`       | A table or view to be used in the join operation                                                                                                              |
| `<join_table2>`       | A second table or view to be used in the join operation                                                                                                       |
| `ON <join_condition>` | One or more boolean comparison expressions that specify the logic to join the two specified tables and which columns should be compared. For example: `ON join_table1.column = join_table2.column` |



### JOIN with USING clause syntax  
{: .no_toc}

```sql
FROM <join_table1> [ INNER | LEFT | RIGHT | FULL ] JOIN <join_table2> USING (column_list)
```

|      Component      |                                                                                                      Description                                                                                                      |
| :--------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<join_table1>`       | A table or view to be used in the join operation                                                                                                                                                                      |
| `<join_table2>`       | A second table or view to be used in the join operation.                                                                                                                                                              |
| `USING (column_list)` | A list of one or more columns to compare for exact matching. `USING` is a shortcut to join tables that share the same column names. The specified columns are joined via a basic match condition. The match condition of `USING (column)` is equivalent to `ON join_table1.column = join_table2.column` |

### JOIN Types
{: .no_toc}

The type of `JOIN` operation specifies which rows are included between two specified tables. If unspecified, `JOIN` defaults to `INNER JOIN`.

`JOIN` types include:


| `[INNER] JOIN`        |  When used with an `ON` clause, `INNER JOIN` includes only rows that satisfy the `<join_condition>` . When used with a `USING` clause, `INNER JOIN` includes rows only if they have matching values for the specified columns in the `column_list`. |
| `LEFT [OUTER] JOIN`   |  Includes all rows from `<join_table1>` but excludes any rows from `<join_table2>` that don’t satisfy the `<join_condition>`. `LEFT JOIN` is equivalent to `LEFT OUTER JOIN`.                                           |
| `RIGHT [OUTER] JOIN`  |  Includes all rows from `<join_table2>` but excludes any rows from `<join_table1>` that don’t satisfy the `<join_condition>`. `RIGHT JOIN` is equivalent to `RIGHT OUTER JOIN`.                                         |
| `FULL [OUTER] JOIN`   |  Includes all rows from both tables matched where appropriate with the `<join_condition>`. `FULL JOIN` is equivalent to `FULL OUTER JOIN`.                                                                              |
| `CROSS JOIN`          |  Includes every possible combination of rows from `<join_table1>` and `<join_table2>`. A `CROSS JOIN` does not use an `ON` or `USING` clause.                                                                           |

### Examples
{: .no_toc}

The `JOIN` examples below use two tables, `num_test` and `num_test2`. These tables are created and populated with data as follows.

```sql
CREATE DIMENSION TABLE num_test (
    firstname varchar,
    score integer);

INSERT INTO num_test VALUES
    ('Carol', 11),
    ('Albert', 50),
    ('Sammy', 90),
    ('Peter', 50),
    ('Deborah', 90),
    ('Frank', 87),
    ('Thomas', 85),
    ('Humphrey', 56);

CREATE DIMENSION TABLE num_test2 (
    firstname varchar,
    score integer);

INSERT INTO num_test2 VALUES
    ('Sammy', 90),
    ('Hector', 56),
    ('Tom', 85),
    ('Peter', 50),
    ('Carl', 100),
    ('Frank', 87),
    ('Deborah', 90),
    ('Albert', 50);
```

The tables and their data are shown below.

| num_test.firstname | num_test.score | num_test2.firstname | num_test2.score |
| :--------------------| :----------------| :---------------------| :-----------------|
| Carol              |             11 | Sammy               |              90 |
| Albert             |             50 | Hector              |              56 |
| Sammy              |             90 | Tom                 |              85 |
| Peter              |             50 | Peter               |              50 |
| Deborah            |             90 | Carl                |             100 |
| Frank              |             87 | Frank               |              87 |
| Thomas             |             85 | Deborah             |              90 |
| Humphrey           |             56 | Albert              |              50 |

#### INNER JOIN example
{: .no_toc}

The `INNER JOIN` example below includes only the rows where the `firstname` and `score` values match.

``` sql
SELECT
    *
FROM
    num_test
INNER JOIN
    num_test2
    USING (
        firstname,
        score
	);
```

This query is equivalent to:

``` sql
SELECT
    *
FROM
    num_test
INNER JOIN
    num_test2
        ON num_test.firstname = num_test2.firstname
        AND num_test.score = num_test2.score;
```

**Returns**

| num_test.firstname | num_test.score | num_test2.firstname | num_test2.score |
| :-----------| :-------| :------------| :--------|
| Sammy     |    90 | Sammy      |     90 |
| Peter     |    50 | Peter      |     50 |
| Albert    |    50 | Albert     |     50 |
| Deborah   |    90 | Deborah    |     90 |
| Frank     |    87 | Frank      |     87 |

#### LEFT OUTER JOIN example
{: .no_toc}

The `LEFT OUTER JOIN` example below includes all `firstname` values from the `num_test` table. Any rows with no matching value in the `num_test2` table return `NULL`.  

``` sql
SELECT
    num_test.firstname,
    num_test2.firstname
FROM num_test
LEFT OUTER JOIN
    num_test2
    USING (firstname);
```

**Returns**

| num_test.firstname | num_test2.firstname |
|:-----------| :------------|
| Sammy     | Sammy      |
| Peter     | Peter      |
| Carol     | NULL       |
| Albert    | Albert     |
| Thomas    | NULL       |
| Humphrey  | NULL       |
| Deborah   | Deborah    |
| Frank     | Frank      |

#### RIGHT OUTER JOIN example
{: .no_toc}

The `RIGHT OUTER JOIN` example below includes all `firstname` values from `num_test2`. Any rows with no matching values in the `num_test` table return `NULL`.

``` sql
SELECT
    num_test.firstname,
    num_test2.firstname
FROM
    num_test
RIGHT OUTER JOIN
    num_test2
    USING (firstname);
```

**Returns**

| num_test.firstname | num_test2.firstname |
| :-----------| :------------|
| Sammy     | Sammy      |
| Peter     | Peter      |
| Albert    | Albert     |
| Deborah   | Deborah    |
| Frank     | Frank      |
| NULL      | Tom        |
| NULL      | Carl       |
| NULL      | Hector     |

#### FULL OUTER JOIN example
{: .no_toc}

The `FULL OUTER JOIN` example below includes all values from `num_test` and `num_test2`. Any rows with no matching values return `NULL`.

``` sql
SELECT
    num_test.firstname,
    num_test2.firstname
FROM
    num_test
FULL OUTER JOIN
    num_test2
    USING (firstname);
```

**Returns**

| num_test.firstname | num_test2.firstname |
| :-----------| :------------|
| Sammy     | Sammy      |
| Peter     | Peter      |
| Deborah   | Deborah    |
| Frank     | Frank      |
| Carol     | NULL       |
| Albert    | Albert     |
| Thomas    | NULL       |
| Humphrey  | NULL       |
| NULL      | Tom        |
| NULL      | Carl       |
| NULL      | Hector     |

#### CROSS JOIN example
{: .no_toc}

A `CROSS JOIN` produces a table with every combination of row values in the specified columns.

This example uses two tables, `crossjoin_test` and `crossjoin_test2`, each with a single `letter` column. The tables contain the following data.

| crossjoin_test.letter | crossjoin_test2.letter |
| :-----------| :------------|
| a     | x      |
| b     | y      |
| c   | z    |

The `CROSS JOIN` example below produces a table of every possible pairing of these rows.

``` sql
SELECT
    crossjoin_test.letter,
    crossjoin_test2.letter
FROM
    crossjoin_test
CROSS JOIN
    crossjoin_test2;
```

**Returns**

| crossjoin_test.letter | crossjoin_test2.letter |
| :-------| :---------|
| a      | x       |
| a      | y       |
| a      | z       |
| b      | x       |
| b      | y       |
| b      | z       |
| c      | x       |
| c      | y       |
| c      | z       |



## UNNEST

An `UNNEST` operator performs join between the table in the left side, and the array in the right side. The output table repeats rows of the table from the left for every element of the array. If the array is empty, the corresponding row from the table is eliminated.

### Syntax
{: .no_toc}

```sql
FROM <from_item> UNNEST(<array_column> [[ AS ] <alias_name>][,<array_column>...])
```

| Component     | Description                                                                                                               | Valid values and syntax                |
| :------------- | :------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------- |
| `<from_item>` | The table containing the array column that you want to use to create a new table                                          |                                        |
| `<expr>`      | Indicates the array or array column to unnest from.  Can be either an array literal or an array typed column. | Any valid array literal or column name |

### Example
{: .no_toc}

The example is based on the following table:

```sql
CREATE FACT TABLE table_with_arrays
(
    product TEXT,
    cost ARRAY(INT)
) PRIMARY INDEX product;
```

Assume the table was populated and contains the following values:

| product | cost     |
| :------- | :-------- |
| apple   | \[2,5]   |
| orange  | \[3,6,7] |

The following query with `UNNEST`:

```sql
SELECT
	product,
	cost
FROM
	table_with_arrays UNNEST(cost);
```

Returns the following result:

| product | cost |
| :------- | :---- |
| apple   | 2    |
| apple   | 5    |
| orange  | 3    |
| orange  | 6    |
| orange  | 7    |

## WHERE

Use the `WHERE` clause to define conditions for the query in order to filter the query results. When included, the `WHERE` clause always follows the `FROM` clause as part of a command such as `SELECT`.

### Syntax
{: .no_toc}

```sql
WHERE <condition>
```

| Component     | Description                            | Valid values and syntax       |
| :------------- | :-------------------------------------- | :----------------------------- |
| `<condition>` | Indicates the conditions of the query. | Any valid boolean expression. |

### Example
{: .no_toc}

In the following example, the query retrieves all entries from the `customers` table for which the `region` value is "EMEA".

```sql
SELECT
	*
FROM
	customers
WHERE
	region = 'EMEA'
```

The following query retrieves users who registered after August 30, 2020 from the users' table:

```sql
SELECT
	user_id,
	city,
	country
FROM
	users
WHERE
	registration_date >= TO_DATE('2020-08-30');
```

The following query retrieves users who registered after August 30 2020 and made a purchase:

```sql
SELECT
	user_id,
	city,
SELECT
	user_id,
	city,
	country
FROM
	users
WHERE
	registration_date >= TO_DATE('2020-08-30')
	AND user_id IN (
		SELECT
			user_id
		FROM
			purchases
	)
```

## GROUP BY

The `GROUP BY` clause indicates by what column or columns the results of the query should be grouped. `GROUP BY` is usually used in conjunction with aggregations, such as `SUM`, `COUNT`, `MIN`, etc. Grouping elements can include column names, the position of columns as specified in the `SELECT` expression, or other expressions used in the query.

### Syntax
{: .no_toc}

```sql
GROUP BY <grouping_element> [, ...n]
```

| Component            | Description                                                                                                                                                                                                                                  |
| :-------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<grouping_element>` | Indicates the condition by which the results should be grouped. <br><br> The number of `<grouping_elements>` must match the number of columns specified in the `SELECT` statement, not counting aggregations. |

### Example
{: .no_toc}

In the following example, the results that are retrieved are grouped by the `product_name` and then by the `product_id` columns.

```sql
SELECT
	product_name,
	product_id,
	sum(total_sales)
FROM
	purchases
GROUP BY
	product_name,
	product_id
```

You can get similar results by specifying the column positions.

```sql
SELECT
	product_name,
	product_id,
	SUM(total_sales)
FROM
	purchases
GROUP BY
	1,
	2
```

Other expressions can also be used, such as a `CASE` statement:

```sql
SELECT
	product_name,
	SUM(price),
	CASE
		WHEN price > 500 THEN "High value"
		WHEN price < 500 THEN "Low value"
	END AS price_text
FROM
	purchases
GROUP BY
	product_name,
	price_text;
```

## HAVING

The `HAVING` clause is used in conjunction with the `GROUP BY` clause, and is computed after computing the `GROUP BY` clause and aggregate functions. `HAVING` is used to further eliminate groups that don't satisfy the `<condition>` by filtering the `GROUP BY` results.

### Syntax
{: .no_toc}

```sql
HAVING <condition> [, ...n]
```

| Component     | Description                                                              |
| :------------- | :------------------------------------------------------------------------ |
| `<condition>` | Indicates the boolean condition by which the results should be filtered. |

## UNION [ALL]

The `UNION` operator combines the results of two or more `SELECT` statements into a single query.

* `UNION` combines with duplicate elimination.
* `UNION ALL` combines without duplicate elimination.

When including multiple clauses, the same number of columns must be selected by all participating `SELECT` statements. Data types of all column parameters must be the same. Multiple clauses are processed left to right; use parentheses to define an explicit order for processing.

### Syntax
{: .no_toc}

```sql
<select_expr1> UNION [ALL] <select_expr2> [ ...n]
```

| Component        | Description                                                  |
| :---------------- | :------------------------------------------------------------ |
| `<select_expr1>` | A `SELECT`statement.                                         |
| `<select_expr2>` | A second `SELECT` statement to be combined with the first.   |

## ORDER BY

The `ORDER BY` clause sorts a result set by one or more output expressions. `ORDER BY` is evaluated as the last step after any `GROUP BY` or `HAVING` clause. `ASC` and `DESC` determine whether results are sorted in ascending or descending order. When the clause contains multiple expressions, the result set is sorted according to the first expression. Then the second expression is applied to rows that have matching values from the first expression, and so on.

The default null ordering is `NULLS LAST`, regardless of ascending or descending sort order.

### Syntax
{: .no_toc}

```sql
ORDER BY <expression> [ ASC | DESC ] [ NULLS FIRST | NULLS LAST] [, ...]
```

| Component                      | Description                                                                                                                                                                                                  |
| :------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<expression>`                 | Each expression may specify output columns from `SELECT` or an ordinal number for an output column by position, starting at one.                                                                             |
| `[ ASC | DESC ]`              | Indicates whether the sort should be in ascending or descending order.                                                                                                                                       |
| `[ NULLS FIRST | NULLS LAST]` | Indicates whether null values should be included at the beginning or end of the result. <br> <br> The default null ordering is `NULLS LAST`, regardless of ascending or descending sort order. |

## LIMIT

The `LIMIT` clause restricts the number of rows that are included in the result set.

### Syntax
{: .no_toc}

```sql
LIMIT <count>
```

| Component | Description                                          | Valid values and syntax |
| :--------- | :---------------------------------------------------- | :----------------------- |
| `<count>` | Indicates the number of rows that should be returned | An integer              |
