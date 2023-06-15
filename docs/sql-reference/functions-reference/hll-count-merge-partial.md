---
layout: default
title: HLL_COUNT_MERGE_PARTIAL
description: Reference material for HLL_COUNT_MERGE_PARTIAL
parent: SQL functions
---


# HLL_COUNT_MERGE_PARTIAL

Takes one or more HLL++ sketch inputs and merges them into a new sketch.

Each sketch must be initialized on the same type and the same precision.
Attempts to merge sketches for different types or precision results in an error.
For example, you cannot merge a sketch initialized from `INTEGER` data with one initialized from `TEXT` data,
or a sketch initialized with 13 precision and a sketch initialized with 14 precision.

If the input expression is NULL or empty, this function returns NULL.

## Syntax
{: .no_toc}

```sql
HLL_COUNT_MERGE_PARTIAL ( <expression> )
```

## Parameters
{: .no_toc}

| Parameter | Description                                                                                                               | Supported input types |
| :--------- |:--------------------------------------------------------------------------------------------------------------------------|:----------------------|
| `<expression>`  | HLL++ sketch should be in a valid format. for example the output of the [`HLL_COUNT_BUILD`](hll-count-build.md) function. | `BYTEA`                |

## Return Type
`BYTEA`

## Example
{: .no_toc}

```sql
SELECT
    HLL_COUNT_MERGE_PARTIAL(hll_sketches) as merged_sketches
FROM
    sketch_table;
```

**Returns**: 

A merged HLL++ sketch represented in data type `BYTEA`.
```sql
' +--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' |   merged_sketches                                                                                                                                                                               |
' +--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
' | '\x2f41676772656761746546756e6374696f6e28312c20756e6971436f6d62696e65643634283132292c20496e743332290a01052ccbc234fcbc56b4e7830665202abf3aced8f809c581510b7518f0a86804904775554cd537d76ad6' |
' +--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```