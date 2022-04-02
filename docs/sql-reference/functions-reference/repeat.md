---
layout: default
title: REPEAT
description: Reference material for REPEAT function
parent: SQL functions
---

# REPEAT

This function repeats the provided string a requested number of times.

## Syntax
{: .no_toc}

```sql
REPEAT(<string>, <repeating_number>)
```

| Parameter            | Description                                                                                                    |
| :-------------------- | :-------------------------------------------------------------------------------------------------------------- |
| `<string>`           | The string to be repeated.                                                                                     |
| `<repeating_number>` | The number of needed repetitions. The minimum valid repeating number is `0`, which results in an empty string. |

## Example
{: .no_toc}

```sql
SELECT
	REPEAT('repeat 3 times ' , 3);
```

**Returns**: `repeat 3 times repeat 3 times repeat 3 times`
