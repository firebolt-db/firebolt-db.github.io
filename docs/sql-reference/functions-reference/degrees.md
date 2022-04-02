---
layout: default
title: DEGREES
description: Reference material for DEGREES function
parent: SQL functions
---

# DEGREES

Converts a value in radians to degrees.

## Syntax
{: .no_toc}

```sql
DEGREES(<exp>)
```

| Parameter | Description                                           |
| :--------- | :----------------------------------------------------- |
| `<exp>`   | Any expression that evaluates to a numeric data type. |

## Example
{: .no_toc}

```sql
SELECT
    DEGREES(3);
```

**Returns**: `171.88733853924697`
