---
layout: default
title: SIGN
description: Reference material for SIGN function
parent: SQL functions
---

# SIGN

Returns the sign of a number according to the table below.

## Syntax

```sql
SIGN(<value>)
```


## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `value` | Any expression that evaluates to a numeric data type. | `INTEGER`, `NUMERIC`, `BIGINT`, `REAL`, `DOUBLE PRECISION` |

## Return Types
Same as the input number type (`<value>`).

## Examples

| If               | Returns |
| :--              | :------ |
| `<value>` \< `0` | `-1`   |
| `<value>` = `0`  | `0`    |
| `<value>` \> `0` | `1`    |

```sql
SIGN(5)
```

**Returns**: `1`

```sql
SIGN(-1.35E-10)
```

**Returns**: `-1`

```sql
SIGN(0)
```

**Returns**: `0`
