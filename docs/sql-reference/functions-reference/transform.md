---
layout: default
title: TRANSFORM
description: Reference material for TRANSFORM function
parent: SQL functions
---

# TRANSFORM

Returns an array by applying `<func>` on each element of `<arr>`.

The Lambda function `<func>` is mandatory.

## Syntax
{: .no_toc}

```sql
TRANSFORM(<func>, <arr>)
```

| Parameter | Description                                                                                                                                                                    |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<func>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. |
| `<arr>`   | The array to be transformed by the function.                                                                                                                                   |

## Examples
{: .no_toc}

```sql
SELECT
	TRANSFORM(x -> x * 2, [ 1, 2, 3, 9 ] ) AS res;
```

**Returns**: `2,4,6,18`

In the example below, the `TRANSFORM` function is used to [`CAST`](./cast.md) each element from a string to a date type. With each element now as a date type, the [`INTERVAL`](../../general-reference/operators.html#interval-for-date-and-time) function is then used to add 5 years to each.  

```sql
SELECT
    TRANSFORM(x ->  CAST(x as DATE) + INTERVAL '5 year',
        [ '1979-01-01', '1986-02-26', '1975-04-04' ] )
    AS res;
```

**Returns**: `["1984-01-01 05:06:00","1991-02-26 05:06:00","1980-04-03 05:06:00"]`

In the example below, `TRANSFORM` is used with `CASE` to modify specific elements based on a condition.

```sql
SELECT
    TRANSFORM(x, y -> CASE
        WHEN y = 'green' THEN x
        ELSE 0
        END,
        [ 1, 2, 3 ],
        [ 'red', 'green', 'blue' ] )
    AS res;
```

**Returns**: `[0,2,0]`

This example again uses `TRANSFORM` with `CASE`. Elements that don't meet the condition are left unchanged.

```sql
SELECT
    TRANSFORM(x, y -> CASE
        WHEN y % 2 == 0
        THEN UPPER(x)
        ELSE x END,
        [ 'red', 'green', 'blue' ],
        [ 1, 2, 3 ] )
    AS res;
```

**Returns**: `["red","GREEN","blue"]`

This is another example using `CASE` that changes elements only if they meet the condition.

```sql
SELECT
    TRANSFORM(x, y -> CASE
        WHEN x < y THEN y
        ELSE x END,
        [ 100, 700, 800 ],
        [ 300, 500, 200 ] )
    AS res;
```

**Returns**: `[300,700,800]`
