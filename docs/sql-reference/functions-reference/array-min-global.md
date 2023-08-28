---
layout: default
title: ARRAY_MIN_GLOBAL
description: Reference material for ARRAY_MIN_GLOBAL function
parent:  SQL functions
---

# ARRAY\_MIN\_GLOBAL

Returns the minimum element taken from all the array elements in each group.

## Syntax
{: .no_toc}

```sql
ARRAY_MIN_GLOBAL(<array>)
```

## Parameters 
{: .no_toc}

| Parameter | Description                                                              | Supported input types |
| :--------- | :------------------------------------------------------------------------ |: ------------------|
| `<array>`   | The array column from which the function will return the minimum element. | Any `ARRAY` type  |

## Return Type
{: .no_toc}

Same as `ARRAY` element type

## Example
{: .no_toc}

The example below uses the following table `Scores`:

| nickname        | recent_scores |
| :---------------| :-------------|
| steven70        | \[1,3,4]      |
| sanderserin     | \[3,5,6,7]    |
| esimpson        | \[30,50,60]   |


In this example, the function calculates the minimum score earned by each player's recent scores. For example, the user `esimpson` received a minimum score of `30`, so this value is returned as `min_score`. 

```sql
SELECT
	nickname,
	ARRAY_MIN_GLOBAL(recent_scores) AS min_score
FROM
	Scores
GROUP BY
	nickname;
```

**Returns**:

| nickname         | min_score     |
| :----------------| :------------ |
| steven70         | 1             |
| sanderserin      | 3             |
| esimpson         | 30            |



