---
layout: default
title: TAN
description: Reference material for TAN function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/godocs/).
# TAN

Calculates the tangent.

## Syntax
{: .no_toc}

```sql
TAN(<val>)
```
## Parameters
{: .no_toc}

| Parameter | Description     | Supported input types | 
| :--------- | :--------------------------------- | :---------|
| `<value>`   | The value that determines the returned tangent | `DOUBLE PRECISION` | 

## Return Type
`DOUBLE PRECISION`

## Example
{: .no_toc}

The following example calculates the tangent of `90`: 
```sql
SELECT
    TAN(90);
```

**Returns**: `-1.995200412208242`
