---
layout: default
title: Working with arrays
description: Learn techniques to manipulate and transform arrays in Firebolt.
nav_order: 3
parent: Working with semi-structured data
---

# Working with arrays
{: .no_toc}

This section covers querying and manipulating arrays in Firebolt.

* Topic ToC
{:toc}

## Declaring ARRAY data types in table definitions

Array types are declared using `ARRAY(<type>)` where `<type>` can be any data type that Firebolt supports. This includes the `ARRAY` data type, so arrays can be arbitrarily nested. The innermost type (the scalar) can be nullable, but `ARRAY`-typed columns cannot be nullable.

Array literals are also supported. For example, the `SELECT` statement shown below is valid.

```sql
SELECT [1,2,3,4]
```

### Basis for examples
{: .no_toc}

All examples in this topic are based on the table below, named `visits`. The column `id` is of type `INT`. All other columns are of type `ARRAY(TEXT)`.

![](../assets/images/array_example_table.png)

## Simple array functions

There are several fundamental functions that you can use to work with arrays, including [LENGTH](../sql-reference/functions-reference/length.md), [ARRAY_CONCAT](../sql-reference/functions-reference/array-concat.md), and [FLATTEN](../sql-reference/functions-reference/flatten.md). See the respective reference for a full description. Brief examples are shown below.

### LENGTH example
{: .no_toc}

`LENGTH` returns the number of elements in an array.

```sql
SELECT 
  id,
  LENGTH(agent_props_keys) as key_array_length
FROM visits;
```

**Returns**:

```
+-----------------------+
| id | key_array_length |
+-----------------------+
| 1  | 3                |
| 2  | 2                |
| 3  | 3                |
+-----------------------+
```

### ARRAY_CONCAT example
{: .no_toc}

`ARRAY_CONCAT` combines multiple arrays into a single array.

```sql
SELECT 
  id, 
  ARRAY_CONCAT(agent_props_keys, agent_props_vals) as concat_keys_and_vals
FROM visits;
```

**Returns**:

```
+----+------------------------------------------------------------------------------+
| id | concat_keys_and_vals                                                         |
+----+------------------------------------------------------------------------------+
| 1  | ["agent","platform","resolution","Mozilla/5.0","Windows NT 6.1","1024X4069"] |
| 2  | ["agent","platform","Safari","iOS 14"]                                       |
| 3  | ["agent","platform","platform","Safari","iOS 14","Windows 11"]               |
+----+------------------------------------------------------------------------------+
```

### FLATTEN example
{: .no_toc}

`FLATTEN` converts one or more nested arrays into a single array.

```sql
SELECT FLATTEN([ [[1,2,3],[4,5]], [[2]] ]) as flattened_array;
```

**Returns**: 

```
+-----------------+
| flattened_array |
+-----------------+
| [1,2,3,4,5,2]   |
+-----------------+
```

## Manipulating arrays with Lambda functions

Firebolt *Lambda functions* are a powerful tool that you can use on arrays to extract results. Lambda functions iteratively perform an operation on each element of one or more arrays. Arrays and the operation to perform are specified as arguments to the Lambda function.

### Lambda function general syntax

The general syntax pattern of a Lambda function is shown below. For detailed syntax and examples see the reference topics for [Lambda functions](../sql-reference/functions-reference/index.md#lambda-functions).

```
<LAMBDA_FUNC>(<arr1_var>[, <arr2_var>][, ...<arrN_var>]) -> <operation>, <array1>[, <array2>][, ...<arrayN>])
```

| Parameter                                     | Description    |
| :-------------------------------------------- | :------------- |
| `<LAMBDA_FUNC>`                                | Any array function that accepts a Lambda expression as an argument. For a list, see [Lambda functions](../sql-reference/functions-reference/index.md#lambda-functions).|
| `<arr1_var>[, <arr2_var>][, ...<arrN_var>]`   | A list of one or more variables that you specify. The list is specified in the same order and must be the same length as the list of array expressions (`<array1>[, <array2>][, ...<arrayN>]`). At runtime, each variable contains an element of the corresponding array. The specified `<operation>` is performed for each variable.|
| <operation>                                   | The operation that is performed for each element of the array. This is typically a function or Boolean expression. |
| <array1>[, <array2>][, ...<arrayN>]           | A comma-separated list of expressions, each of which evaluates to an `ARRAY` data type. |


### Lambda function example&ndash;single array

Consider the following [TRANSFORM](../sql-reference/functions-reference/transform.md) array function that uses a single array variable and reference in the Lambda expression. This example applies the `UPPER` function to each element `t` in the `ARRAY`-typed column `tags`. This converts each element in each `tags` array to upper-case.


```sql
SELECT 
  id, 
  TRANSFORM(t -> UPPER(t), tags) AS up_tags
FROM visits;
```

**Returns:**

```
+----+--------------------------+
| id | up_tags                  |
+----+--------------------------+
| 1  | ["SUMMER-SALE","SPORTS"] |
| 2  | ["GADGETS","AUDIO"]      |
| 3  | ["SUMMER-SALE","AUDIO"]  |
+----+--------------------------+
```

### Lambda function example&ndash;multiple arrays

[ARRAY_FIRST](../sql-reference/functions-reference/array-first.md) is an example of a function that takes multiple arrays as arguments in a map of key-value pairs. One array represents the keys and the other represents the values.

`ARRAY_FIRST` uses a Boolean expression that you specify to find the key in the key array. If the Boolean expression resolves to true, the function returns the first value in the value array that corresponds to the key's element position. If there are duplicate keys, only the first corresponding value is returned.

The example below returns the first value in the `agent_props_vals` array where the corresponding position in the `agent_props_keys` array contains the key `platform`.

```sql
SELECT 
  id, 
  ARRAY_FIRST(v, k -> k = 'platform', agent_props_vals, agent_props_keys) AS platform
FROM visits;
```

**Returns**:

```
+----+----------------+
| id | platform       |
+----+----------------+
| 1  | Windows NT 6.1 |
| 2  | iOS 14         |
| 3  | iOS 14         |
+----+----------------+
```
[ARRAY_SORT](../sql-reference/functions-reference/array-sort.md) sorts one array by another. One array represents the values and the other represents the sort order.

The example below sorts the first array by the positions defined in the second array

```sql
SELECT 
  ARRAY_SORT(x,y -> y, [ 'A','B','C'],[3,2,1]) AS res;
```  
**Returns**:

```
+-----------------+
| res             |
+-----------------+
| ["C", "B", "A"] |
+-----------------+
```

  
## UNNEST

You might want to transform a nested array structure to a standard tabular format so that you can expose views to BI tools that can't handle Firebolt array syntax, or you might find the tabular format more natural to query using standard SQL idioms. `UNNEST` serves these purposes.

[UNNEST](../sql-reference/commands/select.md#unnest) is part of the [FROM](../sql-reference/commands/select.md#from) clause and resembles a [JOIN](../sql-reference/commands/select.md#join). Given an `ARRAY`-typed column, `UNNEST` unfolds the elements of the array and duplicates all other columns found in the `SELECT` clause for each array element.

A single `UNNEST` acts similarly to `JOIN`. You can use a single `UNNEST` command to unnest several arrays if the arrays are the same length.

Multiple `UNNEST` statements in a single `FROM` clause result in a Cartesian product. Each element in the first array has a record in the result set corresponding to each element in the second array.

### Example&ndash;single UNNEST with single ARRAY-typed column

The following example unnests the `tags` column from the `visits` table.

```sql
SELECT 
  id, 
  tags
FROM visits
  UNNEST(tags);
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

```
+----+------------+------------------+
| id | a_keys     | a_vals           |
+----+------------+------------------+
| 1  | agent      | “Mozilla/5.0”    |
| 1  | platform   | “Windows NT 6.1” |
| 1  | resolution | “1024x4069”      |
| 2  | agent      | “Safari”         |
| 2  | platform   | “iOS 14”         |
+----+------------+------------------+
```

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
| INT | a_keys     |   a_values       |
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
    UNNEST(tags, agent_props_keys as a_keys)
```
