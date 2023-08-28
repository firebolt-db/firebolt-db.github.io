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
MD5_NUMBER_UPPER64(<expression>)
```

# Parameters 
{: .no_toc}

| Parameter  | Description                                                              |Supported input type | 
| :---------- | :------------------------------------------------------------------------ | :-------|
| `<expression>` | The string to calculate the MD5 hash value on and represent as `BIGINT` | `TEXT` | 

## Return Type
`BIGINT`

## Example
{: .no_toc}

The following example represents the username `esimpson` as a `BIGINT`: 

```sql
SELECT
	MD5_NUMBER_UPPER64('esimpson') AS username;
```

**Returns**: `-4,517,210,933,321,929,797`
