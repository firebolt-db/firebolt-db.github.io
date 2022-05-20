---
layout: default
title: LOWER
description: Reference material for LOWER function
parent: SQL functions
---

# LOWER

Converts the string to a lowercase format.

## Syntax
{: .no_toc}

```sql
LOWER(<string>)
```

| Parameter  | Description                 |
| :---------- | :--------------------------- |
| `<string>` | The string to be converted. |

## Example
{: .no_toc}

```
SELECT
	LOWER('ABCD');
```

**Returns**: `abcd`
