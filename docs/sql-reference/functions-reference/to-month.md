---
layout: default
title: TO_MONTH
description: Reference material for TO_MONTH function
parent: SQL functions
---

# TO\_MONTH

Converts a date or timestamp (any date format we support) to a number containing the month.

## Syntax
{: .no_toc}

```sql
TO_MONTH(<date>)
```

| Parameter | Description                                                         |
| :--------- | :------------------------------------------------------------------- |
| `<date>`  | The date or timestamp to be converted into the number of the month. |

**Example**

For Tuesday, April 22, 1975:

```sql
SELECT
	TO_MONTH(CAST('1975/04/22' AS DATE)) AS res;
```

**Returns**: `4`
