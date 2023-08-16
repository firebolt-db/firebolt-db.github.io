---
layout: default
title: POW
description: Reference material for POW, POWER functions
parent: SQL functions
---

# POW
Synonym: `POWER`

Returns a number `<value>` raised to the specified power `<value>`.

## Syntax
{: .no_toc}

```sql
POW(<value>, <exponent>);
```
## Parameters 
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input types |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |:------|
| `<value>`   | The base value of the exponent |`DOUBLE PRECISION` |
| `<exponent>`   | The power value of the exponent | `DOUBLE PRECISION` |

## Return Type
`DOUBLE PRECISION`

## Example
{: .no_toc}
The following example calculates `2` to the power of `5`:
```sql
SELECT
    POW(2, 5);
```

**Returns**: `32`
