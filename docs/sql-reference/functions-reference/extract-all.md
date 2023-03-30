---
layout: default
title: EXTRACT_ALL
description: Reference material for EXTRACT_ALL function
parent: SQL functions
---

# EXTRACT\_ALL

Extracts fragments within a string that match a specified regex pattern. String fragments that match are returned as an array of `TEXT` types.

## Syntax
{: .no_toc}

```sql
EXTRACT_ALL( <expr>, '<regex_pattern>' )
```

| Parameter         | Description                                                                 |
| :----------------- | :--------------------------------------------------------------------------- |
| `<expr>`          | Any expression that evaluates to a `TEXT` data type |
| `<regex_pattern>` | An re2 regular expression used for matching.                                |

## Example
{: .no_toc}

In the example below, `EXTRACT_ALL` is used to match variants of "Hello World". The regular expression pattern `'Hello.[Ww]orld!?'` does not match any special characters except for `!`.

```sql
SELECT
	EXTRACT_ALL (
		'Hello world, ;-+ Hello World!',
		'Hello.[Ww]orld!?'
	);
```

**Returns**:

```
["Hello world","Hello World!"]
```
