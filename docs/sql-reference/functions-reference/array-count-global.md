---
layout: default
title: ARRAY_COUNT_GLOBAL
description: Reference material for ARRAY_COUNT_GLOBAL function
parent: SQL functions
---

# ARRAY\_COUNT\_GLOBAL

Returns the number of elements in the array typed column accumulated over all rows. As such it is an _aggregation function._

## Syntax
{: .no_toc}

```sql
ARRAY_COUNT_GLOBAL(<array>)
```

| Parameter   | Description                                                      |
| :----------- | :---------------------------------------------------------------- |
| `<array>` | The array column over which the function will count the elements. |

## Example
{: .no_toc}

For this example, we will create a table `array_test` as shown below.

```sql
CREATE DIMENSION TABLE array_test(array_1 ARRAY(INTEGER));

INSERT INTO
	array_test
VALUES
	([ 1, 2, 3, 4 ]),
	([ 5, 0, 20 ]),
	([ 6, 2, 6 ]),
	([ 9, 10, 13 ]),
	([ 20, 13, 40 ]),
	([ 1 ]);
```

We can use `ARRAY_COUNT_GLOBAL` to learn how many total array elements are in all rows.

```sql
SELECT
	ARRAY_COUNT_GLOBAL(array_1)
FROM
	array_test;
```

**Returns**: `17`

If you want to count elements based on specific criteria, you can use the [`ARRAY_COUNT`](./array-count.md) function with a `SUM` aggregation as demonstrated below.

```sql
SELECT
	SUM(ARRAY_COUNT(x -> x > 3, array_1))
FROM
	array_test;
```

**Returns**: `11`
