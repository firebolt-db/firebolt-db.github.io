---
layout: default
title: Primary indexes
description: Learn about primary indexes in Firebolt and how to configure and use them.
nav_order: 2
parent: Using indexes
---

# Using primary indexes
{: .no_toc}

* Topic ToC
{:toc}

‌Firebolt uses primary indexes to physically sort data into the Firebolt File Format (F3). The index also colocates similar values, which allows data to be pruned at query runtime. When you query a table, rather than scanning the whole data set, Firebolt uses the table’s index to prune the data. Unnecessary ranges of data are never loaded from disk. Firebolt reads only the relevant ranges of data to produce query results.

Primary indexes in Firebolt are a type of *sparse index*. Unlike a dense index that maps every search key value in a file, a sparse index is a smaller construct that holds only one entry per data block (a compressed range of rows). By using the primary index to read a much smaller and highly compressed range of data from F3 into the engine cache at query runtime, Firebolt produces query results much faster with less disk I/O.

The video below explains sparse indexing. Eldad Farkash is the CEO of Firebolt.
<iframe width="560" height="315" src="https://www.youtube.com/embed/7XDTVB9gsFw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## How you create a primary index

To define a primary index, you use the `PRIMARY INDEX` clause within a [`CREATE TABLE`](../sql-reference/commands/create-fact-dimension-table.md) statement. A primary index is required for each fact table and optional for each dimension table. Although they are optional for dimension tables, we strongly recommend them.

The basic syntax of a `PRIMARY INDEX` clause within a `CREATE TABLE` statement is shown in the example below.

```sql
CREATE [FACT|DIMENSION] TABLE <table_name> (
  <colname_1> <datatype>,
  <colname_2> <datatype>,
  <colname_3> <datatype>,
     ...
)
PRIMARY INDEX <colname_1> [, <...colname_N>];
```

## Primary indexes can’t be modified

After you create a table, you can’t modify the primary index. To change the index, you must drop the table and recreate it.

## How to choose primary index columns

The columns that you choose for the primary index and the order in which you specify them are important. Use the following recommendations to guide your choices. To see these guidelines in action, see [Primary index examples](#primary-index-examples).

### Include columns used in WHERE clauses

Include all columns that are used in query `WHERE` clauses to filter query results.

### Consider including columns used in GROUP BY clauses

Consider adding columns that you use in `GROUP BY` statements with aggregate functions.

### Order columns in the index definition by cardinality

Specify columns in order of how frequently they’re used in `WHERE` clauses and in descending order of cardinality. In other words, in the first position (`<colname_1>` in the syntax above) specify the column that filters results the most. Then specify remaining columns in descending order of how much they filter.

Avoid specifying a column of the highest cardinality&mdash;that is, a column that has truly unique values or the primary key&mdash;unless you use that column in query `WHERE` clauses. Also avoid specifying columns of low cardinality that won’t adequately filter results.

### Include as many columns as you need

The number of columns that you specify in the index won’t negatively affect query performance. Additional columns might slow down ingestion very slightly, but the benefit for flexibility and performance of analytics queries will almost certainly outweigh any impact to ingestion performance.

### Consider how you alter values in WHERE clauses

The primary index isn’t effective if Firebolt can’t determine the values in the index column. If the `WHERE` clause in your query contains a function that transforms the column values, Firebolt can’t use the index. Consider a table with the primary index definition shown below, where `asset_id` is a `TEXT` data type in a table named `events_log`.

```sql
  PRIMARY INDEX asset_id
```

In the example analytics query over the `events_log` table, Firebolt can’t use the primary index with the `WHERE` clause. This is because the function with `asset_id` is on the left side of the comparison. To satisfy the conditions of comparison, Firebolt must read all values of `asset_id` to apply the `UPPER` function.

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

If you know that you will use a function in a predicate ahead of time, consider creating a virtual column to store the result of the function. You can then use that virtual column in your index and queries. This is particularly useful for hashing columns.

### With a star schema, include join key columns in the fact table index

If you have a star schema with a fact table referring to many dimension tables, include the join keys (the foreign key columns) in the primary index of the fact table. This helps accelerate queries because the Firebolt query planner uses join keys as a predicate.

Conversely, on the dimension table side, there is no benefit to including the join key in the dimension table primary index unless you use it as a filter on the dimension table itself.

## Using partitions with primary indexes

In most cases, partitioning isn’t necessary because of the efficiency of primary indexes (and aggregating indexes). If you use partitions, the partition column is the first stage of sorting. Firebolt divides the table data into file segments according to the `PARTITION BY` definition. Then, within each of those segments, Firebolt applies the primary index to prune and sort the data into even smaller data ranges as described above.

For more information, see [Working with partitions](../working-with-partitions.html).

## Primary index examples

This section demonstrates different primary indexes created on a fact table, `site_sales`, created with the DDL and sample values shown below.

### Example fact table
{: .no_toc}

The examples in this section are based on the fact table below. The table is a web log with hundreds of millions of rows. Each record stores an `event_count` of each `event_type` for HTML elements identified by `asset_id` and the `customer_id` of the visitor that initiated the event. The table is denormalized. No single column has unique values.

#### Table DDL
{: .no_toc}

```sql
CREATE FACT TABLE events_log (
  visit_date DATE,
  asset_id TEXT,
  customer_id TEXT NOT NULL,
  event_type TEXT,
  event_count INTEGER NOT NULL
)
PRIMARY INDEX <see examples below>;
```

#### Table contents (excerpt)
{: .no_toc}

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

#### Cardinality of columns
{: .no_toc}

A `COUNT DISTINCT` query on each column returns the following. A higher number indicates higher cardinality.

```
+----------------+-----------------+--------------------+-----------------+
| distinct_dates | distinct_assets | distinct_customers | distinct_events |
+----------------+-----------------+--------------------+-----------------+
|           1461 |             300 |              89664 |               3 |
+----------------+-----------------+--------------------+-----------------+
```

### Example query pattern&mdash;date-based queries

Consider the two example queries below that return values with date-based filters.

#### Query 1
{: .no_toc}

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

#### Query 2
{: .no_toc}

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

```sql
PRIMARY INDEX (visit_date, customer_id, event_type)
```

* With `visit_date` in the first position in the primary index, Firebolt sorts and compresses records most efficiently for these date-based queries.
* The addition of `customer_id` in the second position and `event_type` in the third position further compresses data and accelerates query response.
* `customer_id` is in the second position because it has higher cardinality than `event_type`, which has only three possible values.
* `asset_id` is not used in query filters, so it is omitted.

For query 2, you can improve performance further by partitioning the table according to year as shown in the query excerpt below.

```
PRIMARY INDEX (visit_date, customer_id, event_type)
PARTITION BY (EXTRACT (YEAR FROM visit_date))
```

Without the partition, Firebolt likely must scan across file segments to return results for the year 2021. With the partition, segments exist for each year, and Firebolt can read all results from a single segment. If the query runs on a multi-node engine, the benefit may be greater. Firebolt can avoid pulling data from multiple engine nodes for results.

### Example query pattern&mdash;customer-based query

Consider the example query below that returns the sum of `click` values for a particular customer.

```sql
SELECT
  asset_id,
  customer_id,
  event_type,
  SUM(event_value)
FROM
  events
WHERE
  customer_id = "14493"
  AND event_type = 'click'
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

### Example&mdash;using virtual columns

Virtual columns are most often used in a primary index to:

* Accommodate functions that alter column values.
* Calculate hash values for columns that contain long strings.

A virtual-column example for a function that transforms a column value is shown below.

#### Step 1&mdash;create the fact table with the virtual column in the index
{: .no_toc}

The example DDL below creates a fact table similar to the one earlier in this section. However, it adds the `upper_customer_id` column. The table creates this virtual column to store the result of an `UPPER` function that upper-cases `customer_id` values during the `INSERT INTO` operation.

The `PRIMARY INDEX` clause uses the `upper_customer_id` column because that column is used in analytics queries.

```sql
CREATE FACT TABLE events_log (
  visit_date DATE,
  asset_id TEXT,
  customer_id TEXT NOT NULL,
  event_type TEXT,
  event_count INTEGER NOT NULL,
  uppder_customer_id TEXT NOT NULL
)
PRIMARY INDEX visit_date, upper _customer_id;
```

#### Step 2&mdash;use the function during ingestion (`INSERT INTO` statement)
{: .no_toc}

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

#### Step 3&mdash;query using the virtual column in predicates
{: .no_toc}

The example `SELECT` query below uses the virtual column to produce query results and benefits from the index.

```sql
SELECT
  customer_id
FROM
  events_log
WHERE
  upper_customer_id LIKE ‘AAA%’;
```
