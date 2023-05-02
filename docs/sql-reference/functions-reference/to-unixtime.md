---
layout: default
title: TO_UNIXTIME (legacy)
nav_exclude: true
parent: SQL functions
---

# TO\_UNIXTIME (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [EXTRACT](./extract-new.md) function instead.

For `DATETIME` arguments: this function converts the value to its internal numeric representation (Unix Timestamp).  For `TEXT` arguments: this function parses `DATETIME` from a string and returns the corresponding Unix timestamp.

## Syntax
{: .no_toc}

```sql
TO_UNIXTIME(<string>)
```

| Parameter  | Description                 |
| :---------- | :--------------------------- |
| `<string>` | The string to be converted. |

## Example
{: .no_toc}

```sql
SELECT
	TO_UNIXTIME('2017-11-05 08:07:47') AS TO_UNIXTIME;
```

**Returns**: `1509869267`
