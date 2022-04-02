---
layout: default
title: TO_WEEKISO
description: Reference material for TO_WEEKISO function
parent: SQL functions
---

# TO\_WEEKISO

Converts any supported date or timestamp data type to a number representing the week of the year. This function adheres to the [ISO 8601](https://www.wikipedia.org/wiki/ISO_week_date) standards for numbering weeks, meaning week 1 of a calendar year is the first week with 4 or more days in that year.

## Syntax
{: .no_toc}

```sql
TO_WEEKISO(<date>)
```

| Parameter | Description                                                     |
| :--------- | :--------------------------------------------------------------- |
| `<date>`  | The date or timestamp to be converted into the ISO week number. |

## Example
{: .no_toc}

Where `ship_date` is a column of type `DATE `in the table `fct_orders`.

```sql
SELECT
    TO_WEEKISO (ship_date)
FROM
    fct_orders;
```

**Returns**:

```
+-----------+
| ship_date |
+-----------+
|        33 |
|        12 |
|        18 |
|         2 |
|         1 |
|       ... |
+-----------+
```

Where `ship_date` is a column of type `TEXT` with values in the format _YYYY/MM/DD** **_**.**

```sql
SELECT
    TO_WEEKISO(CAST(ship_date AS DATE))
FROM
    fct_orders;
```

**Returns:**

```
+-----------+
| ship_date |
+-----------+
|        33 |
|        12 |
|        18 |
|         2 |
|         1 |
|       ... |
+-----------+
```
