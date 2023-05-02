---
layout: default
title: TO_WEEKISO (legacy)
nav_exclude: true
parent: SQL functions
---

# TO\_WEEKISO (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [EXTRACT](./extract-new.md) function instead.

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
