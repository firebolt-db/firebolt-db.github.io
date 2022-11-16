---
layout: default
title: ARRAY_MAX_GLOBAL
description: Reference material for ARRAY_MAX_GLOBAL function
parent: SQL functions
---

# ARRAY\_MAX\_GLOBAL

Returns the maximum element from all the array elements in each group.

For more information and the sample data used in the example below, please refer to [Aggregate Array Functions](./aggregate-array-functions.md).

## Syntax
{: .no_toc}

```sql
ARRAY_MAX_GLOBAL(<arr>) AS cnt
```

| Parameter | Description                                                               |
| :--------- | :------------------------------------------------------------------------- |
| `<arr>`   | The array column over from which the function returns the maximum element |

## Example
{: .no_toc}

The example below uses the following table `T`:

| Category | vals        |
| :-------- | :----------- |
| a        | \[1,3,4]    |
| b        | \[3,5,6,7]  |
| c        | \[30,50,60] |


```sql
SELECT
	Category,
	ARRAY_MAX_GLOBAL(vals) AS mx
FROM
	T
GROUP BY
	Category;
```

**Returns**:

| category | mx |
| :-------- | :-- |
| a        | 4  |
| b        | 7  |
| c        | 60 |
