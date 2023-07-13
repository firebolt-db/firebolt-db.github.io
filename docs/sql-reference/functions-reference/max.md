---
layout: default
title: MAX (aggregation function)
description: Reference material for MAX
parent: SQL functions
---


# MAX

Calculates the maximum value of an expression across all input values.

## Syntax
{: .no_toc}

```sql
MAX(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>`  | The expression used to calculate the maximum value | Any string, numeric or date/timestamp type |

Valid values for the expression include a column name or functions that return a column name.

## Return Types

Same as input type

## Example
{: .no_toc}
For this example, see the following table, `tournaments`:

| name                          | totalprizedollars |
| :-----------------------------| :-----------------| 
| The Drifting Thunderdome      | 24,768             |
| The Lost Track Showdown       | 5,336              |
| The Acceleration Championship | 19,274             |
| The Winter Wilderness Rally   | 21,560             |
| The Circuit Championship      | 9,739              |

When used on the `totalprizedollars` column, `MAX` will return the highest value.

```sql
SELECT
	MAX(totalprizedollars) as maxprize
FROM
	tournaments;
```

**Returns**: `24,768`

`MAX` can also work on text columns by returning the text row with the characters that are last in the lexicographic order. In this example, the function assesses the `name` column in the `tournaments` table.

```sql
SELECT
	MAX(name) as maxtournament
FROM
	tournaments;
```

**Returns**: `The Winter Wilderness Rally`