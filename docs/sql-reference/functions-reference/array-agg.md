---
layout: default
title: ARRAY_AGG
description: Reference material for ARRAY_AGG function
parent:  SQL functions
---

# ARRAY_AGG

Concatenates input values into an array.


## Syntax
{: .no_toc}

```sql
ARRAY_AGG(<expression>)
```

## Parameters 
{: .no_toc}

| Parameter | Description                                         | Supported input type |
| :--------- | :--------------------------------------------------|:-----|
| `<expression>`   | Expression of any type to be converted to an array. | Any |

## Return Type
{: .no_toc}

`ARRAY` of the same type as the input data

## Example
{: .no_toc}

For the following example, see the `player_information` table:

| nickname   | playerid |
| :------ | :----- |
| stephen70  | 1    |
| burchdenise | 7   |
| sabrina21   | 23    |

This example code selects the columns in the `player_information` table and returns the values in two arrays, `nicknames` and `playerids`. 

```sql
SELECT
  ARRAY_AGG(nickname) AS nicknames,
  ARRAY_AGG(playerid) AS playerids
FROM
	price_list;
```

**Returns**: `['stephen70', 'burchdenise', 'sabrina21'], [1, 7, 23]`
