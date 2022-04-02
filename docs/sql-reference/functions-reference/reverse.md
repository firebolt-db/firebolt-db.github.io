---
layout: default
title: REVERSE
description: Reference material for REVERSE function
parent: SQL functions
---

# REVERSE

This function returns a string of the same size as the original string, with the elements in reverse order.

## Syntax
{: .no_toc}

```sql
REVERSE(<string>)
```

| Parameter  | Description                |
| :---------- | :-------------------------- |
| `<string>` | The string to be reversed. |

## Example
{: .no_toc}

```sql
SELECT
	REVERSE('abcd') AS res
```

**Returns**: `'dcba'`
