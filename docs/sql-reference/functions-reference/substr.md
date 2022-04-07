---
layout: default
title: SUBSTR
description: Reference material for SUBSTR function
parent: SQL functions
---
## SUBSTR

Returns a substring starting at the character indicated by the `<offset>` index and including the number of characters defined by the `<length>`. Character indexing starts from index 1. The `<offset>` and `<length>` arguments must be constants.

##### Syntax
{: .no_toc}

```sql
SUBSTR(<string>, <offset> [, <length>])
```

| Parameter  | Description                                                                                                                                                                       |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>` | The string to be offset.                                                                                                                                                          |
| `<offset>` | The starting position for the substring. 1 is the first character.                                                                                                                |
| `<length>` | Optional. The number of characters to be returned by the `SUBSTR` function. If left blank, `length` by default returns all of the string not specified by the `offset` parameter. |

##### Example
{: .no_toc}

In the example below, the string is offset by 1 and so the `SUBSTR` command begins at the first letter, "h". The `<length>` of 5 indicates the resulting string should be only five characters long.

```sql
SELECT
	SUBSTR('hello world', 1, 5);
```

**Returns**: `hello`

In this next example, there is no `<length>` provided. This means all characters are included after the `<offset>` index, which is 7.

```sql
SELECT
	SUBSTR('hello world', 7);
```

**Returns**: `world`
