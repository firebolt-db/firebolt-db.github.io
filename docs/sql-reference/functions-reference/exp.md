---
layout: default
title: EXP
description: Reference material for EXP function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).
# EXP

Returns the `REAL` value of the constant _e_ raised to the power of a specified number.

## Syntax
{: .no_toc}

```sql
EXP(<value>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input types | 
| :--------- | :------------------------------------------------------------------------------------------------------------------- | :--------| 
| `<value>`   | base value with the power of the constant _e_  | `DOUBLE PRECISION` | 

## Return Type
`DOUBLE PRECISION`

## Example
{: .no_toc}
The following example takes in the value `2` to the power of _e_: 

```sql
SELECT
    EXP(2);
```

**Returns**: `7.389056098924109`
