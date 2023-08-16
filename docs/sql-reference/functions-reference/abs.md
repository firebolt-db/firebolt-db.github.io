---
layout: default
title: ABS
description: Reference material for ABS function
parent: SQL functions
---

# ABS

Calculates the absolute value of a number `<value>`. This means displaying the number's distance from `0`. 

## Syntax
{: .no_toc}

```sql
ABS(<value>)
```
## Parameters
{: .no_toc}

| Parameter | Description                                                                                                         | Supported input types |
| :--------- | :------------------------------------------------------------------------------------------------------------------- | :-------------------|
| `<numeric_type>`   | The number that the absolute value function is applied to. | Any `NUMERIC` type |

## Return Type
`NUMERIC`

## Example
{: .no_toc}

The following example returns the absolute value of `-200.5`:

```sql
SELECT
    ABS(-200.50);
```

**Returns**: `200.5`
