---
layout: default
title: MAX_BY
description: Reference material for MAX_BY
parent: SQL functions
---


# MAX\_BY

The `MAX_BY` function returns a value for the `<arg>` column based on the max value in a separate column, specified by `<val>`.

If there is more than one max value in `<val>`, then the first will be used.

## Syntax
{: .no_toc}

```sql
MAX_BY(<arg>, <val>)
```

| Parameter | Description                                    |
| :--------- | :---------------------------------------------- |
| `<arg>`   | The column from which the value is returned.   |
| `<val>`   | The column that is search for a maximum value. |

## Example
{: .no_toc}

For this example, we will again use the `prices` table that was created above for the `MAX` function. The values for that table are below:

| item   | price |
| :------ | :----- |
| apple  | 4     |
| banana | 25    |
| orange | 11    |
| kiwi   | 20    |

In this example below, `MAX_BY` is used to find the item with the largest price.&#x20;

```sql
SELECT
	MAX_BY(item, price)
FROM
	prices;
```

**Returns**: `banana`
