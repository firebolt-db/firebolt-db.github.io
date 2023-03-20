---
layout: default
title: MIN (aggregation function)
description: Reference material for MIN
parent: SQL functions
---


# MIN

Calculates the minimum value of an expression across all input values.

## Syntax
{: .no_toc}

```sql
MIN(<expression>)
```

| Parameter | Description                                                                                                                                        |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expression>`  | The expression used to calculate the minimum values. Valid values for the expression include a column name or functions that return a column name. |

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
	('kiwi', 20);
```

When used on the `num` column, `MIN` will return the largest value.

```sql
SELECT
	MIN(price)
FROM
	prices;
```

**Returns**: `4`

`MIN` can also work on text columns by returning the text row with the characters that are first in the lexicographic order.

```sql
SELECT
	MIN(item)
FROM
	prices;
```

**Returns**: `apple`
