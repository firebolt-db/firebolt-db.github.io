---
layout: default
title: TO_YEAR
description: Reference material for TO_YEAR function
parent: SQL functions
---

# TO\_YEAR

Converts a date or timestamp (any date format we support) to a number containing the year.

## Syntax
{: .no_toc}

```sql
TO_YEAR(<date>)
```

| Parameter | Description                                                        |
| :--------- | :------------------------------------------------------------------ |
| `<date>`  | The date or timestamp to be converted into the number of the year. |

## Example
{: .no_toc}

For Tuesday, April 22, 1975:

```sql
SELECT
	TO_YEAR(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `1975`
