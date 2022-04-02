---
layout: default
title: APPROX_PERCENTILE
description: Reference material for APPROX_PERCENTILE
parent: SQL functions
---

# APPROX\_PERCENTILE

Returns an approximate value for the specified percentile based on the range of numbers returned by the expression.&#x20;

For example, if you run `APPROX_PERCENTILE` with a specified `<percent>` of .75 on a column with 2,000 numbers, and the function returned `655`, then this would indicate that 75% of the 2,000 numbers in the column are less than 655.&#x20;

The number returned is not necessarily in the original range of numbers.

## Syntax
{: .no_toc}

```sql
APPROX_PERCENTILE(<expr>,<percent>)
```

| Parameter   | Description                                                                                                               |
| :----------- | :------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`    | A valid expression, such as a column name, that evaluates to numeric values.                                              |
| `<percent>` | A constant real number greater than or equal to 0.0 and less than 1. For example, `.999` specifies the 99.9th percentile. |

## Example
{: .no_toc}

To demonstrate `APPROX_PERCENTILE`, we'll use the example table `number_test` as created below. This provides a range of numbers between 1 and 100.

```sql
CREATE DIMENSION TABLE IF NOT EXISTS number_test
	(
		First_name TEXT
	);

INSERT INTO
	number_test
VALUES
	(1),
	(100),
	(55),
	(16),
	(48),
	(86),
	(33),
	(22);
```

The example below shows `APPROX_PERCENTILE` of 50% of the number range in `number_test`.&#x20;

```sql
SELECT
	APPROX_PERCENTILE(num, 0.5)
FROM
	number_test;
```

**Returns**: `40.5`

The example below shows an `APPROX_PERCENTILE` of 25%.&#x20;

```sql
SELECT
	APPROX_PERCENTILE(num, 0.25)
FROM
	number_test;
```

**Returns**: `20.5`
