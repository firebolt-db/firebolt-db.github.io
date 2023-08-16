---
layout: default
title: CBRT
description: Reference material for CBRT function
parent: SQL functions
---

# CBRT

Returns the cubic-root of a non-negative numeric expression.

## Syntax
{: .no_toc}

```sql
CBRT(<value>);
```
## Parameters 
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input types | 
| :--------- | :------------------------------------------------------------------------------------------------------------------- | :--------| 
| `<value>`   | Value that the `CBRT` function is applied to | `DOUBLE_PRECISION` |

## Return Type
`DOUBLE_PRECISION`

## Example
{: .no_toc}
The following example returns the cubic-root of 8: 

```sql
SELECT
    CBRT(8);
```

**Returns**: `2`
