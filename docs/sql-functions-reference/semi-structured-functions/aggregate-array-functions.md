# Aggregate array functions

Aggregate semi-structured functions work globally on all the arrays in a given column expression, instead of a row-by-row application.

At their simplest form \(without a `GROUP BY` clause\) - they will provide the result of globally applying the function on all of the elements of the arrays in the column expression specified as their argument. Thus, fur example, ARRAY\_SUM\_GLOBAL will return the sum of all the elements in all the array of the given column expression argument, and ARRAY\_MAX\_GLOBAL will return the maximal element among all of the elements in _all_ of the arrays in the given column expression.

When combined with a `GROUP BY` clause, these operations will be performed on all of the arrays in each group.

From the remainder of this page we will use the following table T in our examples:

| Category | vals |
| :--- | :--- |
| a | \[1,3,4\] |
| b | \[3,5,6,7\] |
| a | \[30,50,60\] |

## ARRAY\_COUNT\_GLOBAL

Returns the number of elements in the array typed column accumulated over the rows in each group.

**Syntax**

```sql
ARRAY_COUNT_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array column over which the function will count the elements |

Assuming that `arr` is an array typed column, the following is equivalent

```sql
SUM(ARRAY_COUNT(arr))
```

**Usage Example**

```sql
SELECT Category, ARRAY_COUNT_GLOBAL(vals) AS cnt
FROM T
GROUP BY Category;
```

Returns:

| category | cnt |
| :--- | :--- |
| a | 6 |
| b | 4 |

## ARRAY\_SUM\_GLOBAL

Returns the sum of elements in the array typed column accumulated over the rows in each group.

**Syntax**

```sql
ARRAY_COUNT_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array column over which the function will sum the elements |

**Usage Example**

```sql
SELECT Category, ARRAY_SUM_GLOBAL(vals) AS sm
FROM T
GROUP BY Category;
```

Returns:

| category | sm |
| :--- | :--- |
| a | 148 |
| b | 21 |

## ARRAY\_MAX\_GLOBAL

Returns the maximal element taken from all the array elements in each group.

**Syntax**

```sql
ARRAY_MAX_GLOBAL(arr) AS cnt
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array column over from which the function returns the maximal element |

**Usage Example**

```sql
SELECT Category, ARRAY_MAX_GLOBAL(vals) AS mx
FROM T
GROUP BY Category;
```

Returns:

| category | mx |
| :--- | :--- |
| a | 60 |
| b | 7 |

## ARRAY\_MIN\_GLOBAL

Returns the minimal element taken from all the array elements in each group.

**Syntax**

```sql
ARRAY_MIN_GLOBAL(arr)
```

| Parameter | Description |
| :--- | :--- |
| `arr` | The array column from which the function will return the minimal element |

**Usage Example**

```sql
SELECT Category, ARRAY_MIN_GLOBAL(vals) AS mn
FROM T
GROUP BY Category;
```

Returns:

| category | sm |
| :--- | :--- |
| a | 1 |
| b | 3 |

