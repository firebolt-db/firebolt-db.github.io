---
layout: default
title: NEST
description: Reference material for NEST function
parent: SQL functions
---
## NEST

Takes a column as an argument, and returns an array of the values. In case the type of the column is nullable, the `NULL` values will be ignored.

##### Syntax
{: .no_toc}

```sql
​​NEST(<col>)​​
```

| Parameter | Description                                         |
| :--------- | :--------------------------------------------------- |
| `<col>`   | The name of the column to be converted to an array. |

##### Example
{: .no_toc}

Assume we have the following `prices` table:

| item   | price |
| :------ | :----- |
| apple  | 4     |
| banana | NULL  |
| orange | 11    |
| kiwi   | 20    |

Running the following query:

```sql
SELECT
	NEST(price) AS arr
FROM
	prices;
```

**Returns**: `[4,11,20]`
