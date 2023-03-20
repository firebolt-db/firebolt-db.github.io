---
layout: default
title: STDDEV_SAMP
description: Reference material for STDDEV_SAMP
parent: SQL functions
---

# STDDEV\_SAMP

Computes the standard deviation of a sample consisting of a numeric expression.

## Syntax
{: .no_toc}

```sql
STDDEV_SAMP(<expression>)
```

| Parameter | Description                                                                                |
| :--------- | :------------------------------------------------------------------------------------------ |
| `<expression>`  | Any column with numeric values or an expression that returns a column with numeric values. |

## Example
{: .no_toc}

For this example, we'll create a new table `num_test `as shown below:

```
CREATE DIMENSION TABLE IF NOT EXISTS num_test (num INTEGER);


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


`STDDEV_SAMP` returns the standard deviation for the values.

```
SELECT
	STDDEV_SAMP(num)
FROM
	num_test
```

**Returns**: `38.18251906180054`
