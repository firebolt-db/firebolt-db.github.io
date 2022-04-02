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
MOD(<num>,<den>)
```

| Parameter | Description                               |
| :--------- | :----------------------------------------- |
| `<num>`   | The numerator of the division equation.   |
| `<den>`   | The denominator of the division equation. |

## Example
{: .no_toc}

```sql
SELECT
    MOD(45, 7);
```

**Returns**: `3`
