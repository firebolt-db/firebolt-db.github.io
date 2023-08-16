---
layout: default
title: COT
description: Reference material for COT function
parent: SQL functions
---

# COT

Calculates the cotangent.

## Syntax
{: .no_toc}

```sql
COT(<value>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                                           | Supported input types | 
| :--------- | :----------------------------------------------------- | :----------| 
| `<value>`   | The value which the `COT` function will be applied to | `DOUBLE PRECISION` | 

## Return Types 
{: .no_toc}

`DOUBLE PRECISION`

## Example
{: .no_toc}

The following example returns the cotangent of `180`: 

```sql
SELECT
    COT(180);
```

**Returns**: `0.7469988144140444`
