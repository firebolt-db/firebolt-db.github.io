---
layout: default
title: MAX_BY
description: Reference material for MAX_BY
parent: SQL functions
---


# MAX\_BY

The `MAX_BY` function returns the value of the specified `<expression>` column at the row with the maximum value in the specified `<value>` column.

If there is more than one of the same maximum value in `<value>`, then the first occurring will be returned.

## Syntax
{: .no_toc}

```sql
MAX_BY(<expression>, <value>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>` | The column from which the value is returned | Any type |
| `<value>` | The column that is search for a maximum value | Any string, numeric or date/timestamp type |

## Return Types

Same as input type of `<expression>`

## Example
{: .no_toc}

For this example, see the following table, `tournaments`:

| name                          | totalprizedollars |
| :-----------------------------| :-----------------| 
| The Drifting Thunderdome      | 24,768            |
| The Lost Track Showdown       | 5,336             |
| The Acceleration Championship | 19,274            |
| The French Grand Prix         | 237               |
| The Circuit Championship      | 9,739             |


In the example below, `MAX_BY` is used to find the tournament with the highest total prize.

```sql
SELECT
	MAX_BY(name, totalprizedollars) as maxprizetournament
FROM
	tournaments;
```

**Returns:** `The Drifting Thunderdome`
