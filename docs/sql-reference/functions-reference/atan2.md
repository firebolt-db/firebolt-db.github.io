---
layout: default
title: ATAN2
description: Reference material for ATAN2 function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).
# ATAN2

Two-argument arc tangent function. Calculates the angle, in radians, between the specified positive x-axis value and the ray from the origin to the point `(y,x)`.

## Syntax
{: .no_toc}

```sql
ATAN2(<value_y>,<value_x>)
```
## Parameters
{: .no_toc}

| Parameter   | Description | Supported input types | 
| :---------- | :-----------| :-------| 
| `<value_y>`  | The `y value` in the arc tangent calculation | `DOUBLE PRECISION` |
| `<value_x>`  | The `x value` in the arc tangent calculation | `DOUBLE PRECISION` |

## Return Type
`DOUBLE PRECISION`

## Example
{: .no_toc}

The following example returns the arc tangent with the values `(11, 3)`:
```sql
SELECT ATAN2(11,3);
```

**Returns:**
`1.3045442776439713`
