---
layout: default
title: TO_DAY_OF_YEAR (legacy)
nav_exclude: true
parent: SQL functions
---

# TO\_DAY\_OF\_YEAR (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [EXTRACT](./extract-new.md) function instead.

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
