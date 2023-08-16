---
layout: default
title: MOD
description: Reference material for MOD function
parent: SQL functions
---

# MOD

Calculates the remainder after dividing two values, `<num>` / `<den>.`

## Syntax
{: .no_toc}

```sql
MOD(<value_n>,<value_d>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                               | Supported input types | 
| :--------- | :----------------------------------------- |:--------| 
| `<value_n>`   | The numerator of the division equation   | `DOUBLE PRECISION` |
| `<value_d>`   | The denominator of the division equation | `DOUBLE PRECISION` |

## Return Type
`DOUBLE PRECISION` 

## Example
{: .no_toc}

The following example returns the remainder of `45` and `7`: 

```sql
SELECT
    MOD(45, 7);
```

**Returns**: `3`
