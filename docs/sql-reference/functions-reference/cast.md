---
layout: default
title: CAST
description: Reference material for CAST function
parent: SQL functions
---


# CAST

Similar to `TRY_CAST`, `CAST` converts data types into other data types based on the specified parameters. If the conversion cannot be performed, `CAST` returns an error. To return a `NULL` value instead, use `TRY_CAST`.

## Syntax
{: .no_toc}

```sql
CAST(<value> AS <type>)
```

| Parameter | Description                                                                                                                                                                |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<value>` | The value to convert or an expression that results in a value to convert. Can be a column name,  a function applied to a column or another function, or a literal value. |
| `<type>`  | The target [data type](../../general-reference/data-types.md) (case-insensitive).                                                                                          |

## Example
{: .no_toc}

```sql
SELECT CAST('1' AS INT) as res;
```

**Returns**: `1`

`CAST` can also be done by writing the format before the object, for example - `select date '2022-01-01'` , `select timestamp '2022-01-01 01:02:03'.`

{: .note}
`CAST` can also be done by using the `::` operator. For more information, see [:: operator for CAST](../../general-reference/operators.md#-operator-for-cast).



