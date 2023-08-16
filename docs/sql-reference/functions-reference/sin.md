---
layout: default
title: SIN
description: Reference material for SIN function
parent: SQL functions
---

# SIN

Trigonometric function that calculates the sine of a provided value.

## Syntax
{: .no_toc}

```sql
SIN(<value>)
```
## Parameters
{: .no_toc}

| Parameter | Description     | Supported input types | 
| :--------- | :---------------------- | :----|
| `<value>`   | The value that determines the returned sine | `DOUBLE PRECISION` | 

## Return Type
`DOUBLE PRECISION` 

## Example
{: .no_toc}

The following example calculates the sine of `90`: 
```sql
SELECT
    SIN(90);
```

**Returns**: `0.8939966636005579`
