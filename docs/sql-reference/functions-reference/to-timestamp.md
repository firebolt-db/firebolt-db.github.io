---
layout: default
title: TO_TIMESTAMP (legacy)
description: Reference material for TO_TIMESTAMP (legacy) function
nav_exclude: true
parent: SQL functions
---

# TO\_TIMESTAMP (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [TO_TIMESTAMP](./to-timestamp-new.md) function instead.

Converts a string to timestamp with optional formatting.

## Syntax
{: .no_toc}

```sql
TO_TIMESTAMP(<string> [,format])
```

| Parameter  | Description                                        |
| :---------- | :-------------------------------------------------- |
| `<string>` | The string value to convert. |
| `<format>` | An optional string literal that specifies the format of the `<string>` to convert. See [DATE_FORMAT](../functions-reference/date-format.md) for a table of available string literals.  |

## Example
{: .no_toc}

```sql
SELECT
	TO_TIMESTAMP('2020-05-31 10:31:14', 'YYYY-MM-DD HH:MM:SS') AS res;
```

**Returns**: `2020-05-31 10:31:14`
