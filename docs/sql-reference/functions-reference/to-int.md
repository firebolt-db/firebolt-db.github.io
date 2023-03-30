---
layout: default
title: TO_INT
description: Reference material for TO_INT function
parent: SQL functions
---

# TO\_INT

Converts a string to a numeric `INTEGER` data type.

## Syntax
{: .no_toc}

```sql
TO_INT(<expression>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expression>`  | A numeric data type expression that resolves to a `TEXT` data type. |

## Example
{: .no_toc}

```sql
SELECT
	TO_INT('10');
```

**Returns**: `10`
