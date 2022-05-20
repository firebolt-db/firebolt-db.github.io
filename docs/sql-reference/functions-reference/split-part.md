---
layout: default
title: SPLIT_PART
description: Reference material for SPLIT_PART function
parent: SQL functions
---

# SPLIT_PART

Divides a string based on a specified delimiter into an array of substrings.  The string in the specified index is returned, with `1` being the first index. If the string separator is empty, the string is divided into an array of single characters.

## Syntax
{: .no_toc}

```sql
SPLIT_PART(<string>, <delimiter>, <index>)
```

{: .note}
Please note that the order of the arguments is different than the `SPLIT` function.

| Parameter     | Description                                                                                                                                    |
| :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>`    | An expression evaluating to a string to be split.                                                                                              |
| `<delimiter>` | Any character or substring within `<string>`. If `<delimiter>` is an empty string `''`, the `<string>` will be divided into single characters. |
| `<index>`     | The index from which to return the substring.                                                                                                  |

## Example
{: .no_toc}

```sql
SELECT
	SPLIT_PART('hello#world','#',1) AS res;
```

**Returns**: `hello`

```sql
SELECT
	SPLIT_PART('this|is|my|test', '|', 4 ) AS res;
```

**Returns**: `test`

```sql
SELECT
	SPLIT_PART('hello world', '', 7 ) AS res;
```

**Returns**: `w`
