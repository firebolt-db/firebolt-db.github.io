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

The `WITH` clause is used for sub-query refactoring so that you can specify subqueries and then reference them as part of the main query. This simplifies the hierarchy of the main query, enabling you to avoid using multiple nested sub-queries.

In order to reference the data from the `WITH` clause, a name must be specified for it. This name is then treated as a temporary relation table during query execution.

Each subquery can comprise a `SELECT`, `TABLE`, `VALUES`, `INSERT`, `UPDATE`, or `DELETE `statement. The `WITH `clause is the only clause that precedes the main query.

The primary query and the queries included in the `WITH` clause are all executed at the same time; `WITH` queries are evaluated only once every time the main query is executed, even if the clause is referred to by the main query more than once.

When using the `WITH `clause as part of a DML command, it must include a `RETURNING` clause as well, without which the main query cannot reference the WITH clause.

### Syntax
{: .no_toc}

```sql
WITH <subquery_table_name> [ <column_name> [, ...n] ] AS <subquery>
```

| Component               | Description                                                                          |
| :----------------------- | :------------------------------------------------------------------------------------ |
| `<subquery_table_name>` | A unique name for a temp table                                                       |
| `<column_name>`         | An optional list of one or more column names. Columns should be separated by commas. |
| `<subquery>`            | Any query statement                                                                  |

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

A `JOIN` operator combines rows from two data sources (tables/views) and creates a new combined row that can be used in the query.

### Syntax
{: .no_toc}

```sql
FROM <from_item> [ NATURAL ] <join_type> <from_item> [ ON <join_condition> ]
```

`JOIN `types:

* `[ INNER ] JOIN`
* `LEFT [ OUTER ] JOIN`
* `RIGHT [ OUTER ] JOIN`
* `FULL [ OUTER ] JOIN`
* `CROSS JOIN`

### Example
{: .no_toc}

```sql
SELECT
	*
FROM
	customers c
	JOIN orders o ON c.cust_key = o.cust_key;
```

## UNNEST

An `UNNEST` operator performs join between the table in the left side, and the array in the right side. The output table repeats rows of the table from the left for every element of the array. If the array is empty, the corresponding row from the table is eliminated.

### Syntax
{: .no_toc}

```sql
FROM <from_item> UNNEST <expr>
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

## LIMIT_DISTINCT

The `LIMIT_DISTINCT` clause selects a defined number of rows to return for each distinct value as specified by the expression.

Returned values will not be grouped together unless you use an `ORDER BY` statement. `LIMIT_DISTINCT` does not preclude also using a `LIMIT` clause.

### Syntax
{: .no_toc}

```sql
LIMIT_DISTINCT <returned_values> [OFFSET <offset_value>] BY <expr> [, <expr2> [,...n]]
```

| Component                    | Description                                                                                                                                                                                                                                                                                                                                        |
| :---------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<returned_values>`          | The number of rows to return for each distinct value, as defined by the `expr`                                                                                                                                                                                                                                                                     |
| `<offset_value>`             | The number of rows that should be skipped from the beginning of the block before returning rows for `<returned_values>`. <br><br> If the `<offset_value>` exceeds the number of rows in the data block, no rows are returned. The `<offset_value>` is restricted to be greater than 0. |
| `<expr> [, <expr2> [,...n]]` | The expression(s) to define the distinct value that will be limited by `LIMIT_DISTINCT`. Multiple expressions can be used.                                                                                                                                                                                                                         |

### Example
{: .no_toc}

To demonstrate the `LIMIT_DISTINCT` clause, we will create an example table of students called `class_test`:

```sql
CREATE DIMENSION TABLE IF NOT EXISTS class_test3
    (
        First_name      TEXT,
        Last_name       TEXT,
        Teacher         TEXT,
        Grade_level     INT
    );

INSERT INTO class_test3
    VALUES
        ('Sammy','Sardine','Roberts', 12),
        ('Carol','Catnip','Roberts', 10),
        ('Thomas','Tinderbox','Roberts', 10),
        ('Deborah','Donut','Roberts', 9),
        ('Humphrey','Hoagie','Roberts', 11),
        ('Frank','Falafel', 'Chamberpot', 11),
        ('Peter','Patchouli', 'Chamberpot', 11),
        ('Albert','Applesauce','Chamberpot', 11),
        ('Gary','Garnish', 'Chamberpot', 12),
        ('Roseanna','Rotisserie','Chamberpot', 12),
        ('Jesse','Jelloshot','Chamberpot', 12),
        ('Mary','Marblecake','Diddlysquat', 9),
        ('Iris','Icecream','Diddlysquat', 9),
        ('Larry','Lardbelly','Diddlysquat', 9),
        ('Charles','Cokebottle','Diddlysquat', 10),
        ('Brunhilda','Breadknife','Diddlysquat', 10),
        ('Franco','Frenchdip','Rosebottom', 11),
        ('Yolinda','Yogurt','Rosebottom', 11),
        ('Jojo','Jujubee','Rosebottom', 11),
        ('Shangxiu','Shadytree','Rosebottom', 12),
        ('Otis','Oatmeal','Rosebottom', 12),
        ('Wanda','Waterfall','Rosebottom', 10),
        ('Shawn','Sharpshooter','Rosebottom', 10)
```

The example below uses `LIMIT_DISTINCT` to get a subset of each teacher's students. For each teacher, only two students are included in the query results.

```sql
SELECT
	Teacher,
	Student_Firstname,
	Student_Lastname
FROM
	class_test
ORDER BY
	Teacher
LIMIT_DISTINCT 2 BY
	Teacher;
```

**Returns:**

```
+--------------------------------------------+
| Teacher,Student_Firstname,Student_Lastname |
+--------------------------------------------+
| Chamberpot,Peter,Patchouli                 |
| Chamberpot,Roseanna,Rotisserie             |
| Diddlysquat,Mary,Marblecake                |
| Diddlysquat,Larry,Lardbelly                |
| Roberts,Carol,Catnip                       |
| Roberts,Sammy,Sardine                      |
| Rosebottom,Wanda,Waterfall                 |
| Rosebottom,Shawn,Sharpshooter              |
+--------------------------------------------+
```

`LIMIT_DISTINCT` can also include multiple expressions to limit for distinct values. The example below returns a subset of each teacher's students in each grade level.

```sql
SELECT
	Teacher,
	Grade_level,
	First_name,
	Last_name
FROM
	class_test3
ORDER BY
	Teacher
LIMIT_DISTINCT 1 BY
	Teacher,
	Grade_level;
```

**Returns**:

```
+----------------------------------------------------------+
| Teacher,Grade_level, Student_Firstname, Student_Lastname |
+----------------------------------------------------------+
| Chamberpot,11,Peter,Patchouli                            |
| Chamberpot,12,Gary,Garnish                               |
| Diddlysquat,9,Mary,Marblecake                            |
| Diddlysquat,10,Charles,Cokebottle                        |
| Roberts,12,Sammy,Sardine                                 |
| Roberts,11,Humphrey,Hoagie                               |
| Roberts,10,Carol,Catnip                                  |
| Roberts,9,Deborah,Donut                                  |
| Rosebottom,12,Otis,Oatmeal                               |
| Rosebottom,10,Shawn,Sharpshooter                         |
| Rosebottom,11,Jojo,Jujubee                               |
+----------------------------------------------------------+
```

## OFFSET

The `OFFSET` clause omits a specified number of rows from the beginning of the result set. When used with `LIMIT`, it specifies the row number after which the limited rows are returned. When used with `FETCH`, only the number of rows specified by the `<fetch_count>` are returned after the `OFFSET`

### Syntax
{: .no_toc}

```sql
[ LIMIT <limit_number> ] OFFSET <offset_number> [ FETCH <fetch_count>]  
```

| Component         | Description                                                            | Valid values and syntax |
| :---------------- | :---------------------------------------------------------------------- | :----------------------- |
| `<limit_number>`  | Indicates the number of rows to be returned                            | An integer              |
| `<offset_number>` | Indicates the start row number                                         | An integer              |
| `<fetch_count>`   | Fetch with count specifies the number of rows to fetch from the offset | An integer              |

In the following example, we will retrieve 3 rows, starting from the 2nd row.

```sql
SELECT
	product_name,
	product_id
FROM
	purchases
ORDER BY
	1
LIMIT
	3 OFFSET 1;
```
