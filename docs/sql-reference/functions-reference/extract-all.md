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
EXTRACT_ALL( <expression>, <pattern> )
```
## Parameters 
{: .no_toc}

| Parameter         | Description                                      | Supported input types | 
| :----------------- | :---------------------------------------------- |:---------|
| `<expression>`          | The string to be extracted from. | `TEXT` |
| `<pattern>` | Regex pattern that is applied to `<expression>` | An re2 regular expression used for matching.  | 

## Return Type
`ARRAY TEXT` 

## Example
{: .no_toc}

In the example below, `EXTRACT_ALL` is used to match variants of a tournament name, "Hello World". The regular expression pattern `'Hello.[Ww]orld!?'` does not match any special characters except for `!`.

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
