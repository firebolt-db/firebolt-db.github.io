---
layout: default
title: TRUNC
description: Reference material for TRUNC function
parent: SQL functions
---

# TRUNC

Returns the rounded absolute value of a numeric value. The returned value will always be rounded to less than the original value.

## Syntax
{: .no_toc}

```sql
TRUNC(<value>[, <decimal>])
```
## Parameters
{: .no_toc}

| Parameter | Description                                                                                                                  | Supported input types | 
| :--------- | :---------------------------------------------------------------------------------------------------------------------------- |:--------|
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.          | `DOUBLE PRECISION` | 
| `<decimal>`   | Optional. An `INTEGER` constant that defines the decimal range of the returned value. By default, `TRUNC` returns whole numbers. | `INTEGER` | 

## Return Type
`DOUBLE PRECISION` 

## Example
{: .no_toc}

The following example returns the truncated value of `-20.5`: 
```sql
SELECT
    TRUNC(-20.5);
```

**Returns**: `-20`

This example returns the truncated value of `-99.999999` to `3` decimal places: 
```sql
SELECT
    TRUNC(-99.999999, 3);
```

**Returns**: `-99.999`
