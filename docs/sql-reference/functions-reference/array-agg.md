---
layout: default
title: ARRAY_AGG
description: Reference material for ARRAY_AGG function
parent: SQL functions
---

# ARRAY_AGG

Concatenates input values into an array.


## Syntax
{: .no_toc}

```sql
ARRAY_AGG(<expr>)
```

| Parameter | Description                                         |
| :--------- | :--------------------------------------------------- |
| `<expr>`   | Expression of any type to be converted to an array. |

## Example
{: .no_toc}

Assume we have the following `price_list` table:

| item   | price |
| :------ | :----- |
| apple  | 4     |
| orange | 11    |
| kiwi   | 20    |

Running the following query:

```sql
SELECT
  ARRAY_AGG(item) AS items,
  ARRAY_AGG(price) AS prices
FROM
	price_list;
```

**Returns**: `['apple', 'orange', 'kiwi'], [4,11,20]`
