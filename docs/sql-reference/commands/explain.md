---
layout: default
title: EXPLAIN
parent: SQL commands
---

# EXPLAIN

Returns the query execution plan for a specified query statement without running it. `EXPLAIN` can help you identify opportunities to tune query performance before you run a query.

By default, `EXPLAIN` returns output in JSON format.The SQL workspace uses the JSON to generate *visual explain* output. For more information, including example JSON output, see [Using explain to analyze query execution](../../using-the-sql-workspace/using-explain-to-analyze-query-execution.md). Specify the `USING TEXT` option to return plain text.

## Syntax

```sql
EXPLAIN [USING {TEXT|JSON}] <query_statement>
```

| Parameter              | Description |
| :--------------------- | :---------- |
| `[USING {TEXT|JSON}]`  | Specifies the output format for the query plan. Defaults to JSON if not specified. If `USING TEXT` is specified, list view and graph view are not available. For more information, see [Viewing and copying explain output](../../using-the-sql-workspace/using-explain-to-analyze-query-execution.md#viewing-and-copying-explain-output). |
| `<query_statement>`    | Any query statement that does not include DDL commands. |

## Example

The example below demonstrates an `EXPLAIN` statement for a `SELECT` query on a table named `lineitem`.

```sql
EXPLAIN
SELECT
	l_shipdate,
	l_linestatus,
	l_orderkey,
	AVG(l_discount)
FROM
	lineitem
WHERE
	l_returnflag = 'N'
	AND l_shipdate > '1996-01-01'
GROUP BY
	l_shipdate,
	l_linestatus,
	l_orderkey
ORDER BY
	1,2,3,4;
```

**Returns:**

![](../../assets/images/explain_results.png)

The `EXPLAIN` results indicate that this `SELECT` query will execute operations as follows. The Firebolt engine will:

1. Filter the `lineitem` table for columns used in the `SELECT` query, and then by the `WHERE` conditions.
2. Perform the aggregation as specified by the `GROUP BY` clause.
3. Sort results in ascending order by the `l_shipdate` column, as specified by the `ORDER BY` clause.
