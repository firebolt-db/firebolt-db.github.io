---
layout: default
title: RADIANS
description: Reference material for RADIANS function
grand_parent: SQL functions
parent: Numeric functions
great_grand_parent: SQL reference
---

# RADIANS

Converts degrees to radians as a `REAL` value.

## Syntax
{: .no_toc}

```sql
RADIANS(<value>) 
```
## Parameters 
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input types | 
| :--------- | :------------------------------------------------------------------------------------------------------------------- | :------------| 
| `<value>`   | The value to be converted from radians | `DOUBLE PRECISION` |

## Return Type
`DOUBLE PRECISION`

## Example
{: .no_toc}
The following example converts the value `180` in radians to a `REAL` value: 
```sql
SELECT
    RADIANS(180);
```

**Returns**: `3.141592653589793`
