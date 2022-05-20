---
layout: default
title: MD5_NUMBER_UPPER64
description: Reference material for MD5_NUMBER_UPPER64 function
parent: SQL functions
---

# MD5\_NUMBER\_UPPER64

Represent the upper 64 bits of the MD5 hash value of the input string as `BIGINT`.

## Syntax
{: .no_toc}

```sql
MD5_NUMBER_UPPER64(<string>)
```

| Parameter  | Description                                                  |
| :---------- | :------------------------------------------------------------ |
| `<string>` | The string to calculate the MD5 on and represent as `BIGINT` |

## Example
{: .no_toc}

```sql
SELECT
	MD5_NUMBER_UPPER64('test') AS res;
```

**Returns**: `688887797400064883`
