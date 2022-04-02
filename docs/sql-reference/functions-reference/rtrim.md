---
layout: default
title: RTRIM
description: Reference material for RTRIM function
parent: SQL functions
---

# RTRIM

Removes all consecutive occurrences of common whitespace (ASCII character 32) from the end of a string. It doesn’t remove other kinds of whitespace characters (tab, no-break space, etc.).

## Syntax
{: .no_toc}

```sql
​​RTRIM(<target>)​​
```

| Parameter  | Description               |
| :---------- | :------------------------- |
| `<target>` | The string to be trimmed. |

## Example
{: .no_toc}

```sql
SELECT
	RTRIM('Hello, world!     ');
```

**Returns**: `Hello, world!`
