---
layout: default
title: TO_DAY_OF_YEAR
parent: SQL functions
---

# TO\_DAY\_OF\_YEAR

Converts a date or timestamp to a number containing the number for the day of the year.

## Syntax
{: .no_toc}

```sql
TO_DAY_OF_YEAR(<date>)
```

| Parameter | Description                                             |
| :--------- | :------------------------------------------------------- |
| `<date>`  | An expression that evaluates to a `DATE `or `TIMESTAMP` |

## Example
{: .no_toc}

This example below finds the day of the year number for April 22, 1975. The string first needs to be transformed to `DATE `type using the `CAST `function.

```sql
SELECT
    TO_DAY_OF_YEAR(CAST('1975/04/22' AS DATE)) as res;
```

**Returns**: `112`
