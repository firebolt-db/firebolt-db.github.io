---
layout: default
title: EXTRACT (legacy)
description: Reference material for EXTRACT function
parent: SQL functions
---

# EXTRACT (legacy)

Retrieves subfields such as year or hour from date/time values.

{: .note}
The functions works with legacy `DATE` and `TIMESTAMP` data types. If you are using new `PGDATE`, `TIMESTAMPTZ`, and `TIMESTAMPNTZ` data types, see [EXTRACT (new)](../functions-reference/extract-new.md).

## Syntax
{: .no_toc}

```sql
EXTRACT(<field> FROM <source>)
```

| Parameter  | Description                                                                                                      |
| :---------- | :---------------------------------------------------------------------------------------------------------------- |
| `<field>`  | Supported fields: `DAY`, `DOW, MONTH`, `WEEK`, `WEEKISO`, `QUARTER`, `YEAR`, `HOUR`, `MINUTE`, `SECOND`, `EPOCH` |
| `<source>` | A value expression of type timestamp.                                                                            |

## Example
{: .no_toc}

This example below extracts the year from the timestamp. The string date first need to be transformed to `TIMESTAMP` type using the `CAST `function.

```sql
SELECT
	EXTRACT(
		YEAR
		FROM
			CAST('2020-01-01 10:00:00' AS TIMESTAMP)
	);
```

**Returns**: `2020`