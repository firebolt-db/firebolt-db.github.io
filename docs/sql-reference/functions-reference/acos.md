---
layout: default
title: ACOS
description: Reference material for ACOS function
parent: SQL functions
---

# ACOS

Calculates the arc cosine of a value `<value>`. `ACOS` returns `NULL` if `<value>` is higher than 1.

## Syntax
{: .no_toc}

```sql
ACOS(<value>)
```

## Parameters 
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input types |
| :--------- | :------------------------------------------------------------------------------------------------------------------- | :-------------------|
| `<value>`   | The number that the arc cosine value function is applied to | `DOUBLE PRECISION` |

## Return Type
`DOUBLE PRECISION`

## Example
The following example returns the arc cosine  of `0.5`:

```sql
SELECT
    ACOS(0.5);
```

**Returns**: `1.0471975511965979`
