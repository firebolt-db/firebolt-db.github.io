# Aggregate array functions

Aggregate semi-structured functions work globally on all the arrays in a given column expression, instead of a row-by-row application.

At their simplest form (without a `GROUP BY` clause) - they will provide the result of globally applying the function on all of the elements of the arrays in the column expression specified as their argument. For example, `ARRAY_SUM_GLOBAL` will return the sum of all the elements in all the array of the given column. `ARRAY_MAX_GLOBAL` will return the maximum element among all of the elements in _all_ of the arrays in the given column expression.

When combined with a `GROUP BY` clause, these operations will be performed on all of the arrays in each group.

From the remainder of this page we will use the following table `T` in our examples:

| Category | vals        |
| -------- | ----------- |
| a        | \[1,3,4]    |
| b        | \[3,5,6,7]  |
| a        | \[30,50,60] |

## ARRAY\_MAX\_GLOBAL

Returns the maximum element from all the array elements in each group.

**Syntax**

```sql
ARRAY_MAX_GLOBAL(<arr>) AS cnt
```

| Parameter | Description                                                               |
| --------- | ------------------------------------------------------------------------- |
| `<arr>`   | The array column over from which the function returns the maximum element |

**Example**

```sql
SELECT
	Category,
	ARRAY_MAX_GLOBAL(vals) AS mx
FROM
	T
GROUP BY
	Category;
```

**Returns**:

| category | mx |
| -------- | -- |
| a        | 4  |
| b        | 7  |
| c        | 60 |

## ARRAY\_MIN\_GLOBAL

Returns the minimal element taken from all the array elements in each group.

**Syntax**

```sql
ARRAY_MIN_GLOBAL(<arr>)
```

| Parameter | Description                                                              |
| --------- | ------------------------------------------------------------------------ |
| `<arr>`   | The array column from which the function will return the minimal element |

**Example**

```sql
SELECT
	Category,
	ARRAY_MIN_GLOBAL(vals) AS mn
FROM
	T
GROUP BY
	Category;
```

**Returns**:

| category | sm |
| -------- | -- |
| a        | 1  |
| b        | 3  |
| c        | 30 |

## ARRAY\_SUM\_GLOBAL

Returns the sum of elements in the array column accumulated over the rows in each group.

**Syntax**

```sql
ARRAY_SUM_GLOBAL(<arr>)
```

| Parameter | Description                                                    |
| --------- | -------------------------------------------------------------- |
| `<arr>`   | The array column over which the function will sum the elements |

**Example**

```sql
SELECT
	Category,
	ARRAY_SUM_GLOBAL(vals) AS sm
FROM
	T
GROUP BY
	Category;
```

**Returns**:

| category | sm  |
| -------- | --- |
| a        | 8   |
| b        | 21  |
| c        | 140 |
