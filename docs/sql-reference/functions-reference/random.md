---
layout: default
title: RANDOM
description: Reference material for RANDOM function
parent: SQL functions
---

# RANDOM

Returns a pseudo-random unsigned value greater than 0 and less than 1 of type `DOUBLE`.

## Syntax
{: .no_toc}

```sql
RANDOM()
```

## Example
{: .no_toc}

The example below demonstrates using `RANDOM` without any other numeric functions. This generates a `DOUBLE` value less than 1.

```sql
SELECT RANDOM()
```

**Returns:** `0.8544004706537051`

### Example&ndash;using RANDOM for range of values 

To create a random integer number between two values, you can use `RANDOM` with the `FLOOR` function as demonstrated below. `a` is the lesser value and `b` is the greater value.

```sql
SELECT
	FLOOR(RANDOM() * (b - a + 1)) + a;
```

For example, the formula below generates a random integer between 50 and 100:&#x20;

```sql
SELECT
	FLOOR(RANDOM() * (100 - 50 + 1)) + 50;
```

**Returns**: `61`
