---
layout: default
title: SQRT
description: Reference material for SQRT function
parent: SQL functions
---

# SQRT

Returns the square root of a non-negative numeric expression.

## Syntax
{: .no_toc}

```sql
SQRT(<value>);
```
## Parameters
{: .no_toc}

| Parameter | Description  | Supported input types | 
|:----------|:-----------------------------------------------|:-----| 
| `<value>`  | Value that the `SQRT` function is applied to  | `DOUBLE PRECISION` | 

## Return Types 
* `DOUBLE PRECISION` if value is positive
* `NULL` if value is negative 

## Example
{: .no_toc}

The following example returns the square root of `64`: 
```sql
SELECT
    SQRT(64);
```

**Returns**: `8`
