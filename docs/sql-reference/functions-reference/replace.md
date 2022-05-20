---
layout: default
title: REPLACE
description: Reference material for REPLACE function
parent: SQL functions
---

# REPLACE

Replaces all occurrences of the `<pattern>` substring within the `<string>` with the `<replacement>` substring.

## Syntax
{: .no_toc}

```sql
REPLACE (<string>, <pattern>, <replacement>)
```

| Parameter       | Description                                                                                                                                                                                |
| :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<string>`      | The original string that will be searched for instances of the `<pattern>`.                                                                                                                |
| `<pattern>`     | The substring to be searched and replaced in the string.                                                                                                                                   |
| `<replacement>` | The substring to replace the original substring defined by `<pattern>`. To remove the `<pattern>` substring with no replacement, you can use a empty string `''` as the replacement value. |

## Example
{: .no_toc}

In the example below, "hello" in "hello world" is replaced with "nice".

```sql
SELECT
	REPLACE('hello world','hello','nice') AS res;
```

**Returns**: `nice world`

In this example below, "world" is replaced by an empty string.

```sql
SELECT
	REPLACE('hello world',' world','') AS res;
```

**Returns**: `hello`

In this following example, the substring "hi" is not found in the original string, so the string is returned unchanged.

```sql
SELECT
	REPLACE('hello world','hi','something') AS res;
```

**Returns**: `hello world`
