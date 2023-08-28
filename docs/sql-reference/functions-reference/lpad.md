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
LPAD(<expression>, <value>[, <pad>])
```

## Parameters 
{: .no_toc}

| Parameter  | Description                                      |Supported input types | 
| :---------- | :---------------------------------------------- | :------------|
| `<expression>`    | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string. | `TEXT` | 
| `<value>` | The length of the string as an integer after it has been left-padded.  | `INTEGER` |                                                                                                         |
| `<pad>`    | The string to add to the start of the primary string `<expression>`. If left blank, `<pad>` defaults to whitespace characters.         | `TEXT` |                                                                                            |

## Return Type
`TEXT`

## Example
{: .no_toc}

The following statement adds the string "ABC" in front of the username string "esimpson" repetitively until the resulting string is equivalent to 17 characters in length.

```sql
SELECT
	LPAD('esimpson', 17, 'UserName:');
```

**Returns**:

```
UserName:esimpson
```
