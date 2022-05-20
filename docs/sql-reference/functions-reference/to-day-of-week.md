---
layout: default
title: TO_DAY_OF_WEEK
description: Referece material for TO_DAY_OF_WEEK function
parent: SQL functions
---

# TO\_DAY\_OF\_WEEK

Converts a date or timestamp to a number representing the day of the week (Monday is 1, and Sunday is 7).

## Syntax
{: .no_toc}

```sql
TO_DAY_OF_WEEK(<date>)
```

| Parameter | Description                                             |
| :--------- | :------------------------------------------------------- |
| `<date>`  | An expression that evaluates to a `DATE `or `TIMESTAMP` |

## Example
{: .no_toc}

This example below finds the day of week number for April 22, 1975. The string first needs to be transformed to `DATE `type using the `CAST `function.

```sql
SELECT
    TO_DAY_OF_WEEK(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `2`
