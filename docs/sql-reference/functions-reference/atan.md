---
layout: default
title: ATAN
description: Reference material for ATAN function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/godocs/).
# ATAN

Calculates the arc tangent of the real number returned by the specified expression `<expression>`.

## Syntax
{: .no_toc}

```sql
ATAN(<expression>)
```

## Parameters 
{: .no_toc}

| Parameter | Description | Supported input types | 
| :-------- | :-----------| :------|
| `<expression>`  | The expression that the `ATAN` function is applied to | Any expression that evaluates to a real number |

## Return Type 
`DOUBLE PRECISION` 

## Example
{: .no_toc}

The following example returns the arc tangent of the specified literal value `90`:

```sql
SELECT
    ATAN(90);
```

**Returns**: `1.5596856728972892`
