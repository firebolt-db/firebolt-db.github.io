---
layout: default
title: TO_WEEK
description: Reference material for TO_WEEK function
parent: SQL functions
---

# TO\_WEEK

Converts a date or timestamp to a number representing the week. This function defines week 1 of a calendar year as the first full week of a calendar year starting on a Sunday.

## Syntax
{: .no_toc}

```sql
TO_WEEK(<date>)
```

| Parameter | Description                                                        |
| :--------- | :------------------------------------------------------------------ |
| `<date>`  | The date or timestamp to be converted into the number of the week. |

## Example
{: .no_toc}

For Sunday, Jan. 1,  2017:&#x20;

```sql
SELECT
    TO_WEEK(CAST('2017/01/01' AS DATE))
```

**Returns**: `1`

For Monday, Jan. 1, 2018:&#x20;

```
SELECT
    TO_WEEK(CAST('2018/01/01' AS DATE))
```

**Returns**: `0`
