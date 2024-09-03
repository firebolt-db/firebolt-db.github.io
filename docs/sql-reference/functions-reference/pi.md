---
layout: default
title: PI
description: Reference material for PI function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/godocs/).
# PI

Calculates π as a `REAL` value.

## Syntax
{: .no_toc}

```sql
PI() 
```

## Return Type
`DOUBLE PRECISION` 

## Example
{: .no_toc}

This example returns π as a `DOUBLE PRECISION` value: 
```
SELECT
    PI();
```

**Returns**: `3.141592653589793`
