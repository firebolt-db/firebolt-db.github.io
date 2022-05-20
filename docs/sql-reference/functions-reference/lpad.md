---
layout: default
title: LPAD
description: Reference material for LPAD function
parent: SQL functions
---

# LPAD

Adds a specified pad string to the end of the string repetitively up until the length of the resulting string is equivalent to an indicated length.

The similar function to pad the end of a string is [`RPAD`](./rpad.md).

## Syntax
{: .no_toc}

```sql
LPAD(<str>, <length>[, <pad>])
```

| Parameter  | Description                                                                                                                                                                                                                 |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<str>`    | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string.  `<str>` can be a literal string or the name of a column. |
| `<length>` | The length of the string as an integer after it has been left-padded.  A negative number returns an empty string.                                                                                                          |
| `<pad>`    | The string to add to the start of the primary string `<str>`. If left blank, `<pad>` defaults to whitespace characters.                                                                                                     |

## Example
{: .no_toc}

The following statement adds the string "ABC" in front of the string Firebolt repetitively until the resulting string is equivalent to 20 characters in length.

```sql
SELECT
	LPAD('Firebolt', 20, 'ABC');
```

**Returns**:

```
ABCABCABCABCFirebolt
```
