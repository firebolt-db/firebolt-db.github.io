---
layout: default
title: ATAN2
description: Reference material for ATAN2 function
parent: SQL functions
---

# ATAN2

Two-argument arc tangent function. Calculates the angle, in radians, between the specified positive x-axis value and the ray from the origin to the point (y,x), where x is a number of type `DOUBLE` returned by the expression `<x_expr>`, and y is a number of type `DOUBLE` returned by the expression `<y_expr>`. Returns the radians as type `DOUBLE`.

## Syntax
{: .no_toc}

```sql
ATAN2(<y_expr>,<x_expr>)
```

| Parameter   | Description |
| :---------- | :-----------|
| `<y_expr>`  | Any expression that evaluates to a number of type `DOUBLE`. |
| `<y_expr>`  | Any expression that evaluates to a number of type `DOUBLE`. |

## Example
{: .no_toc}

```sql
SELECT ATAN2(11,3);
```

**Returns:**
`1.3045442776439713`
