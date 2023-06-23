---
layout: default
title: SUBSTRING
description: Reference material for SUBSTRING function
parent: SQL functions
---
## SUBSTRING

Returns a substring starting at the character indicated by the `<start>` index and including the number of characters defined by `<count>`. Character indexing starts at index 1.

##### Syntax
{: .no_toc}

```sql
SUBSTRING(<expression> [FROM <start>] [FOR <count>])
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>`  | The input string.   	| `TEXT` |
| `<start>`   | Optional. The starting position for the substring. 1 is the first character. | `INTEGER` |
| `<count>`   | Optional. The number of characters to be returned by the `SUBSTRING` function. Must be positive or 0. If not specified, `count` by default returns all of the string not specified by the `start` parameter. | `INTEGER` |

At least one of the optional arguments `<start>` and `<count>` must be given.

Negative `<start>` values begin the substring before the input `<expression>`. Positions before the input `<expression>` are considered empty.

## Return Type
`TEXT`

##### Example
{: .no_toc}

In the example below, the string is offset by 1 and so the `SUBSTRING` command begins at the first letter, "h". The `<count>` of 5 indicates the resulting string should be only five characters long.

```sql
SELECT
	SUBSTRING('hello world' FROM 1 FOR 5);
```

**Returns**: `hello`

In this next example `<count>` is not provided. This means all characters are included after the `<start>` index, which is 7.

```sql
SELECT
	SUBSTRING('hello world' FROM 7);
```

**Returns**: `world`

For negative `<start>` values, empty positions before the input string are selected. Thus, without `<count>` negative values will select the entire input `<string>`.

```sql
SELECT
	SUBSTRING('hello world' FROM -2);
```

**Returns**: `hello world`

With a negative `<start>` value and `<count>`, the empty positions before the string are counted towards the substring length. In this example, beginning the substring at `-2` for `8` characters includes 3 empty positions and 5 positions with characters from the input `<expression>`.

```sql
SELECT
	SUBSTRING('hello world' FROM -2 FOR 8);
```

**Returns**: `hello`
