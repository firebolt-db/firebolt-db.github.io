---
layout: default
title: MAX (aggregation function)
description: Reference material for MAX
parent: SQL functions
---


# MAX

Calculates the maximum value of an expression across all input values.

## Syntax
{: .no_toc}

```sql
MAX(<expression>)
```

| Parameter | Description                                                                                                                                        |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expression>`  | The expression used to calculate the maximum values. Valid values for the expression include a column name or functions that return a column name. |

## Example
{: .no_toc}

For this example, we'll create a new table `prices` as shown below.

```sql
CREATE DIMENSION TABLE IF NOT EXISTS prices
    (
        item TEXT,
        price INTEGER
    );

INSERT INTO
	prices
VALUES
	('apple', 4),
	('banana', 25),
	('orange', 11),
	('kiwi', 20)
```

When used on the num column, `MAX` will return the largest value.

```sql
SELECT
	MAX(price)
FROM
	prices;
```

**Returns**: `25`

MAX can also work on text columns by returning the text row with the characters that are last in the lexicographic order.&#x20;

```
SELECT
	MAX(item)
FROM
	prices;
```

**Returns:** `orange`
