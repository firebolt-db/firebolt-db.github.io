---
layout: default
title: MIN_BY
description: Reference material for MIN_BY
parent: SQL functions
---


# MIN\_BY

The `MIN_BY` function returns the value of `arg` column at the row in which the `val` column is minimal.

If there is more than one minimal values in `val`, then the first will be used.

## Syntax
{: .no_toc}

```sql
MIN_BY(arg, val)
```

| Parameter | Description                                    |
| :--------- | :---------------------------------------------- |
| `<arg>`   | The column from which the value is returned.   |
| `<val>`   | The column that is search for a minimum value. |

## Example
{: .no_toc}

For this example, we will again use the `prices` table that was created above for the `MIN` function. The values for that table are below:&#x20;

| item   | price |
| :------ | :----- |
| apple  | 4     |
| banana | 25    |
| orange | 11    |
| kiwi   | 20    |

In this example below, `MIN_BY` is used to find the item with the lowest price.

```sql
SELECT
	MIN_BY(item, price)
FROM
	prices
```

**Returns:** `apple`
