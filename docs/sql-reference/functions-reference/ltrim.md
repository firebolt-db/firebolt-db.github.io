---
layout: default
title: LTRIM
description: Reference material for LTRIM function
parent: SQL functions
---

# LTRIM

Removes all consecutive occurrences of common whitespace (ASCII character 32) from the beginning of a string. It doesn’t remove other kinds of whitespace characters (tab, no-break space, etc.).

## Syntax
{: .no_toc}

```sql
LTRIM(<target>)
```

| Parameter  | Description               |
| :---------- | :------------------------- |
| `<target>` | The string to be trimmed. |

## Example
{: .no_toc}

```sql
SELECT
	LTRIM('     Hello, world! ');
```

**Returns**:

```
Hello, world!
```
