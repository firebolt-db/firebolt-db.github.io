---
layout: default
title: MEDIAN
description: Reference material for MEDIAN
parent: SQL functions
---


# MEDIAN

Calculates an approximate median for a given column.

## Syntax
{: .no_toc}

```sql
MEDIAN(<col>)
```

| Parameter | Description                                                                                                        |
| :--------- | :------------------------------------------------------------------------------------------------------------------ |
| `<col>`   | The column used to calculate the median value. This column can consist of numeric data types or DATE and TIMESTAMP. |

## Example
{: .no_toc}

For this example, we'll create a new table `num_test `as shown below:

```sql
CREATE DIMENSION TABLE IF NOT EXISTS num_test
	(
		num INT
	);

INSERT INTO
	num_test
VALUES
	(1),
	(7),
	(12),
	(30),
	(59),
	(76),
	(100);
```

`MEDIAN` returns the approximate middle value between the lower and higher halves of the values.

```sql
SELECT
	MEDIAN(num)
FROM
	number_test
```

**Returns**: `30`
