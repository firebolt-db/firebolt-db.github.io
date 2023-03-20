---
layout: default
title: TRY_CAST
description: Reference material for TRY_CAST function
parent: SQL functions
---

# TRY_CAST

Similar to `CAST`, `TRY_CAST` converts data types into other data types based on the specified parameters. If the conversion cannot be performed, `TRY_CAST` returns a `NULL`. To return an error message instead, use `CAST`.

## Syntax
{: .no_toc}

```sql
TRY_CAST(<value> AS <type>)
```

| Parameter | Description                                                                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<value>` | The value to convert or an expression that results in a value to convert. Can be a column name,  a function applied to a column or another function, or a literal value. |
| `<type>`  | The target [data type](../../general-reference/data-types.md) (case-insensitive).                                                                                          |

## Example
{: .no_toc}

```sql
SELECT TRY_CAST('1' AS INTEGER) as res, TRY_CAST('test' AS INTEGER) as res1;
```

**Returns**: `1,null`
