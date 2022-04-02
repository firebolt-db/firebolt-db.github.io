---
layout: default
title: TO_INT
description: Reference material for TO_INT function
parent: SQL functions
---

# TO\_INT

Converts a string to a numeric `INT` data type.

## Syntax
{: .no_toc}

```sql
TO_INT(<exp>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

## Example
{: .no_toc}

```sql
SELECT
	TO_INT('10');
```

**Returns**: `10`
