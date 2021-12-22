---
layout: default
title: Using indexes
nav_order: 2
parent: Concepts
---
# Using indexes to accelerate query performance

Firebolt has unique technologies that accelerate query performance. Indexes are among the most important. By creating efficient indexes, you can accelerate query performance and use engines more efficiently to save cost.

## In this section

This topic covers basic concepts and guidelines for creating each type of index. Each section finishes with examples of indexes based on a dataset and the analytics queries that typically run over that dataset.

## Prerequisites

This topic assumes you are familiar with Firebolt engines, the basics of Firebolt data ingestion, and the different types of tables in Firebolt. For more information, see our [Working with Engines section](../working-with-engines/working-with-engines.html).

## Additional resources

For additional best practices and tips to improve query performance, see <xref>Top 10 Tips for the Fastest Firebolt Queries</xref>. For more in-depth information about index internals, see the [Firebolt Cloud Data Warehouse Whitepaper](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper), particularly the sections on [Indexes](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper#Indexes) and [Query Optimization](https://www.firebolt.io/resources/firebolt-cloud-data-warehouse-whitepaper#Query-optimization).

## Index basics

There are three types of indexes that you can create in Firebolt.

* Primary indexes
* Aggregating indexes
* Join indexes

### You can combine indexes

Each table has only one primary index, which is mandatory for fact tables and optional for dimension tables. You can have as many aggregating indexes and join indexes as your workloads demand. Indexes are highly compressed. The cost of storing them is small when compared to the potential savings in engine runtime, number of nodes, and instance type.

### Firebolt maintains indexes automatically

After you define an index for a table, Firebolt updates the index on the general purpose engine that you use to ingest data (the engine that runs the `INSERT INTO` statement). You don’t need to manually maintain or recreate indexes as you incrementally ingest data.

### Test and validate indexes before deploying to production

We recommend that you experiment with index configurations before you go to production. Create indexes on tables, create analytics queries that are comparable to your production queries, run the queries, and then compare performance results using query statistics, query history, and explain plans. For more information, see (*need xref*)Analyzing index performance.

## Index quick reference

### Primary index

* Accelerates queries at runtime—efficiently prunes ranges of data for reads from Firebolt File Format (F3)
* Defined by you in `CREATE TABLE` clause, only one per table because of physical sort in F3, updated automatically with incremental ingestion
* Best built with columns frequently used in `WHERE` predicates that drastically filter, in order of filtering effect (highest cardinality first), also add join key columns
* Sparse index behind the scenes—one entry per data block vs. mapping every search key value like dense index, less I/O and maintenance
* Works with partitions, prunes data after partitions

### Aggregating indexes

* Accelerates queries with aggregate functions—used by query analyzer instead of scanning table to calculate results, like a materialized view
* Defined by you on fact tables with `CREATE AGGREGATING INDEX`, as many as you want
Best with empty fact table, but you can use `CREATE AND GENERATE` on populated fact table—memory-intensive
* Built with columns first, like a primary index for pruning, followed by aggregations exactly as they are used in analytics queries
* Only used by optimizer if all columns, measures (and aggregations), and join key columns in the aggregations are in your index definition

### Join index

* Accelerates joins--stored in RAM and used by query optimizer instead of performing the actual join at runtime
* Defined by you on dimension tables with `CREATE JOIN INDEX`, as many as you want
Built with join key column first, and then other dimension columns used in analytics queries
* Most effective in schema with many-fact-to-one-dimension relationship, with large dimension tables, and with small subset of available dimension columns
* Must have dimension join key column defined with `UNIQUE` attribute for best performance

## Using primary indexes

‌Firebolt uses primary indexes to physically sort data in the Firebolt File Format (F3). The index also colocates similar values, which allows data to be pruned at query runtime. When you query a table, rather than scanning the whole data set, Firebolt uses the table’s index to prune the data. This means that Firebolt reads only the relevant ranges of data to produce query results. Unnecessary ranges of data are never loaded from disk.

Primary indexes in Firebolt are a type of sparse index. Unlike a dense index that maps every search key value in a file, a sparse index is a smaller construct that holds only one entry per data block (a compressed range of rows). By using the primary index to read a much smaller and highly compressed range of data from F3 into the engine cache at query runtime, Firebolt can produce query results much faster with less disk I/O.

### How you create a primary index

To define a primary index, you use the PRIMARY INDEX clause within a [`CREATE TABLE`](../sql-reference/commands/ddl-commands.html/#create-fact--dimension-table) statement. A primary index is required for each fact table and optional for each dimension table. Although they are optional for dimension tables, we strongly recommend them.

The basic syntax of a `PRIMARY INDEX` clause within a `CREATE TABLE` statement is shown in the example below.

```sql
CREATE TABLE <table_name> )
     <colname_1> <datatype>,
     <colname_2> <datatype>,
     <colname_3> <datatype>,
     ...
     )
     PRIMARY INDEX <colname_1> [, <colname_n> [, ...]];
```

### Primary indexes can’t be modified

After you create a table, you can’t modify the primary index. To change the index, you must drop the table and recreate it.

### How to choose primary index columns

The columns that you choose for the primary index and the order in which you specify them are important.

The most important considerations for choosing and ordering columns is how you filter data in your analytics queries and the cardinality of columns. If you don’t know your query pattern in advance, narrow down your columns to those most likely to be used in filters and then order them in descending order of cardinality.

Use the following recommendations to guide your choices. To see these guidelines in action, see our [examples](./get-instant-query-response-time.html/#primary-index-examples.)

***Use columns without NULLs***

Columns that you specify in a primary index must not contain `NULL`. Consider defining columns that you use in a primary index with the `NOT NULL` constraint as a preventive measure. Columns in Firebolt are `NOT NULL` by default.

***Include columns used in WHERE clauses***

Include all columns that are used in query `WHERE` clauses to filter query results.

***Consider including columns used in GROUP BY clauses***

Consider adding columns that you use in `GROUP BY` statements with aggregate functions.

***Order columns in the index definition by cardinality***

Specify columns in order of how frequently they’re used in WHERE clauses and in descending order of cardinality. In other words, in the first position -- that is, `<colname_1>` in the syntax above -- specify the column that filters results the most. Then specify remaining columns in descending order of how much they filter.

Avoid specifying columns of the highest cardinality -– that is, truly unique values or the primary key -– unless you use that value in query `WHERE` clauses. Also avoid specifying columns of low cardinality that won’t adequately filter results.

***Include as many columns as you need***

The number of columns that you specify in the index won’t negatively affect query performance. Additional columns might slow down ingestion very slightly, but the benefit for flexibility and performance of analytics queries will almost certainly outweigh any impact to ingestion performance.

***Consider how you alter values in WHERE clauses***

The primary index isn’t effective if Firebolt can’t determine the values in the index column. If the `WHERE` clause in your query contains a function that transforms the column values, Firebolt can’t use the index. Consider the examples below, with the primary index on a table defined as:

```sql
  PRIMARY INDEX asset_id
```

Where `asset_id` is a `TEXT` data type in a table named `events`.

In the example below, Firebolt can’t use the primary index with the `WHERE` clause. This is because the function is on the left side of the comparison. To satisfy the conditions of comparison, Firebolt must read all values of `asset_id` to apply the `UPPER` function.

![](../assets/images/Red_X_resized.png)  

```sql
SELECT
	asset_id
FROM
	events_log
WHERE
	UPPER(asset_id) LIKE ‘AA%’;
  ```

In contrast, Firebolt can use the primary index in the following example:

![](../assets/images/Green_check_resized.png)  

```sql
SELECT
	asset_id
FROM
	events_log
WHERE
	asset_id LIKE ‘AAA%’;
```

If you know that you will use a function in a predicate ahead of time, consider creating a virtual column to store the result of the function. You can then use that virtual column in your index and queries. This is particularly useful for hashing columns. For an example, see the [example section](./get-instant-query-response-time.html/#primary-index-examples).

***With a star schema, include join key columns in the fact table index***

If you have a star schema with many fact tables referring to a single dimension table, include the join keys (the foreign key columns) in the primary index of the fact table. This helps accelerate queries because the Firebolt query planner uses join keys as a predicate.

Conversely ,on the dimension table side, there is no benefit to including the join key in the dimension table primary index unless you use it as a filter on the dimension table itself.

### Using partitions with primary indexes

In most cases, partitioning isn’t necessary because of the efficiency of primary indexes (and aggregating indexes). If you use partitions, the partition column is the first stage of sorting. Firebolt divides the table data into file segments according to the `PARTITION BY` definition. Then, within each of those segments, Firebolt applies the primary index to prune and sort the data into even smaller data ranges as described above.

For more information and examples, see [Using Partitions](./working-with-partitions.html).

### Primary index examples

This section demonstrates different primary indexes created on a fact table, `site_sales`, created with the DDL and sample values shown below.

***Example fact table***

The examples in this section are based on the fact table below. The table is a web log with hundreds of millions of rows. Each record stores an `event_count` of each `event_type` for HTML elements identified by `asset_id` and the `customer_id` of the visitor that initiated the event. The table is denormalized. No single column has unique values.

**Table DDL**

```sql
CREATE FACT TABLE events_log (
	visit_date DATE,
	asset_id TEXT,
	customer_id TEXT NOT NULL,
	event_type TEXT,
	event_count INT NOT NULL
) PRIMARY INDEX < see examples below >;
```

**Table contents (excerpt)**

```
+------------+--------------------------------------+-------------+------------+-------------+
| visit_date |               asset_id               | customer_id | event_type | event_count |
+------------+--------------------------------------+-------------+------------+-------------+
| 2018-05-30 | a974ff70-3367-4460-bd2e-e26de9439469 |       78152 | click      |         137 |
| 2020-11-13 | 3d58b0a0-f838-428b-8f1c-2ff30aa9b9ea |       57328 | mouseover  |         104 |
| 2020-07-11 | e8c533a4-b039-44df-b3a1-61fdc3d6c21d |       44963 | mouseout   |         111 |
| 2019-09-06 | 02333518-5a39-4c11-a1a7-ed5e4163cb04 |       70147 | click      |          49 |
| 2019-05-04 | 83f3a7bc-f6ca-4511-a8fb-74683e2b25cc |       58458 | mouseover  |         127 |
| 2021-03-19 | 1664be68-d09e-4beb-a5b7-1889ebd06cfb |       40360 | mouseout   |          43 |
| 2018-05-01 | 37858981-bbea-46bf-8d85-0e9a73062137 |       47880 | mouseover  |         101 |
| 2018-06-19 | c5e7882b-3639-42ee-93f0-8bf5c6e99b14 |       74728 | mouseover  |         141 |
| 2018-02-28 | 97ac6f85-3bbc-4894-811f-7584304c84f9 |       84802 | mouseout   |          15 |
| ...        |                                      |             |            |             |
+------------+--------------------------------------+-------------+------------+-------------+
```

**Cardinality of columns**

A `COUNT DISTINCT` query on each column returns the following. A higher number indicates higher cardinality.

```
+----------------+-----------------+--------------------+-----------------+
| distinct_dates | distinct_assets | distinct_customers | distinct_events |
+----------------+-----------------+--------------------+-----------------+
|           1461 |             300 |              89664 |               3 |
+----------------+-----------------+--------------------+-----------------+
```

***Example query pattern – date-based queries***

Consider the two example queries below that return values with date-based filters.

**Query 1**

```sql
SELECT
	*
FROM
	events_log
WHERE
	visit_date BETWEEN '2020-01-01' AND '2020-01-02'
	AND customer_id = "11386"
	AND event_type = 'click'
```

**Query 2**

```sql
SELECT
	count(*),
visit_date
FROM
events_log
WHERE
	EXTRACT(YEAR FROM visit_date) = ‘2021’
```

For both queries, the best primary index is:

  ```
  PRIMARY INDEX (visit_date, customer_id, event_type)
  ```

* With `visit_date` in the first position in the primary index, Firebolt sorts and compresses records most efficiently for these date-based queries.
* The addition of `customer_id` in the second position and `event_type` in the third position further compresses data and accelerates query response.
* `customer_id` is in the second position because it has higher cardinality than `event_type`, which has only three possible values.
* `asset_id` is not used in query filters, so it is omitted.

For query 2, you can improve performance further by partitioning the table according to year as shown in the query excerpt below.

```
PRIMARY INDEX (visit_date, customer_id, event_type)
PARTITION BY (EXTRACT (YEAR FROM visit_date)
```

Without the partition, Firebolt likely must scan across file segments to return results for the year 2021. With the partition, segments exist for each year, and Firebolt can read all results from a single segment. If the query runs on a multi-node engine, the benefit may be greater. Firebolt can avoid pulling data from multiple engine nodes for results.

***Example query pattern – customer-based query***

Consider the example query below that returns the sum of `Click` values for a particular customer.

```sql
SELECT
	asset_id,
	customer_id,
	event_type,
	sum(event_value)
FROM
	events
WHERE
	customer_id = "14493"
	AND event_type = 'Click'
	AND event_value > 0
GROUP BY
	1,
	2,
	3;
```

For this query, the best primary index is:

```sql
PRIMARY INDEX (customer_id, asset_id, event_type)
```

* `customer_id` is in the first position because it has the highest cardinality and sorts and prunes data most efficiently for this query.
* The addition of `asset_id` won’t accelerate this particular query, but adding it is not detrimental.
* Although `event_type` has low cardinality, because it’s contained in the `WHERE` clause, adding it to the primary index has some benefit.

***Example – using virtual columns***

The two most frequent uses of virtual columns in a primary index are to accommodate functions that alter column values and to calculate hash values for columns that contain long strings. An example of a function that transforms a column value is shown below.

**Step 1 – Create the fact table with the virtual column in the index**

The example DDL below creates a fact table similar to the one earlier in this section. However, it adds the `upper_customer_id` column. The table creates this virtual column to store the result of an `UPPER` function that upper-cases `customer_id` values during the `INSERT INTO` operation.

The `PRIMARY INDEX` clause uses the `upper_customer_id` column because that is the one that is used in analytics queries.

```sql
CREATE FACT TABLE events_log (
	visit_date DATE,
	asset_id TEXT,
	customer_id TEXT NOT NULL,
	event_type TEXT,
	event_count INT NOT NULL,
	uppder_customer_id TEXT NOT NULL
) PRIMARY INDEX visit_date, upper _customer_id;
```

**Step 2 – Use the function during ingestion (`INSERT INTO`)**

```sql
INSERT INTO
	events_log
SELECT
	visit_date,
	asset_id,
	customer_id,
	event_type,
	event_count,
	UPPER(customer_id) AS upper_customer_id
FROM
	ext_tbl_events;
```

**Step 3 – Query using the virtual column in predicates**

The example `SELECT` query below uses the virtual column to produce query results and benefits from the index.

```sql
SELECT
	customer_id
FROM
	events_log
WHERE
	upper_customer_id LIKE ‘AAA%’;
```

## Using aggregating indexes

Aggregating indexes accelerate queries that contain aggregate functions that you perform repeatedly on large fact tables with millions or billions of rows. Aggregating indexes greatly reduce the compute resources required at query runtime to process functions. This can improve performance and save cost by allowing you to use less costly engines. Dashboards and repetitive reports are common use cases for aggregating indexes. It’s less common to create aggregating indexes for ad hoc queries.

### How aggregating indexes work

Firebolt uses an aggregating index to pre-calculate and store the results of aggregate functions that you define. An aggregating index is like a materialized view in many ways, with technology proprietary to Firebolt that works together with the F3 storage format to make them more efficient.

At query runtime, Firebolt scans the aggregating indexes associated with a fact table to determine those that provide the best fit to accelerate query performance. To return query results, Firebolt uses the indexes rather than scanning the table.

Firebolt automatically updates aggregating indexes as you ingest new data. The precalculated results of aggregate functions are stateful and consistent with the underlying fact table data on the engine.

Firebolt shards aggregating indexes across engine nodes in multi-node engines as it does with underlying fact tables.

### Aggregating index tradeoffs

Effective aggregating indexes are relatively small compared to the underlying fact table. We recommend that you confirm that an aggregating index is significantly smaller than the underlying fact table. For more information, see <xref/>.

For very large fact tables, an aggregating index may still be quite large. If the index is effective, the savings at query runtime will outweigh the cost of storage. Aggregating indexes also increase compute requirements during data ingestion because Firebolt performs pre-calculations at that time. As with storage, savings at query runtime usually outweigh the ingestion cost.

If your application favors speed of ingestion over speed of analytics queries, be sure to test ingestion with aggregating indexes before production. You can also change the impact of aggregating indexes on ingestion and first-query speed by configuring the engine warmup method. For more information, see <xref to warmup topic/>.

### How you define an aggregating index

To create an aggregating index, use the [`CREATE AGGREGATING INDEX`](../sql-reference/commands/ddl-commands.html#create-aggregating-index) statement. This statement specifies a fact table, a subset of columns from the table, and a list of the aggregate functions that commonly run over that table. You can create as many aggregating indexes per table as you need. Each aggregating index is associated with a single fact table.

The syntax for the `CREATE AGGREGATING INDEX` is shown below.

```sql
CREATE [AND GENERATE] AGGREGATING INDEX <agg_index_name> ON <fact_table_name>
  (
    <fact_table_column_1> [,<fact_table_column_2>][,...]
    <aggregate_expression> [,...]
  );
```

### Creating the index on empty tables is preferred

The `AND GENERATE` option is required only when you generate an aggregating index on a fact table with records. Running the `AND GENERATE` option is a memory-intensive operation. If you do this, select an engine specification with a lot of memory and multiple nodes. Whenever possible, we strongly recommend that you create aggregating indexes for a fact table when the table is empty, before you run the first `INSERT INTO` command to ingest data.

### Aggregating indexes can’t be modified

You can’t modify aggregating indexes after you create them. To modify an aggregating index, use the `DROP AGGREGATING INDEX` command, and then use `CREATE AND GENERATE AGGREGATING INDEX` to specify a new index for the same table.

### How to choose aggregating index columns

Firebolt uses the columns that you specify for an aggregating index in much the same way as the columns for a primary index.

Follow the same guidelines as those outlined for primary index columns. For more information, see the [Primary Index section](./get-instant-query-response-time.html/#using-primary-indexes). Most importantly, specify columns in descending order, highest cardinality first.

All columns that are used in aggregations at query runtime must appear in the index definition—either the primary index or the function definitions—for the optimizer to use the index at query runtime. This includes columns that are part of the aggregate functions, any columns used in `GROUP BY` and `WHERE` clauses, and any columns in the fact table that are used as join keys. If a column is missing, Firebolt must scan the fact table, and the aggregating index doesn’t improve performance.

### How to choose aggregate expressions

You can specify as many aggregate expressions as required in an aggregating index definition. At query runtime, the number of aggregate expressions does not affect query performance. However, because Firebolt pre-processes each aggregate expression during ingestion, each additional aggregate expression increases compute requirements during ingestion.

Aggregate expressions that you specify must correspond precisely to the aggregate expressions used at query runtime, including specified columns. You also can specify complex functions in the index definition, but make sure to specify them precisely as you use them in queries.

### Using partitions with aggregating indexes

Aggregating indexes inherit the partitions from the underlying fact table. When you drop a partition from the underlying fact table, the partition is dropped from the aggregating index.

### How aggregating indexes work with engine warm-up method

The columns that you specify for an aggregating index are essentially a primary index for the aggregating index. With the warmup method set to **Preload indexes**, an engine preloads these columns on warmup but doesn’t perform the pre-calculations until Firebolt uses the index. This accelerates ingestion, but causes first queries to be slower than subsequent queries. With the warmup method set to **Preload all data**, an engine loads the calculations in addition to the columns. This slows ingestion, but accelerates the first analytics query.

### Validating aggregating index size

You should aim for aggregating index results to be a ratio of approximately 20-50% size of the whole table or smaller. The smaller the ratio, the more effective the aggregating index is.

For example, with the aggregating index below on the table store_sales with 200,000,000 rows.

```sql
CREATE AGGREGATING INDEX idx_agg_store_sales ON store_sales (
	ss_sold_date_sk,
	ss_item_sk,
	sum(ss_ext_discount_amt));
```

You can run the following query to validate that the size of the aggregating index is effective:

```sql
SELECT
	count(*)
FROM
	(
		SELECT
			ss_sold_date_sk,
			ss_item_sk
	)
FROM
	store_sales
GROUP BY
	1
);
```

If the `SELECT` query returns 100,000,000 or fewer, the aggregating index may be beneficial. If it returns 40,000,000 or fewer it will almost certainly be beneficial.

### Using the query explain function to verify aggregating index configuration

*<TO DO: this needs to be fleshed out. The examples we have are too complex because they are combined with a join. We need to start small and work up to that. Also, we need to reference the EXPLAIN documentation, which is in work. This might be a version 2.>*

*(image1 of EXPLAIN query)*

With the index

*(image2 of EXPLAIN query)*

### Aggregating index examples

*<TO DO: This section needs to be updated to use same examples as above. Maybe v2. Right now, uses the examples from the > To demonstrate the requirement for unique function definitions and the ability to handle complex queries, consider a query with the complex COALESCE clauses as shown in the example below.*

*(image of agg_explain)*

The examples in this section are based on a fact table, `fact_orders`, created with the DDL shown below.

```sql
CREATE FACT TABLE fact_orders
(
    order_id LONG,
    product_id LONG,
    store_id LONG,
    client_id LONG,
    order_date DATE,
    order_total DOUBLE,
    order_item_count INT
)
PRIMARY INDEX store_id, product_id, order_id;
```

From this table, let's assume we typically run queries that use these aggregations:

```sql
SUM(order_total)
SUM(order_item_count)
AVG(order_item_count)
COUNT(DISTINCT client_id)
```

And they are grouped by different combinations of the `store_id` and `product_id` columns.

‌The DDL below creates an aggregating index to accelerate these aggregations.

```sql
CREATE AND GENERATE AGGREGATING INDEX agg_fact_orders ON fact_orders
(
  store_id,
  product_id,
  SUM(order_total),
  SUM(order_item_count),
  AVG(order_item_count),
  COUNT(DISTINCT client_id)
);
```

As with a primary index, the order of the columns specified is important. Firebolt creates a primary index for the aggregating index. In our example, the primary index is in the order of `store_id`, `product_id`.
