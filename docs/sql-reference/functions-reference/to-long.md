---
layout: default
title: TO_LONG
description: Reference material for TO_LONG function
parent: SQL functions
---

## TO\_LONG

Converts a string to a numeric `LONG` data type.

##### Syntax
{: .no_toc}

```sql
TO_LONG(<exp>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

##### Example
{: .no_toc}

```sql
SELECT
	TO_LONG('1234567890');
```

**Returns**: `1234567890`
