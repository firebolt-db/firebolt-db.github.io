---
layout: default
title: Working with arrays
description: Learn techniques to manipulate and transform arrays in Firebolt.
nav_order: 3
parent: Working with semi-structured data
---

# Working with arrays

This section covers querying and manipulating arrays in Firebolt.

* Topic ToC
{: .toc}

## Declaring ARRAY data types in table definitions

Array types are declared using `ARRAY(<type>)` where `<type>` can be any data type that Firebolt supports. This includes the `ARRAY` data type, so arrays can be arbitrarily nested. The innermost type (the scalar) can be nullable, but `ARRAY`-typed columns cannot be nullable.

Array literals are also supported. For example, the `SELECT` statement shown below is valid.

```sql
SELECT [1,2,3,4]
```

## Common table example

All examples in this topic are based on the table below, named `visits`. The column `id` is of type `INT`. All other columns are of type `ARRAY(TEXT)`.

```
+----+--------------------------+-------------------------------------+------------------------------------------------+
| id |           tags           |          agent_props_keys           |                agent_props_vals                |
+----+--------------------------+-------------------------------------+------------------------------------------------+
|  1 | ["summer-sale","sports"] | ["agent", "platform", "resolution"] | ["Mozilla/5.0", "Windows NT 6.1", "1024x4069"] |
|  2 | ["gadgets","audio"]      | ["agent", "platform"]               | ["Safari", "iOS 14"]                           |
+----+--------------------------+-------------------------------------+------------------------------------------------+

```

## Basic array functions

There are several self-explanatory functions to work with arrays including [LENGTH](../sql-reference/functions-reference/length.md), [ARRAY_CONCAT](../sql-reference/functions-reference/array-concat.md), and [FLATTEN](../sql-reference/functions-reference/flatten.md). See the respective reference for a full description. Here's a short example:

```sql
SELECT LENGTH(agent_prop_keys)
FROM visits
-- returns 3,2

SELECT ARRAY_CONCAT(agent_props_keys, agent_props_vals)
FROM visits
-- returns ["agent", "platform", "resolution", "Mozilla/5.0", "Windows NT 6.1", "1024x4069"]

SELECT FLATTEN([ [[1,2,3],[4,5]], [[2]] ])
-- returns [1,2,3,4,5,2]
```

## Manipulating arrays with Lambda expressions

Firebolt *Lambda expressions* are a powerful tool to manipulate arrays to extract results. The following array functions use Lambda expressions to operate on each element of one or more arrays. The arrays are specified as arguments in the Lambda expression.

* ALL_MATCH
* ANY_MATCH
* ARRAY_COUNT
* ARRAY_CUMULATIVE_SUM
* ARRAY_FILL
* ARRAY_FIRST_INDEX
* ARRAY_FIRST
* ARRAY_REPLACE_BACKWARDS
* ARRAY_SORT
* ARRAY_SUM
* FILTER
* TRANSFORM

### Lambda function general syntax

The general syntax pattern of Lambda expressions is uniform across the array functions that use them. That general syntax is shown below. For syntax and examples of each expression used in the context of the array function, see the reference topic for the specific [Array function](../sql-reference/index.md#array-functions).

```
<ARRAY_FUNC>(<arr1_var>[, <arr2_var>][, ...<arrN_var>]) -> <operation>, <array1>[, <array2>][, ...<arrayN>])
```

| Parameter                                     | Description    |
| :-------------------------------------------- | :------------- |
| `<ARRAY_FUNC>`                                | Any [Array function](../sql-reference/index.md#array-functions) that accepts a lambda expression as an argument. |
| `<arr1_var>[, <arr2_var>][, ...<arrN_var>]``  | A list of one or more variables that you specify. The list is specified in the same order and must be the same length as the list of array expressions (`<array1>[, <array2>][, ...<arrayN>]`). At run-time, each variable contains an element of the corresponding array, upon which the specified `<operation>` is performed.|
| <operation>                                   | The operation that is performed for each element of the array. This is typically a function or comparison. | <array1>[, <array2>][, ...<arrayN>]           | A comma-separated list of expressions, each of which evaluates to an `ARRAY` data type. |


### Lambda function example&ndash;single array

Consider the following [TRANSFORM](../sql-reference/functions-reference/transform.md) array function that uses a single array variable and reference in the Lambda expression.

```sql
SELECT TRANSFORM(t -> UPPER(t), tags) as up_tags
FROM visits
```

The [TRANSFORM](../sql-reference/functions-reference/transform.md) uses the lambda expression to apply `UPPER` to each element `t` in each array found in the `ARRAY`-typed column `tags`. This converts each element in each array in `tags` to upper-case, as shown in the result example below.

```
+----------------------------+
|          up_tags           |
+----------------------------+
| ["SUMMER_SALE", "SPORTS"] |
| ["GADGETS", "AUDIO"]       |
+----------------------------+
```

### Lambda function example&ndash;multiple arrays

A common use case where you provide multiple array arguments is when one array represents the keys and the other represents the values in a map of key-value pairs.

To extract the value associated with a particular key, you can use the [ARRAY_FIRST ](../sql-reference/functions-reference/array-first.md) function, which returns the first element for which the lambda expression evaluates to a result that is true (non-`0`). The value returned always corresponds to the first array argument in the series. However, the lambda expression operation can evaluate its comparison using any array argument.

In the example below, we want to return the value in `agent_props_vals` where the corresponding position in the `agent_props_keys` array contains the value `platform`.

```sql
SELECT ARRAY_FIRST(v, k -> k = 'platform', agent_props_vals, agent_props_keys)
as platform
FROM visits
```

**Returns**:

```
+------------------+
|     platform     |
+------------------+
| "Windows NT 6.1" |
| "iOS 14"         |
+------------------+
```

## UNNEST

You might want to transform a nested array structure to a standard tabular format so that you can expose views to BI tools that can't handle Firebolt array syntax, or you might find the tabular format more natural to query using standard SQL idioms. `UNNEST` serves these purposes.

[UNNEST](../sql-reference/commands/select.md#unnest) is part of the [FROM](../sql-reference/commands/select.md#from) clause and resembles a [JOIN](../sql-reference/commands/select.md#join). Given an `ARRAY`-typed column, `UNNEST` unfolds the elements of the array and duplicates all other columns found in the `SELECT` clause for each array element.

A single `UNNEST` acts similarly to `JOIN`. You can use a single `UNNEST` command to unnest several arrays if the arrays are the same length.

Multiple `UNNEST` statements in a single `FROM` clause result in a Cartesian product. Each element in the first array has a record in the result set corresponding to each element in the second array.

### Example&ndash;single UNNEST with single ARRAY-typed column

The following example unnests the `tags` column from the `visits` table.

```sql
SELECT id, tags
  FROM visits
UNNEST(tags)
```

**Returns**:

```
+----+---------------+
| id |     tags      |
+----+---------------+
|  1 | "summer-sale" |
|  1 | "sports"      |
|  2 | "gadgets"     |
|  2 | "audio"       |
+----+---------------+
```

### Example&ndash;single UNNEST using multiple ARRAY-typed columns

The following query specifies both the `agent_props_keys` and `agent_props_vals` columns to unnest.

```sql
SELECT
    id,
    a_keys,
    a_vals
FROM
    visits
    UNNEST(agent_props_keys as a_keys,
           agent_props_vals as a_vals)
```

**Returns**:

| id   | a_keys | a_vals |
| :--- | :---   | :---   |
| 1    | agent | "Mozilla/5.0" |
| 1    | platform | "Windows NT 6.1" |
| 1    | resolution | "1024x4069" |
| 2    | agent | "Safari" |
| 2    | platform | "iOS 14" |

### Example&ndash;multiple UNNEST clauses resulting in a Cartesian product

The following query, while valid, creates a Cartesian product.

```sql
SELECT
    id,
    a_keys,
    a_vals
FROM
    visits
UNNEST(agent_props_keys as a_keys)
UNNEST(agent_props_vals as a_vals)
```

**Returns**:

```
+-----+------------+------------------+
| INT |   a_keys   |     a_values     |
+-----+------------+------------------+
|   1 | agent      | "Mozilla/5.0"    |
|   1 | agent      | "Windows NT 6.1" |
|   1 | agent      | "1024x4069"      |
|   1 | platform   | "Mozilla/5.0"    |
|   1 | platform   | "Windows NT 6.1" |
|   1 | platform   | "1024x4069"      |
|   1 | resolution | "Mozilla/5.0"    |
|   1 | resolution | "Windows NT 6.1" |
|   1 | resolution | "1024x4069"      |
|   2 | agent      | "Safari"         |
|   2 | agent      | "iOS 14"         |
|   2 | platform   | "Safari"         |
|   2 | platform   | "iOS 14"         |
+-----+------------+------------------+
```

### Example&ndash;error on UNNEST of multiple arrays with different lengths

The following query is **invalid** and will result in an error as the `tags` and `agent_props_keys` arrays have different lengths for row 1.

```sql
SELECT
    id,
    tags,
    a_keys
FROM
    visits
    UNNEST(tags,
           agent_props_keys as a_keys)
```
