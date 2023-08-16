---
layout: default
title: ROUND
description: Reference material for ROUND function
parent: SQL functions
---

# ROUND

Rounds a value to a specified number of decimal places.

## Syntax
{: .no_toc}

```sql
ROUND(<value> [, <decimal>])
```
## Parameters
{: .no_toc}

| Parameter | Description                                                                                                                   | Supported input types | 
| :--------- | :----------------------------------------------------------------------------------------------------------------------------- |:------| 
| `<value>`   | The value to be rounded       |
| `<decimal>`   | Optional. An `INTEGER` constant that defines the decimal range of the returned value. By default, `ROUND` returns whole numbers. | `INTEGER` | 

## Return Types
`DOUBLE PRECISION`

## Example
{: .no_toc}

The following example returns the rounded value of `5.4`. Since there is no specification of the decimal range, the functions returns a whole number: 
```sql
SELECT
    ROUND(5.4);
```

**Returns**: `5`

The following example rounds the value `5.6930` to `1` decimal place: 
```
SELECT
    ROUND(5.6930, 1);
```

**Returns**: `5.7`
