---
layout: default
title: IFNULL
description: Reference material for IFNULL function
parent: SQL functions
---

# IFNULL
Compares two expressions. Returns `<expr1>` if it’s not `NULL`, otherwise returns `<expr2>`.

## Syntax
{: .no_toc}

```sql
IFNULL(<exp1>, <exp2>)
```

| Parameter | Description |
| :-------- | :---------- |
| `<expr1>`, `<expr2>` | Expressions that evaluate to any data type that Firebolt supports. |

## Example
{: .no_toc}

The following truth table demonstrates values that `IFNULL` returns based on the values of two column expressions: `col1` and `col2`.

```
+-----------+-----------+-------------------+-------------------+
|  col1     |   col2    | IFNULL(col1,col2) | IFNULL(col2,col1) |
+-----------+-----------+-------------------+-------------------+
| 0         | 32        | 0                 | 32                |
| 0         | [NULL]    | 0                 | 0                 |
| [NULL]    | 32        | 32                | 32                |
| [NULL]    | [NULL]    | [NULL]            | [NULL]            |
-----------+-----------+-------------------+-------------------+
```
