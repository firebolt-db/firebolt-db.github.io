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
DEGREES(<value>)
```
## Parameters
{: .no_toc}

| Parameter | Description                                           | Supported input types | 
| :--------- | :----------------------------------------------------- | :------------|
| `<value>`   | The value to be converted to degrees from radians | `DOUBLE PRECISION` | 

## Return Types
`DOUBLE PRECISION` 

## Example
{: .no_toc}

The following example returns the value `3` in degrees: 
```sql
SELECT
    DEGREES(3);
```

**Returns**: `171.88733853924697`
