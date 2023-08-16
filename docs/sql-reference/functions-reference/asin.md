---
layout: default
title: ASIN
description: Reference material for ASIN function
parent: SQL functions
---

# ASIN

Calculates the arcsine. `ASIN` returns `NULL` if `<value>` is higher than 1.

## Syntax
{: .no_toc}

```sql
ASIN(<value>)
```

## Parameters 
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input type | 
| :--------- | :------------------------------------------------------------------------------------------------------------------- | :-----------| 
| `<value>`   | The value which the `ASIN` function is applied to | `DOUBLE_PRECISION` |

## Return Type 
`DOUBLE_PRECISION`

## Example
{: .no_toc}

The following example calculates the arc sine of `1.0`:
```sql
SELECT
    ASIN(1.0);
```

**Returns**: `1.5707963267948966`
