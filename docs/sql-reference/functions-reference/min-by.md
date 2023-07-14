---
layout: default
title: MIN_BY
description: Reference material for MIN_BY
grand_parent: SQL functions
parent: Aggregation functions
---


# MIN\_BY

The `MIN_BY` function returns the value of the specified `<expression>` column at the row with the minimum value in the specified `<value>` column.

If there is more than one of the same minimum value in `<value>`, then the first occurring will be returned.

## Syntax
{: .no_toc}

```sql
MIN_BY(<expression>, <value>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>` | The column from which the value is returned | Any type |
| `<value>` | The column that is search for a minimum value | Any string, numeric or date/timestamp type |

## Return Types

Same as input type of <expression>

## Example
{: .no_toc}

For this example, see the following table, `tournaments`:

| name                          | totalprizedollars |
| :-----------------------------| :-----------------| 
| The Drift Championship        | 22,048            |
| The Lost Track Showdown       | 5,336             |
| The Acceleration Championship | 19,274            |
| The French Grand Prix         | 237               |
| The Circuit Championship      | 9,739             |


In the example below, `MIN_BY` is used to find the tournament with the lowest total prize.

```sql
SELECT
	MIN_BY(name, totalprizedollars) as minprizetournament
FROM
	tournaments
```

**Returns:** `The French Grand Prix`
