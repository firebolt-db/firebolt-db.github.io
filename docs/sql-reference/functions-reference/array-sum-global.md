---
layout: default
title: ARRAY_SUM_GLOBAL
description: Reference material for ARRAY_SUM_GLOBAL function
parent: SQL functions
---

# ARRAY\_SUM\_GLOBAL

Returns the sum of elements in the array column accumulated over the rows in each group.

For more information and the sample data used in the example below, please refer to [Aggregate Array Functions](./aggregate-array-functions.md).

## Syntax
{: .no_toc}

The example below uses the following table `T`:

| Category | vals        |
| :-------- | :----------- |
| a        | \[1,3,4]    |
| b        | \[3,5,6,7]  |
| c        | \[30,50,60] |

```sql
ARRAY_SUM_GLOBAL(<arr>)
```

| Parameter | Description                                                    |
| :--------- | :-------------------------------------------------------------- |
| `<arr>`   | The array column over which the function will sum the elements |

## Example
{: .no_toc}

```sql
SELECT
	Category,
	ARRAY_SUM_GLOBAL(vals) AS sm
FROM
	T
GROUP BY
	Category;
```

**Returns**:

| category | sm  |
| :-------- | :--- |
| a        | 8   |
| b        | 21  |
| c        | 140 |
