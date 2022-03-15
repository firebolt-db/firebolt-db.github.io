---
layout: default
title: SUM (aggregation function)
description: Reference material for SUM
parent: SQL functions
---


## SUM

Calculates the sum of an expression.

##### Syntax
{: .no_toc}

```sql
​​SUM(<expr>)​​
```

| Parameter | Description                                                                                                                              |
| :--------- | :---------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`  | The expression used to calculate the sum. Valid values for `<expr>` include column names or expressions that evaluate to numeric values. |

**Example**

For this example, we'll create a new table `num_test `as shown below:

```
CREATE DIMENSION TABLE IF NOT EXISTS num_test (num INT);


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

`SUM` adds together all of the values in the `num` column.

```
SELECT
	SUM(num)
FROM
	numb_test
```

**Returns**: `285`
