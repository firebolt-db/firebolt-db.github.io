---
layout: default
title: HLL_COUNT_BUILD
description: Reference material for HLL_COUNT_BUILD
parent: SQL functions
---


# HLL_COUNT_BUILD

Counts the approximate number of unique or not NULL values, aggregating the values to HLL++ sketches represented as the [BYTEA data type](../general-reference/bytea-data-type.md).
Later these sketches can be merged to a single sketch using the aggregate function [`HLL_COUNT_MERGE_PARTIAL`](hll-count-merge-partial.md), or the estimated cardinality extracted (to get the final estimated distinct count value) using the [`HLL_COUNT_EXTRACT`](hll-count-extract.md) scalar function.
`HLL_COUNT_BUILD` uses the HLL++ algorithm and allows you to control the set sketch size precision, similar to [`HLL_COUNT_DISTINCT`](hll-count-distinct.md). 


`HLL_COUNT_BUILD` requires less memory than exact aggregation functions, but also introduces statistical uncertainty. The default precision is 12, with a maximum of 20 set optionally.

{: .note}
>Higher precision comes at a memory and performance cost.

## Syntax
{: .no_toc}

```sql
HLL_COUNT_BUILD ( <expression> [, <precision> ] )
```

## Parameters
{: .no_toc}

| Parameter | Description | Supported input types |
| :--------- |:------------|:-|
| `<expression>`  | Any column name or function that return a column name. | Any type |
| `<precision>` | Optional literal integer value to set precision. If not included, the default precision is 12. Precision range: 12-20. | `INTEGER`, `BIGINT ` |

## Return Type
`BYTEA`

If the input is NULL, this function returns NULL.

## Example
{: .no_toc}

```sql
SELECT
    HLL_COUNT_BUILD(name, 12) as hll_sketch
FROM
    levels;
```

**Returns**: 

An HLL++ sketch represented as data type `BYTEA`.

| hll_sketch                                                                                                |
|: ---------------------------------------------------------------------------------------------------------|
|\x3041676772656761746546756e6374696f6e28312c20756e6971436f6d62696e65643634283132292c20537472696e6729000100 |