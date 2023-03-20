---
layout: default
title: BASE64_ENCODE
description: Reference material for BASE64_ENCODE function
parent: SQL functions
---

# BASE64\_ENCODE

Encodes a string into Base64 notation.

## Syntax
{: .no_toc}

```sql
BASE64_ENCODE(<expression>)
```

| Parameter | Description                                                                 |
| :--------- | :--------------------------------------------------------------------------- |
| `<expression>`  | Any expression that evaluates to a `TEXT` data type |

## Example
{: .no_toc}

```sql
SELECT
	BASE64_ENCODE('Hello World');
```

**Returns**: `SGVsbG8gV29ybGQ=`
