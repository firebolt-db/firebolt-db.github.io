---
layout: default
title: TRANSFORM
description: Reference material for TRANSFORM function
parent: SQL functions
---

# TRANSFORM

Returns an array by applying `<function>` on each element of `<array>`.

The Lambda function `<function>` is a mandatory parameter.

## Syntax
{: .no_toc}

```sql
TRANSFORM(<function>, <array>)
```
## Parameters
{: .no_toc} 

| Parameter | Description                 | Supported input type | 
| :--------- | :---------------------------------- |:------| 
| `<function>`  | A [Lambda function](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions) used to check elements in the array. | Any Lambda function | 
| `<array>`   | The array to be transformed by the function.   | Any array | 

## Return Type 
`ARRAY` of the same type as the input array 

## Examples
{: .no_toc}

```sql
SELECT
	TRANSFORM(x -> x * 2, [ 1, 2, 3, 9 ] ) AS levels;
```

**Returns**: `2,4,6,18`

In the example below, the `TRANSFORM` function is used to [`CAST`](./cast.md) each element from a string to a date type. With each element now as a date type, the [`INTERVAL`](../../general-reference/operators.md#interval-for-date-and-time) function is then used to add 5 years to each.  

```sql
SELECT
    TRANSFORM(x ->  CAST(x as DATE) + INTERVAL '5 year',
        [ '1979-01-01', '1986-02-26', '1975-04-04' ] )
    AS registeredon;
```

**Returns**: `["1984-01-01 05:06:00","1991-02-26 05:06:00","1980-04-03 05:06:00"]`

In the example below, `TRANSFORM` is used with `CASE` to modify specific elements based on a condition.

```sql
SELECT
    TRANSFORM(x, y -> CASE
        WHEN y = 'esimpson' THEN x
        ELSE 0
        END,
        [ 1, 2, 3 ],
        [ 'kennethpark', 'esimpson', 'sabrina21' ] )
    AS levels;
```

**Returns**: `[0,2,0]`

This example again uses `TRANSFORM` with `CASE`. Elements that don't meet the condition are left unchanged.

```sql
SELECT
    TRANSFORM(x, y -> CASE
        WHEN y % 2 == 0
        THEN UPPER(x)
        ELSE x END,
        [ 'esimpson', 'sabrina21', 'kennethpark' ],
        [ 1, 2, 3 ] )
    AS players;
```

**Returns**: `["esimpson","SABRINA21","kennethpark"]`

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