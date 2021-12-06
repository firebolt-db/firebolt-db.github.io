# Aggregation functions

This page describes the aggregation functions supported in Firebolt.

## MIN

Calculates the minimum value of an expression across all input values.

**Syntax**

```sql
​​MIN(expr)
```

| Parameter | Description |
| :--- | :--- |
| `expr` | The expression used to calculate the minimum values. Valid values for the expression include column names or functions that return a column name. |

## MAX

Calculates the maximum value of an expression across all input values.

**Syntax**

```sql
​​MAX(expr)
```

| Parameter | Description |
| :--- | :--- |
| `expr` | The expression used to calculate the maximum values. Valid values for the expression include column names or functions that return a column name. |

## MAX\_BY

The `MAX_BY` function returns the value of `arg` column at the row in which the `val` column is maximal.

If there is more than one maximal values in `val` the first will be used.

**Syntax**

```sql
MAX_BY(arg, val)
```

| Parameter | Description |
| :--- | :--- |
| `arg` | The column from which the value is returned. |
| `val` | The column from which the maximum value is searched. |

**Usage example**

Assume we have the following `prices` table:

| item | price |
| :--- | :--- |
| apple | 4 |
| banana | 25 |
| orange | 11 |
| kiwi | 20 |

The query

```sql
MAX_BY(item, price)
```

Will result in `'banana'`

## MIN\_BY

The `MIN_BY` function returns the value of `arg` column at the row in which the `val` column is minimal.

If there is more than one minimal values in `val` the first will be used.

**Syntax**

```sql
MIN_BY(arg, val)
```

| Parameter | Description |
| :--- | :--- |
| `arg` | The column from which the value is returned. |
| `val` | The column from which the maximum value is searched. |

**Usage example**

Assume we have the following `prices` table:

| item | price |
| :--- | :--- |
| apple | 4 |
| banana | 25 |
| orange | 11 |
| kiwi | 20 |

The query

```sql
MIN_BY(item, price)
```

Will result in `'apple'`

## SUM

Calculates the sum of an expression.

**Syntax**

```sql
​​SUM(expr)​​
```

| Parameter | Description |
| :--- | :--- |
| `expr` | The expression used to calculate the sum. Valid values for the expression include column names or functions that return a column name for columns that contain numeric values. |

## AVG

Calculates the average of an expression

**Syntax**

```sql
​​AVG(expr)​​
```

| Parameter | Description |
| :--- | :--- |
| `expr` | The expression used to calculate the average. Valid values for the expression include column names or functions that return a column name for columns that contain numeric values. |

{: .note}
The AVG\(\) aggregate function dismisses rows with NULL value; so an AVG from 3 rows containing 1, 2 and NULL values results in 1.5 as the NULL row is dismissed. For accurate AVG\(\), use SUM\(COLUMN\)/COUNT\(\*\)


## COUNT

Counts the number of rows or not NULL values.

**Syntax**

```sql
COUNT([ DISTINCT ] expr)
```

| Parameter | Description |
| :--- | :--- |
| `expr` | Valid values for the expression include column names \(or \* for counting all columns\) or functions that return a column name for columns that contain numeric values. When DISTINCT is being used, counts only the unique number of rows with not NULL values. |

{: .note}
COUNT\(\*\) will return a total count of rows in the table, while COUNT\(&lt;column\_name&gt;\) will return a count of rows with a non-NULL value in that particular column.

{: .note}
By default, COUNT DISTINCT will return approximate results. If you wish to get an accurate result \(with a performance penalty\), set the following parameter: `SET firebolt\_optimization\_enable\_exact\_count\_distinct=1;`

**Usage example**

```sql
SELECT COUNT(DISTINCT col) FROM my_table;
```

## MEDIAN

Calculates an approximate median using reservoir sampling for the given expression.

**Syntax**

```sql
​​MEDIAN(expr)​​
```

| Parameter | Description |
| :--- | :--- |
| `col` | Expression over the column values that returns numeric \(INT, FLOAT, etc\), DATE or DATETIME data types. |

## ANY\_VALUE

Returns one arbitrarily value from the given column.

**Syntax**

```sql
​​ANY_VALUE(col)​​
```

| Parameter | Description |
| :--- | :--- |
| `col` | The column from which the value is returned. |

## NEST

Takes a column as an argument, and returns an array of the values.

See the [full description](semi-structured-functions/array-functions.md#nest) under Semi-structured data functions.

## STDDEV\_SAMP

Computes the standard deviation of a sample consisting of a numeric-expression.

**Syntax**

```sql
STDDEV_SAMP(expr)​
```

| Parameter | Description |
| :--- | :--- |
| `expr` | Any column with numeric values or expression that returns a column with numeric values. |
