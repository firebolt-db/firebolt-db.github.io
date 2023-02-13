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
SIGN(<expr>)
```

`<expr>` can be any expression that evaluates to a numeric data type.

|  If              | Returns |
|  :--             | :------ |
|  `<expr>` \< `0` | `-1`    |
|  `<expr>` = `0`  | `0`     |
| `<expr>` \> `0`  | `1`     |

## Examples

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
