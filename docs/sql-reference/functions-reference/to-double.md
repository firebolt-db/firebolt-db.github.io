---
layout: default
title: TO_DOUBLE
description: Reference material for TO_DOUBLE function
parent: SQL functions
---

# TO\_DOUBLE

Converts a string to a numeric `DOUBLE` data type.

## Syntax
{: .no_toc}

```sql
TO_DOUBLE(<exp>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

## Example
{: .no_toc}

```sql
SELECT
	TO_DOUBLE('100');
```

**Returns**: `100`
