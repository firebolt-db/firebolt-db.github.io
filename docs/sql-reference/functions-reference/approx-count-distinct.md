---
layout: default
title: APPROX_COUNT_DISTINCT
description: Reference material for APPROX_COUNT_DISTINCT
parent: SQL functions
---


# APPROX_COUNT_DISTINCT

Counts the approximate number of unique or not NULL values. `APPROX_COUNT_DISTINCT` uses the HLL algorithm with the default parameter to control the sketch size set to 17. This is subject to change. 

## Syntax
{: .no_toc}

```sql
APPROX_COUNT_DISTINCT ( <expr> )
```

| Parameter | Description                                                                                                                                                                                                           |
| :--------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Valid values for the expression include column names or functions that return a column name. |

{: .note}
> By default, `APPROX_COUNT_DISTINCT` and `COUNT(DISTINCT)` return the same, approximate results. If you require a precise result for `COUNT(DISTINCT)` (with a performance penalty), please contact Firebolt Support through the Help menu support form. 

## Example
{: .no_toc}

To understand the difference between `COUNT(DISTINCT pk)` with exact precision enabled, `APPROX_COUNT_DISTNCT(pk)`, and `HLL_COUNT_DISTINCT(pk, <precision>)`, consider a table, `count_test` with 8,388,608 unique `pk` values. 

```sql
SELECT
	COUNT(DISTINCT pk) as count_distinct,
	APPROX_COUNT_DISTINCT(pk) as approx_count
	HLL_COUNT_DISTINCT(pk, 12) as hll12_count,
	HLL_COUNT_DISTINCT(pk, 20) as hll20_count
FROM
	count_test;
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