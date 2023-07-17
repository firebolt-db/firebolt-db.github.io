---
layout: default
title: SUM (aggregation function)
description: Reference material for SUM
parent: SQL functions
---

# SUM

Calculates the sum of an expression.

## Syntax
{: .no_toc}

```sql
SUM ([DISTINCT] <value>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<value>`   | The expression used to calculate the sum. | Any numeric type | 

Valid values for `<value>` include column names or expressions that evaluate to numeric values. When `DISTINCT` is being used, only the unique number of rows with no `NULL` values are summed.

## Return Types
`NUMERIC` 

## Example

For this example, see the following table `tournaments`: 

| name                          | totalprizedollars |
| :-----------------------------| :-----------------| 
| The Drifting Thunderdome      | 24,768             |
| The Lost Track Showdown       | 5,336              |
| The Acceleration Championship | 19,274             |
| The Winter Wilderness Rally   | 21,560             |
| The Circuit Championship      | 9,739              |
| The Singapore Grand Prix      | 19,274             |


```
SELECT
	SUM(totalprizedollars)
FROM
	tournaments
```

**Returns**: `99,951`

```
SELECT
	SUM (DISTINCT totalprizedollars)
FROM
	tournaments
```

For this calculation, since both the Singapore Grand Prix and The Acceleration Championship have the same total prize of `19,274`, only one of these values in this sum in included. 

**Returns**: `80,677`
