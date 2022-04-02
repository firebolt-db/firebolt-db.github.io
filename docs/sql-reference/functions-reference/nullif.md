---
layout: default
title: NULLIF
description: Reference material for NULLIF function
parent: SQL functions
---

# NULLIF

Compares two expressions. Returns `NULL` if the expressions evaluate to equal values. Returns the result of `<expr1>` if they are not equal. To return `<expr2>` instead, use `IFNULL`.

## Syntax
{: .no_toc}

```sql
NULLIF(<exp1>, <exp2>)
```

| Parameter | Description |
| :-------- | :---------- |
| `<expr1>`, `<expr2>` | Expressions that evaluate to any data type that Firebolt supports. The expressions must evaluate to the same data type or synonyms, or an error occurs. The result of `<exp1>` is returned if the expressions do not evaluate to an equal result. |

## Example
{: .no_toc}

```sql
NULLIF('Firebolt fast','Firebolt fast')
```

**Returns**: `NULL`

```sql
NULLIF('Firebolt fast','Firebolt Fast')
```

**Returns**: `Firebolt fast`
