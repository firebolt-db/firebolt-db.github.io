---
layout: default
title: HLL_COUNT_BUILD
description: Reference material for HLL_COUNT_BUILD
parent: SQL functions
---


# HLL_COUNT_BUILD

An aggregate function similar to [`HLL_COUNT_DISTINCT`](hll-count-distinct.md) it counts the approximate number of unique or not NULL values,
to the precision specified.
`HLL_COUNT_BUILD` uses the HLL++ algorithm and allows you to control the sketch size set precision.
But it aggregates the values to HLL++ sketches represented as the [BYTEA datatype](../general-reference/bytea-data-type.md).
Later these sketches can be merged to single sketch using the aggregate function [`HLL_COUNT_MERGE_PARTIAL`](hll-count-merge-partial.md)
or they can be exteracted the estimated cardinality (final estimated count distinct value) 
using the [`HLL_COUNT_EXTRACT`](hll-count-extract.md) scalar function.

`HLL_COUNT_BUILD` requires less memory than exact aggregation functions, but also introduces statistical uncertainty. The default precision is 12, with a maximum of 20.

If the input is NULL, this function returns NULL.

{: .note}
>Higher precision comes at a memory and performance cost.

## Syntax
{: .no_toc}

```sql
HLL_COUNT_BUILD ( <expr> [, <precision> ] )
```

## Parameters
{: .no_toc}

| Parameter | Description | Supported input types |
| :--------- |:------------|:-|
| `<expr>`  | Valid values for the expression include column names or functions that return a column name. | Any type |
| `<precision>` | Optional literal integer value to set precision. If not included, the default precision is 12. Precision range: 12-20. | Int, Long |

## Return Type
`BYTEA`

## Example
{: .no_toc}

```sql
SELECT
    HLL_COUNT_BUILD(col_a, 12) as hll_sketch
FROM
    count_table;
```

**Returns**: 

HLL++ sketch represented as `BYTEA`.
```sql
' +--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' |   hll_sketch                                                                                                                                                                               |
' +--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' | '\x2f41676772656761746546756e6374696f6e28312c20756e6971436f6d62696e65643634283132292c20496e743332290a01052ccbc234fcbc56b4e7830665202abf3aced8f809c581510b7518f0a86804904775554cd537d76ad6' |
' +--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```