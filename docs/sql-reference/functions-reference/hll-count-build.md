---
layout: default
title: HLL_COUNT_BUILD
description: Reference material for HLL_COUNT_BUILD
parent: SQL functions
---


# HLL_COUNT_BUILD

An aggregate function similar to [`HLL_COUNT_DISTINCT`](hll-count-distinct.md) it counts the approximate number of unique or not NULL values,
to the precision specified.
`HLL_COUNT_BUILD` uses the HLL algorithm and allows you to control the sketch size set precision.
But it aggregates the values to HLL sketches represented as the [BYTEA datatype](../general-reference/bytea-data-type.md).
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

| Parameter | Description                                                                                                            |
| :--------- |:-----------------------------------------------------------------------------------------------------------------------|
| `<expr>`  | Valid values for the expression include column names or functions that return a column name.                           |
| `<precision>` | Optional literal integer value to set precision. If not included, the default precision is 12. Precision range: 12-20. |


## Example
{: .no_toc}

```sql
SELECT
    HLL_COUNT_BUILD(col_a, 12) as hll12_count
FROM
	count_table;
```

**Returns**: 

Assuming 8,388,608 unique pk values, we will see results like: 


```sql
' +----------------+--------------+-------------+-------------+
' | count_distinct | approx_count | hll12_count | hll20_count |
' +----------------+--------------+-------------+-------------+
' |      8,388,608 |    8,427,387 |   8,667,274 |   8,377,014 |
' +----------------+--------------+-------------+-------------+
```

where approx_count is using precision 17, hll12_count is using precision 12, and hll20_count is using precision 20, the most precise. 