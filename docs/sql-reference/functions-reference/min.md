---
layout: default
title: MIN (aggregation function)
description: Reference material for MIN
parent: SQL functions
---


# MIN

Calculates the minimum value of an expression across all input values.

## Syntax
{: .no_toc}

```sql
MIN(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>`  | The expression used to calculate the minimum value | Any string, numeric or date/timestamp type |

Valid values for the expression include a column name or functions that return a column name.

## Return Types

Same as input type

## Example
{: .no_toc}
For this example, see the following table, `tournaments`:

| name                          | totalprizedollars |
| :-----------------------------| :-----------------| 
| The Drift Championship        | 22,048             |
| The Lost Track Showdown       | 5,336              |
| The Acceleration Championship | 19,274             |
| The French Grand Prix         | 237               |
| The Circuit Championship      | 9,739              |

When used on the `totalprizedollars` column, `MIN` will return the smallest value.

```sql
SELECT
	MIN(totalprizedollars) as minprize
FROM
	tournaments;
```

**Returns**: `237`

`MIN` can also work on text columns by returning the text row with the characters that are first in the lexicographic order. In this example, the function assesses the `name` column in the `tournaments` table.

```sql
SELECT
	MIN(name) as mintournament
FROM
	tournaments;
```

**Returns**: `The Acceleration Championship`
