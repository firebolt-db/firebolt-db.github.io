---
layout: default
title: TO_STRING
description: Reference material for TO_STRING function
parent: SQL functions
---

## TO\_STRING

Converts a date into a STRING. The date is any [date data type​​](../../general-reference/data-types.md).

##### Syntax
{: .no_toc}

```sql
TO_STRING(<date>)
```

| Parameter | Description                           |
| :--------- | :------------------------------------- |
| `<date>`  | The date to be converted to a string. |

##### Example
{: .no_toc}


This que**r**y returns today's date and the current time.

```sql
SELECT
	TO_STRING(NOW());
```

**Returns**: `2022-10-10 22:22:33`
