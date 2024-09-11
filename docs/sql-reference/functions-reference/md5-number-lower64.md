---
layout: default
title: MD5_NUMBER_LOWER64
description: Reference material for MD5_NUMBER_LOWER64 function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).
# MD5\_NUMBER\_LOWER64

Represent the lower 64 bits of the MD5 hash value of the input string as `BIGINT`.

## Syntax
{: .no_toc}

```sql
MD5_NUMBER_LOWER64(<expression>)
```

## Parameters 
{: .no_toc}

| Parameter  | Description                                                              | Supported input type | 
| :---------- | :------------------------------------------------------------------------ | :-------|
| `<expression>` | The string to calculate the MD5 hash value on and represent as `BIGINT` | `TEXT` | 

## Return Type
`BIGINT`

## Example
{: .no_toc}

The following example represents the username `esimpson` as a `BIGINT`: 

```sql
SELECT
	MD5_NUMBER_LOWER64('esimpson') AS username;
```

**Returns**: `624,533,696,996,866,075`
