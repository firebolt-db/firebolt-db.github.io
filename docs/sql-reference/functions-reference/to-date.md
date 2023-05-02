---
layout: default
title: TO_DATE (legacy)
description: Reference material for TO_DATE (legacy) function
nav_exclude: true
parent: SQL functions
---

# TO\_DATE (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [TO_DATE](./to-date-new.md) function instead.

Converts a string to `DATE` type using optional formatting.

## Syntax
{: .no_toc}

```sql
TO_DATE(<string> [,format])
```

| Parameter   | Description                                                                 |
| :---------- | :-------------------------------------------------------------------------- |
| `<string>` | The string to convert to a date. |
| `format` | An optional string literal that defines the format of the input string, in terms of its date parts.  |

## Example
{: .no_toc}

```sql
SELECT
	TO_DATE('2020-05-31', 'YYYY-MM-DD') AS res;
```

**Returns**: `2020-05-31`
