---
layout: default
title: TO_TEXT
description: Reference material for TO_TEXT function
parent: SQL functions
---

# TO\_TEXT

Converts a date or timestamp into type `TEXT`. The date is any [date or time data type](../../general-reference/data-types.md).

## Syntax
{: .no_toc}

```sql
TO_TEXT(<date>)
```

| Parameter | Description                           | Supported input types |
| :--------- | :------------------------------------- | :-------------------- |
| `<date>`  | The date or timestamp to be converted to type `TEXT`. | `DATE`, `TIMESTAMP` |

## Example
{: .no_toc}

This query returns today's date and the current time, in type `TEXT`.

```sql
SELECT
	TO_TEXT(NOW());
```

**Returns**: `2022-10-10 22:22:33`
