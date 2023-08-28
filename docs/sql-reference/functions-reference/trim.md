---
layout: default
title: TRIM
description: Reference material for TRIM function
parent: SQL functions
---

# TRIM

Removes all specified characters from the start, end, or both sides of a string. By default removes all consecutive occurrences of common whitespace (ASCII character 32) from both ends of a string.

## Syntax
{: .no_toc}

```sql
TRIM( [LEADING | TRAILING | BOTH] <trim_character> FROM <expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `LEADING | TRAILING | BOTH` | Specifies which part or parts of the `<expression>` to remove the defined `<trim_character>`. | If unspecified, this defaults to `BOTH`.<br><br>`LEADING` - trims from the beginning of the specified string<br><br>`TRAILING` - trims from the end of the specified string. <br><br>`BOTH` - trims from the beginning and the end of the specified string. |
| `<trim_character>`                | The characters to be removed.  | 	`TEXT` |
| `<expression>`                 | The string to be trimmed.        | `TEXT` |

## Return Type
`TEXT`

## Example
{: .no_toc}

In the example below, no part of the string is specified for `TRIM`, so it defaults to `BOTH`.

```sql
SELECT
	TRIM('$' FROM '$Hello world$') AS res;
```

**Returns**: `Hello world`

This next example trims only from the start of the string because the `LEADING` parameter is specified.

```sql
SELECT
	TRIM( LEADING '$' FROM '$Hello world$') AS res;
```

**Returns**: `Hello world$`
