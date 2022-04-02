---
layout: default
title: ARRAY_MIN_GLOBAL
description: Reference material for ARRAY_MIN_GLOBAL function
parent: SQL functions
---

# ARRAY\_MIN\_GLOBAL

Returns the minimal element taken from all the array elements in each group.

For more information and the sample data used in the example below, please refer to [Aggregate Array Functions](./aggregate-array-functions.md).

## Syntax
{: .no_toc}

The example below uses the following table `T`:

| Category | vals        |
| :-------- | :----------- |
| a        | \[1,3,4]    |
| b        | \[3,5,6,7]  |
| a        | \[30,50,60] |

```sql
ARRAY_MIN_GLOBAL(<arr>)
```

| Parameter | Description                                                              |
| :--------- | :------------------------------------------------------------------------ |
| `<arr>`   | The array column from which the function will return the minimal element |

## Example
{: .no_toc}

```sql
SELECT
	Category,
	ARRAY_MIN_GLOBAL(vals) AS mn
FROM
	T
GROUP BY
	Category;
```

**Returns**:

| category | sm |
| :-------- | :-- |
| a        | 1  |
| b        | 3  |
| c        | 30 |
