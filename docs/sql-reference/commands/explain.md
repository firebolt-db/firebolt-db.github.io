---
layout: default
title: EXPLAIN
parent: SQL commands
---

# EXPLAIN

The `EXPLAIN` feature in Firebolt is a powerful tool that helps you understand how the system executes a query. It provides insight into the execution plan that Firebolt will use to compute the result of your query. This information is crucial for query optimization and understanding the performance of your SQL queries.

If you specify the `ANALYZE` option for `EXPLAIN`, Firebolt also executes the query and collects detailed metrics about each operator, such as how much time is spent on the operator, and how much data it processes.

## Syntax

```sql
EXPLAIN [( <option_name> [<option_value>] [, ...] )] <select_statement>
```

| Parameter            | Description                                                                 |
| :------------------- | :-------------------------------------------------------------------------- |
| `option_name`        | The name of an option. See below for a list of all available options.       |
| `option_value`       | The value of the option. If no value is specified, it is `TRUE` by default. |
| `<select_statement>` | Any select statement.                                                       |

## Explain Options

The output of `EXPLAIN` can be augmented by specifying options. The following table lists all available options:

| Option Name | Option Values   | Description                                                                                                                                                                                                                                                                   |
| :---------- | :-------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `LOGICAL`   | `TRUE`, `FALSE` | Returns the optimized logical query plan in the column `explain_logical`. Its default value is `TRUE` if neither the `PHYSICAL` nor the `ANALYZE` option is enabled. Otherwise, it is `FALSE`.                                                                                |
| `PHYSICAL`  | `TRUE`, `FALSE` | Returns the optimized physical query plan containing shuffle operators for queries on distributed engines. This gives insights how work is distributed between the nodes of an engine. The result is returned in the column `explain_physical`. Its default value is `FALSE`. |
| `ANALYZE`   | `TRUE`, `FALSE` | Executes the query and returns the optimized physical query plan annotated with metrics from query execution in the column `explain_analyze`. The metrics are explained in [Example with ANALYZE](#example-with-analyze). Its default value is `FALSE`.                       |
| `ALL`       | `TRUE`, `FALSE` | Changes the default value of `LOGICAL`, `PHYSICAL`, and `ANALYZE`. Its default value is `FALSE`. Executing `EXPLAIN (ALL) <select statement>` set the value of the `ALL` option to `TRUE`, and thus enables the `LOGICAL`, `PHYSICAL`, and `ANALYZE` options.                 |

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
	ALL
ORDER BY
	1,2,3,4;
```

**Returns:**

```
[0] [Projection] lineitem.l_shipdate, lineitem.l_linestatus, lineitem.l_orderkey, avgOrNull(lineitem.l_discount)
 \_[1] [Sort] OrderBy: [lineitem.l_shipdate Ascending Last, lineitem.l_linestatus Ascending Last, lineitem.l_orderkey Ascending Last, avgOrNull(lineitem.l_discount) Ascending Last]
    \_[2] [Aggregate] GroupBy: [lineitem.l_orderkey, lineitem.l_linestatus, lineitem.l_shipdate] Aggregates: [avgOrNull(lineitem.l_discount)]
       \_[3] [Projection] lineitem.l_orderkey, lineitem.l_discount, lineitem.l_linestatus, lineitem.l_shipdate
          \_[4] [Predicate] equals(lineitem.l_returnflag, 'N'), greater(lineitem.l_shipdate, toPGDate('1996-01-01'))
             \_[5] [StoredTable] Name: 'lineitem', used 5/16 column(s) FACT
```

The `EXPLAIN` results indicate that this `SELECT` query will execute operations as follows. The Firebolt engine will:

1. Read the required columns from the `lineitem` table.
2. Filter the `lineitem` table by the `WHERE` conditions.
3. Remove the columns that are no longer required.
4. Perform the aggregation as specified by the `GROUP BY` clause.
5. Sort resulting rows in ascending order by all columns from the `ORDER BY` clause.
6. Bring the columns into the order specified in the `SELECT` clause.

## Example with ANALYZE

Now, we execute the same query on a multi-node engine, but with the `(ALL)` option specified. This is equivalent to writing `(ALL TRUE)` or `(LOGICAL, PHYSICAL, ANALYZE)`.

```sql
EXPLAIN (ALL)
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
	ALL
ORDER BY
	1,2,3,4;
```

**Returns:**

Disclaimer
: The exact format of this result is still subject to change.

The query returns three columns `explain_logical`, `explain_physical`, and `explain_analyze`. They are presented in the following sections.

Each column can be turned off individually using the corresponding option. For example, to only show `explain_logical` and `explain_analyze`, we could either specify `(LOGICAL, ANALYZE)` or `(ALL, PHYSICAL FALSE)`. With the `ANALYZE` option set, this query took 4.7s to execute. If the `ANALYZE` option is not set, the query is not executed and should return the result almost immediately.

### `EXPLAIN (LOGICAL)` output

```
[0] [Projection] ref_2, ref_1, ref_0, ref_3
|   [RowType]: pgdate not null, text not null, bigint not null, double precision null
 \_[1] [Sort] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
   |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
    \_[2] [Aggregate] GroupBy: [ref_0, ref_2, ref_3] Aggregates: [avgOrNull(ref_1)]
      |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
       \_[3] [Projection] ref_0, ref_1, ref_3, ref_4
         |   [RowType]: bigint not null, double precision not null, text not null, pgdate not null
          \_[4] [Predicate] equals(ref_2, 'N'), greater(ref_4, toPGDate('1996-01-01'))
            |   [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
             \_[5] [StoredTable] Name: 'lineitem', used 5/16 column(s) FACT, ref_0: 'l_orderkey' ref_1: 'l_discount' ref_2: 'l_returnflag' ref_3: 'l_linestatus' ref_4: 'l_shipdate'
                   [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
```

The `explain_logical` column shows the optimized logical query plan of the select statement. This is the same plan as in [Example](#example). Additionally, it shows the output row type for each operator. A variable `ref_2` refers to the second input column from the operator below. For the operators with multiple input operators like the `Join` operator, the input columns are concatenated. If the first input emits three columns, and the second input four columns, the columns of the first input are referred to as `ref_0` - `ref_2`, and the columns of the second input are referred to as `ref_3` - `ref-6`.

### `EXPLAIN (PHYSICAL)` output

```
[0] [Projection] ref_2, ref_1, ref_0, ref_3
|   [RowType]: pgdate not null, text not null, bigint not null, double precision null
 \_[1] [SortMerge] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
   |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
    \_[2] [Shuffle] Gather
      |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
       \_[3] [Sort] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
         |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
          \_[4] [AggregateMerge] GroupBy: [ref_0, ref_1, ref_2] Aggregates: [avgOrNullMerge(ref_3)]
            |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
             \_[5] [Shuffle] Hash by [ref_0, ref_1, ref_2]
               |   [RowType]: bigint not null, text not null, pgdate not null, aggregatefunction2(avgornull, double precision not null) not null
                \_[6] [AggregatePartial] GroupBy: [ref_0, ref_2, ref_3] Aggregates: [avgOrNullState(ref_1)]
                  |   [RowType]: bigint not null, text not null, pgdate not null, aggregatefunction2(avgornull, double precision not null) not null
                   \_[7] [Projection] ref_0, ref_1, ref_3, ref_4
                     |   [RowType]: bigint not null, double precision not null, text not null, pgdate not null
                      \_[8] [Predicate] equals(ref_2, 'N'), greater(ref_4, toPGDate('1996-01-01'))
                        |   [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
                         \_[9] [StoredTable] Name: 'lineitem', used 5/16 column(s) FACT, ref_0: 'l_orderkey' ref_1: 'l_discount' ref_2: 'l_returnflag' ref_3: 'l_linestatus' ref_4: 'l_shipdate'
                               [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
```

The `explain_physical` column shows the more detailed optimized physical plan containing `Shuffle` operators for distributed query execution. It allows insights into how work is distributed across the nodes of an engine. A `Shuffle` operator redistributes data between the nodes of an engine. Scans of `FACT` tables, like operator `[9] [StoredTable]` in the example above, and the operators following it are automatically distributed across all nodes of an engine. A `Shuffle` operator of type `Hash` indicates that the work on the operators following it is distributed over all nodes, as well. A `Shuffle` operator of type `Gather` gathers all data on a single node of the engine. In the example above, only the operator `[1] [SortMerge]` is executed on a single node, merging the sorted partial query results from all other nodes.

### `EXPLAIN (ANALYZE)` output

```
[0] [Projection] ref_2, ref_1, ref_0, ref_3
|   [RowType]: pgdate not null, text not null, bigint not null, double precision null
|   [Execution Metrics]: output cardinality = 24640805, thread time = 0ms, cpu time = 0ms
 \_[1] [SortMerge] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
   |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
   |   [Execution Metrics]: output cardinality = 24640805, thread time = 2805ms, cpu time = 2804ms
    \_[2] [Shuffle] Gather
      |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
      |   [Execution Metrics]: output cardinality = 24640805, thread time = 304ms, cpu time = 303ms
       \_[3] [Sort] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
         |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
         |   [Execution Metrics]: output cardinality = 24640805, thread time = 18025ms, cpu time = 18019ms
          \_[4] [AggregateMerge] GroupBy: [ref_0, ref_1, ref_2] Aggregates: [avgOrNullMerge(ref_3)]
            |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
            |   [Execution Metrics]: output cardinality = 24640805, thread time = 5499ms, cpu time = 5466ms
             \_[5] [Shuffle] Hash by [ref_0, ref_1, ref_2]
               |   [RowType]: bigint not null, text not null, pgdate not null, aggregatefunction2(avgornull, double precision not null) not null
               |   [Execution Metrics]: output cardinality = 24640806, thread time = 2093ms, cpu time = 2065ms
                \_[6] [AggregateState partial] GroupBy: [ref_0, ref_2, ref_3] Aggregates: [avgOrNullState(ref_1)]
                  |   [RowType]: bigint not null, text not null, pgdate not null, aggregatefunction2(avgornull, double precision not null) not null
                  |   [Execution Metrics]: output cardinality = 24640806, thread time = 18498ms, cpu time = 18165ms
                   \_[7] [Projection] ref_0, ref_1, ref_3, ref_4
                     |   [RowType]: bigint not null, double precision not null, text not null, pgdate not null
                     |   [Execution Metrics]: output cardinality = 25050365, thread time = 0ms, cpu time = 0ms
                      \_[8] [Predicate] equals(ref_2, 'N'), greater(ref_4, toPGDate('1996-01-01'))
                        |   [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
                        |   [Execution Metrics]: output cardinality = 25050365, thread time = 703ms, cpu time = 700ms
                         \_[9] [StoredTable] Name: 'lineitem', used 5/16 column(s) FACT, ref_0: 'l_orderkey' ref_1: 'l_discount' ref_2: 'l_returnflag' ref_3: 'l_linestatus' ref_4: 'l_shipdate'
                               [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
                               [Execution Metrics]: output cardinality = 30373792, thread time = 4629ms, cpu time = 4511ms
```

The `explain_analyze` column contains the same query plan as the `explain_physical` column, but annotated with metrics collected during query execution. For each operator, it shows the number of rows it produced (`output_cardinality`), and how much time was spent on that operator (`thread_time` and `cpu_time`). `thread_time` is the sum of the wall-clock time that threads spent working on this operator across all nodes. `cpu_time` is the sum of the time these threads where scheduled on a CPU core. If `cpu_time` is considerably smaller than `thread_time`, this indicates that the operator is waiting a lot on IO or the engine is under multiple queries at once.

#### Analyzing the Metrics

In the example above, the `cpu_time` is almost as high as the `thread_time` on the `StoredTable` node. This indicates that the data of the `lineitem` table was in cache. On a cold run of the same query where the data has to be fetched from S3, the output for the same operator shows a `thread_time` considerably higher than `cpu_time`:

```
[9] [StoredTable] Name: 'lineitem', used 5/16 column(s) FACT, ref_0: 'l_orderkey' ref_1: 'l_discount' ref_2: 'l_returnflag' ref_3: 'l_linestatus' ref_4: 'l_shipdate'
    [RowType]: bigint not null, double precision not null, text not null, text not null, pgdate not null
    [Execution Metrics]: output cardinality = 30373792, thread time = 144771ms, cpu time = 6342ms
```

Furthermore, we see that a lot of time is spent on sorting the query result:

```
[1] [SortMerge] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
   |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
   |   [Execution Metrics]: output cardinality = 24640805, thread time = 2805ms, cpu time = 2804ms
    \_[2] [Shuffle] Gather
      |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
      |   [Execution Metrics]: output cardinality = 24640805, thread time = 304ms, cpu time = 303ms
       \_[3] [Sort] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last]
             [RowType]: bigint not null, text not null, pgdate not null, double precision null
             [Execution Metrics]: output cardinality = 24640805, thread time = 18025ms, cpu time = 18019ms
```

Thus, removing the `ORDER BY` can considerably speed up query execution. In this case, the execution time of the whole query halves from 4.7s to 2.3s. If we are only interested in the first results according to our specified sorting order, we can introduce a `LIMIT` operator to improve performance, as well. Adding a `LIMIT 10000` to the query gives the following output:

```
[1] [SortMerge] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last] Limit: [10000]
|   [RowType]: bigint not null, text not null, pgdate not null, double precision null
|   [Execution Metrics]: output cardinality = 10000, thread time = 1ms, cpu time = 1ms
 \_[2] [Shuffle] Gather
   |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
   |   [Execution Metrics]: output cardinality = 40000, thread time = 1ms, cpu time = 1ms
    \_[3] [Sort] OrderBy: [ref_2 Ascending Last, ref_1 Ascending Last, ref_0 Ascending Last, ref_3 Ascending Last] Limit: [10000]
      |   [RowType]: bigint not null, text not null, pgdate not null, double precision null
      |   [Execution Metrics]: output cardinality = 40000, thread time = 2215ms, cpu time = 2190ms
       \_[4] [AggregateMerge] GroupBy: [ref_0, ref_1, ref_2] Aggregates: [avgOrNullMerge(ref_3)]
             [RowType]: bigint not null, text not null, pgdate not null, double precision null
             [Execution Metrics]: output cardinality = 24640805, thread time = 5644ms, cpu time = 5608ms
```

The time spent in the `Sort` operator is almost an order of magnitude lower. The `Sort` operator takes the `LIMIT` clause directly into account and emits only the minimum number of rows it is required to. The execution time of the whole query is reduced from 4.7s to 1.7s. This is even more than the improvement by removing the `ORDER BY` clause, because less query result data needs to be serialized for returning it to the client.
