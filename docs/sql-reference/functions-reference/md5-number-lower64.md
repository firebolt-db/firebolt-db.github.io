---
layout: default
title: MD5_NUMBER_LOWER64
description: Reference material for MD5_NUMBER_LOWER64 function
parent: SQL functions
---

# MD5\_NUMBER\_LOWER64

Represent the lower 64 bits of the MD5 hash value of the input string as `BIGINT`.

## Syntax
{: .no_toc}

```sql
MD5_NUMBER_LOWER64(<string>)
```

| Parameter  | Description                                                              |
| :---------- | :------------------------------------------------------------------------ |
| `<string>` | The string to calculate the MD5 hash value on and represent as `BIGINT.` |

## Example
{: .no_toc}

```sql
SELECT
	MD5_NUMBER_LOWER64('test') AS res;
```

**Returns**: `14618207765679027446`
