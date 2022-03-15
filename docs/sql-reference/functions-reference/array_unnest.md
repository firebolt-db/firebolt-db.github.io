---
layout: default
title: ARRAY_UNNEST
description: Reference material for ARRAY_UNNEST function
parent: SQL functions
---
## ARRAY\_UNNEST

This function "unfolds" a given array by creating a column result containing the individual members from the array's values.

##### Syntax
{: .no_toc}

```sql
ARRAY_UNNEST(<arr>)
```

| Parameter | Description               |
| :--------- | :------------------------- |
| `<arr>`   | The array to be unfolded. |

##### Example
{: .no_toc}

```sql
SELECT
	ARRAY_UNNEST([ 1, 2, 3, 4 ]) AS res;
```

**Returns**:

| res |
| :--- |
| 1   |
| 2   |
| 3   |
| 4   |
