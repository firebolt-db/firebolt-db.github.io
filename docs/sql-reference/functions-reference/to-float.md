---
layout: default
title: TO_FLOAT
description: Reference material for TO_FLOAT function
parent: SQL functions
---

# TO\_FLOAT

Converts a string to a numeric `FLOAT` data type.

## Syntax
{: .no_toc}

```sql
TO_FLOAT(<expr>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

## Example
{: .no_toc}

```sql
SELECT
	TO_FLOAT('10.5');
```

**Returns**: `10.5`
