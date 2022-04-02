---
layout: default
title: ATAN
description: Reference material for ATAN function
parent: SQL functions
---

# ATAN

Calculates the arc tangent of the real number returned by the specified expression `<expr>`.

## Syntax
{: .no_toc}

```sql
ATAN(<expr>)
```

| Parameter | Description |
| :-------- | :-----------|
| `<expr>`  | Any expression that evaluates to a real number. |

## Example
{: .no_toc}

The following example returns the arc tangent of the specified literal value `90`.

```sql
SELECT
    ATAN(90);
```

**Returns**: `1.5596856728972892`
