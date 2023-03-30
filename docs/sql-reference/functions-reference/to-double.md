---
layout: default
title: TO_DOUBLE
description: Reference material for TO_DOUBLE function
parent: SQL functions
---

# TO\_DOUBLE

Converts a string to a numeric `DOUBLE PRECISION` data type.

## Syntax
{: .no_toc}

```sql
TO_DOUBLE(<expression>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expression>`  | A numeric data type or numeric characters that resolve to a `TEXT` data type. |

## Example
{: .no_toc}

```sql
SELECT
	TO_DOUBLE('100');
```

**Returns**: `100`
