---
layout: default
title: HLL_COUNT_EXTRACT
description: Reference material for HLL_COUNT_EXTRACT
parent: SQL functions
---


# HLL_COUNT_EXTRACT

A scalar function that extracts a cardinality estimate of a single HLL++ sketch.

If sketch is NULL, this function returns a cardinality estimate of 0.

## Syntax
{: .no_toc}

```sql
HLL_COUNT_EXTRACT ( <expr> )
```

## Parameters
{: .no_toc}

| Parameter | Description                                                                                                                | Supported input types |
| :--------- |:---------------------------------------------------------------------------------------------------------------------------|:----------------------|
| `<expr>`  | HLL++ sketch should be in a valid format. for example the output of the [`HLL_COUNT_BUILD`](hll-count-build.md) function. | `BYTEA`                |

## Return Type
`LONG`

## Example
{: .no_toc}

```sql
SELECT
    HLL_COUNT_EXTRACT(hll_sketches) as count_distinct, hll_sketches
FROM
    sketch_table;
```

**Returns**: 

HLL++ sketch represented as `BYTEA`.
```sql
' +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' | hll_sketches | count_distinct                                                                                                                                                                                             |
' +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' | 5            | '\x2f41676772656761746546756e6374696f6e28312c20756e6971436f6d62696e65643634283132292c20496e743332290a01052ccbc234fcbc56b4e7830665202abf3aced8f809c581510b7518f0a86804904775554cd537d76ad6'                 |
' +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' | 6            | '\x2f41676772656761746546756e6374696f6e28312c20756e6971436f6d62696e65643634283132292c20496e743332290c01062ccbc234fcbc56b4e7830665202abf3aced8f809c581510bddd168e4cb29077487c6a393a5ccab46d5f1f4f71f9a2091' |
' +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```