---
layout: default
title: TO_FLOAT
description: Reference material for TO_FLOAT function
parent: SQL functions
---

# TO\_FLOAT

Converts a string to a numeric `REAL` data type.

## Syntax
{: .no_toc}

```sql
TO_FLOAT(<expression>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expression>`  | A numeric data type or numeric characters that resolve to a `TEXT` data type. |

## Example
{: .no_toc}

```sql
SELECT
	TO_FLOAT('10.5');
```

**Returns**: `10.5`
