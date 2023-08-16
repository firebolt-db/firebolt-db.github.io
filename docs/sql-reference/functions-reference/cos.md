---
layout: default
title: COS
description: Reference material for COS function
parent: SQL functions
---

# COS

Trigonometric function that calculates the cosine of a specific value.

## Syntax
{: .no_toc}

```sql
COS(<value>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                                           | Supported input types | 
| :--------- | :----------------------------------------------------- | :--------| 
| `<value>`   | The value that the `COS` function is applied to | `DOUBLE PRECISION` |

## Return Type 
`DOUBLE PRECISION`

## Example
{: .no_toc}

The following example returns the cosine of `180`: 
```sql
SELECT
    COS(180);
```

**Returns**: `-0.5984600690578581`
