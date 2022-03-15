---
layout: default
title: Working with arrays
description: Learn techniques to manipulate and transform arrays in Firebolt.
nav_order: 3
parent: Working with semi-structured data
---
# Working with arrays

This section covers querying and manipulating arrays in Firebolt.

Array types are declared using `ARRAY(<type>)` where `<type>` can be any data type that Firebolt supports. This includes the `ARRAY` data type, so arrays can be arbitrarily nested. The innermost type (the scalar) can be nullable, but `ARRAY` typed columns cannot be nullable.

Array literals are also supported. For example, the `SELECT` statement shown below is valid.

```sql
SELECT [1,2,3,4]
```

This topic uses the table presented in [Working with semi-structured data](working-with-semi-structured-data.md) and assumes its name is `visits`. The relevant columns are shown below for convenience.

| id INT | tags ARRAY\(TEXT\) | agent\_props\_keys | agent\_props\_vals |
| :--- | :--- | :--- | :--- |
| 1 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |

## Basic Functionality

There are several self-explanatory functions to work with arrays including [LENGTH,](../sql-reference/functions-reference/length.md), [ARRAY\_CONCAT](../sql-reference/functions-reference/array-concat.md), and [FLATTEN](../sql-reference/functions-reference/flatten.md). See the respective reference for a full description. Here's a short example:

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

## Manipulating arrays with Lambda functions

Much of the power in Firebolt's array manipulation functionality comes from incorporating Lambda functions. These are expressions passed to functions applied to arrays and in turn, are being applied element by element. The results of the Lambda function interpreted according to the array function in use.

The general form of array functions taking a Lambda as an argument is `ARRAY_FUNC(<lambda-expression>, arr[, arr1, arr2...])`, where the lambda expression is in the form `a1[, a2, a3...] -> <lambda-body>` , and `arr`, `arr1`, `arr2`... are expressions evaluating to arrays. The variables a1, a2, ... are called the lambda arguments. The number of the lambda arguments must be equal to the number of arrays passed starting from the second argument of the array function. In addition, the lengths of all the arrays should be equal.

We'll start with a simple example using a single array argument.

```sql
SELECT TRANSFORM(t -> UPPER(t), tags) as up_tags
FROM visits
```

Here, the function [TRANSFORM](../sql-reference/functions-reference/transform.md) will apply the lambda body - that is convert the element to upper-case - on each of the array elements and will result in:

| up\_tags |
| :--- |
| \["SUMMER\_SALE", "SPORTS"\] |
| \["GADGETS", "AUDIO"\] |

A common use case where multiple array arguments are provided is used in the context of two arrays representing a map. The function [ARRAY\_FIRST ](../sql-reference/functions-reference/array-first.md)returns the first element for which the lambda expression returns a result other than 0. The return value will always be taken from the first array argument provided, however, the lambda expression can compute its result based on all of the lambda arguments corresponding to elements of the array arguments.

So if we want to find the value in `agent_props_vals` corresponding to the key `"platform"` in `agent_props_keys` the following query:

```sql
SELECT ARRAY_FIRST(v, k -> k = 'platform', agent_props_vals, agent_props_keys)
as platform
FROM visits
```

Returns the desired results:

| platform |
| :--- |
| "Windows NT 6.1" |
| "iOS 14" |

## UNNEST

Sometimes it is desirable to transform the nested array structure to a standard tabular format. This can be used to expose views to BI tools that cannot handle Firebolt array syntax, or the tabular format is more natural to query using standard SQL idioms. `UNNEST` serves these purposes.

`UNNEST` is part of the [FROM](../sql-reference/commands/select.md#from) clause and it resembles a `JOIN` sub-clause. Given an array typed column, it unfolds the element of the array and duplicates all other columns found in the `SELECT` clause per each array element.

For example the following query:

```sql
SELECT id, tags
FROM visits
UNNEST(tags)
```

Will result in:

| id | tags |
| :--- | :--- |
| 1 | "summer-sale" |
| 1 | "sports" |
| 2 | "gadgets" |
| 2 | "audio" |
