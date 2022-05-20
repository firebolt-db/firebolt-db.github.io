---
layout: default
title: UPPER
description: Reference material for UPPER function
parent: SQL functions
---

# UPPER

Converts the string to uppercase format.

## Syntax
{: .no_toc}

```sql
UPPER(<string>)
```

| Parameter  | Description                                             |
| :---------- | :------------------------------------------------------- |
| `<string>` | The string to be converted to all uppercase characters. |

## Example
{: .no_toc}

```sql
SELECT
	UPPER('hello world')
```

**Returns**: `HELLO WORLD`
