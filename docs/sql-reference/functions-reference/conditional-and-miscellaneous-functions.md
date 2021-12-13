---
layout: default
title: Conditional and miscellaneous functions
nav_order: 2
parent: SQL functions reference
---

# Conditional and miscellaneous functions

This page describes the conditional and miscellaneous functions supported in Firebolt.

## CASE

The CASE expression is a conditional expression similar to if-then-else statements.\
If the result of the condition is true then the value of the CASE expression is the result that follows the condition. ​ If the result is false any subsequent WHEN clauses (conditions) are searched in the same manner. ​ If no WHEN condition is true then the value of the case expression is the result specified in the ELSE clause. ​ If the ELSE clause is omitted and no condition matches, the result is null.

**Syntax**

```sql
CASE
    WHEN <condition> THEN <result>
    [WHEN ...n]
    [ELSE <result>]
END;
```

| Parameter     | Description                                                                                                                                             |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<condition>` | An expression that returns a boolean result. ​ A condition can be defined for each `WHEN`, and `ELSE` clause.                                               |
| `<result>`    | The result of any condition. Every ​`THEN` ​​clause receives a single result. All results in a single ​`CASE` ​​function must share the same data type. |

**Example**

This example references a table `Movie_test` with the following columns and values:&#x20;

| Movie                | Length |
| :-------------------- | :------ |
| Citizen Kane         | 114    |
| Happy Gilmore        | 82     |
| Silence of the Lambs | 110    |
| The Godfather        | 150    |
| The Jazz Singer      | 40     |
| Tropic Thunder       | 90     |

The following example categorizes each entry by length. If the movie is longer than zero minutes and less than 50 minutes it is categorized as SHORT. When the length is 50-120 minutes, it's categorized as Medium, and when even longer, it's categorized as Long.

```sql
SELECT
   Movie,
   length,
   CASE
      WHEN
         length > 0
         AND length <= 50
      THEN
         'Short'
      WHEN
         length > 50
         AND length <= 120
      THEN
         'Medium'
      WHEN
         length > 120
      THEN
         'Long'
   END
   duration
FROM
   movie_test
ORDER BY
   Movie;
```

**Returns:**

```
+----------------------+--------+----------+
|        Title         | Length | duration |
+----------------------+--------+----------+
| Citizen Kane         |    114 | Medium   |
| Happy Gilmore        |     82 | Medium   |
| Silence of the Lambs |    110 | Medium   |
| The Godfather        |    150 | Long     |
| The Jazz Singer      |     40 | Short    |
| Tropic Thunder       |     90 | Medium   |
+----------------------+--------+----------+
```

## CAST

Similar to `TRY_CAST`, `CAST` converts data types into other data types based on the specified parameters. If the conversion cannot be performed, `CAST` returns an error. To return a `NULL` value instead, use `TRY_CAST`.

**Syntax**

```sql
CAST(<value> AS <type>)
```

| Parameter | Description                                                                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<value>` | The value to convert or an expression that results in a value to convert. Can be a column name, ​ ​a function applied to a column or another function, or a literal value. |
| `<type>`  | The target [data type](../../general-reference/data-types.md) (case-insensitive).                                                                                          |

**Example**

```sql
SELECT CAST('1' AS INT) as res;
```

Returns: `1`

{: .note}
`CAST` can also be done by using the `::` operator. For more information, see [Cast operator](../commands/operators.md#cast-operator).

## CITY\_HASH

Takes one or more input parameters of any data type and returns a 64-bit non-cryptographic hash value. `CITY_HASH` uses the CityHash algorithm for string data types, implementation-specific algorithms for other data types, and the CityHash combinator to produce the resulting hash value.

**Syntax**

```sql
CITY_HASH(<exp>, [, expr2 [,...]])
```

| Parameter | Description                                                      |
| :--------- | :---------------------------------------------------------------- |
| `<exp>`   | An expression that returns any data type that Firebolt supports. |

**Example**

```
SELECT CITY_HASH('15', 'apple', '02-25-1918')
```

**Returns: **`2383463095444788470`

## COALESCE

Checks from left to right for the first non-NULL argument found for each entry parameter pair. For example, for an Employee table (where each employee can have more than one location), check multiple location parameters, find the first non-null pair per employee (the first location with data per employee).

**Syntax**

```sql
​​COALESCE(<value> [,...])
```

| Parameter | Description                                                                                                                                       |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<value>` | The value(s) to coalesce. Can be either: column name, ​ ​a function applied on a column (or on another function), and a literal (constant value). |

**Example**

```sql
SELECT COALESCE(null, 'London','New York') AS res;
```

Returns: `London`

## NULL\_IF

Alias for `NULLIF`.

## NULLIF

Compares two values. Returns `null` if the values are equal and returns the first value if they are not equal.

**Syntax**

```sql
NULLIF(<exp1>, <exp2>)
```

| Parameter            | Description                                                                                                                                                                                                                                 |
| :-------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr1>`, `<expr2>` | Expressions that evaluate to any data type that Firebolt supports. The expressions must evaluate to the same data type or synonyms, or an error occurs. `<exp1>` is the value returned if the expressions do not evaluate to an equal result. |

**Example**

```sql
NULLIF('Firebolt fast','Firebolt fast')
```

**Returns**: `null`

```sql
NULLIF('Firebolt fast','Firebolt Fast')
```

**Returns**: `Firebolt fast`

## TRY\_CAST

Similar to `CAST`, `TRY_CAST` converts data types into other data types based on the specified parameters. If the conversion cannot be performed, `TRY_CAST` returns a `NULL`. To return an error message instead, use `CAST`.

**Syntax**

```sql
TRY_CAST(<value> AS <type>)
```

| Parameter | Description                                                                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<value>` | The value to convert or an expression that results in a value to convert. Can be a column name, ​ ​a function applied to a column or another function, or a literal value. |
| `<type>`  | The target [data type](../../general-reference/data-types.md) (case-insensitive).                                                                                          |

**Example**

```sql
SELECT TRY_CAST('1' AS INT) as res, TRY_CAST('test' AS INT) as res1;
```

**Returns**: `1,null`
