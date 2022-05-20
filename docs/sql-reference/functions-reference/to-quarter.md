---
layout: default
title: TO_QUARTER
description: Reference material for TO_QUARTER function
parent: SQL functions
---

# TO\_QUARTER

Converts a date or timestamp (any date format we support) to a number containing the quarter.

## Syntax
{: .no_toc}

```sql
TO_QUARTER(<date>)
```

| Parameter | Description                                                           |
| :--------- | :--------------------------------------------------------------------- |
| `<date>`  | The date or timestamp to be converted into the number of the quarter. |

## Example
{: .no_toc}

For Tuesday, April 22, 1975:

```sql
SELECT
	TO_QUARTER(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `2`
