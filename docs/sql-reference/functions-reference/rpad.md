---
layout: default
title: RPAD
description: Reference material for RPAD function
parent: SQL functions
---

# RPAD

Adds a specified pad string to the end of the string repetitively up until the length of the resulting string is equivalent to an indicated length.

The similar function to pad the start of a string is [`LPAD`](./lpad.md).

## Syntax
{: .no_toc}

```sql
RPAD(<str>, <length>[, <pad>])
```

| Parameter  | Description                                                                                                                                                                                                                 |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<str>`    | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string.  `<str>` can be a literal string or the name of a column. |
| `<length>` | The integer length that the string will be after it has been left-padded.  A negative number returns an empty string.                                                                                                      |
| `<pad>`    | The string to add to the end of the primary string `<str>`. If left blank, `<pad>` defaults to whitespace characters.                                                                                                       |

## Example
{: .no_toc}

The following statement adds the string "ABC" to the end of the string "Firebolt" repetitively until the resulting string is equivalent to 20 characters in length.

```sql
SELECT
	RPAD('Firebolt', 20, 'ABC');
```

**Returns**: `FireboltABCABCABCABC`
